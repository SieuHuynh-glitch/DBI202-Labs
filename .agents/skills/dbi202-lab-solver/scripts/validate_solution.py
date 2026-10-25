#!/usr/bin/env python3
"""
Solution Validator for DBI202 Lab Exercises.
Checks Relational Algebra queries and Normalization schemas for common student mistakes.
"""

import re
import sys

# Ensure UTF-8 output across Windows environments
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

def check_relational_algebra(expr: str):
    issues = []
    # Check parentheses balance
    if expr.count('(') != expr.count(')'):
        issues.append(f"Mất cân bằng dấu ngoặc đơn: {expr.count('(')} '(' vs {expr.count(')')} ')'")
    
    # Check for the classical Color='Red' AND Color='Green' trap
    and_pattern = re.search(r"(\w+)\s*=\s*['\"]([^'\"]+)['\"]\s+(?:AND|and|\^|\&)\s+\1\s*=\s*['\"]([^'\"]+)['\"]", expr)
    if and_pattern:
        col, val1, val2 = and_pattern.group(1), and_pattern.group(2), and_pattern.group(3)
        if val1.lower() != val2.lower():
            issues.append(f"CẢNH BÁO BẪY LOGIC: Biểu thức kiểm tra '{col}={val1} AND {col}={val2}' trên cùng một bản ghi sẽ luôn trả về RỖNG! Cần dùng phép Giao (∩) giữa 2 quan hệ hoặc Self-Join.")

    # Check for division operator syntax
    if "all boats" in expr.lower() or "tat ca" in expr.lower():
        if "÷" not in expr and "/" not in expr and "-" not in expr:
            issues.append("Bài toán 'tất cả' (For all) thường cần dùng toán tử Chia quan hệ (÷) hoặc phép Trừ kép (-).")

    return issues

def check_normalization_schema(schema_text: str):
    issues = []
    derived_keywords = ['total', 'tax', 'amount owing', 'amount_owing', 'age']
    for kw in derived_keywords:
        if re.search(rf"\b{kw}\b", schema_text, re.IGNORECASE):
            issues.append(f"CẢNH BÁO THUỘC TÍNH SUY DẪN: Phát hiện thuộc tính '{kw}'. Trong chuẩn hóa CSDL, các trường tính toán được không nên lưu trữ trong bảng để tránh dị thường.")
    return issues

if __name__ == "__main__":
    test_expr = "πSname(σColor='Red' AND Color='Green' (Boats) ⋈ Reserves ⋈ Sailors)"
    print("Testing expression:", test_expr)
    results = check_relational_algebra(test_expr)
    for res in results:
        print(" -", res)
