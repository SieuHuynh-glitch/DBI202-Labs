---
name: dbi202-evaluator
description: "Comprehensive assessment, grading, audit, and examination generator skill for DBI202 (Database Systems) at FPT University, covering all 8 curriculum chapters (DB Introduction, Relational Model, Normalization & Design Theory, ERD Modeling, Bags/Multisets, Relational Algebra & SQL, Storage/Indexes/Transactions, and Database Programming with Triggers/Stored Procedures). Use this skill whenever the user wants to:
1) Audit and Grade Lab/Assignment Submissions: Review student solutions for Lab 1, Lab 2, Lab 3 or custom SQL/ERD exercises, detect logical bugs, identify edge case failures (such as AND vs OR in Relational Algebra, incomplete 2NF/3NF decompositions, missing foreign keys, incorrect cardinalities), and provide an objective rubric score with constructive feedback.
2) Generate DBI202 Quizzes and Practice Exams: Create standard FPT multiple-choice questions (MCQs with 4 options A/B/C/D and detailed rationale for both correct answers and distractors), conceptual check questions, or Practical Exam (PE) scenarios across any specific chapter (Chapters 1 through 8).
3) Interactive Diagnostic / Knowledge Check: Run a live mock test session where the agent presents questions one by one, assesses the student's answer, identifies knowledge gaps, and recommends targeted review sections from lecture slides and notes.
Make sure to trigger this skill whenever the user mentions 'chấm bài DBI', 'kiểm tra lab', 'đánh giá bài tập', 'grade lab', 'tạo đề trắc nghiệm DBI202', 'quiz DBI', 'ôn thi PE', 'ôn thi FE', 'kiểm tra kiến thức CSDL', or asks 'bài giải này đúng chưa'."
---

# DBI202 Evaluator & Quiz Generator

Skill chuyên biệt kiểm tra, thẩm định, chấm điểm bài làm và tạo đề thi / quiz kiểm tra kiến thức toàn diện môn **DBI202 (Database Systems)** tại Đại học FPT, dựa trên hệ thống 8 Chapters bài giảng và tài liệu học tập chuẩn.

---

## 🧭 Hai chế độ hoạt động chính (2 Core Modes)

```
                     ┌────────────────────────────────────────┐
                     │          DBI202 Evaluator              │
                     └──────────────────┬─────────────────────┘
                                        │
           ┌────────────────────────────┴───────────────────────────┐
           ▼                                                        ▼
┌───────────────────────────┐                            ┌───────────────────────────┐
│          MODE 1           │                            │          MODE 2           │
│  Thẩm định & Chấm bài     │                            │   Tạo Quiz & Đề thi       │
│  (Audit & Grade Solution) │                            │   (Exam / Quiz Generator) │
└───────────────────────────┘                            └───────────────────────────┘
```

---

## 🎯 MODE 1: Thẩm định & Chấm bài thực hành (Audit & Grade Submissions)

Áp dụng khi người dùng cung cấp bài giải Lab 1, Lab 2, Lab 3 hoặc bài tập truy vấn/thiết kế CSDL và yêu cầu kiểm tra tính chính xác.

### Quy trình thẩm định 4 bước:

1. **Bước 1: Đối chiếu yêu cầu đề bài**:
   - Xác định rõ ràng các bảng tham gia, các ràng buộc và kết quả mong muốn.
2. **Bước 2: Soi lỗi chi tiết theo từng loại Lab**:
   - **Đối với Lab 1 (Đại số quan hệ)**:
     - ❌ **Lỗi kinh điển**: Dùng `Color='Red' AND Color='Green'` trên cùng 1 bảng $\to$ Trừ ngay 100% điểm câu đó (kết quả rỗng).
     - ❌ **Lỗi phép chia**: Bài toán "tất cả" (*all*) nhưng chỉ dùng phép Join thông thường mà không dùng toán tử chia ($\div$) hoặc phép trừ kép qua tích Descartes.
     - ❌ **Lỗi tự nối (Self-join)**: Tìm "ít nhất 2" nhưng không kiểm tra điều kiện khác biệt (`bid1 != bid2`).
     - ❌ **Lỗi thiếu ngoặc hoặc sai thứ tự ưu tiên**: Không chiếu đúng cột ở bước cuối cùng.
   - **Đối với Lab 2 (Chuẩn hóa Normalization)**:
     - ❌ **Lỗi lưu thuộc tính suy dẫn**: Lưu `Total`, `Tax`, `Amount Owing`, `Age` vào bảng $\to$ Trừ điểm thiết kế.
     - ❌ **Lỗi 2NF**: Chưa tách hết các thuộc tính phụ thuộc vào một phần khóa chính hỗn hợp.
     - ❌ **Lỗi 3NF**: Chưa khử hết phụ thuộc bắc cầu (ví dụ: `CustomerName` suy ra `Address`).
     - ❌ **Lỗi mất mát thông tin**: Tách bảng làm mất khóa liên kết (không thỏa mãn *Lossless Join*).
   - **Đối với Lab 3 (ERD & Ánh xạ sang Lược đồ quan hệ)**:
     - ❌ **Lỗi quan hệ M:N**: Không tạo bảng trung gian (*Junction Table*).
     - ❌ **Lỗi thực thể yếu**: Khóa chính của thực thể yếu thiếu khóa của thực thể chủ.
     - ❌ **Lỗi khóa ngoại (FK)**: Đặt FK sai phía trong quan hệ 1:N (đặt ở phía 1 thay vì phía N).
