---
name: dbi202-lab-solver
description: "Expert assistant specialized in solving and producing complete, high-scoring lab exercises and assignments for DBI202 (Database Systems) at FPT University, specifically modeled after Lab 1, Lab 2, and Lab 3 formats. Use this skill whenever the user wants to:
1) Solve Relational Algebra and SQL queries (Lab 1: selections, projections, joins, set difference, Cartesian products, division for 'for all' conditions, groupings, and aggregations using standard operators π, σ, ⋈, ×, -, ÷, ρ).
2) Perform Database Normalization step-by-step (Lab 2: converting unnormalized reports, forms, or invoices through 1NF, 2NF, 3NF, and BCNF, identifying functional dependencies, candidate keys, partial and transitive dependencies).
3) Analyze business requirements, design Entity-Relationship Diagrams (ERD), and convert ERD to Relational Models (Lab 3: identifying entities, weak entities, attributes, relationships, cardinalities 1:1, 1:N, M:N, primary keys, foreign keys, and integrity constraints).
Make sure to trigger this skill whenever the user mentions 'DBI202', 'giải bài tập DBI', 'làm lab DBI', 'Lab 1 DBI', 'Lab 2 DBI', 'Lab 3 DBI', 'Relational Algebra', 'đại số quan hệ', 'chuẩn hóa dữ liệu', '1NF 2NF 3NF BCNF', 'vẽ ERD', 'chuyển ERD sang quan hệ', or provides database problems matching the FPT University curriculum."
---

# DBI202 Lab Solver

Skill chuyên biệt giải toàn diện và chính xác các bài thực hành môn **DBI202 (Database Systems)** tại Đại học FPT, bám sát bộ bài tập mẫu (Lab 1, Lab 2, Lab 3) và giáo trình chuẩn (Slide Chapters 1–8).

---

## 📌 Nguyên tắc cốt lõi khi giải bài

1. **Độ chính xác học thuật tuyệt đối**:
   - Tránh bẫy logic kinh điển (ví dụ: điều kiện `Color='Red' AND Color='Green'` trên cùng 1 thuyền là rỗng; phải dùng phép giao $\cap$ hoặc self-join).
   - Xử lý phép chia quan hệ ($\div$) hoặc bù của tích Descartes khi gặp bài toán "tất cả" (*for all / every*).
   - Không lưu thuộc tính suy dẫn (*derived attributes* như Total, Tax, Age) vào bảng chuẩn hóa hay mô hình quan hệ.
2. **Trình bày rõ ràng, chuẩn định dạng FPT**:
   - Có tiêu đề Header sinh viên (Name, Student ID, Class).
   - Sử dụng chuẩn ký hiệu Unicode toán học cho Đại số quan hệ ($\pi, \sigma, \bowtie, \times, -, \cap, \cup, \div, \rho$).
   - Thể hiện rõ các bảng trung gian, các bước phân tích phụ thuộc hàm, và giải thích lý do tách bảng.
   - Sẵn sàng xuất ra Markdown hoặc tích hợp với skill `docx` để tạo file nộp bài chuẩn.

---

## 🗂️ 3 Workflow giải bài chính

```
DBI202 Lab Task
 ├── Lab 1 Type ──► [Workflow 1: Relational Algebra & Queries]
 ├── Lab 2 Type ──► [Workflow 2: Normalization 1NF -> 2NF -> 3NF -> BCNF]
 └── Lab 3 Type ──► [Workflow 3: Requirements -> ERD -> Relational Model]
```

---

## 🚀 Workflow 1: Giải bài tập Lab 1 (Đại số quan hệ - Relational Algebra)

Áp dụng cho các bài tập truy vấn dữ liệu bằng biểu thức Đại số quan hệ (như lược đồ Sailors, Boats, Reserves).

### Quy trình giải 4 bước:
1. **Xác định tập quan hệ và thuộc tính cần lấy**:
   - Bảng đích chứa kết quả cuối cùng: đặt ngoài cùng trong phép chiếu $\pi_{\text{Attribute}}$.
   - Các bảng trung gian cần liên kết (Join $\bowtie$).
2. **Xác định điều kiện chọn ($\sigma$)**:
   - Điều kiện lọc giá trị đơn lẻ: đưa vào gần nhất với bảng nguồn (để tối ưu hóa biểu thức đại số quan hệ).
