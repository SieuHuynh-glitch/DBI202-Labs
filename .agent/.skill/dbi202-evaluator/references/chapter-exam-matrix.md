# Ma trận đề thi và Trọng số kiến thức 8 Chương (Chapter Exam Matrix)

Tài liệu này tổng hợp cấu trúc đề thi FE (Final Exam) và PE (Practical Exam) của môn **DBI202 (Database Systems)** tại Đại học FPT, dựa trên hệ thống bài giảng Chapters 1–8.

---

## 📑 Bảng mục lục
1. [Ma trận đề thi trắc nghiệm (FE Exam Blueprint)](#1-ma-trận-đề-thi-trắc-nghiệm-fe)
2. [Chi tiết trọng tâm kiến thức theo 8 Chapters](#2-chi-tiết-trọng-tâm-kiến-thức-theo-8-chapters)
3. [Cấu trúc bài thi thực hành (PE Exam Blueprint)](#3-cấu-trúc-bài-thi-thực-hành-pe)

---

## 1. Ma trận đề thi trắc nghiệm FE

Đề thi FE thông thường gồm **60 câu hỏi trắc nghiệm** (thời gian làm bài: 60 - 90 phút). Tỷ lệ phân bổ câu hỏi theo từng chương như sau:

| Chương | Nội dung bài học | Số câu ước lượng | Tỷ lệ (%) | Mức độ nhận thức chính |
|---|---|:---:|:---:|---|
| **Chapter 1** | Introduction to Database System | 3 – 5 câu | ~6% | Nhận biết & Thông hiểu |
| **Chapter 2** | The Relational Model of Data | 5 – 7 câu | ~10% | Thông hiểu & Vận dụng |
| **Chapter 3** | Design Theory & Normalization | 10 – 14 câu | ~20% | Vận dụng & Vận dụng cao |
| **Chapter 4** | High-Level Database Model (ERD) | 6 – 8 câu | ~12% | Vận dụng |
| **Chapter 5** | Bags Concept (Multi-sets) | 2 – 4 câu | ~5% | Thông hiểu |
| **Chapter 6** | The Database Language SQL | 12 – 16 câu | ~25% | Vận dụng & Vận dụng cao |
| **Chapter 7** | Practical Issues (Index, ACID, Concurrency) | 6 – 8 câu | ~12% | Thông hiểu & Vận dụng |
| **Chapter 8** | Database Programming (Triggers, SP, UDF) | 5 – 7 câu | ~10% | Vận dụng |
| **Tổng cộng** | **Toàn bộ chương trình DBI202** | **60 câu** | **100%** | **Bao phủ toàn diện** |

---

## 2. Chi tiết trọng tâm kiến thức theo 8 Chapters

### 📘 Chapter 1: Introduction to Databases
- Khái niệm Database, DBMS, Database System.
- So sánh DBMS với File-processing system (Data redundancy, Inconsistency, Difficulty in accessing data, Concurrent access anomalies, Security).
- Kiến trúc 3 tầng ANSI/SPARC: Internal/Physical level, Conceptual/Logical level, External/View level.
- Tính độc lập dữ liệu: Physical Data Independence vs Logical Data Independence.

### 📘 Chapter 2: The Relational Model of Data
- Khái niệm Relation (Bảng), Attribute (Cột), Tuple (Dòng), Domain (Miền giá trị).
- Các loại khóa:
  - Superkey: Tập thuộc tính phân biệt duy nhất các bộ.
  - Candidate Key: Superkey tối tiểu (minimal superkey).
  - Primary Key: Khóa ứng viên được chọn làm định danh chính.
  - Foreign Key: Thuộc tính tham chiếu đến Primary Key của bảng khác.
- Ràng buộc toàn vẹn: Entity Integrity (PK không được NULL), Referential Integrity (FK phải tồn tại trong bảng cha hoặc mang giá trị NULL).

### 📘 Chapter 3: Design Theory for Relational Databases
- Định nghĩa Phụ thuộc hàm (FD: $X \to Y$).
- Hệ tiên đề Armstrong: Tính phản xạ, tăng trưởng, bắc cầu.
- Thuật toán tính bao đóng thuộc tính $X^+$.
- Thuật toán tìm Candidate Keys từ tập FD.
- Dị thường dữ liệu (Insertion, Deletion, Update Anomalies).
- 4 Dạng chuẩn:
  - 1NF: Dữ liệu nguyên tố, không nhóm lặp.
  - 2NF: Đạt 1NF + Không có phụ thuộc một phần vào khóa chính.
  - 3NF: Đạt 2NF + Không có phụ thuộc bắc cầu (Với mọi $X \to A$, $X$ là superkey hoặc $A$ là thuộc tính khóa).
  - BCNF: Với mọi FD không tầm thường $X \to A$, $X$ bắt buộc phải là superkey.
- Bảo toàn thông tin (Lossless Join Decomposition) và Bảo toàn phụ thuộc (Dependency Preservation).

### 📘 Chapter 4: High-Level Database Model (ERD)
- Mô hình ER: Entity, Weak Entity, Attributes (Simple, Composite, Multivalued, Derived, Key).
- Quan hệ và bản số: 1:1, 1:N, M:N. Ràng buộc tham gia: Total vs Partial.
- Mối quan hệ đệ quy (Recursive Relationship) và vai trò (Roles).
- Chuyên biệt hóa / Kế thừa (Subclasses / ISA hierarchy).
- 7 Quy tắc chuyển đổi ERD sang Lược đồ quan hệ.

### 📘 Chapter 5: Bags Concept (Multisets)
- Sự khác biệt giữa Set (Tập hợp không chứa phần tử trùng) và Bag/Multiset (Tập đa phần tử cho phép trùng lặp).
- Lý do DBMS thương mại dùng Bag: Hiệu năng (không mất chi phí khử trùng lặp sau mỗi phép chiếu).
- Các phép toán trên Bag:
  - Bag Union: Số lần xuất hiện của phần tử $x$ bằng tổng số lần xuất hiện ở 2 bảng.
  - Bag Intersection: Số lần xuất hiện của $x$ bằng giá trị nhỏ nhất (MIN).
  - Bag Difference: Số lần xuất hiện bằng hiệu (nếu âm thì bằng 0).
- Các toán tử mở rộng: $\delta(R)$ (Duplicate elimination - DISTINCT), $\gamma(R)$ (Grouping & Aggregation), $\tau(R)$ (Sorting - ORDER BY).

### 📘 Chapter 6: The Database Language SQL
- SQL DDL: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, `ADD CONSTRAINT` (PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT, UNIQUE).
- SQL DML:
  - `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`.
  - Các loại Join: `INNER JOIN`, `LEFT OUTER JOIN`, `RIGHT OUTER JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`.
  - Subqueries: Scalar subquery, Correlated subquery (truy vấn con tương quan), các toán tử `EXISTS`, `NOT EXISTS`, `IN`, `NOT IN`, `ALL`, `ANY`.
- Xử lý giá trị `NULL` và logic 3 giá trị (TRUE, FALSE, UNKNOWN).

### 📘 Chapter 7: Practical Issues of Database Application
- Cấu trúc lưu trữ & Chỉ mục (Indexes):
  - Clustered Index: Quyết định thứ tự vật lý của các dòng trên đĩa; mỗi bảng chỉ có tối đa 1 Clustered Index (mặc định tạo trên Primary Key).
  - Non-clustered Index: Cấu trúc B-Tree riêng biệt chứa con trỏ trỏ về dòng dữ liệu; một bảng có thể có nhiều Non-clustered Index.
- Giao dịch (Transactions) và 4 thuộc tính ACID:
  - **Atomicity** (Tính nguyên tố): All or Nothing.
  - **Consistency** (Tính nhất quán): CSDL luôn chuyển từ trạng thái hợp lệ này sang trạng thái hợp lệ khác.
  - **Isolation** (Tính cô lập): Các giao dịch chạy đồng thời không ảnh hưởng lẫn nhau.
  - **Durability** (Tính bền vững): Dữ liệu đã commit không bị mất khi có sự cố sập nguồn.
- Các hiện tượng tranh chấp đồng thời (Concurrency Anomalies): Dirty Read, Non-repeatable Read, Phantom Read.
- 4 Mức cô lập (Isolation Levels): Read Uncommitted, Read Committed, Repeatable Read, Serializable.

### 📘 Chapter 8: Database Programming on SQL Server
- Biến trong T-SQL (`DECLARE @var INT`), cấu trúc rẽ nhánh (`IF...ELSE`), vòng lặp (`WHILE`).
- Khung nhìn (Views): Virtual table, cập nhật dữ liệu qua View.
- Thủ tục lưu trữ (Stored Procedures): Tham số đầu vào (`INPUT`), tham số đầu ra (`OUTPUT`), mã trả về (`RETURN`).
- Hàm người dùng định nghĩa (User-Defined Functions - UDF): Scalar Function (trả về 1 giá trị) vs Table-Valued Function (trả về 1 bảng). *Lưu ý: UDF không được phép thay đổi trạng thái CSDL (không được INSERT/UPDATE/DELETE).*
- Triggers:
  - `AFTER / FOR Trigger`: Kích hoạt sau khi thao tác DML thành công.
  - `INSTEAD OF Trigger`: Kích hoạt thay thế hoàn toàn cho thao tác DML (thường dùng trên View phức tạp).
  - Hai bảng logic đặc biệt: `inserted` (chứa dữ liệu mới thêm hoặc giá trị mới sau khi update) và `deleted` (chứa dữ liệu bị xóa hoặc giá trị cũ trước khi update).

---

## 3. Cấu trúc bài thi thực hành PE

Bài thi PE thường gồm **10 câu truy vấn và lập trình SQL** trên phần mềm SQL Server (thời gian: 60 - 90 phút):
1. **Câu 1**: Tạo bảng với đầy đủ PK, FK, CHECK constraint (DDL).
2. **Câu 2 - 4**: Truy vấn cơ bản, lọc dữ liệu với `LIKE`, `BETWEEN`, `ORDER BY`.
3. **Câu 5 - 6**: Truy vấn nối bảng (`INNER JOIN`, `LEFT JOIN`), gom nhóm dữ liệu (`GROUP BY`, `HAVING`).
4. **Câu 7 - 8**: Truy vấn con nâng cao (`Subquery`, `EXISTS`, `NOT EXISTS`, `CTE`).
5. **Câu 9**: Viết Stored Procedure hoặc User-Defined Function có kiểm tra điều kiện.
6. **Câu 10**: Viết Trigger kiểm soát toàn vẹn dữ liệu (sử dụng bảng `inserted` hoặc `deleted`).