3. **Bước 3: Chấm điểm theo Rubric**:
   - Sử dụng thang điểm 10 chuẩn hóa (Xem [grading-rubrics.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-evaluator/references/grading-rubrics.md)).
4. **Bước 4: Xuất Báo cáo Thẩm định (Evaluation Report)**:
   - Tổng điểm đạt được (x/10).
   - Liệt kê các lỗi sai cụ thể, vị trí lỗi và lý do tại sao sai.
   - Cung cấp lời giải chuẩn xác đã được sửa lại hoàn chỉnh.
   - Lời khuyên ôn tập cải thiện.

---

## 📝 MODE 2: Tạo Quiz & Đề thi Kiểm tra (Exam & Quiz Generator)

Áp dụng khi người dùng muốn tự kiểm tra kiến thức, làm bài trắc nghiệm ôn tập trước kỳ thi PE (Practical Exam) hoặc FE (Final Exam).

### Ma trận 8 Chapters kiến thức DBI202:
- **Chapter 1: DB Introduction**: DBMS vs File system, 3-Schema Architecture, Logical & Physical Data Independence.
- **Chapter 2: Relational Model**: Relations, Attributes, Tuples, Candidate Keys, Primary Keys, Foreign Keys, Referential Integrity.
- **Chapter 3: Design Theory & Normal Forms**: Functional Dependencies (FD), Armstrong Axioms, Attribute Closure ($X^+$), 1NF, 2NF, 3NF, BCNF, Anomalies.
- **Chapter 4: High-Level Database Model**: ERD, Strong/Weak Entities, Multivalued/Derived attributes, Cardinality 1:1, 1:N, M:N, 7 Transformation Rules.
- **Chapter 5: Bags (Multisets)**: Bag relational algebra, Duplicate elimination ($\delta$), Aggregation ($\gamma$), Sorting ($\tau$).
- **Chapter 6: SQL Language**: DDL (CREATE/ALTER/DROP), DML (SELECT, JOINs, Subqueries, GROUP BY, HAVING, EXISTS, IN), Three-valued logic (NULL).
- **Chapter 7: Practical Issues**: Indexes (Clustered vs Non-clustered, B-Tree), Transactions & ACID, Serializability, Concurrency anomalies (Dirty Read, Non-repeatable Read, Phantom Read), Isolation levels.
- **Chapter 8: Database Programming**: T-SQL, Stored Procedures, Scalar & Table-valued UDFs, Triggers (AFTER vs INSTEAD OF, `inserted` & `deleted` tables), Views.

### Các format tạo đề thi:
1. **Format 1: Quick Quiz (5 - 10 câu trắc nghiệm ngẫu nhiên)**:
   - Mỗi câu gồm 4 đáp án A, B, C, D.
   - Có đáp án và phân tích chi tiết: vì sao đáp án này đúng, và vì sao các đáp án còn lại là bẫy sai (*distractors*).
2. **Format 2: Chế độ Thi thử tương tác (Interactive Mock Test)**:
   - AI đưa từng câu hỏi một cho sinh viên trả lời.
   - Sau khi sinh viên chọn, AI phản hồi đúng/sai ngay lập tức, giải thích kiến thức liên quan và chuyển sang câu tiếp theo.
   - Tổng kết điểm số sau bài thi và chỉ ra các chương cần ôn luyện thêm.
3. **Format 3: Bài tập thực hành mô phỏng PE (Practical Exam)**:
   - Cho lược đồ CSDL và yêu cầu viết câu lệnh SQL nâng cao (Subquery, Group by, Window functions hoặc Stored Procedure / Trigger).

> 📖 **Xem ngân hàng câu hỏi mẫu và ma trận đề thi**:
> - [chapter-exam-matrix.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-evaluator/references/chapter-exam-matrix.md)
> - [quiz-bank-samples.md](file:///d:/FPT%20UNIVERSITY/Hoc-ki/ki%203/DBI/Lab123/.agent/.skill/dbi202-evaluator/references/quiz-bank-samples.md)

---

## 📋 Mẫu phản hồi thẩm định chuẩn (Evaluation Output)

Khi thực hiện chấm bài cho sinh viên, luôn trình bày theo mẫu chuẩn sau:

```markdown
# 📋 BÁO CÁO THẨM ĐỊNH VÀ CHẤM ĐIỂM BÀI LÀM
- **Bài kiểm tra**: [Lab 1 / Lab 2 / Lab 3 / Bài tập CSDL]
- **Tổng điểm đánh giá**: **[x.x] / 10.0**
- **Đánh giá tổng quan**: [Tóm tắt ngắn gọn ưu và nhược điểm]

---

### 🔍 Chi tiết từng câu / tiêu chí:
1. **Câu 1 / Mục 1**: [Tên nội dung]
   - **Kết quả**: ✅ ĐÚNG / ⚠️ ĐÚNG MỘT PHẦN / ❌ SAI
   - **Điểm**: [x/y điểm]
   - **Nhận xét**: [Phân tích logic của sinh viên]
   - **Khắc phục (nếu sai)**: [Biểu thức hoặc thiết kế đúng]

---

### ⚠️ Các lỗi cần lưu ý đặc biệt:
- [Liệt kê các bẫy sinh viên đã mắc phải]

### 💡 Lời khuyên cải thiện:
- [Đề xuất tài liệu hoặc slide tương ứng để xem lại]
```
