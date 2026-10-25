# Tiêu chí chấm điểm và Thang điểm thẩm định (Grading Rubrics)

Tài liệu chuẩn dùng để chấm điểm và đánh giá bài làm sinh viên môn **DBI202 (Database Systems)** tại Đại học FPT.

---

## 📑 Bảng mục lục
1. [Rubric chấm bài Lab 1 (Đại số quan hệ)](#1-rubric-lab-1-đại-số-quan-hệ)
2. [Rubric chấm bài Lab 2 (Chuẩn hóa cơ sở dữ liệu)](#2-rubric-lab-2-chuẩn-hóa-cơ-sở-dữ-liệu)
3. [Rubric chấm bài Lab 3 (Thiết kế ERD & Chuyển đổi lược đồ)](#3-rubric-lab-3-thiết-kế-erd--chuyển-đổi-lược-đồ)
4. [Bảng trừ điểm các lỗi phổ biến (Penalty Table)](#4-bảng-trừ-điểm-các-lỗi-phổ-biến)

---

## 1. Rubric Lab 1: Đại số quan hệ (Thang điểm 10.0)

Mỗi câu trong 10 câu truy vấn chuẩn chiếm **1.0 điểm**:

| Câu | Yêu cầu bài toán | Tiêu chí đạt điểm tối đa (1.0đ) | Mức độ lỗi trừ điểm |
|---|---|---|---|
| **Q1** | Thuyền 103 | Dùng $\sigma_{\text{bid}=103}$ kết hợp $\bowtie$ và $\pi_{\text{sname}}$ | Sai bảng join: -0.5đ; Quên chiếu tên: -0.5đ |
| **Q2** | Thuyền đỏ | Nối đúng 3 bảng `Boats`, `Reserves`, `Sailors` với $\sigma_{\text{color}='Red'}$ | Thiếu 1 bảng: 0đ; Chiếu sai cột: -0.5đ |
| **Q3** | Màu thuyền Lubber | Nối đúng và lọc $\sigma_{\text{sname}='Lubber'}$, chiếu $\pi_{\text{color}}$ | Chiếu nhầm tên: -0.5đ |
| **Q4** | Đặt ít nhất 1 thuyền | Nối `Sailors` $\bowtie$ `Reserves` và chiếu $\pi_{\text{sname}}$ | Thừa điều kiện lọc không cần thiết: -0.25đ |
| **Q5** | Thuyền đỏ HOẶC xanh | Dùng toán tử OR ($\lor$) trong phép chọn hoặc dùng phép Hợp ($\cup$) | Dùng nhầm AND: 0đ (lạc đề) |
| **Q6** | Thuyền đỏ VÀ xanh | Dùng phép giao ($\cap$) giữa 2 tập `sid` hoặc self-join trên `Reserves` | **Dùng `Color='Red' AND Color='Green'` trên cùng 1 bảng Boats: 0đ** |
| **Q7** | Tuổi > 20 chưa đặt thuyền đỏ | Dùng phép trừ quan hệ ($-$), lấy tập vũ trụ trừ tập vi phạm | Dùng $\neq 'Red'$ trong join: 0đ (sai logic vì họ có thể đặt thuyền khác) |
| **Q8** | Đặt TẤT CẢ các thuyền | Dùng toán tử chia ($\div$) hoặc phép trừ kép qua tích Descartes | Chỉ dùng join thông thường: 0đ |
| **Q9** | Đặt TẤT CẢ thuyền Interlake | Chia cho $\pi_{\text{bid}}(\sigma_{\text{bname}='Interlake'}(\text{Boats}))$ | Lọc nhầm thuyền hoặc thiếu phép chia: 0đ |
| **Q10** | Đặt ít nhất 2 thuyền | Self-join `Reserves` với điều kiện `bid1 != bid2` và chiếu tên | Quên điều kiện `bid1 != bid2`: 0đ (trở thành ít nhất 1) |

---

## 2. Rubric Lab 2: Chuẩn hóa cơ sở dữ liệu (Thang điểm 10.0)

Bài Lab 2 thường gồm 2 bài toán thực tế (mỗi bài 5.0 điểm):

### Phân bổ điểm cho từng bài toán (5.0 điểm/bài):
1. **Phân tích ban đầu & Nhận diện thuộc tính suy dẫn (1.0 điểm)**:
   - Liệt kê đầy đủ các thuộc tính có trên báo cáo/hóa đơn: +0.5đ.
   - Nhận diện và **loại bỏ** các trường tính toán (Total, Tax, Amount Owing): +0.5đ.
2. **Dạng chuẩn 1NF (1.0 điểm)**:
   - Trải phẳng nhóm lặp (repeating groups) thành dữ liệu nguyên tố: +0.5đ.
   - Xác định chính xác khóa chính hỗn hợp (Composite Primary Key): +0.5đ.
3. **Dạng chuẩn 2NF (1.5 điểm)**:
   - Liệt kê đầy đủ các phụ thuộc hàm (FDs): +0.5đ.
   - Phát hiện đúng các phụ thuộc một phần vào khóa chính: +0.5đ.
   - Tách thành các bảng quan hệ 2NF chuẩn xác, có khóa chính riêng: +0.5đ.
4. **Dạng chuẩn 3NF (1.5 điểm)**:
   - Phát hiện đúng các phụ thuộc bắc cầu giữa các thuộc tính không khóa: +0.5đ.
   - Tách bảng chuẩn xác và thiết lập khóa ngoại (Foreign Key) hợp lý: +0.5đ.
   - Thêm surrogate key (như `CustomerID`) nếu thuộc tính định danh không đảm bảo tính duy nhất: +0.5đ.

---

## 3. Rubric Lab 3: Thiết kế ERD & Chuyển đổi lược đồ (Thang điểm 10.0)

1. **Phân tích yêu cầu nghiệp vụ (2.0 điểm)**:
   - Xác định đầy đủ tất cả các thực thể nghiệp vụ: +1.0đ.
   - Nhận diện đúng thực thể yếu (Weak Entity - ví dụ: Section): +1.0đ.
2. **Thiết kế Sơ đồ ERD (3.0 điểm)**:
   - Biểu diễn đúng các loại thuộc tính (Key, Multivalued, Derived): +1.0đ.
   - Xác định chính xác bản số / quan hệ: 1:1, 1:N, M:N: +1.0đ.
   - Thể hiện rõ ràng buộc tham gia (Total / Partial participation): +1.0đ.
3. **Chuyển đổi sang Lược đồ quan hệ (5.0 điểm)**:
   - Ánh xạ đúng thực thể mạnh và yếu (có ghép khóa chủ): +1.0đ.
   - Ánh xạ đúng quan hệ 1:N (đẩy FK về bên N): +1.0đ.
   - Ánh xạ đúng quan hệ M:N (tạo bảng trung gian với composite PK): +1.0đ.
   - Xử lý đúng thuộc tính đa trị (tách bảng riêng): +1.0đ.
   - Liệt kê tường minh tất cả Khóa chính (gạch chân) và Khóa ngoại: +1.0đ.

---

## 4. Bảng trừ điểm các lỗi phổ biến (Penalty Table)

| Loại lỗi | Mức độ nghiêm trọng | Điểm bị trừ |
|---|---|---|
| **Lỗi logic rỗng (Color='Red' AND Color='Green')** | Nghiêm trọng | Trừ 100% điểm câu truy vấn đó |
| **Lưu thuộc tính suy dẫn trong bảng chuẩn** | Trung bình | Trừ 0.5đ - 1.0đ trên bài chuẩn hóa |
| **Quên tạo bảng trung gian cho quan hệ M:N** | Nghiêm trọng | Trừ 1.5đ - 2.0đ trên bài ERD |
| **Xác định sai thực thể yếu (thiếu khóa của thực thể chủ)** | Nghiêm trọng | Trừ 1.0đ |
| **Đặt sai vị trí khóa ngoại (đặt ở phía 1 thay vì phía N)** | Trung bình | Trừ 0.5đ mỗi quan hệ sai |
| **Không gạch chân / in đậm Khóa chính (PK)** | Nhẹ | Trừ 0.25đ trên toàn bài |
| **Mất cân bằng dấu ngoặc trong biểu thức đại số quan hệ** | Nhẹ | Trừ 0.25đ |
