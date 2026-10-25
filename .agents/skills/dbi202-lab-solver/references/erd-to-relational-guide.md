# Hướng dẫn chi tiết Thiết kế ERD & Chuyển đổi sang Mô hình quan hệ (ERD to Relational Model Guide)

Tài liệu tham khảo chuyên sâu cho môn học **DBI202 (Database Systems)** - Đại học FPT, phục vụ giải quyết bài tập dạng Lab 3 và các bài toán phân tích thiết kế CSDL thực tế.

---

## 📑 Bảng mục lục
1. [Khái niệm cốt lõi trong mô hình ERD](#1-khái-niệm-cốt-lõi-trong-mô-hình-erd)
2. [7 Quy tắc chuyển đổi ERD sang Lược đồ quan hệ](#2-7-quy-tắc-chuyển-đổi-erd-sang-lược-đồ-quan-hệ)
3. [Case Study thực chiến: Quản lý Trường Đại học (Lab 3 mẫu)](#3-case-study-lab-3-quản-lý-trường-đại-học)
4. [Các bẫy thiết kế và lỗi thường gặp](#4-các-bẫy-thiết-kế-thường-gặp)

---

## 1. Khái niệm cốt lõi trong mô hình ERD

### 1.1. Thực thể (Entities)
- **Thực thể mạnh (Strong Entity)**: Có định danh riêng độc lập (ví dụ: `Student`, `Instructor`, `Department`).
- **Thực thể yếu (Weak Entity)**: Không có khóa chính riêng; sự tồn tại và định danh phụ thuộc hoàn toàn vào một thực thể chủ (*Owner Entity*) thông qua mối quan hệ xác định (*Identifying Relationship*). Ví dụ: `Section` phụ thuộc `Class`, hoặc `Dependent` phụ thuộc `Employee`.
  - Khóa bộ phận / Phân biệt (*Discriminator / Partial Key*): Được gạch chân nét đứt.

### 1.2. Thuộc tính (Attributes)
- **Thuộc tính đơn (Simple)**: Không thể chia nhỏ (ví dụ: `Age`, `Sex`).
- **Thuộc tính phức hợp (Composite)**: Gồm nhiều thành phần (ví dụ: `Address` gồm `Street`, `City`, `Province`).
- **Thuộc tính đa trị (Multivalued)**: Có thể nhận nhiều giá trị cho một thực thể (ví dụ: `Qualifications` của giảng viên, `PhoneNumbers`). Biểu diễn bằng hình oval đôi.
- **Thuộc tính suy dẫn (Derived)**: Tính toán được từ thuộc tính khác (ví dụ: `TotalScore` từ `TheoryScore` và `PracticeScore`, hoặc `Age` từ `BirthDate`). Biểu diễn bằng nét đứt $\to$ **Không lưu trong bảng quan hệ**.

### 1.3. Mối quan hệ và Bản số (Relationships & Cardinalities)
- **1:1 (Một - Một)**: Mỗi thể hiện của thực thể A liên kết với tối đa 1 thể hiện của B, và ngược lại (VD: Một trưởng khoa quản lý 1 phòng ban).
- **1:N (Một - Nhiều)**: Một thể hiện của A liên kết với nhiều thể hiện của B, nhưng B chỉ thuộc về 1 A (VD: Một khoa có nhiều giảng viên).
- **M:N (Nhiều - Nhiều)**: Một thể hiện của A liên kết với nhiều B, và một B liên kết với nhiều A (VD: Giảng viên dạy nhiều môn học, môn học được dạy bởi nhiều giảng viên).
- **Ràng buộc tham gia (Participation)**:
  - **Toàn phần (Total / Mandatory)**: Mọi thể hiện bắt buộc phải tham gia quan hệ (Đường kẻ đôi).
  - **Bộ phận (Partial / Optional)**: Có thể tham gia hoặc không (Đường kẻ đơn).

---

## 2. 7 Quy tắc chuyển đổi ERD sang Lược đồ quan hệ

```
  [ERD Element]                                    [Relational Schema]
┌───────────────────────────┐                    ┌───────────────────────────┐
│ 1. Strong Entity          │ ─────────────────► │ Bảng riêng, PK = Entity Key│
│ 2. Weak Entity            │ ─────────────────► │ Bảng riêng, PK = OwnerPK +│
│                           │                    │                  Discrim. │
│ 3. 1:1 Relationship       │ ─────────────────► │ Đẩy FK sang bên Total     │
│ 4. 1:N Relationship       │ ─────────────────► │ Đẩy FK sang bên "N" (Many)│
│ 5. M:N Relationship       │ ─────────────────► │ Bảng liên kết trung gian  │
│ 6. Multivalued Attribute  │ ─────────────────► │ Bảng riêng (OwnerPK + Attr│
│ 7. Subclass (ISA)         │ ─────────────────► │ Bảng riêng hoặc gộp cờ    │
└───────────────────────────┘                    └───────────────────────────┘
```

1. **Quy tắc 1 (Thực thể mạnh)**: Mỗi thực thể mạnh tạo thành một bảng. Khóa chính của thực thể trở thành Primary Key (PK) của bảng.
2. **Quy tắc 2 (Thực thể yếu)**: Tạo bảng riêng. Khóa chính PK gồm: `(Khóa của thực thể chủ + Khóa bộ phận của thực thể yếu)`. Khóa của thực thể chủ đóng vai trò Foreign Key (FK).
3. **Quy tắc 3 (Quan hệ 1:1)**: Đặt khóa chính của bảng này làm khóa ngoại FK ở bảng kia. *Kinh nghiệm vàng: Ưu tiên đặt FK vào bên có ràng buộc tham gia toàn phần (Total Participation) để tránh giá trị NULL.*
4. **Quy tắc 4 (Quan hệ 1:N)**: Đặt khóa chính của bảng phía "1" làm khóa ngoại FK tại bảng phía "N".
5. **Quy tắc 5 (Quan hệ M:N)**: Tạo **bảng liên kết trung gian** (*Junction / Associative Table*). Khóa chính PK của bảng trung gian là khóa hỗn hợp gồm PK của hai thực thể liên kết. Mọi thuộc tính của chính mối quan hệ đó cũng được đưa vào bảng này.
6. **Quy tắc 6 (Thuộc tính đa trị)**: Tạo bảng riêng gồm `(Owner_PK, Multivalued_Attribute)`. Khóa chính là tổ hợp của cả 2 cột.
7. **Quy tắc 7 (Chuyên biệt hóa / Kế thừa ISA)**:
   - Cách 1 (Chuẩn ER): Bảng cha chứa thuộc tính chung (PK chung), các bảng con chứa thuộc tính riêng + PK là FK trỏ về cha.
   - Cách 2 (Single Table): Gộp tất cả vào một bảng lớn kèm cột cờ `Type` (chấp nhận các cột riêng có giá trị NULL).

---

## 3. Case Study Lab 3: Quản lý Trường Đại học

### 3.1. Phân tích yêu cầu bài toán
- **Khoa (Department)**: Quản lý giảng viên, môn học, lớp. Có trưởng khoa là 1 giảng viên (`ManagerID`, `StartDate`).
- **Giảng viên (Instructor)**: Thuộc 1 khoa, có thể dạy nhiều môn (`TEACH`), có nhiều bằng cấp (`QUALIFICATION` - thuộc tính đa trị).
- **Môn học (Subject)**: Thuộc 1 khoa, có môn tiên quyết (`PREREQUISITE` - quan hệ đệ quy M:N).
- **Lớp học (Class)**: Thuộc 1 khoa, có 1 giáo viên chủ nhiệm (`SupervisorID`), chia thành các lớp học phần (`Section`).
- **Sinh viên (Student)**: Thuộc 1 lớp hành chính, có mã SV duy nhất, số CMND/CCCD (`SSN`) duy nhất.
- **Lớp học phần (Section)**: Là thực thể yếu phụ thuộc vào `Class`, phân biệt bằng `TrainingYear`, `Semester`, `SectionNo`. Dạy 1 môn học và do 1 giảng viên phụ trách.
- **Bảng điểm (Grade Report)**: Kết quả của sinh viên trong một Section. Gồm điểm lý thuyết, điểm thực hành, điểm thi lại lý thuyết. Điểm tổng kết và trạng thái đậu/rớt là thuộc tính suy dẫn $\to$ không lưu.

### 3.2. Sơ đồ ERD (Mermaid)

```mermaid
erDiagram
    DEPARTMENT ||--o{ INSTRUCTOR : "employs"
    DEPARTMENT ||--|| INSTRUCTOR : "managed_by"
    DEPARTMENT ||--o{ SUBJECT : "offers"
    DEPARTMENT ||--o{ CLASS : "manages"
    INSTRUCTOR ||--o{ QUALIFICATION : "holds"
    INSTRUCTOR }|--|{ SUBJECT : "teaches"
    SUBJECT }|--|{ SUBJECT : "prerequisite"
    CLASS ||--o{ STUDENT : "contains"
    CLASS ||--|{ SECTION : "divided_into"
    INSTRUCTOR ||--o{ SECTION : "assigned_to"
    SUBJECT ||--o{ SECTION : "for_subject"
    STUDENT ||--o{ GRADE_REPORT : "receives"
    SECTION ||--o{ GRADE_REPORT : "has_grades"
```

### 3.3. Lược đồ quan hệ hoàn chỉnh (Relational Schema)

*(Ghi chú: Thuộc tính gạch chân hoặc in đậm là Khóa chính - PK)*

1. **`DEPARTMENT`** (<u>`DeptCode`</u>, `DeptName`, `OfficeNumber`, `OfficePhone`, `ManagerID`, `ManageStartDate`)
   - FK: `ManagerID` $\to$ `INSTRUCTOR(InstructorID)`
2. **`INSTRUCTOR`** (<u>`InstructorID`</u>, `Name`, `BirthDate`, `StartDate`, `Sex`, `DeptCode`)
   - FK: `DeptCode` $\to$ `DEPARTMENT(DeptCode)`
3. **`QUALIFICATION`** (<u>`InstructorID`, `SpecializedTraining`, `Institution`</u>, `GraduationYear`)
   - FK: `InstructorID` $\to$ `INSTRUCTOR(InstructorID)`
4. **`SUBJECT`** (<u>`SubjectCode`</u>, `SubjectName`, `TotalCredit`, `TheoryCredit`, `PracticeCredit`, `DeptCode`)
   - FK: `DeptCode` $\to$ `DEPARTMENT(DeptCode)`
5. **`PREREQUISITE`** (<u>`SubjectCode`, `PrereqSubjectCode`</u>)
   - FK: `SubjectCode` $\to$ `SUBJECT(SubjectCode)`
   - FK: `PrereqSubjectCode` $\to$ `SUBJECT(SubjectCode)`
6. **`TEACH`** (<u>`InstructorID`, `SubjectCode`</u>, `StartDate`, `EndDate`)
   - FK: `InstructorID` $\to$ `INSTRUCTOR(InstructorID)`
   - FK: `SubjectCode` $\to$ `SUBJECT(SubjectCode)`
7. **`CLASS`** (<u>`ClassCode`</u>, `CourseworkProgram`, `DeptCode`, `SupervisorID`)
   - FK: `DeptCode` $\to$ `DEPARTMENT(DeptCode)`
   - FK: `SupervisorID` $\to$ `INSTRUCTOR(InstructorID)`
8. **`STUDENT`** (<u>`StudentNumber`</u>, `SSN`, `Name`, `BirthDate`, `Sex`, `CurrentAddress`, `CurrentPhone`, `PermanentAddress`, `PermanentPhone`, `ClassCode`)
   - Unique: `SSN`
   - FK: `ClassCode` $\to$ `CLASS(ClassCode)`
9. **`SECTION`** (<u>`ClassCode`, `TrainingYear`, `Semester`, `SectionNo`</u>, `SubjectCode`, `InstructorID`)
   - FK: `ClassCode` $\to$ `CLASS(ClassCode)`
   - FK: `SubjectCode` $\to$ `SUBJECT(SubjectCode)`
   - FK: `InstructorID` $\to$ `INSTRUCTOR(InstructorID)`
10. **`GRADE_REPORT`** (<u>`StudentNumber`, `ClassCode`, `TrainingYear`, `Semester`, `SectionNo`</u>, `TheoryGrade`, `PracticeGrade`, `RetakeTheoryGrade`)
    - FK: `StudentNumber` $\to$ `STUDENT(StudentNumber)`
    - FK: `(ClassCode, TrainingYear, Semester, SectionNo)` $\to$ `SECTION`

---

## 4. Các bẫy thiết kế thường gặp

1. **Quên tạo bảng trung gian cho quan hệ M:N**: Nhét danh sách mã môn học vào cột của giảng viên vi phạm 1NF ngay lập tức!
2. **Lưu thuộc tính suy dẫn**: Điểm tổng kết (`TotalScore`), trạng thái `Pass/Fail`, tuổi (`Age`), tổng tiền (`Total`) phải tính khi truy vấn, tuyệt đối không tạo cột trong DB vì sẽ gây dị thường cập nhật khi điểm thành phần thay đổi.
3. **Xác định sai thực thể yếu**: `Section` không thể tồn tại độc lập nếu thiếu `ClassCode`, do đó khóa chính của nó bắt buộc phải ghép `ClassCode` với `SectionNo`.
