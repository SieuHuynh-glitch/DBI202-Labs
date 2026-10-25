# Phân tích so sánh các bài giải mẫu (mau/Lab123-k, mau/Lab123-t, mau/lab)

Tài liệu này tổng hợp phân tích đối chiếu các bài nộp mẫu thực tế của sinh viên trong thư mục `mau/` nhằm chỉ ra các lỗi sai phổ biến và đưa ra chuẩn đáp án tối ưu.

---

## 1. Lab 1: Đại số quan hệ (Relational Algebra)

### Điểm khác biệt chí mạng ở Câu 6:
> **Đề bài**: *Find the names of sailors who have reserved a red and a green boat*

- **Bài làm của `Lab123-k/Lab1.docx`**:
  $$\pi_{\text{Sname}}(\sigma_{\text{Color}='Red' \land \text{Color}='Green'}(\text{Boats}) \bowtie \text{Reserves} \bowtie \text{Sailors})$$
  ❌ **ĐÁNH GIÁ: SAI NGHIÊM TRỌNG (0 điểm câu này).**
  - **Lý do**: Trong quan hệ `Boats`, mỗi dòng chỉ có duy nhất một giá trị `Color`. Điều kiện `Color='Red' AND Color='Green'` trên cùng một bộ luôn trả về `FALSE` (tập rỗng $\emptyset$). Biểu thức này không trả về bất kỳ thủy thủ nào.

- **Bài làm của `mau/lab/QE210078_Le Chan Huy_LAB1.docx`**:
  $$\rho(Red, \pi_{\text{sid}}(\sigma_{\text{color}='Red'}(\text{Boats}) \bowtie \text{Reserves}))$$
  $$\rho(Green, \pi_{\text{sid}}(\sigma_{\text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves}))$$
  $$\pi_{\text{sname}}((Red \cap Green) \bowtie \text{Sailors})$$
  ✅ **ĐÁNH GIÁ: ĐÚNG CHUẨN XÁC VÀ ĐẦY ĐỦ (10/10).**
  - **Lý do**: Tách riêng tập các `sid` đặt thuyền đỏ, tập các `sid` đặt thuyền xanh, sau đó lấy **phép giao ($\cap$)** rồi mới nối với bảng `Sailors` để lấy tên.

---

## 2. Lab 2: Chuẩn hóa dữ liệu (Normalization)

### Điểm khác biệt trong bài toán Hóa đơn (Hilltop Animal Hospital):
> **Đề bài**: Chuẩn hóa thông tin hóa đơn gồm Tổng tiền, Thuế 8%, Tiền phải trả, Khách hàng, Địa chỉ, Danh sách khám...

- **Bài làm của `Lab123-k/Lab2.docx`**:
  - Không giải thích tại sao `Total`, `Tax`, `Amount Owing` biến mất giữa 1NF và 2NF.
  - Sử dụng tên khách hàng làm khóa chính cho bảng `CUSTOMER`, dễ gây trùng lặp tên.
- **Bài làm của `mau/lab/Lab2_LCH.docx`**:
  - ✅ **Điểm cộng xuất sắc**: Giải thích rõ ràng nguyên tắc: *Total, Tax and Amount owing are derived (Total = SUM(Amount), Tax = 8% × Total, Amount owing = Total + Tax), so they are not stored*.
  - Thêm khóa nhân tạo `CustomerID` vì *Customer names are not guaranteed to be unique*.
  - Kiểm tra lại tính toàn vẹn số tiền: $30.00 + 24.00 = 54.00$, Tax = $4.32$, Amount owing = $58.32$.

---

## 3. Lab 3: Phân tích nghiệp vụ & Chuyển đổi ERD

### Điểm khác biệt trong mô hình thực thể yếu:
- **Bài làm của `Lab123-k/Lab3.docx`**:
  - Đưa sơ đồ dạng text liền dòng, không phân tách rõ đâu là thực thể yếu hay quan hệ trung gian.
- **Bài làm của `mau/lab/QE210078_Le Chan Huy_LAB3.docx`**:
  - Nhận diện đúng `SECTION` là thực thể yếu phụ thuộc vào `CLASS`.
  - Khóa chính của `SECTION` là bộ 4 thuộc tính: `(ClassCode, TrainingYear, Semester, SectionNo)`.
  - Bảng `GRADE_REPORT` có khóa chính gồm `StudentNumber` và toàn bộ khóa của `SECTION`.
  - Nêu rõ ràng buộc: *CLASS.SupervisorID must refer to an instructor of CLASS.DeptCode*.
