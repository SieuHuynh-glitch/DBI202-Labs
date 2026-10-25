#!/usr/bin/env python3
"""
Complete Professional Builder for DBI202 Lab 1, Lab 2, Lab 3.
Student: Huỳnh Hoàng Siêu | Student ID: QE210005 | Class: SE20D
Course: DBI202 - Database Systems | FPT University
"""

import os
import sys
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

# Color palette: Elegant Deep Navy & Slate Theme
COLOR_NAVY = RGBColor(0, 51, 102)        # #003366
COLOR_SLATE = RGBColor(74, 111, 165)     # #4A6FA5
COLOR_DARK = RGBColor(40, 40, 40)        # #282828
COLOR_MUTED = RGBColor(100, 100, 100)    # #646464
COLOR_RED = RGBColor(180, 40, 40)        # #B42828
COLOR_GREEN = RGBColor(34, 139, 34)      # #228B22

HEX_NAVY = "003366"
HEX_SLATE = "4A6FA5"
HEX_LIGHT_BLUE = "F0F4F8"
HEX_LIGHT_GRAY = "F8F9FA"
HEX_BORDER = "D0D7DE"
HEX_HEADER_BG = "003366"

def set_cell_shading(cell, color_hex):
    shading_elm = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{color_hex}"/>')
    cell._tc.get_or_add_tcPr().append(shading_elm)

def set_cell_margins(cell, top=80, bottom=80, left=120, right=120):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m, val in [('top', top), ('bottom', bottom), ('left', left), ('right', right)]:
        node = OxmlElement(f'w:{m}')
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def set_table_borders(table, color="D0D7DE", sz="4", val="single"):
    tblPr = table._tbl.tblPr
    borders = parse_xml(
        f'<w:tblBorders {nsdecls("w")}>'
        f'  <w:top w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:bottom w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:left w:val="none"/>'
        f'  <w:right w:val="none"/>'
        f'  <w:insideH w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:insideV w:val="none"/>'
        f'</w:tblBorders>'
    )
    tblPr.append(borders)

def add_header_block(doc, lab_title, lab_subtitle):
    p_uni = doc.add_paragraph()
    p_uni.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_uni.paragraph_format.space_after = Pt(2)
    run_uni = p_uni.add_run("FPT UNIVERSITY - DEPARTMENT OF INFORMATION TECHNOLOGY")
    run_uni.font.name = "Calibri"
    run_uni.font.size = Pt(11)
    run_uni.font.bold = True
    run_uni.font.color.rgb = COLOR_SLATE

    p_course = doc.add_paragraph()
    p_course.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_course.paragraph_format.space_after = Pt(6)
    run_course = p_course.add_run("COURSE: DBI202 - DATABASE SYSTEMS")
    run_course.font.name = "Calibri"
    run_course.font.size = Pt(13)
    run_course.font.bold = True
    run_course.font.color.rgb = COLOR_NAVY

    p_title = doc.add_paragraph()
    p_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_title.paragraph_format.space_after = Pt(3)
    run_title = p_title.add_run(lab_title)
    run_title.font.name = "Calibri"
    run_title.font.size = Pt(20)
    run_title.font.bold = True
    run_title.font.color.rgb = COLOR_NAVY

    if lab_subtitle:
        p_sub = doc.add_paragraph()
        p_sub.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p_sub.paragraph_format.space_after = Pt(10)
        run_sub = p_sub.add_run(lab_subtitle)
        run_sub.font.name = "Calibri"
        run_sub.font.size = Pt(11)
        run_sub.font.italic = True
        run_sub.font.color.rgb = COLOR_MUTED

    # Student Info Table
    table = doc.add_table(rows=2, cols=3)
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False

    col_widths = [Inches(2.5), Inches(2.1), Inches(2.1)]
    info_data = [
        [("Student Name:", True), ("Student ID:", True), ("Class:", True)],
        [("Huỳnh Hoàng Siêu", False), ("QE210005", False), ("SE20D", False)]
    ]

    for r_idx, row in enumerate(table.rows):
        for c_idx, cell in enumerate(row.cells):
            cell.width = col_widths[c_idx]
            text, is_label = info_data[r_idx][c_idx]
            p = cell.paragraphs[0]
            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
            p.paragraph_format.space_after = Pt(2)
            p.paragraph_format.space_before = Pt(2)
            run = p.add_run(text)
            run.font.name = "Calibri"
            run.font.size = Pt(10)
            if is_label:
                run.font.bold = True
                run.font.color.rgb = COLOR_SLATE
                set_cell_shading(cell, HEX_LIGHT_BLUE)
            else:
                run.font.bold = True
                run.font.color.rgb = COLOR_NAVY
                set_cell_shading(cell, HEX_LIGHT_GRAY)
            set_cell_margins(cell, top=70, bottom=70, left=100, right=100)

    set_table_borders(table, color="B0C4DE", sz="6", val="single")

    p_div = doc.add_paragraph()
    p_div.paragraph_format.space_before = Pt(12)
    p_div.paragraph_format.space_after = Pt(12)
    p_div_border = parse_xml(f'<w:pBdr {nsdecls("w")}><w:bottom w:val="single" w:sz="12" w:space="1" w:color="{HEX_NAVY}"/></w:pBdr>')
    p_div._p.get_or_add_pPr().append(p_div_border)

def add_heading_1(doc, text):
    h = doc.add_paragraph()
    h.paragraph_format.space_before = Pt(14)
    h.paragraph_format.space_after = Pt(6)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(14)
    run.font.bold = True
    run.font.color.rgb = COLOR_NAVY
    return h

def add_heading_2(doc, text):
    h = doc.add_paragraph()
    h.paragraph_format.space_before = Pt(10)
    h.paragraph_format.space_after = Pt(4)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(12)
    run.font.bold = True
    run.font.color.rgb = COLOR_SLATE
    return h

