# 📚 DBI202 - Database Systems | FPT University

Complete academic lab solutions, relational database modeling, advanced SQL queries, normal forms decomposition, and database programming for course **DBI202 (Database Systems)** at FPT University.

---

## 👤 Student Information
- **Student Name**: Huỳnh Hoàng Siêu
- **Student ID**: QE210005
- **Class**: SE20D
- **Course**: DBI202 - Database Systems
- **Institution**: FPT University

---

## 📂 Repository Structure

```
.
├── output/                         # 📁 Solved deliverables ready for submission (.docx)
│   ├── Lab1.docx                   # Lab 1: Relational Algebra Queries (10 Tasks)
│   ├── Lab2.docx                   # Lab 2: Database Normalization (1NF → 3NF/BCNF)
│   ├── Lab3.docx                   # Lab 3: Conceptual Design & Relational Mapping (ERD)
│   ├── Lab4.docx                   # Lab 4: Advanced SQL Queries (CompanyDB - 52 Queries)
│   ├── Lab5.docx                   # Lab 5: Database Programming on SQL Server (T-SQL)
│   └── erd_diagram.png             # High-Resolution ERD Diagram for University Management
│
├── Lab/                            # 📁 Original laboratory assignment problem statements
│   ├── Lab1.docx
│   ├── Lab2.docx
│   ├── Lab3.docx
│   ├── Lab4.docx
│   └── Lab5.docx
│
├── kien-thuc/                      # 📁 Course lecture slides & reference documentation
│   ├── Slide/                      # Official slides (Chapters 1 to 8 + Introduction)
│   │   ├── Chapter 1.pptx          # Introduction to Database System
│   │   ├── Chapter 2.pptx          # The Relational Model of Data
│   │   ├── Chapter 3.pptx          # Design Theory & Normalization
│   │   ├── Chapter 4.pptx          # High-Level Database Model (ERD)
│   │   ├── Chapter 5.pptx          # Bags Concept (Multisets)
│   │   ├── Chapter 6.pptx          # The Database Language SQL
│   │   ├── Chapter 7.pptx          # Indexes, Transactions & Concurrency Control
│   │   └── Chapter 8.pptx          # Database Programming on SQL Server
│   ├── 1. Class Notes/
│   ├── 2. AI Interactions/
│   └── 3. Key Concepts/
│
├── mau/                            # 📁 Historical sample submissions and comparison benchmarks
│   ├── Lab123-k/
│   ├── Lab123-t/
│   └── lab/
│
├── .agent/.skill/                  # 📁 Specialized AI Agent Skills
│   ├── dbi202-lab-solver/          # Expert solver skill for Relational Algebra, Normalization & ERD
│   └── dbi202-evaluator/           # Audit, grading & exam question generator skill
│
├── build_all_labs.py               # 🐍 Automation script generating Lab 1, Lab 2, Lab 3 docx files
├── build_lab45.py                  # 🐍 Automation script generating Lab 4, Lab 5 docx files
└── README.md
```

---

## 📝 Laboratory Exercises Summary

### 🔹 Lab 1: Relational Algebra Queries
- **Schema**: `Sailors(sid, sname, rating, age)`, `Boats(bid, bname, color)`, `Reserves(sid, bid, day)`.
- **Core Topics**:
  - Selection ($\sigma$), Projection ($\pi$), Natural Join ($\bowtie$), Cartesian Product ($\times$).
  - Logical conditions: Disjunction ($\lor$) vs Conjunction across tuples ($\cap$).
  - Negation and set difference ($-$) for non-reservation queries.
  - Universal quantification via Relational Division ($\div$) and double negation.
  - Self-joins ($\rho$) with inequality comparisons for counting thresholds ($\ge 2$).

### 🔹 Lab 2: Database Normalization (1NF → 3NF / BCNF)
- **Problem 1 (Healthy History Report)**: Decomposing clinical treatment data into `PET`, `PROCEDURE`, `VISIT`, and `OWNER`.
- **Problem 2 (Hilltop Animal Hospital Invoice)**:
  - Critical rule of **Derived Attributes**: Dynamically computed fields (`Total`, `Tax`, `Amount Owing`) are excluded from database storage.
  - Removing partial dependencies to achieve 2NF.
  - Eliminating transitive dependencies to achieve 3NF (`CUSTOMER`, `INVOICE`, `INVOICE_DETAIL`).

### 🔹 Lab 3: Conceptual Modeling (ERD) & Relational Mapping
- **Domain**: University Management System.
- **Components**:
  - Entities: `DEPARTMENT`, `INSTRUCTOR`, `SUBJECT`, `CLASS`, `STUDENT`.
  - Weak Entity: `SECTION` (identified by `CLASS`).
  - Associative Junction: `GRADE_REPORT`, `INSTRUCTOR_SUBJECT` (`TEACH`), `PREREQUISITE_SUBJECT`.
  - Multivalued attribute normalization: `INSTRUCTOR_QUALIFICATION`.
- **Systematic Mapping**: 7 formal conversion rules applied from ERD to Relational Model.

### 🔹 Lab 4: Advanced SQL Queries (CompanyDB)
- **Domain**: 52 complex SQL queries covering employee hierarchies, project allocations, department management, location mappings, and dependents.
- **Techniques**:
  - Multi-table joins and self-joins for supervision hierarchies.
  - Ranking queries using `TOP 1 WITH TIES ... ORDER BY ...`.
  - Grouping and conditional group filters with `GROUP BY` and `HAVING`.
  - Anti-joins and existential filtering via `NOT IN` and `NOT EXISTS`.

### 🔹 Lab 5: Database Programming on SQL Server (ABCCompany)
- **Domain**: Materials, Sales Orders & Inventory Management.
- **Implemented Objects**:
  - `QE210005_Func1(@mavt)`: Scalar function calculating total revenue of a material.
  - `QE210005_FuncTotalHoaDon(@MaHD)`: Scalar function calculating total amount of an invoice.
  - `QE210005_Proc1(@makh, @diachi)`: Stored procedure updating customer address with existence checks.
  - `QE210005_ProcAddItem`: Transaction-safe stored procedure inserting line items and deducting inventory.
  - `QE210005_Trig1`: Multi-row safe `AFTER INSERT, UPDATE, DELETE` DML trigger automatically updating `Tongtien` in `HOADON`.
  - `QE210005_View1`: Relational view extracting distinct customers purchasing material 'GACH ONG'.

---

## 🚀 How to Regenerate Deliverables

To re-generate all Word documents with full formatting:

```bash
# Generate Lab 1, Lab 2, and Lab 3 (.docx)
python build_all_labs.py

# Generate Lab 4 and Lab 5 (.docx)
python build_lab45.py
```

The output documents will be placed in the `output/` directory.
