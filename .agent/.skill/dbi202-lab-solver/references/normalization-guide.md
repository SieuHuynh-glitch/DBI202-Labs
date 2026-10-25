# Hướng dẫn chi tiết Chuẩn hóa cơ sở dữ liệu (Database Normalization Guide)

Tài liệu tham khảo chuyên sâu cho môn học **DBI202 (Database Systems)** - Đại học FPT, phục vụ giải quyết bài tập dạng Lab 2 và các câu hỏi lý thuyết / chuẩn hóa trong bài thi.

---

## 📑 Bảng mục lục
1. [Khái niệm cốt lõi & Phụ thuộc hàm (FDs)](#1-khái-niệm-cốt-lõi--phụ-thuộc-hàm)
2. [Hệ tiên đề Armstrong & Thuật toán tính Bao đóng (Closure)](#2-hệ-tiên-đề-armstrong--thuật-toán-bao-đóng)
3. [4 Dạng chuẩn (1NF, 2NF, 3NF, BCNF)](#3-4-dạng-chuẩn-1nf-2nf-3nf-bcnf)
4. [Quy trình giải bài toán chuẩn hóa từ Báo cáo / Hóa đơn](#4-quy-trình-chuẩn-hóa-từ-báo-cáo--hóa-đơn)
5. [Giải chi tiết 2 Case Study trong Lab 2 mẫu](#5-giải-chi-tiết-2-case-study-trong-lab-2)

---

## 1. Khái niệm cốt lõi & Phụ thuộc hàm

### 1.1. Phụ thuộc hàm (Functional Dependency - FD)
Cho lược đồ quan hệ $R(A_1, A_2, \dots, A_n)$. Phụ thuộc hàm $X \to Y$ (với $X, Y \subseteq R$) phát biểu rằng:
> Nếu hai bộ $t_1, t_2$ có cùng giá trị trên tập thuộc tính $X$ ($t_1[X] = t_2[X]$), thì chúng bắt buộc phải có cùng giá trị trên tập thuộc tính $Y$ ($t_1[Y] = t_2[Y]$).

- **$X$ gọi là vế trái (Determinant - Định thức)**.
- **$Y$ gọi là vế phải (Dependent - Thuộc tính phụ thuộc)**.
- **Tầm thường (Trivial FD)**: $X \to Y$ là tầm thường nếu $Y \subseteq X$ (ví dụ: $\{A, B\} \to A$).

### 1.2. Các dị thường dữ liệu (Anomalies) khi chưa chuẩn hóa
1. **Redundancy (Dư thừa dữ liệu)**: Lặp lại thông tin giống nhau ở nhiều hàng, tốn dung lượng.
2. **Insertion Anomaly (Dị thường thêm)**: Không thể thêm một sự kiện mới nếu thiếu thông tin ở một thực thể khác (VD: Không thể thêm thông tin phòng ban mới nếu chưa có nhân viên nào).
3. **Deletion Anomaly (Dị thường xóa)**: Xóa một dòng dữ liệu vô tình làm mất hoàn toàn thông tin quan trọng khác (VD: Xóa nhân viên duy nhất trong phòng ban làm mất luôn thông tin phòng ban đó).
4. **Update Anomaly (Dị thường sửa)**: Sửa thông tin ở 1 dòng nhưng quên sửa ở các dòng khác $\to$ dữ liệu mất tính nhất quán.

---

## 2. Hệ tiên đề Armstrong & Thuật toán Bao đóng

### 2.1. Hệ 3 tiên đề Armstrong cơ bản
1. **Tính phản xạ (Reflexivity)**: Nếu $Y \subseteq X$, thì $X \to Y$.
2. **Tính tăng trưởng (Augmentation)**: Nếu $X \to Y$, thì $XZ \to YZ$ (với mọi $Z$).
3. **Tính bắc cầu (Transitivity)**: Nếu $X \to Y$ và $Y \to Z$, thì $X \to Z$.

**Các quy tắc suy diễn mở rộng**:
- **Hợp (Union)**: Nếu $X \to Y$ và $X \to Z$, thì $X \to YZ$.
- **Phân rã (Decomposition)**: Nếu $X \to YZ$, thì $X \to Y$ và $X \to Z$.
- **Giả bắc cầu (Pseudo-transitivity)**: Nếu $X \to Y$ và $WY \to Z$, thì $WX \to Z$.

### 2.2. Thuật toán tính Bao đóng của tập thuộc tính ($X^+$)
- **Input**: Tập thuộc tính $X$, tập phụ thuộc hàm $F$.
- **Output**: Bao đóng $X^+$ đối với $F$.
- **Các bước**:
  1. Khởi tạo: $X^{(0)} = X$.
  2. Lặp: Với mỗi $Y \to Z \in F$, nếu $Y \subseteq X^{(i)}$, thì $X^{(i+1)} = X^{(i)} \cup Z$.
  3. Dừng lại khi không còn thuộc tính nào được thêm vào ($X^{(i+1)} = X^{(i)}$). Khi đó $X^+ = X^{(i)}$.

> 🔑 **Xác định Khóa ứng viên (Candidate Key)**:
> - Một tập thuộc tính $K$ là **Superkey** nếu $K^+ = R$.
> - $K$ là **Candidate Key** nếu $K$ là Superkey và không có tập con thực sự nào của $K$ là Superkey.
> - **Mẹo**: Những thuộc tính không bao giờ xuất hiện ở vế phải của bất kỳ FD nào bắt buộc phải nằm trong mọi Candidate Key!

---

## 3. 4 Dạng chuẩn (1NF, 2NF, 3NF, BCNF)

| Dạng chuẩn | Định nghĩa chính thức | Mục tiêu loại bỏ |
|---|---|---|
| **1NF** (First Normal Form) | Mọi thuộc tính đều chứa **giá trị nguyên tố (Atomic values)**, không chứa nhóm lặp (repeating groups) hay mảng/đa trị. | Loại bỏ đa trị & nhóm lặp |
| **2NF** (Second Normal Form) | Đạt 1NF và **mọi thuộc tính không khóa đều phụ thuộc đầy đủ vào khóa chính** (không có phụ thuộc một phần). | Loại bỏ phụ thuộc một phần (*Partial dependency*) |
| **3NF** (Third Normal Form) | Đạt 2NF và **mọi thuộc tính không khóa không phụ thuộc bắc cầu vào khóa chính**. Hoặc với mọi FD $X \to A$, hoặc $X$ là superkey, hoặc $A$ là thuộc tính khóa (*prime attribute*). | Loại bỏ phụ thuộc bắc cầu (*Transitive dependency*) |
| **BCNF** (Boyce-Codd Normal Form) | Với mọi FD không tầm thường $X \to A$, **$X$ bắt buộc phải là Superkey**. | Loại bỏ mọi định thức không phải là siêu khóa |

---

## 4. Quy trình chuẩn hóa từ Báo cáo / Hóa đơn

```
[Báo cáo / Hóa đơn thô]
        │
        ▼ (Bước 0: Bỏ thuộc tính suy dẫn: Total, Tax, Age...)
[1NF: Bảng phẳng + Composite Key]
        │
        ▼ (Bước 1: Tách các FDs phụ thuộc vào một phần Composite Key)
[2NF: Các bảng tách riêng theo từng phần khóa]
        │
        ▼ (Bước 2: Tách các FDs không khóa phụ thuộc vào không khóa khác)
[3NF: Các bảng quan hệ chuẩn hóa hoàn chỉnh]
```

---

## 5. Giải chi tiết 2 Case Study trong Lab 2

### Case Study 1: Healthy History Report (Hồ sơ khám chữa bệnh thú cưng)

**Bảng dữ liệu mẫu**:
```
PET ID | PET NAME | PET TYPE | PET AGE | OWNER     | VISIT DATE  | PROCEDURE
246    | ROVER    | DOG      | 12      | SAM COOK  | JAN 13/2002 | 01 - RABIES VACCINATION
       |          |          |         |           | MAR 27/2002 | 10 - EXAMINE and TREAT WOUND
       |          |          |         |           | APR 02/2002 | 05 - HEART WORM TEST
```

#### Bước 1: 1NF (Loại bỏ nhóm lặp)
Tất cả các dòng được điền đầy đủ dữ liệu nguyên tố. Nhóm lặp {VisitDate, Procedure} được trải phẳng.
- **Lược đồ**:
  `HEALTHY_REPORT(PetID, VisitDate, ProcedureID, PetName, PetType, PetAge, Owner, ProcedureName)`
- **Khóa chính**: `(PetID, VisitDate, ProcedureID)`
- **Tập phụ thuộc hàm (FDs)**:
  - $FD_1: \text{PetID} \to \text{PetName, PetType, PetAge, Owner}$
  - $FD_2: \text{ProcedureID} \to \text{ProcedureName}$
  - $FD_3: (\text{PetID, VisitDate, ProcedureID}) \to \text{các thuộc tính của lần khám}$

#### Bước 2: 2NF (Khử phụ thuộc một phần)
Khóa chính là `(PetID, VisitDate, ProcedureID)`.
- $FD_1$ chỉ phụ thuộc vào `PetID` (một phần của khóa) $\to$ vi phạm 2NF!
- $FD_2$ chỉ phụ thuộc vào `ProcedureID` (một phần của khóa) $\to$ vi phạm 2NF!
$\Rightarrow$ Tách thành 3 bảng:
1. `PETS(PetID, PetName, PetType, PetAge, Owner)` — PK: `PetID`
2. `PROCEDURES(ProcedureID, ProcedureName)` — PK: `ProcedureID`
3. `VISITS(PetID, VisitDate, ProcedureID)` — PK: `(PetID, VisitDate, ProcedureID)`, FK: `PetID` tham chiếu `PETS`, `ProcedureID` tham chiếu `PROCEDURES`.

#### Bước 3: 3NF (Khử phụ thuộc bắc cầu)
Trong bảng `PETS`:
Nếu coi `Owner` là một thực thể độc lập có mã định danh `OwnerID` hoặc `OwnerName` quản lý thông tin chủ nhân, ta tách:
1. `OWNERS(OwnerID, OwnerName)` — PK: `OwnerID`
2. `PETS(PetID, PetName, PetType, PetAge, OwnerID)` — PK: `PetID`, FK: `OwnerID` tham chiếu `OWNERS`.
3. `PROCEDURES(ProcedureID, ProcedureName)` — PK: `ProcedureID`
4. `VISITS(PetID, VisitDate, ProcedureID)` — PK: `(PetID, VisitDate, ProcedureID)`

---

### Case Study 2: Hilltop Animal Hospital Invoice (Hóa đơn viện thú y)

**Dữ liệu trên hóa đơn**:
- Thông tin chung: Invoice # 987, Date: JAN 13/2002
- Thông tin khách hàng: Mr. Richard Cook, 123 This Street, My City, Ontario, Z5Z 6G6
- Dòng chi tiết (Lines):
  - Pet: Rover, Procedure: Rabies Vaccination, Amount: 30.00
  - Pet: Morris, Procedure: Rabies Vaccination, Amount: 24.00
- Tổng kết: Total: 54.00, Tax (8%): 4.32, Amount Owing: 58.32

#### Bước 0: Nhận diện thuộc tính suy dẫn (Derived Attributes)
- `Total = SUM(Amount)`
- `Tax = 8% * Total`
- `Amount Owing = Total + Tax`
$\Rightarrow$ **KHÔNG LƯU** `Total`, `Tax`, `Amount Owing` vào bất kỳ bảng nào!

#### Bước 1: 1NF
Trải phẳng nhóm lặp dịch vụ thú cưng:
- `INVOICE_1NF(InvoiceNo, InvoiceDate, CustomerName, Street, City, Province, PostalCode, PetID, ProcedureID, Amount)`
- **Khóa chính**: `(InvoiceNo, PetID, ProcedureID)`

#### Bước 2: 2NF
Phân tích phụ thuộc hàm:
- `InvoiceNo` $\to$ `InvoiceDate, CustomerName, Street, City, Province, PostalCode` (Phụ thuộc một phần)
- `(InvoiceNo, PetID, ProcedureID)` $\to$ `Amount` (Phụ thuộc toàn phần)
$\Rightarrow$ Tách thành:
1. `INVOICE(InvoiceNo, InvoiceDate, CustomerName, Street, City, Province, PostalCode)` — PK: `InvoiceNo`
2. `INVOICE_DETAIL(InvoiceNo, PetID, ProcedureID, Amount)` — PK: `(InvoiceNo, PetID, ProcedureID)`

#### Bước 3: 3NF
Trong bảng `INVOICE`:
Có phụ thuộc bắc cầu: `InvoiceNo` $\to$ `CustomerName` $\to$ `Street, City, Province, PostalCode`. Do tên khách hàng có thể trùng lặp, chuẩn hóa bằng cách thêm `CustomerID`:
1. `CUSTOMER(CustomerID, CustomerName, Street, City, Province, PostalCode)` — PK: `CustomerID`
2. `INVOICE(InvoiceNo, InvoiceDate, CustomerID)` — PK: `InvoiceNo`, FK: `CustomerID`
3. `INVOICE_DETAIL(InvoiceNo, PetID, ProcedureID, Amount)` — PK: `(InvoiceNo, PetID, ProcedureID)`, FK: `InvoiceNo` tham chiếu `INVOICE`.
*(Lưu ý: PetID và ProcedureID có thể tham chiếu đến bảng PET và PROCEDURE đã chuẩn hóa ở Case 1).*