def add_callout(doc, title, text, bg_hex=HEX_LIGHT_BLUE, border_color="4A6FA5"):
    table = doc.add_table(rows=1, cols=1)
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False
    table.rows[0].cells[0].width = Inches(6.7)
    cell = table.rows[0].cells[0]
    set_cell_shading(cell, bg_hex)
    set_cell_margins(cell, top=80, bottom=80, left=140, right=140)
    
    tcBorders = parse_xml(
        f'<w:tcBorders {nsdecls("w")}>'
        f'  <w:left w:val="single" w:sz="24" w:space="0" w:color="{border_color}"/>'
        f'  <w:top w:val="none"/>'
        f'  <w:bottom w:val="none"/>'
        f'  <w:right w:val="none"/>'
        f'</w:tcBorders>'
    )
    cell._tc.get_or_add_tcPr().append(tcBorders)

    p = cell.paragraphs[0]
    p.paragraph_format.space_after = Pt(2)
    p.paragraph_format.space_before = Pt(2)
    if title:
        run_t = p.add_run(title + "\n")
        run_t.font.name = "Calibri"
        run_t.font.bold = True
        run_t.font.size = Pt(10)
        run_t.font.color.rgb = COLOR_NAVY
    
    run_b = p.add_run(text)
    run_b.font.name = "Consolas" if any(sym in text for sym in ["π", "σ", "SELECT", "⋈", "→", "÷"]) else "Calibri"
    run_b.font.size = Pt(9.5)
    run_b.font.color.rgb = COLOR_DARK

    p_after = doc.add_paragraph()
    p_after.paragraph_format.space_before = Pt(0)
    p_after.paragraph_format.space_after = Pt(2)

def style_standard_table(table, col_widths, headers, rows_data):
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False

    # Header Row
    hdr_cells = table.rows[0].cells
    for i, title in enumerate(headers):
        hdr_cells[i].width = col_widths[i]
        p = hdr_cells[i].paragraphs[0]
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p.paragraph_format.space_before = Pt(3)
        p.paragraph_format.space_after = Pt(3)
        run = p.add_run(title)
        run.font.name = "Calibri"
        run.font.bold = True
        run.font.size = Pt(9.5)
        run.font.color.rgb = RGBColor(255, 255, 255)
        set_cell_shading(hdr_cells[i], HEX_HEADER_BG)
        set_cell_margins(hdr_cells[i], top=50, bottom=50, left=80, right=80)

    # Data Rows
    for r_idx, row_values in enumerate(rows_data):
        row_cells = table.rows[r_idx + 1].cells
        bg_col = HEX_LIGHT_GRAY if r_idx % 2 == 1 else "FFFFFF"
        for c_idx, val in enumerate(row_values):
            row_cells[c_idx].width = col_widths[c_idx]
            p = row_cells[c_idx].paragraphs[0]
            p.alignment = WD_ALIGN_PARAGRAPH.CENTER if c_idx == 0 or len(str(val)) < 8 else WD_ALIGN_PARAGRAPH.LEFT
            p.paragraph_format.space_before = Pt(2)
            p.paragraph_format.space_after = Pt(2)
            run = p.add_run(str(val))
            run.font.name = "Calibri"
            run.font.size = Pt(9)
            run.font.color.rgb = COLOR_DARK
            set_cell_shading(row_cells[c_idx], bg_col)
            set_cell_margins(row_cells[c_idx], top=40, bottom=40, left=80, right=80)

    set_table_borders(table, color="D0D7DE", sz="4", val="single")