3. **Xử lý các mẫu bài toán đặc thù**:
   - **Mẫu "Hoặc" (OR / At least one of Red or Green)**:
     $$\pi_{\text{sname}}(\sigma_{\text{color}='Red' \lor \text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves} \bowtie \text{Sailors})$$
   - **Mẫu "Và" trên nhiều dòng (AND / Both Red AND Green)**:
     *Không được dùng `color='Red' AND color='Green'` trong cùng 1 selection vì 1 dòng chỉ có 1 màu!*
     *Giải pháp:* Dùng giao ($\cap$) hoặc phép đổi tên $\rho$:
     $$\rho(R_{\text{red}}, \pi_{\text{sid}}(\sigma_{\text{color}='Red'}(\text{Boats}) \bowtie \text{Reserves}))$$
     $$\rho(R_{\text{green}}, \pi_{\text{sid}}(\sigma_{\text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves}))$$
     $$\pi_{\text{sname}}((R_{\text{red}} \cap R_{\text{green}}) \bowtie \text{Sailors})$$
   - **Mẫu "Phủ định / Chưa từng" (NOT reserved Red)**:
     $$\pi_{\text{sid}}(\text{Sailors}) - \pi_{\text{sid}}(\text{Reserves} \bowtie \sigma_{\text{color}='Red'}(\text{Boats}))$$
   - **Mẫu "Tất cả / For all" (Reserved ALL boats)**:
     *Cách 1 (Toán tử chia $\div$):*
     $$\pi_{\text{sname}}((\pi_{\text{sid}, \text{bid}}(\text{Reserves}) \div \pi_{\text{bid}}(\text{Boats})) \bowtie \text{Sailors})$$
     *Cách 2 (Phép trừ kép - Double Negation):*
     $$\pi_{\text{sname}}((\pi_{\text{sid}}(\text{Sailors}) - \pi_{\text{sid}}((\pi_{\text{sid}}(\text{Sailors}) \times \pi_{\text{bid}}(\text{Boats})) - \pi_{\text{sid}, \text{bid}}(\text{Reserves}))) \bowtie \text{Sailors})$$
   - **Mẫu "Ít nhất 2" (At least two boats)**:
     Dùng phép đổi tên $\rho$ và nối tự thân có điều kiện khác nhau:
     $$\pi_{\text{sname}}(\pi_{R1.\text{sid}}(\sigma_{R1.\text{bid} \neq R2.\text{bid}}(\rho(R1, \text{Reserves}) \bowtie_{R1.\text{sid}=R2.\text{sid}} \rho(R2, \text{Reserves}))) \bowtie \text{Sailors})$$
4. **Viết kết quả và bảng dữ liệu mẫu**: Nếu đề bài cung cấp bộ dữ liệu (instance), hãy tính toán và liệt kê chính xác các bản ghi kết quả trả về.

> 📖 **Xem chi tiết lý thuyết và cú pháp đầy đủ**: [relational-algebra-guide.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-lab-solver/references/relational-algebra-guide.md)

---

## 🚀 Workflow 2: Giải bài tập Lab 2 (Chuẩn hóa cơ sở dữ liệu - Normalization)

Áp dụng cho bài toán đưa bảng dữ liệu phi chuẩn (Báo cáo, Hóa đơn, Hồ sơ bệnh án...) qua các dạng chuẩn 1NF $\to$ 2NF $\to$ 3NF $\to$ BCNF.

### Quy trình giải 5 bước:

1. **Bước 0: Thu thập thuộc tính & loại bỏ giá trị suy dẫn**:
   - Liệt kê toàn bộ thuộc tính có trong tài liệu/báo cáo.
   - **Loại bỏ thuộc tính suy dẫn**: Các giá trị tính toán được (ví dụ: `Total = SUM(Amount)`, `Tax = 8% * Total`, `Amount Owing = Total + Tax`) **không được lưu** vào các bảng chuẩn.
2. **Bước 1: Đưa về 1NF (First Normal Form)**:
   - Quy tắc: Mỗi ô chỉ chứa giá trị nguyên tố (*atomic value*), không có nhóm lặp (*repeating groups*).
   - Xác định khóa chính hỗn hợp (*Composite Primary Key*) bao gồm cả khóa của nhóm lặp.
   - Ký hiệu: `TEN_BANG (PK1, PK2, ..., ThuocTinhKhac)`
3. **Bước 2: Xác định Phụ thuộc hàm (FDs) & Đưa về 2NF**:
   - Liệt kê tất cả FDs thực tế từ ngữ nghĩa nghiệp vụ: $X \to Y$.
   - Tìm phụ thuộc một phần (*Partial Functional Dependency*): Thuộc tính không khóa phụ thuộc vào *một phần* của khóa chính hỗn hợp.
   - Tách các thuộc tính phụ thuộc một phần ra bảng riêng với khóa chính tương ứng. Bảng còn lại giữ khóa chính hỗn hợp và các thuộc tính phụ thuộc toàn phần.
4. **Bước 3: Đưa về 3NF**:
   - Tìm phụ thuộc bắc cầu (*Transitive Dependency*): Thuộc tính không khóa phụ thuộc vào một thuộc tính không khóa khác ($PK \to X \to Y$).
   - Tách $X \to Y$ ra bảng riêng (với $X$ là PK). Trong bảng gốc, chỉ giữ lại $X$ làm Foreign Key (FK).
