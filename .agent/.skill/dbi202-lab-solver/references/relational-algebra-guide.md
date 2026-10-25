# Hướng dẫn chi tiết Đại số quan hệ (Relational Algebra Guide)

Tài liệu tham khảo chuyên sâu cho môn học **DBI202 (Database Systems)** - Đại học FPT, phục vụ giải quyết bài tập dạng Lab 1 và các câu hỏi lý thuyết / bài tập truy vấn.

---

## 📑 Bảng mục lục
1. [Hệ thống các toán tử trong Đại số quan hệ](#1-hệ-thống-các-toán-tử)
2. [Toán tử nâng cao & Các mẫu truy vấn kinh điển](#2-các-mẫu-truy-vấn-kinh-điển)
3. [Phân tích & Lời giải chuẩn cho 10 câu Lab 1 mẫu](#3-bộ-10-câu-lab-1-chuẩn)
4. [Bảng ánh xạ tương đương giữa Đại số quan hệ và SQL](#4-ánh-xạ-sang-sql)

---

## 1. Hệ thống các toán tử

### 1.1. Các toán tử nguyên thủy (Fundamental Operators)
| Ký hiệu | Tên toán tử | Ý nghĩa toán học | Ví dụ |
|---|---|---|---|
| $\sigma_{\text{cond}}(R)$ | **Selection** (Chọn) | Chọn các bộ (dòng) trong $R$ thỏa điều kiện | $\sigma_{\text{rating} > 7}(\text{Sailors})$ |
| $\pi_{A_1, \dots, A_k}(R)$ | **Projection** (Chiếu) | Giữ lại các cột thuộc tính chỉ định, loại bỏ trùng | $\pi_{\text{sname, rating}}(\text{Sailors})$ |
| $R \times S$ | **Cartesian Product** (Tích Descartes) | Ghép mọi bộ của $R$ với mọi bộ của $S$ | $\text{Sailors} \times \text{Boats}$ |
| $R \cup S$ | **Union** (Hợp) | Tập hợp các bộ thuộc $R$ hoặc $S$ (phải cùng lược đồ) | $\text{Sailors}_1 \cup \text{Sailors}_2$ |
| $R - S$ hoặc $R \setminus S$ | **Difference** (Trừ) | Tập hợp các bộ thuộc $R$ nhưng không thuộc $S$ | $\text{Sailors}_1 - \text{Sailors}_2$ |
| $\rho_{S}(R)$ hoặc $\rho_{S(A_1, \dots)}(R)$ | **Renaming** (Đổi tên) | Đổi tên quan hệ thành $S$ hoặc đổi tên thuộc tính | $\rho(R_1, \text{Reserves})$ |

### 1.2. Các toán tử dẫn xuất & Mở rộng (Derived & Extended Operators)
| Ký hiệu | Tên toán tử | Định nghĩa tương đương |
|---|---|---|
| $R \cap S$ | **Intersection** (Giao) | $R - (R - S)$ |
| $R \bowtie S$ | **Natural Join** (Nối tự nhiên) | Bằng giá trị các thuộc tính cùng tên, khử cột trùng |
| $R \bowtie_{\theta} S$ | **Theta Join** (Nối có điều kiện) | $\sigma_{\theta}(R \times S)$ |
| $R \div S$ | **Division** (Chia quan hệ) | Dùng cho truy vấn "tất cả" (*for all*) |
| $\gamma_{L, \text{agg}(A) \to B}(R)$ | **Aggregation** (Gom nhóm & tổng hợp) | $\text{GROUP BY } L, \text{ AGG}(A)$ (COUNT, SUM, AVG...) |

---

## 2. Các mẫu truy vấn kinh điển

### 2.1. Mẫu 1: Điều kiện "OR" (Hoặc thuộc tính này hoặc thuộc tính kia)
- **Yêu cầu**: Tìm thủy thủ đặt thuyền đỏ **HOẶC** thuyền xanh.
- **Biểu thức**:
  $$\pi_{\text{sname}}(\sigma_{\text{color}='Red' \lor \text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves} \bowtie \text{Sailors})$$

### 2.2. Mẫu 2: Bẫy điều kiện "AND" (Cùng đặt cả 2 thuyền khác nhau)
- **Sai lầm phổ biến của sinh viên**:
  $$\sigma_{\text{color}='Red' \land \text{color}='Green'}(\text{Boats})$$
  *(Lỗi nghiêm trọng: Mỗi dòng thuyền chỉ có 1 màu, không có thuyền nào vừa 'Red' vừa 'Green'. Kết quả luôn RỖNG!)*
- **Giải pháp chính xác**: Phải tìm tập các thủy thủ đặt thuyền đỏ, sau đó **giao ($\cap$)** với tập các thủy thủ đặt thuyền xanh:
  $$\rho(S_{\text{red}}, \pi_{\text{sid}}(\sigma_{\text{color}='Red'}(\text{Boats}) \bowtie \text{Reserves}))$$
  $$\rho(S_{\text{green}}, \pi_{\text{sid}}(\sigma_{\text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves}))$$
  $$\pi_{\text{sname}}((S_{\text{red}} \cap S_{\text{green}}) \bowtie \text{Sailors})$$

### 2.3. Mẫu 3: Điều kiện phủ định "NOT" (Chưa từng đặt thuyền đỏ)
- **Tư duy**: Lấy toàn bộ tập vũ trụ trừ đi tập những người vi phạm điều kiện.
- **Biểu thức**:
  $$\pi_{\text{sid}}(\sigma_{\text{age}>20}(\text{Sailors})) - \pi_{\text{sid}}(\text{Reserves} \bowtie \sigma_{\text{color}='Red'}(\text{Boats}))$$

### 2.4. Mẫu 4: Điều kiện "Tất cả" (Reserved ALL boats) - Phép chia quan hệ
- **Định nghĩa toán học của $R(A, B) \div S(B)$**:
  $$R \div S = \pi_{A}(R) - \pi_{A}((\pi_{A}(R) \times S) - R)$$
  *Ý nghĩa: Lấy tất cả $A$ có thể có, trừ đi những $A$ mà tồn tại một $B \in S$ sao cho cặp $(A, B)$ không có trong $R$.*
- **Biểu thức ngắn gọn**:
  $$\pi_{\text{sname}}((\pi_{\text{sid, bid}}(\text{Reserves}) \div \pi_{\text{bid}}(\text{Boats})) \bowtie \text{Sailors})$$
- **Biểu thức khai triển bằng các toán tử cơ bản**:
  $$\pi_{\text{sname}}((\pi_{\text{sid}}(\text{Sailors}) - \pi_{\text{sid}}((\pi_{\text{sid}}(\text{Sailors}) \times \pi_{\text{bid}}(\text{Boats})) - \pi_{\text{sid, bid}}(\text{Reserves}))) \bowtie \text{Sailors})$$

### 2.5. Mẫu 5: Điều kiện "Ít nhất 2 lần" (At least two boats)
- **Tư duy**: Nối quan hệ với chính nó (Self-join), kiểm tra cùng thủy thủ (`sid`) nhưng khác mã thuyền (`bid1 != bid2`).
- **Biểu thức**:
  $$\pi_{\text{sname}}(\pi_{R1.\text{sid}}(\sigma_{R1.\text{bid} \neq R2.\text{bid}}(\rho(R1, \text{Reserves}) \bowtie_{R1.\text{sid}=R2.\text{sid}} \rho(R2, \text{Reserves}))) \bowtie \text{Sailors})$$

---

## 3. Bộ 10 câu Lab 1 chuẩn (Sailors, Boats, Reserves)

Lược đồ cơ sở dữ liệu:
- `Sailors(sid: integer, sname: string, rating: integer, age: real)`
- `Boats(bid: integer, bname: string, color: string)`
- `Reserves(sid: integer, bid: integer, day: date)`

| # | Câu hỏi | Lời giải Đại số quan hệ chuẩn | Kết quả mẫu |
|---|---|---|---|
| **Q1** | Find the names of sailors who have reserved boat 103 | $\pi_{\text{sname}}(\sigma_{\text{bid}=103}(\text{Reserves}) \bowtie \text{Sailors})$ | Dustin, Lubber, Horatio |
| **Q2** | Find the names of sailors who have reserved a red boat | $\pi_{\text{sname}}(\sigma_{\text{color}='Red'}(\text{Boats}) \bowtie \text{Reserves} \bowtie \text{Sailors})$ | Dustin, Lubber, Horatio |
| **Q3** | Find the colors of boats reserved by Lubber | $\pi_{\text{color}}(\sigma_{\text{sname}='Lubber'}(\text{Sailors}) \bowtie \text{Reserves} \bowtie \text{Boats})$ | Red, Green |
| **Q4** | Find the names of sailors who have reserved at least one boat | $\pi_{\text{sname}}(\text{Sailors} \bowtie \text{Reserves})$ | Dustin, Lubber, Horatio |
| **Q5** | Find the names of sailors who have reserved a red or a green boat | $\pi_{\text{sname}}(\sigma_{\text{color}='Red' \lor \text{color}='Green'}(\text{Boats}) \bowtie \text{Reserves} \bowtie \text{Sailors})$ | Dustin, Lubber, Horatio |
| **Q6** | Find the names of sailors who have reserved a red and a green boat | $\pi_{\text{sname}}((\pi_{\text{sid}}(\sigma_{\text{color}='Red'}\text{Boats} \bowtie \text{Reserves}) \cap \pi_{\text{sid}}(\sigma_{\text{color}='Green'}\text{Boats} \bowtie \text{Reserves})) \bowtie \text{Sailors})$ | Dustin, Lubber |
| **Q7** | Find the sids of sailors with age over 20 who have not reserved a red boat | $\pi_{\text{sid}}(\sigma_{\text{age}>20}(\text{Sailors})) - \pi_{\text{sid}}(\text{Reserves} \bowtie \sigma_{\text{color}='Red'}(\text{Boats}))$ | 29, 32, 58, 85, 95 |
| **Q8** | Find the names of sailors who have reserved all boats | $\pi_{\text{sname}}((\pi_{\text{sid, bid}}(\text{Reserves}) \div \pi_{\text{bid}}(\text{Boats})) \bowtie \text{Sailors})$ | Dustin |
| **Q9** | Find the names of sailors who have reserved all boats called Interlake | $\pi_{\text{sname}}((\pi_{\text{sid, bid}}(\text{Reserves}) \div \pi_{\text{bid}}(\sigma_{\text{bname}='Interlake'}(\text{Boats}))) \bowtie \text{Sailors})$ | Dustin, Horatio |
| **Q10** | Find the names of sailors who have reserved at least two boats | $\pi_{\text{sname}}(\pi_{R1.\text{sid}}(\sigma_{R1.\text{bid} \neq R2.\text{bid}}(R1 \bowtie_{R1.\text{sid}=R2.\text{sid}} R2)) \bowtie \text{Sailors})$ với $R1, R2$ là Reserves | Dustin, Lubber, Horatio |

---

## 4. Ánh xạ sang SQL

| Đại số quan hệ | Tương đương trong SQL |
|---|---|
| $\sigma_{\text{rating} > 7}(\text{Sailors})$ | `SELECT * FROM Sailors WHERE rating > 7;` |
| $\pi_{\text{sname}}(\text{Sailors})$ | `SELECT DISTINCT sname FROM Sailors;` |
| $R \bowtie S$ | `SELECT * FROM R INNER JOIN S ON R.id = S.id;` |
| $R_1 \cup R_2$ | `SELECT * FROM R1 UNION SELECT * FROM R2;` |
| $R_1 \cap R_2$ | `SELECT * FROM R1 INTERSECT SELECT * FROM R2;` |
| $R_1 - R_2$ | `SELECT * FROM R1 EXCEPT SELECT * FROM R2;` |
| $R \div S$ (All boats) | `SELECT S.sname FROM Sailors S WHERE NOT EXISTS (SELECT B.bid FROM Boats B EXCEPT SELECT R.bid FROM Reserves R WHERE R.sid = S.sid);` |
| $\gamma_{\text{rating}, \text{COUNT}(\text{sid})}(\text{Sailors})$ | `SELECT rating, COUNT(sid) FROM Sailors GROUP BY rating;` |