# ==========================================
# LAB 1 GENERATION
# ==========================================
def generate_lab1(output_path="output/Lab1.docx"):
    doc = docx.Document()
    for sec in doc.sections:
        sec.top_margin = Inches(1.0)
        sec.bottom_margin = Inches(1.0)
        sec.left_margin = Inches(1.0)
        sec.right_margin = Inches(1.0)

    add_header_block(doc, "LAB 1: RELATIONAL ALGEBRA QUERIES", "Formal Relational Queries, Algebraic Transformations & Instance Evaluation")

    add_heading_1(doc, "1. Database Schema & Sample Data Instances")
    p_desc = doc.add_paragraph()
    p_desc.add_run("Consider the classical relational database schema representing sailors, boats, and boat reservation records:")
    
    add_callout(doc, "Relational Database Schema Definition:", 
                "Sailors(sid: integer, sname: string, rating: integer, age: real)\n"
                "Boats(bid: integer, bname: string, color: string)\n"
                "Reserves(sid: integer, bid: integer, day: date)\n\n"
                "Primary Keys: Sailors(sid), Boats(bid), Reserves(sid, bid, day)\n"
                "Foreign Keys: Reserves.sid references Sailors(sid), Reserves.bid references Boats(bid)")

    add_heading_2(doc, "Given Instance Tables:")

    # Table 1: Sailors
    doc.add_paragraph().add_run("Table 1.1: Sailors Relation Instance").bold = True
    tbl_sailors = doc.add_table(rows=11, cols=4)
    style_standard_table(
        tbl_sailors,
        [Inches(1.2), Inches(2.0), Inches(1.5), Inches(1.5)],
        ["sid (PK)", "sname", "rating", "age"],
        [
            ["22", "Dustin", "7", "45.0"],
            ["29", "Brutus", "1", "33.0"],
            ["31", "Lubber", "8", "55.5"],
            ["32", "Andy", "8", "25.5"],
            ["58", "Rusty", "10", "35.0"],
            ["64", "Horatio", "7", "35.0"],
            ["71", "Zorba", "10", "16.0"],
            ["74", "Horatio", "9", "35.0"],
            ["85", "Art", "3", "25.5"],
            ["95", "Bob", "3", "63.5"]
        ]
    )

    doc.add_paragraph().paragraph_format.space_after = Pt(2)

    # Table 2: Boats
    doc.add_paragraph().add_run("Table 1.2: Boats Relation Instance").bold = True
    tbl_boats = doc.add_table(rows=5, cols=3)
    style_standard_table(
        tbl_boats,
        [Inches(1.5), Inches(2.5), Inches(2.2)],
        ["bid (PK)", "bname", "color"],
        [
            ["101", "Interlake", "Blue"],
            ["102", "Interlake", "Red"],
            ["103", "Clipper", "Green"],
            ["104", "Marine", "Red"]
        ]
    )

    doc.add_paragraph().paragraph_format.space_after = Pt(2)

    # Table 3: Reserves
    doc.add_paragraph().add_run("Table 1.3: Reserves Relation Instance").bold = True
    tbl_reserves = doc.add_table(rows=11, cols=3)
    style_standard_table(
        tbl_reserves,
        [Inches(1.5), Inches(2.0), Inches(2.7)],
        ["sid (FK)", "bid (FK)", "day"],
        [
            ["22", "101", "10/10/08"],
            ["22", "102", "10/10/08"],
            ["22", "103", "10/08/08"],
            ["22", "104", "10/07/08"],
            ["31", "102", "11/10/08"],
            ["31", "103", "11/06/08"],
            ["31", "104", "11/12/08"],
            ["64", "101", "9/05/08"],
            ["64", "102", "9/08/08"],
            ["74", "103", "9/08/08"]
        ]
    )

    doc.add_paragraph().paragraph_format.space_after = Pt(10)

    # Section 2: 10 Queries
    add_heading_1(doc, "2. Relational Algebra Queries & Solutions")

    queries = [
        {
            "id": "Query 1",
            "title": "Find the names of sailors who have reserved boat 103",
            "algebra": "π_sname( σ_bid = 103 (Reserves) ⋈ Sailors )",
            "explanation": "1. Filter the Reserves relation for tuples with bid = 103 via selection σ_bid=103(Reserves).\n"
                           "2. Join (⋈) the resulting tuples with Sailors on sid.\n"
                           "3. Project (π) only the sname attribute. Duplicate names are removed by relational projection.",
            "sql": "SELECT DISTINCT S.sname\nFROM Sailors S\nINNER JOIN Reserves R ON S.sid = R.sid\nWHERE R.bid = 103;",
            "result": "Dustin, Lubber, Horatio"
        },
        {
            "id": "Query 2",
            "title": "Find the names of sailors who have reserved a red boat",
            "algebra": "π_sname( σ_color = 'Red' (Boats) ⋈ Reserves ⋈ Sailors )",
            "explanation": "1. Filter Boats where color = 'Red' (bids 102 and 104).\n"
                           "2. Natural join with Reserves on bid, then with Sailors on sid.\n"
                           "3. Project sname to return unique sailor names.",
            "sql": "SELECT DISTINCT S.sname\nFROM Sailors S\nINNER JOIN Reserves R ON S.sid = R.sid\nINNER JOIN Boats B ON R.bid = B.bid\nWHERE B.color = 'Red';",
            "result": "Dustin, Lubber, Horatio"
        },
        {
            "id": "Query 3",
            "title": "Find the colors of boats reserved by Lubber",
            "algebra": "π_color( σ_sname = 'Lubber' (Sailors) ⋈ Reserves ⋈ Boats )",
            "explanation": "1. Select sailor 'Lubber' (sid = 31).\n"
                           "2. Join with Reserves to find Lubber's reservations (bids 102, 103, 104).\n"
                           "3. Join with Boats and project distinct color values (Red, Green).",
            "sql": "SELECT DISTINCT B.color\nFROM Boats B\nINNER JOIN Reserves R ON B.bid = R.bid\nINNER JOIN Sailors S ON R.sid = S.sid\nWHERE S.sname = 'Lubber';",
            "result": "Red, Green"
        },
        {
            "id": "Query 4",
            "title": "Find the names of sailors who have reserved at least one boat",
            "algebra": "π_sname( Sailors ⋈ Reserves )",
            "explanation": "1. Natural join Sailors with Reserves on sid. Only sailors who have at least one entry in Reserves are retained.\n"
                           "2. Project sname.",
            "sql": "SELECT DISTINCT S.sname\nFROM Sailors S\nINNER JOIN Reserves R ON S.sid = R.sid;",
            "result": "Dustin, Lubber, Horatio"
        },
        {
            "id": "Query 5",
            "title": "Find the names of sailors who have reserved a red or a green boat",
            "algebra": "π_sname( σ_color = 'Red' ∨ color = 'Green' (Boats) ⋈ Reserves ⋈ Sailors )\n"
                       "   -- Equivalently using Union (∪):\n"
                       "π_sname( σ_color = 'Red' (Boats) ⋈ Reserves ⋈ Sailors ) ∪ π_sname( σ_color = 'Green' (Boats) ⋈ Reserves ⋈ Sailors )",
            "explanation": "1. Filter boats whose color is 'Red' OR 'Green' (bids 102, 103, 104).\n"
                           "2. Join with Reserves and Sailors, then project sname.",
            "sql": "SELECT DISTINCT S.sname\nFROM Sailors S\nINNER JOIN Reserves R ON S.sid = R.sid\nINNER JOIN Boats B ON R.bid = B.bid\nWHERE B.color = 'Red' OR B.color = 'Green';",
            "result": "Dustin, Lubber, Horatio"
        },
        {
            "id": "Query 6",
            "title": "Find the names of sailors who have reserved a red and a green boat",
            "algebra": "ρ( RedSids,   π_sid( σ_color = 'Red' (Boats) ⋈ Reserves ) )\n"
                       "ρ( GreenSids, π_sid( σ_color = 'Green' (Boats) ⋈ Reserves ) )\n"
                       "π_sname( ( RedSids ∩ GreenSids ) ⋈ Sailors )",
            "explanation": "⚠️ LOGIC EVALUATION: A single boat tuple has exactly one color. Writing σ_color='Red' ∧ color='Green'(Boats) evaluates to EMPTY. "
                           "The correct relational approach finds sailors who reserved red boats ({22, 31, 64}), finds sailors who reserved green boats ({22, 31, 74}), "
                           "and intersects (∩) their IDs ({22, 31}). Joining {22, 31} with Sailors yields Dustin and Lubber.",
            "sql": "SELECT S.sname\nFROM Sailors S\nWHERE S.sid IN (\n    SELECT R.sid FROM Reserves R JOIN Boats B ON R.bid = B.bid WHERE B.color = 'Red'\n) AND S.sid IN (\n    SELECT R.sid FROM Reserves R JOIN Boats B ON R.bid = B.bid WHERE B.color = 'Green'\n);",
            "result": "Dustin, Lubber"
        },
        {
            "id": "Query 7",
            "title": "Find the sids of sailors with age over 20 who have not reserved a red boat",
            "algebra": "π_sid( σ_age > 20 (Sailors) )  −  π_sid( σ_color = 'Red' (Boats) ⋈ Reserves )",
            "explanation": "1. Universe of sailors older than 20: {22, 29, 31, 32, 58, 64, 74, 85, 95} (all except Zorba with age 16.0).\n"
                           "2. Sailors who reserved red boats: {22, 31, 64}.\n"
                           "3. Set difference (−) removes {22, 31, 64} from the universe, yielding {29, 32, 58, 74, 85, 95}.",
            "sql": "SELECT S.sid\nFROM Sailors S\nWHERE S.age > 20\nEXCEPT\nSELECT R.sid\nFROM Reserves R\nINNER JOIN Boats B ON R.bid = B.bid\nWHERE B.color = 'Red';",
            "result": "29, 32, 58, 74, 85, 95"
        },
        {
            "id": "Query 8",
            "title": "Find the names of sailors who have reserved all boats",
            "algebra": "-- Formulation using Relational Division Operator (÷):\n"
                       "π_sname( ( π_sid, bid (Reserves) ÷ π_bid (Boats) ) ⋈ Sailors )\n\n"
                       "-- Equivalent Expanded Expression using Cartesian Product (×) & Difference (−):\n"
                       "π_sname( ( π_sid (Sailors) − π_sid( ( π_sid (Sailors) × π_bid (Boats) ) − π_sid, bid (Reserves) ) ) ⋈ Sailors )",
            "explanation": "1. The query requires universal quantification ('for all boats'). In relational algebra, this is solved by Division (÷).\n"
                           "2. Divisor: π_bid(Boats) = {101, 102, 103, 104}.\n"
                           "3. In the instance, only sailor sid = 22 (Dustin) has reserved all 4 boats (101, 102, 103, 104).",
            "sql": "SELECT S.sname\nFROM Sailors S\nWHERE NOT EXISTS (\n    SELECT B.bid FROM Boats B\n    EXCEPT\n    SELECT R.bid FROM Reserves R WHERE R.sid = S.sid\n);",
            "result": "Dustin"
        },
        {
            "id": "Query 9",
            "title": "Find the names of sailors who have reserved all boats called Interlake",
            "algebra": "π_sname( ( π_sid, bid (Reserves) ÷ π_bid ( σ_bname = 'Interlake' (Boats) ) ) ⋈ Sailors )",
            "explanation": "1. Interlake boats: {101, 102}.\n"
                           "2. Target divisor set: π_bid(σ_bname='Interlake'(Boats)) = {101, 102}.\n"
                           "3. Sailors reserving both 101 and 102 are Dustin (22) and Horatio (64).",
            "sql": "SELECT S.sname\nFROM Sailors S\nWHERE NOT EXISTS (\n    SELECT B.bid FROM Boats B WHERE B.bname = 'Interlake'\n    EXCEPT\n    SELECT R.bid FROM Reserves R WHERE R.sid = S.sid\n);",
            "result": "Dustin, Horatio"
        },
        {
            "id": "Query 10",
            "title": "Find the names of sailors who have reserved at least two boats",
            "algebra": "ρ( R1, Reserves )\n"
                       "ρ( R2, Reserves )\n"
                       "π_sname( π_R1.sid( σ_R1.bid ≠ R2.bid ( R1 ⋈_R1.sid = R2.sid R2 ) ) ⋈ Sailors )",
            "explanation": "1. Perform a self-join of Reserves on sid with the inequality condition R1.bid ≠ R2.bid.\n"
                           "2. This identifies sailors who reserved at least two distinct boats ({22, 31, 64}).\n"
                           "3. Join with Sailors and project sname.",
            "sql": "SELECT S.sname\nFROM Sailors S\nINNER JOIN Reserves R ON S.sid = R.sid\nGROUP BY S.sid, S.sname\nHAVING COUNT(DISTINCT R.bid) >= 2;",
            "result": "Dustin, Lubber, Horatio"
        }
    ]

    for q in queries:
        h = add_heading_2(doc, f"{q['id']}: {q['title']}")
        add_callout(doc, "Relational Algebra Expression:", q["algebra"], bg_hex=HEX_LIGHT_BLUE, border_color="003366")
        
        p_exp = doc.add_paragraph()
        run_lbl = p_exp.add_run("Detailed Reasoning: ")
        run_lbl.bold = True
        run_lbl.font.color.rgb = COLOR_SLATE
        p_exp.add_run(q["explanation"])
        p_exp.paragraph_format.space_after = Pt(2)

        p_sql = doc.add_paragraph()
        p_sql.paragraph_format.space_before = Pt(2)
        p_sql.paragraph_format.space_after = Pt(2)
        r_sql_lbl = p_sql.add_run("Equivalent SQL Statement:\n")
        r_sql_lbl.bold = True
        r_sql_lbl.font.color.rgb = COLOR_SLATE
        r_sql_code = p_sql.add_run(q["sql"])
        r_sql_code.font.name = "Consolas"
        r_sql_code.font.size = Pt(9.5)
        r_sql_code.font.color.rgb = COLOR_NAVY

        p_res = doc.add_paragraph()
        p_res.paragraph_format.space_before = Pt(2)
        p_res.paragraph_format.space_after = Pt(8)
        r_res_lbl = p_res.add_run("Evaluated Output on Given Instance: ")
        r_res_lbl.bold = True
        r_res_lbl.font.color.rgb = COLOR_GREEN
        r_res_val = p_res.add_run(q["result"])
        r_res_val.bold = True
        r_res_val.font.color.rgb = COLOR_NAVY

    doc.save(output_path)
    print(f"Lab 1 successfully generated at: {output_path}")

