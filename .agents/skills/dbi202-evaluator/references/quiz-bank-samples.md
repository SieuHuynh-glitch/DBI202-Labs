# Ngân hàng câu hỏi trắc nghiệm mẫu 8 Chương (DBI202 Quiz Bank)

Ngân hàng câu hỏi trắc nghiệm chuẩn đại học FPT, biên soạn trực tiếp từ hệ thống Slide và tài liệu học tập của môn **DBI202 (Database Systems)**. Mỗi câu đều kèm đáp án và phân tích chi tiết.

---

## 📑 Bảng mục lục
1. [Chapter 1: Introduction to Databases](#chapter-1-introduction-to-databases)
2. [Chapter 2: The Relational Model of Data](#chapter-2-the-relational-model-of-data)
3. [Chapter 3: Design Theory & Normal Forms](#chapter-3-design-theory--normal-forms)
4. [Chapter 4: High-Level Database Model (ERD)](#chapter-4-high-level-database-model-erd)
5. [Chapter 5: Bags Concept (Multisets)](#chapter-5-bags-concept-multisets)
6. [Chapter 6: The Database Language SQL](#chapter-6-the-database-language-sql)
7. [Chapter 7: Practical Issues (Index, ACID, Concurrency)](#chapter-7-practical-issues)
8. [Chapter 8: Database Programming on SQL Server](#chapter-8-database-programming)

---

## Chapter 1: Introduction to Databases

### Câu 1.1
Khả năng thay đổi lược đồ vật lý (Physical schema) mà không làm thay đổi lược đồ quan niệm (Conceptual schema) được gọi là gì?
- **A.** Logical Data Independence
- **B.** Physical Data Independence
- **C.** Schema Evolution
- **D.** Data Redundancy
> **Đáp án đúng: B**
> **Giải thích**: 
> - *Physical Data Independence* là tính độc lập dữ liệu vật lý, cho phép thay đổi cấu trúc lưu trữ hoặc đánh chỉ mục mà không ảnh hưởng đến mức quan niệm/logic.
> - *Logical Data Independence* (A) là khả năng thay đổi mức quan niệm mà không làm thay đổi mức view ngoài (External/View level).

### Câu 1.2
Nhược điểm nào sau đây KHÔNG PHẢI là vấn đề chính của hệ thống xử lý tệp truyền thống (File-processing system) khi so sánh với DBMS?
- **A.** Dư thừa và không nhất quán dữ liệu (Data redundancy and inconsistency)
- **B.** Khó khăn trong việc truy cập dữ liệu (Difficulty in accessing data)
- **C.** Hỗ trợ tính độc lập dữ liệu cao (High data independence)
- **D.** Dị thường khi truy cập đồng thời (Concurrent access anomalies)
> **Đáp án đúng: C**
> **Giải thích**: Hệ thống tệp truyền thống có mức độ phụ thuộc dữ liệu rất cao (phần mềm gắn liền với định dạng tệp), do đó "High data independence" là một ưu điểm của DBMS chứ không phải của File system.

---

## Chapter 2: The Relational Model of Data

### Câu 2.1
Một tập thuộc tính $K$ được gọi là **Candidate Key** của lược đồ quan hệ $R$ khi và chỉ khi:
- **A.** $K$ là một siêu khóa (Superkey) bất kỳ.
- **B.** $K$ là một siêu khóa tối tiểu (Minimal Superkey), nghĩa là không có tập con thực sự nào của $K$ cũng là siêu khóa.
- **C.** $K$ chứa toàn bộ các thuộc tính của quan hệ $R$.
- **D.** $K$ là khóa ngoại tham chiếu đến bảng khác.
> **Đáp án đúng: B**
> **Giải thích**: Theo định nghĩa chuẩn trong Chapter 2, Candidate Key là một siêu khóa mà khi ta loại bỏ bất kỳ thuộc tính nào ra khỏi nó, tập còn lại không còn là siêu khóa nữa (tính tối tiểu).

### Câu 2.2
Ràng buộc toàn vẹn thực thể (Entity Integrity Constraint) quy định điều gì đối với Primary Key?
- **A.** Khóa chính có thể nhận giá trị NULL nếu các cột khác đã duy nhất.
- **B.** Khóa chính không được phép chứa giá trị NULL ở bất kỳ thuộc tính thành phần nào.
- **C.** Khóa chính phải luôn là kiểu số nguyên tự tăng.
- **D.** Khóa chính phải tham chiếu đến một khóa ngoại tương ứng.
> **Đáp án đúng: B**
> **Giải thích**: Ràng buộc toàn vẹn thực thể nghiêm cấm mọi thuộc tính tham gia vào Primary Key nhận giá trị NULL.

---

## Chapter 3: Design Theory & Normal Forms

### Câu 3.1
Cho lược đồ $R(A, B, C, D)$ và tập phụ thuộc hàm $F = \{A \to B, B \to C, C \to D\}$. Bao đóng của thuộc tính $A$ ($A^+$) là:
- **A.** $\{A, B\}$
- **B.** $\{A, B, C\}$
- **C.** $\{A, B, C, D\}$
- **D.** $\{A, D\}$
> **Đáp án đúng: C**
> **Giải thích**: Khởi tạo $A^{(0)} = \{A\}$. Với $A \to B \Rightarrow \{A, B\}$. Với $B \to C \Rightarrow \{A, B, C\}$. Với $C \to D \Rightarrow \{A, B, C, D\}$. Vậy $A^+ = \{A, B, C, D\}$. $A$ chính là một Candidate Key của $R$.

### Câu 3.2
Một lược đồ quan hệ đạt dạng chuẩn **3NF (Third Normal Form)** khi nào?
- **A.** Đạt 1NF và mọi thuộc tính không khóa phụ thuộc đầy đủ vào khóa chính.
- **B.** Đạt 2NF và không có thuộc tính không khóa nào phụ thuộc bắc cầu vào khóa chính.
- **C.** Mọi phụ thuộc hàm không tầm thường $X \to Y$ đều có $X$ là siêu khóa.
- **D.** Không chứa bất kỳ mối quan hệ nhiều - nhiều nào.
> **Đáp án đúng: B**
> **Giải thích**: 
> - A là định nghĩa của 2NF.
> - B là định nghĩa chuẩn của 3NF (khử phụ thuộc bắc cầu giữa các thuộc tính không khóa).
> - C là định nghĩa của BCNF (khắt khe hơn 3NF).

---

## Chapter 4: High-Level Database Model (ERD)

### Câu 4.1
Trong mô hình ERD, một **Thực thể yếu (Weak Entity)** được định danh bằng cách nào?
- **A.** Tự có một thuộc tính khóa chính độc lập.
- **B.** Kết hợp khóa của thực thể chủ (Owner Entity) với khóa bộ phận (Discriminator) của chính nó.
- **C.** Chỉ cần một thuộc tính bất kỳ có giá trị duy nhất.
- **D.** Không bao giờ có thể xác định được khóa chính.
> **Đáp án đúng: B**
> **Giải thích**: Thực thể yếu không có đủ thuộc tính để tự tạo khóa chính, do đó khóa của nó bắt buộc phải ghép giữa Primary Key của thực thể chủ và Discriminator (thuộc tính phân biệt) của thực thể yếu.

### Câu 4.2
Khi chuyển đổi một mối quan hệ **Nhiều - Nhiều (M:N)** từ ERD sang mô hình quan hệ, quy tắc chuẩn là:
- **A.** Đặt khóa chính của bảng bên trái làm khóa ngoại ở bảng bên phải.
- **B.** Tạo một bảng liên kết trung gian mới với khóa chính gồm khóa chính của cả hai thực thể tham gia.
- **C.** Gộp cả hai thực thể vào một bảng duy nhất.
- **D.** Đặt khóa chính của bảng bên phải làm khóa ngoại ở bảng bên trái.
> **Đáp án đúng: B**
> **Giải thích**: Mối quan hệ M:N bắt buộc phải được phân rã thành một bảng trung gian (Junction Table) để tránh vi phạm dạng chuẩn 1NF (nhóm lặp).

---

## Chapter 5: Bags Concept (Multisets)

### Câu 5.1
Cho hai Bag $R = \{1, 1, 2, 2, 2, 3\}$ và $S = \{1, 2, 2, 4\}$. Kết quả của phép toán **Bag Intersection ($R \cap S$)** là:
- **A.** $\{1, 2\}$
- **B.** $\{1, 2, 2\}$
- **C.** $\{1, 1, 2, 2, 2, 3, 4\}$
- **D.** $\{1, 2, 2, 2\}$
> **Đáp án đúng: B**
> **Giải thích**: Trong đại số quan hệ trên Bag, số lần xuất hiện của một phần tử trong phép giao bằng $\min(\text{count}_R, \text{count}_S)$:
> - Số 1 xuất hiện: $\min(2, 1) = 1$ lần.
> - Số 2 xuất hiện: $\min(3, 2) = 2$ lần.
> - Số 3 xuất hiện: $\min(1, 0) = 0$ lần.
> - Số 4 xuất hiện: $\min(0, 1) = 0$ lần.
> Kết quả là $\{1, 2, 2\}$.

---

## Chapter 6: The Database Language SQL

### Câu 6.1
Trong SQL, mệnh đề `HAVING` khác mệnh đề `WHERE` ở điểm nào?
- **A.** `HAVING` dùng để lọc các dòng trước khi gom nhóm, còn `WHERE` lọc sau khi gom nhóm.
- **B.** `HAVING` dùng để lọc trên các hàm tổng hợp (Aggregate functions) sau khi dữ liệu đã được gom nhóm (`GROUP BY`).
- **C.** `HAVING` chỉ dùng được với bảng không có khóa chính.
- **D.** `WHERE` bắt buộc phải đi kèm với `ORDER BY`.
> **Đáp án đúng: B**
> **Giải thích**: Mệnh đề `WHERE` lọc từng bản ghi riêng lẻ trước khi thực hiện gom nhóm và không được dùng trực tiếp các hàm tổng hợp như `COUNT()`, `SUM()`. `HAVING` được dùng để đặt điều kiện lọc trên các nhóm kết quả sau `GROUP BY`.

### Câu 6.2
Trong SQL Server, kết quả của biểu thức điều kiện `NULL = NULL` sẽ trả về:
- **A.** TRUE
- **B.** FALSE
- **C.** UNKNOWN
- **D.** Báo lỗi cú pháp (Syntax error)
> **Đáp án đúng: C**
> **Giải thích**: Trong chuẩn SQL và SQL Server (với cờ `ANSI_NULLS ON` mặc định), mọi phép so sánh với `NULL` (kể cả so sánh với chính `NULL`) đều trả về giá trị logic thứ ba là `UNKNOWN`. Để kiểm tra NULL, phải dùng cú pháp `IS NULL` hoặc `IS NOT NULL`.

---

## Chapter 7: Practical Issues (Index, ACID, Concurrency)

### Câu 7.1
Một bảng trong SQL Server có thể có tối đa bao nhiêu **Clustered Index**?
- **A.** 1
- **B.** 249
- **C.** 999
- **D.** Không giới hạn
> **Đáp án đúng: A**
> **Giải thích**: Clustered Index quyết định thứ tự sắp xếp vật lý thực tế của các dòng dữ liệu trên đĩa từ. Do dữ liệu vật lý chỉ có thể được xếp theo một thứ tự duy nhất tại một thời điểm, mỗi bảng chỉ có thể có **tối đa 1** Clustered Index.

### Câu 7.2
Hiện tượng một giao dịch đọc lại một dòng dữ liệu mà nó vừa đọc trước đó, nhưng phát hiện dữ liệu của dòng đó đã bị thay đổi bởi một giao dịch khác vừa COMMIT, được gọi là hiện tượng gì?
- **A.** Dirty Read
- **B.** Non-repeatable Read (Unrepeatable Read)
- **C.** Phantom Read
- **D.** Lost Update
> **Đáp án đúng: B**
> **Giải thích**: 
> - *Dirty Read* là đọc dữ liệu chưa commit của giao dịch khác.
> - *Non-repeatable Read* là đọc lại một dòng đã đọc trước đó nhưng giá trị bên trong dòng đó đã bị UPDATE bởi giao dịch khác đã commit.
> - *Phantom Read* là đọc lại một phạm vi bản ghi (range) và phát hiện có thêm các dòng mới được INSERT.

---

## Chapter 8: Database Programming on SQL Server

### Câu 8.1
Sự khác biệt căn bản giữa **User-Defined Function (UDF)** và **Stored Procedure (SP)** trong SQL Server là gì?
- **A.** UDF có thể chứa lệnh `INSERT/UPDATE/DELETE` làm thay đổi bảng vật lý, còn SP thì không.
- **B.** UDF có thể được gọi trực tiếp bên trong câu lệnh `SELECT`, `WHERE`, `HAVING`; trong khi SP thì không thể gọi như vậy mà phải gọi qua lệnh `EXEC`.
- **C.** SP không cho phép truyền tham số đầu vào.
- **D.** UDF không thể trả về kiểu dữ liệu bảng (Table).
> **Đáp án đúng: B**
> **Giải thích**: UDF được thiết kế để tính toán và trả về giá trị hoặc bảng, có thể nhúng trực tiếp vào các mệnh đề của `SELECT`. Quan trọng hơn, UDF không được phép làm thay đổi trạng thái của CSDL (không được chạy DML thay đổi dữ liệu bảng ngoài).

### Câu 8.2
Trong một Trigger loại `AFTER UPDATE`, bảng logic ảo **`deleted`** chứa dữ liệu nào?
- **A.** Dữ liệu mới sau khi đã được cập nhật.
- **B.** Dữ liệu cũ trước thời điểm thực hiện lệnh cập nhật.
- **C.** Toàn bộ dữ liệu của bảng gốc.
- **D.** Bảng `deleted` luôn rỗng trong thao tác UPDATE.
> **Đáp án đúng: B**
> **Giải thích**: Trong thao tác UPDATE, SQL Server xem như một cặp thao tác: xóa bản ghi cũ và chèn bản ghi mới. Do đó bảng ảo `deleted` lưu giá trị cũ trước khi update, và bảng ảo `inserted` lưu giá trị mới sau khi update.
