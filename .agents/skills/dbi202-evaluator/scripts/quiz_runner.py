#!/usr/bin/env python3
"""
Interactive Quiz Runner & Grader for DBI202.
Allows running quick MCQ checks from terminal or validating answer keys.
"""

import sys

if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

SAMPLE_QUESTIONS = [
    {
        "id": 1,
        "chapter": "Chapter 1",
        "question": "Khả năng thay đổi cấu trúc lưu trữ vật lý mà không làm thay đổi lược đồ quan niệm (Conceptual schema) được gọi là gì?",
        "options": {
            "A": "Logical Data Independence",
            "B": "Physical Data Independence",
            "C": "Schema Evolution",
            "D": "Data Redundancy"
        },
        "answer": "B",
        "explanation": "Physical Data Independence là tính độc lập dữ liệu vật lý (Chapter 1)."
    },
    {
        "id": 2,
        "chapter": "Chapter 3",
        "question": "Dạng chuẩn nào loại bỏ hoàn toàn các phụ thuộc hàm có vế trái không phải là siêu khóa (Superkey)?",
        "options": {
            "A": "1NF",
            "B": "2NF",
            "C": "3NF",
            "D": "BCNF"
        },
        "answer": "D",
        "explanation": "BCNF yêu cầu mọi phụ thuộc hàm không tầm thường X -> Y đều phải có X là Superkey."
    },
    {
        "id": 3,
        "chapter": "Chapter 7",
        "question": "Một bảng trong SQL Server có thể có tối đa bao nhiêu Clustered Index?",
        "options": {
            "A": "1",
            "B": "249",
            "C": "999",
            "D": "Không giới hạn"
        },
        "answer": "A",
        "explanation": "Clustered Index quyết định thứ tự vật lý của dữ liệu trên đĩa, nên mỗi bảng chỉ có tối đa 1 Clustered Index."
    }
]

def run_diagnostic():
    print("=" * 60)
    print("=== DBI202 DIAGNOSTIC QUIZ CHECK ===")
    print("=" * 60)
    score = 0
    total = len(SAMPLE_QUESTIONS)
    for q in SAMPLE_QUESTIONS:
        print(f"\n[Câu {q['id']} - {q['chapter']}]: {q['question']}")
        for opt, txt in q['options'].items():
            print(f"  {opt}. {txt}")
        print(f"  -> Đáp án đúng: {q['answer']}")
        print(f"  -> Giải thích: {q['explanation']}")
        score += 1
    print("\n" + "=" * 60)
    print(f"Diagnostic hoàn tất. Đã nạp thành công {total} câu hỏi mẫu.")

if __name__ == "__main__":
    run_diagnostic()