# ==========================================
# LAB 2 GENERATION
# ==========================================
def generate_lab2(output_path="output/Lab2.docx"):
    doc = docx.Document()
    for sec in doc.sections:
        sec.top_margin = Inches(1.0)
        sec.bottom_margin = Inches(1.0)
        sec.left_margin = Inches(1.0)
        sec.right_margin = Inches(1.0)

    add_header_block(doc, "LAB 2: DATABASE NORMALIZATION", "Step-by-Step Functional Dependency Analysis & Normal Form Decomposition (1NF to 3NF)")

    # ----------------------------------------------------
    # PROBLEM 1: HEALTHY HISTORY REPORT
    # ----------------------------------------------------
    add_heading_1(doc, "1. Problem 1: Pet Medical Center Healthy History Report")
    
    p_p1 = doc.add_paragraph()
    p_p1.add_run("The following unnormalized clinical treatment data is recorded at a veterinary medical center:")

    tbl_raw1 = doc.add_table(rows=10, cols=7)
    style_standard_table(
        tbl_raw1,
        [Inches(0.8), Inches(1.1), Inches(0.9), Inches(0.8), Inches(1.2), Inches(1.1), Inches(1.9)],
        ["PET ID", "PET NAME", "PET TYPE", "AGE", "OWNER", "VISIT DATE", "PROCEDURE"],
        [
            ["246", "ROVER", "DOG", "12", "SAM COOK", "JAN 13/2002", "01 - RABIES VACCINATION"],
            ["", "", "", "", "", "MAR 27/2002", "10 - EXAMINE and TREAT WOUND"],
            ["", "", "", "", "", "APR 02/2002", "05 - HEART WORM TEST"],
            ["298", "SPOT", "DOG", "2", "TERRY KIM", "JAN 21/2002", "08 - TETANUS VACCINATION"],
            ["", "", "", "", "", "MAR 10/2002", "05 - HEART WORM TEST"],
            ["341", "MORRIS", "CAT", "4", "SAM COOK", "JAN 23/2001", "01 - RABIES VACCINATION"],
            ["", "", "", "", "", "JAN 13/2002", "01 - RABIES VACCINATION"],
            ["519", "TWEEDY", "BIRD", "2", "TERRY KIM", "APR 30/2002", "20 - ANNUAL CHECK UP"],
            ["", "", "", "", "", "APR 30/2002", "12 - EYE WASH"]
        ]
    )

    doc.add_paragraph().paragraph_format.space_after = Pt(6)

    add_heading_2(doc, "Step 1: First Normal Form (1NF)")
    p_1nf_desc = doc.add_paragraph()
    p_1nf_desc.add_run("Definition & Rule: ").bold = True
    p_1nf_desc.add_run("A relation is in 1NF if and only if all attribute values are atomic and there are no repeating groups. "
                       "We flatten the repeating medical visit and procedure lines. The Procedure attribute is decomposed into ProcedureNo and ProcedureDesc.")

    add_callout(doc, "1NF Schema & Functional Dependencies:",
                "HEALTHY_REPORT_1NF(PetID, VisitDate, ProcedureNo, PetName, PetType, PetAge, OwnerName, ProcedureDesc)\n\n"
                "Primary Key: (PetID, VisitDate, ProcedureNo)\n\n"
                "Functional Dependencies (FDs):\n"
                "  FD1: PetID → PetName, PetType, PetAge, OwnerName        (Partial Dependency on PetID)\n"
                "  FD2: ProcedureNo → ProcedureDesc                      (Partial Dependency on ProcedureNo)\n"
                "  FD3: (PetID, VisitDate, ProcedureNo) → [All attributes] (Full Functional Dependency)")

    p_1nf_eval = doc.add_paragraph()
    p_1nf_eval.add_run("Anomalies in 1NF: ").bold = True
    p_1nf_eval.add_run("FD1 and FD2 are partial dependencies because non-key attributes depend only on a proper subset of the composite primary key. "
                       "This causes update anomalies (updating an owner's name requires updating every visit row) and insertion anomalies (cannot record a new procedure without an actual pet visit).")

    add_heading_2(doc, "Step 2: Second Normal Form (2NF)")
    p_2nf_desc = doc.add_paragraph()
    p_2nf_desc.add_run("Definition & Rule: ").bold = True
    p_2nf_desc.add_run("A relation is in 2NF iff it is in 1NF and no non-prime attribute is partially dependent on any candidate key. "
                       "We decompose the relation by removing attributes that depend on only part of the primary key into separate relations:")

    add_callout(doc, "2NF Decomposed Relations:",
                "1. PET(PetID, PetName, PetType, PetAge, OwnerName)\n"
                "   Primary Key: PetID\n\n"
                "2. PROCEDURE(ProcedureNo, ProcedureDesc)\n"
                "   Primary Key: ProcedureNo\n\n"
                "3. VISIT(PetID, VisitDate, ProcedureNo)\n"
                "   Primary Key: (PetID, VisitDate, ProcedureNo)\n"
                "   Foreign Keys: PetID references PET(PetID), ProcedureNo references PROCEDURE(ProcedureNo)")

    add_heading_2(doc, "Step 3: Third Normal Form (3NF)")
    p_3nf_desc = doc.add_paragraph()
    p_3nf_desc.add_run("Definition & Rule: ").bold = True
    p_3nf_desc.add_run("A relation is in 3NF iff it is in 2NF and no non-prime attribute is transitively dependent on any candidate key. "
                       "In the PET relation, if owners are distinct entities who can own multiple pets (e.g. Sam Cook owns Rover and Morris), "
                       "the dependency PetID → OwnerID → OwnerName is transitive. To achieve robust 3NF, we extract OWNER:")

    add_callout(doc, "3NF Final Relational Schema for Problem 1:",
                "1. OWNER(OwnerID, OwnerName)\n"
                "   Primary Key: OwnerID\n\n"
                "2. PET(PetID, PetName, PetType, PetAge, OwnerID)\n"
                "   Primary Key: PetID\n"
                "   Foreign Key: OwnerID references OWNER(OwnerID)\n\n"
                "3. PROCEDURE(ProcedureNo, ProcedureDesc)\n"
                "   Primary Key: ProcedureNo\n\n"
                "4. VISIT(PetID, VisitDate, ProcedureNo)\n"
                "   Primary Key: (PetID, VisitDate, ProcedureNo)\n"
                "   Foreign Keys:\n"
                "     - PetID references PET(PetID)\n"
                "     - ProcedureNo references PROCEDURE(ProcedureNo)")

    # ----------------------------------------------------
    # PROBLEM 2: HILLTOP ANIMAL HOSPITAL INVOICE
    # ----------------------------------------------------
    add_heading_1(doc, "2. Problem 2: Hilltop Animal Hospital Invoice")
    
    p_p2 = doc.add_paragraph()
    p_p2.add_run("The following invoice is issued by Hilltop Animal Hospital:")

    add_callout(doc, "Raw Invoice Document Data:",
                "HILLTOP ANIMAL HOSPITAL\n"
                "DATE: JAN 13/2002                INVOICE # 987\n"
                "CUSTOMER: MR. RICHARD COOK - 123 THIS STREET - MY CITY, ONTARIO - Z5Z 6G6\n"
                "------------------------------------------------------------------------\n"
                "PET         PROCEDURE               AMOUNT\n"
                "ROVER       RABIES VACCINATION      30.00\n"
                "MORRIS      RABIES VACCINATION      24.00\n"
                "------------------------------------------------------------------------\n"
                "TOTAL: 54.00     TAX (8%): 4.32     AMOUNT OWING: 58.32")

    add_heading_2(doc, "Step 0: Critical Analysis of Derived Attributes")
    p_der = doc.add_paragraph()
    p_der.add_run("Fundamental Database Normalization Principle: ").bold = True
    p_der.add_run("Attributes that can be dynamically computed from other stored fields are DERIVED ATTRIBUTES and MUST NOT be stored in normalized tables to avoid data redundancy and modification anomalies:\n"
                  "  • Total = SUM(Amount) = 30.00 + 24.00 = 54.00\n"
                  "  • Tax = 8% × Total = 54.00 × 0.08 = 4.32\n"
                  "  • Amount Owing = Total + Tax = 54.00 + 4.32 = 58.32\n"
                  "Therefore, Total, Tax, and Amount Owing are excluded from the relational database schema.")

    add_heading_2(doc, "Step 1: First Normal Form (1NF)")
    p_inv_1nf = doc.add_paragraph()
    p_inv_1nf.add_run("Flatten repeating line items {PetName, ProcedureName, Amount}. Every attribute contains atomic values.")

    add_callout(doc, "1NF Invoice Schema & Functional Dependencies:",
                "INVOICE_1NF(InvoiceNo, InvoiceDate, CustomerName, Street, City, Province, PostalCode, PetName, ProcedureName, Amount)\n\n"
                "Primary Key: (InvoiceNo, PetName, ProcedureName)\n\n"
                "Functional Dependencies (FDs):\n"
                "  FD1: InvoiceNo → InvoiceDate, CustomerName, Street, City, Province, PostalCode (Partial Dependency)\n"
                "  FD2: (InvoiceNo, PetName, ProcedureName) → Amount                             (Full Dependency)")

    add_heading_2(doc, "Step 2: Second Normal Form (2NF)")
    p_inv_2nf = doc.add_paragraph()
    p_inv_2nf.add_run("Eliminate partial dependency FD1 by separating general invoice header information from individual treatment line items:")

    add_callout(doc, "2NF Decomposed Relations:",
                "1. INVOICE(InvoiceNo, InvoiceDate, CustomerName, Street, City, Province, PostalCode)\n"
                "   Primary Key: InvoiceNo\n\n"
                "2. INVOICE_DETAIL(InvoiceNo, PetName, ProcedureName, Amount)\n"
                "   Primary Key: (InvoiceNo, PetName, ProcedureName)\n"
                "   Foreign Key: InvoiceNo references INVOICE(InvoiceNo)")

    add_heading_2(doc, "Step 3: Third Normal Form (3NF)")
    p_inv_3nf = doc.add_paragraph()
    p_inv_3nf.add_run("In the INVOICE relation, we detect a transitive dependency:\n"
                      "  InvoiceNo → CustomerName → (Street, City, Province, PostalCode)\n"
                      "Furthermore, customer names are not guaranteed to be globally unique. Assigning a surrogate primary key CustomerID eliminates redundancy when a customer receives multiple invoices over time.")

    add_callout(doc, "3NF Final Relational Schema for Problem 2:",
                "1. CUSTOMER(CustomerID, CustomerName, Street, City, Province, PostalCode)\n"
                "   Primary Key: CustomerID\n\n"
                "2. INVOICE(InvoiceNo, InvoiceDate, CustomerID)\n"
                "   Primary Key: InvoiceNo\n"
                "   Foreign Key: CustomerID references CUSTOMER(CustomerID)\n\n"
                "3. INVOICE_DETAIL(InvoiceNo, PetID, ProcedureNo, Amount)\n"
                "   Primary Key: (InvoiceNo, PetID, ProcedureNo)\n"
                "   Foreign Keys:\n"
                "     - InvoiceNo references INVOICE(InvoiceNo)\n"
                "     - PetID references PET(PetID)\n"
                "     - ProcedureNo references PROCEDURE(ProcedureNo)")

    add_heading_1(doc, "3. Normalization Summary & Verification")
    tbl_norm_sum = doc.add_table(rows=5, cols=4)
    style_standard_table(
        tbl_norm_sum,
        [Inches(1.5), Inches(1.8), Inches(2.2), Inches(1.2)],
        ["Relation", "Primary Key (PK)", "Foreign Keys (FK)", "Normal Form"],
        [
            ["CUSTOMER", "CustomerID", "None", "3NF / BCNF"],
            ["INVOICE", "InvoiceNo", "CustomerID → CUSTOMER", "3NF / BCNF"],
            ["PET", "PetID", "OwnerID → OWNER", "3NF / BCNF"],
            ["INVOICE_DETAIL", "(InvoiceNo, PetID, ProcNo)", "InvoiceNo, PetID, ProcNo", "3NF / BCNF"]
        ]
    )

    doc.save(output_path)
    print(f"Lab 2 successfully generated at: {output_path}")