5. **Bước 4: Kiểm tra BCNF (nếu được yêu cầu)**:
   - Với mọi phụ thuộc hàm không tầm thường $X \to Y$, $X$ bắt buộc phải là siêu khóa (*superkey*).
   - Nếu vi phạm, tách $R$ thành $R_1(X, Y)$ và $R_2(R - Y)$.

> 📖 **Xem chi tiết thuật toán bao đóng, hệ tiên đề Armstrong và ví dụ mẫu**: [normalization-guide.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-lab-solver/references/normalization-guide.md)

---

## 🚀 Workflow 3: Giải bài tập Lab 3 (Phân tích nghiệp vụ $\to$ ERD $\to$ Relational Model)

Áp dụng cho bài toán cho văn bản mô tả nghiệp vụ (Quản lý trường đại học, Bệnh viện, Công ty...), yêu cầu vẽ ERD và chuyển sang Lược đồ quan hệ.

### Quy trình giải 3 giai đoạn:

### Giai đoạn 1: Trích xuất thực thể, thuộc tính và mối quan hệ
- **Thực thể (Entities)**: Danh từ chính (ví dụ: `Department`, `Instructor`, `Student`, `Subject`, `Class`, `Section`).
- **Thực thể yếu (Weak Entities)**: Thực thể không có khóa độc lập, phụ thuộc vào thực thể chủ (ví dụ: `Section` phụ thuộc `Class`, hoặc `Dependent` phụ thuộc `Employee`).
- **Mối quan hệ & Bậc (Relationships & Cardinality)**:
  - 1:1 (Một - Một), ví dụ: Department được quản lý bởi 1 Instructor.
  - 1:N (Một - Nhiều), ví dụ: 1 Department có nhiều Instructor; 1 Class có nhiều Section.
  - M:N (Nhiều - Nhiều), ví dụ: Instructor dạy nhiều Subject, 1 Subject được dạy bởi nhiều Instructor.

### Giai đoạn 2: Vẽ sơ đồ ERD
- Cung cấp sơ đồ Mermaid chuẩn `erDiagram` trực quan, rõ ràng.
- Ghi rõ tên quan hệ, cardinalities (`||--o{`, `}|--|{`, v.v.).

### Giai đoạn 3: Áp dụng 7 Quy tắc chuyển đổi ERD sang Relational Model
1. **Thực thể mạnh**: Tạo bảng riêng, thuộc tính khóa thành Primary Key (PK gạch chân).
2. **Thực thể yếu**: Tạo bảng riêng, PK = (Khóa của thực thể chủ + Khóa bộ phận / Discriminator).
3. **Quan hệ 1:1**: Đặt PK của bảng này làm FK ở bảng kia (ưu tiên đặt vào phía có sự tham gia toàn phần / *total participation*).
4. **Quan hệ 1:N**: Đặt PK của phía "1" làm FK tại bảng phía "N".
5. **Quan hệ M:N**: Tạo **bảng liên kết trung gian** (*Junction Table*). PK của bảng này là khóa hỗn hợp gồm PK của 2 thực thể tham gia (vừa là PK vừa là FK), kèm theo các thuộc tính của mối quan hệ nếu có.
6. **Thuộc tính đa trị**: Tách thành bảng riêng gồm (PK của thực thể chủ + Thuộc tính đa trị) làm PK hỗn hợp.
7. **Lược đồ quan hệ chuẩn**: Liệt kê danh sách bảng, đánh dấu PK gạch chân hoặc in đậm, liệt kê tường minh các Foreign Keys và các ràng buộc toàn vẹn.

> 📖 **Xem hướng dẫn chi tiết và ví dụ Lab 3 mẫu**: [erd-to-relational-guide.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-lab-solver/references/erd-to-relational-guide.md)

---

## 📋 Cấu trúc bài làm chuẩn khi trả lời người dùng

Khi xuất kết quả giải bài, luôn tuân thủ cấu trúc chuyên nghiệp sau:

```markdown
# BÀI LÀM: [TÊN LAB HOẶC BÀI TẬP]
- **Họ và tên**: [Tên sinh viên]
- **Mã sinh viên**: [Mã số]
- **Lớp**: [Lớp học]
- **Môn học**: DBI202 - Hệ thống cơ sở dữ liệu

---

## [Câu hỏi 1 / Phần 1: Tên nội dung]
### 1. Phân tích đề bài & Ý tưởng giải
- [Tóm tắt logic và các bước tiếp cận]

### 2. Lời giải chi tiết
- [Biểu thức đại số quan hệ / Các bước 1NF-2NF-3NF / Sơ đồ ERD & Lược đồ quan hệ]

### 3. Giải thích / Minh chứng kết quả
- [Giải thích tại sao biểu thức/lược đồ này đúng, bảng kết quả nếu có]

---
```

> 💡 **Mẹo**: Nếu người dùng muốn xuất trực tiếp file Word (.docx), hãy phối hợp cùng skill `docx` hoặc tạo script để đóng gói tài liệu theo cấu trúc trên.