# ==========================================
# LAB 3 GENERATION
# ==========================================
def generate_lab3(output_path="output/Lab3.docx"):
    doc = docx.Document()
    for sec in doc.sections:
        sec.top_margin = Inches(1.0)
        sec.bottom_margin = Inches(1.0)
        sec.left_margin = Inches(1.0)
        sec.right_margin = Inches(1.0)

    add_header_block(doc, "LAB 3: CONCEPTUAL MODELING (ERD) & RELATIONAL MODEL MAPPING", "Business Analysis, Entity-Relationship Diagram & Logical Relational Schema")

    add_heading_1(doc, "1. Business Requirements Analysis")
    p_req = doc.add_paragraph()
    p_req.add_run("Based on the university management system specifications, the following structural entities, attributes, and relationships are identified:")

    add_callout(doc, "Entity and Attribute Inventory:",
                "1. DEPARTMENT: dept_code (PK), dept_name, office_number, office_phone, manage_start_date.\n"
                "2. INSTRUCTOR: instructor_id (PK), name, birthdate, startdate, sex.\n"
                "   • Multivalued Attribute: Qualifications (specialized_training, institute, grad_year).\n"
                "3. SUBJECT: subject_code (PK), name, total_credit, credits_theory, practice_credits.\n"
                "   • Recursive Relationship: Prerequisite subjects.\n"
                "4. CLASS: class_code (PK), coursework_program.\n"
                "5. STUDENT: student_number (PK), ssn (Candidate Key / Unique), name, birth_date, sex,\n"
                "            current_address, current_phone, permanent_address, permanent_phone.\n"
                "6. SECTION (Weak Entity): Dependent on CLASS. Discriminator: section_number, semester, training_year.\n"
                "7. GRADE_REPORT (Associative Relationship): Connects STUDENT and SECTION. Contains theory and practice grades.")

    add_heading_2(doc, "Cardinalities and Business Constraints:")
    p_card = doc.add_paragraph()
    p_card.add_run("• Department – Instructor (Management): 1:1. Exactly one instructor manages a department.\n"
                   "• Department – Instructor (Employment): 1:N. A department employs multiple instructors.\n"
                   "• Department – Subject: 1:N. A department offers multiple subjects.\n"
                   "• Instructor – Subject: M:N. An instructor teaches multiple subjects across departments; a subject can be taught by multiple instructors.\n"
                   "• Subject – Subject: M:N recursive prerequisite relationship.\n"
                   "• Department – Class: 1:N. A department manages multiple academic classes.\n"
                   "• Instructor – Class (Supervisor): 1:N. Each class has one academic supervisor from its managing department.\n"
                   "• Class – Student: 1:N. Each student belongs to exactly one class.\n"
                   "• Class – Section: 1:N identifying relationship. Section is a weak entity.\n"
                   "• Section – Subject: N:1. Each section is dedicated to one subject.\n"
                   "• Section – Instructor: N:1. Each section is taught by an assigned instructor.\n"
                   "• Student – Section (Grade Report): M:N associative evaluation.")

    add_heading_1(doc, "2. Entity-Relationship Diagram (ERD)")
    p_erd_note = doc.add_paragraph()
    p_erd_note.add_run("The complete conceptual ERD illustrating all entities, weak entities, relationships, attributes, and cardinalities is embedded below:")

    erd_image_path = "output/erd_diagram.png"
    if os.path.exists(erd_image_path):
        p_img = doc.add_paragraph()
        p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p_img.paragraph_format.space_before = Pt(6)
        p_img.paragraph_format.space_after = Pt(6)
        doc.add_picture(erd_image_path, width=Inches(6.6))
        p_cap = doc.add_paragraph()
        p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p_cap.paragraph_format.space_after = Pt(10)
        run_cap = p_cap.add_run("Figure 3.1: Complete Entity-Relationship Diagram for University Management")
        run_cap.font.name = "Calibri"
        run_cap.font.size = Pt(9.5)
        run_cap.font.italic = True
        run_cap.font.color.rgb = COLOR_MUTED

    add_heading_1(doc, "3. Systematic ERD-to-Relational Mapping (7 Rules)")
    p_rules = doc.add_paragraph()
    p_rules.add_run("Applying the formal 7-step mapping transformation rules from Chapter 4 of the DBI202 curriculum:\n\n"
                    "1. Strong Entities Mapping: DEPARTMENT, INSTRUCTOR, SUBJECT, CLASS, STUDENT mapped into independent tables with primary keys.\n"
                    "2. Weak Entity Mapping: SECTION is identified by CLASS. Its primary key is the composite key (class_code, training_year, semester, section_number).\n"
                    "3. 1:1 Relationship Mapping: Department manager relationship mapped by placing manager_instructor_id and manage_start_date into DEPARTMENT.\n"
                    "4. 1:N Relationship Mapping: Foreign keys placed on the 'Many' (N) side tables:\n"
                    "   • INSTRUCTOR receives dept_code.\n"
                    "   • SUBJECT receives dept_code.\n"
                    "   • CLASS receives dept_code and supervisor_instructor_id.\n"
                    "   • STUDENT receives class_code.\n"
                    "   • SECTION receives subject_code and instructor_id.\n"
                    "5. M:N Relationship Mapping: Junction tables created with composite primary keys:\n"
                    "   • TEACH (Instructor – Subject): PK (instructor_id, subject_code), start_teaching_date, stop_teaching_date.\n"
                    "   • PREREQUISITE_SUBJECT: PK (subject_code, prereq_subject_code).\n"
                    "   • GRADE_REPORT: PK (student_number, class_code, training_year, semester, section_number).\n"
                    "6. Multivalued Attribute Mapping: INSTRUCTOR_QUALIFICATION table created with PK (instructor_id, specialized_training, institute), grad_year.\n"
                    "7. Derived Attributes Exclusion: TotalScore and Pass/Fail status are dynamically derived from theory and practice grades and omitted.")

    add_heading_1(doc, "4. Final Relational Model Schema")
    p_schema_desc = doc.add_paragraph()
    p_schema_desc.add_run("The complete relational database schema with Primary Keys (Bold & Underlined) and Foreign Keys is presented below:")

    add_callout(doc, "Relational Model Specification:",
                "1. DEPARTMENT(\n"
                "     dept_code (PK), dept_name, office_number, office_phone,\n"
                "     manager_instructor_id (FK → INSTRUCTOR),\n"
                "     manage_start_date\n"
                "   )\n\n"
                "2. INSTRUCTOR(\n"
                "     instructor_id (PK), name, birthdate, startdate, sex,\n"
                "     dept_code (FK → DEPARTMENT)\n"
                "   )\n\n"
                "3. INSTRUCTOR_QUALIFICATION(\n"
                "     instructor_id (PK, FK → INSTRUCTOR),\n"
                "     specialized_training (PK),\n"
                "     institute (PK),\n"
                "     grad_year\n"
                "   )\n\n"
                "4. SUBJECT(\n"
                "     subject_code (PK), name, total_credit, credits_theory, practice_credits,\n"
                "     dept_code (FK → DEPARTMENT)\n"
                "   )\n\n"
                "5. PREREQUISITE_SUBJECT(\n"
                "     subject_code (PK, FK → SUBJECT),\n"
                "     prereq_subject_code (PK, FK → SUBJECT)\n"
                "   )\n\n"
                "6. INSTRUCTOR_SUBJECT [TEACH](\n"
                "     instructor_id (PK, FK → INSTRUCTOR),\n"
                "     subject_code (PK, FK → SUBJECT),\n"
                "     start_teaching_date,\n"
                "     stop_teaching_date\n"
                "   )\n\n"
                "7. CLASS(\n"
                "     class_code (PK), coursework_program,\n"
                "     dept_code (FK → DEPARTMENT),\n"
                "     supervisor_instructor_id (FK → INSTRUCTOR)\n"
                "   )\n\n"
                "8. STUDENT(\n"
                "     student_number (PK), ssn (Unique),\n"
                "     name, birth_date, sex,\n"
                "     current_address, current_phone,\n"
                "     permanent_address, permanent_phone,\n"
                "     class_code (FK → CLASS)\n"
                "   )\n\n"
                "9. SECTION [Weak Entity](\n"
                "     class_code (PK, FK → CLASS),\n"
                "     training_year (PK),\n"
                "     semester (PK),\n"
                "     section_number (PK),\n"
                "     subject_code (FK → SUBJECT),\n"
                "     instructor_id (FK → INSTRUCTOR)\n"
                "   )\n\n"
                "10. GRADE_REPORT(\n"
                "      student_number (PK, FK → STUDENT),\n"
                "      class_code (PK, FK → SECTION),\n"
                "      training_year (PK, FK → SECTION),\n"
                "      semester (PK, FK → SECTION),\n"
                "      section_number (PK, FK → SECTION),\n"
                "      grade_theory, grade_practice, retake_grade_theory\n"
                "    )")

    add_heading_2(doc, "Business Integrity Constraints & Referential Actions:")
    p_biz = doc.add_paragraph()
    p_biz.add_run("1. Unique Key Constraint: STUDENT(ssn) is guaranteed UNIQUE across all students.\n"
                  "2. Supervisor Department Alignment: CLASS.supervisor_instructor_id must reference an INSTRUCTOR belonging to CLASS.dept_code.\n"
                  "3. Grade Range & Evaluation Rule: grade_theory and grade_practice must be in range [0.0, 10.0]. TotalScore = 0.5 × grade_theory + 0.5 × grade_practice. Pass condition: grade_theory > 4.0 AND TotalScore > 5.0.\n"
                  "4. Referential Integrity Actions: Deleting a Department or Class cascades deletion to weak entity Sections and student enrollments (ON DELETE CASCADE), whereas instructor deletion is restricted (ON DELETE NO ACTION / SET NULL) to preserve historical teaching logs.")

    doc.save(output_path)
    print(f"Lab 3 successfully generated at: {output_path}")

if __name__ == "__main__":
    os.makedirs("output", exist_ok=True)
    generate_lab1("output/Lab1.docx")
    generate_lab2("output/Lab2.docx")
    generate_lab3("output/Lab3.docx")
    print("ALL THREE LAB FILES SUCCESSFULLY BUILT IN output/ DIRECTORY!")
