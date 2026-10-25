-- =====================================================================================
-- HỌ VÀ TÊN: Huỳnh Hoàng Siêu
-- MSSV: QE210005
-- LỚP: SE20D
-- MÔN HỌC: DBI202 - DATABASE SYSTEMS
-- BÀI TẬP: LAB 4 - SQL QUERIES (FUH_COMPANY / CompanyDB)
-- =====================================================================================

USE CompanyDB;
-- (Nếu bạn restore database với tên khác như FUH_COMPANY, vui lòng đổi tên ở dòng USE trên)
GO

-- -------------------------------------------------------------------------------------
-- Câu 1: Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển.
-- Thông tin yêu cầu: mã số, họ tên nhân viên, mã số phòng ban, tên phòng ban
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Họ tên nhân viên],
    d.depNum AS [Mã số phòng ban],
    d.depName AS [Tên phòng ban]
FROM tblDepartment d
INNER JOIN tblEmployee e ON d.mgrSSN = e.empSSN
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
GO

-- -------------------------------------------------------------------------------------
-- Câu 2: Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào.
-- Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã số dự án],
    p.proName AS [Tên dự án],
    d.depName AS [Tên phòng ban quản lý]
FROM tblProject p
INNER JOIN tblDepartment d ON p.depNum = d.depNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
GO

-- -------------------------------------------------------------------------------------
-- Câu 3: Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào.
-- Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã số dự án],
    p.proName AS [Tên dự án],
    d.depName AS [Tên phòng ban quản lý]
FROM tblProject p
INNER JOIN tblDepartment d ON p.depNum = d.depNum
WHERE p.proName = 'ProjectB';
GO

-- -------------------------------------------------------------------------------------
-- Câu 4: Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An.
-- Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Họ tên nhân viên]
FROM tblEmployee e
INNER JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
WHERE s.empName = N'Mai Duy An';
GO

-- -------------------------------------------------------------------------------------
-- Câu 5: Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An.
-- Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát.
-- -------------------------------------------------------------------------------------
SELECT 
    s.empSSN AS [Mã số nhân viên giám sát],
    s.empName AS [Họ tên nhân viên giám sát]
FROM tblEmployee e
INNER JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
WHERE e.empName = N'Mai Duy An';
GO

-- -------------------------------------------------------------------------------------
-- Câu 6: Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu.
-- Thông tin yêu cầu: mã số, tên vị trí làm việc.
-- -------------------------------------------------------------------------------------
SELECT 
    l.locNum AS [Mã vị trí làm việc],
    l.locName AS [Tên vị trí làm việc]
FROM tblProject p
INNER JOIN tblLocation l ON p.locNum = l.locNum
WHERE p.proName = 'ProjectA';
GO

-- -------------------------------------------------------------------------------------
-- Câu 7: Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào.
-- Thông tin yêu cầu: mã số, tên dự án
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã số dự án],
    p.proName AS [Tên dự án]
FROM tblProject p
INNER JOIN tblLocation l ON p.locNum = l.locNum
WHERE l.locName LIKE N'%HCM%' OR l.locName LIKE N'%Hồ Chí Minh%';
GO

-- -------------------------------------------------------------------------------------
-- Câu 8: Cho biết những người phụ thuộc trên 18 tuổi.
-- Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.
-- -------------------------------------------------------------------------------------
SELECT 
    d.depName AS [Tên người phụ thuộc],
    d.depBirthdate AS [Ngày sinh người phụ thuộc],
    e.empName AS [Tên nhân viên phụ thuộc vào]
FROM tblDependent d
INNER JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE DATEADD(YEAR, 18, d.depBirthdate) < GETDATE();
GO

-- -------------------------------------------------------------------------------------
-- Câu 9: Cho biết những người phụ thuộc là nam giới.
-- Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào
-- -------------------------------------------------------------------------------------
SELECT 
    d.depName AS [Tên người phụ thuộc],
    d.depBirthdate AS [Ngày sinh người phụ thuộc],
    e.empName AS [Tên nhân viên phụ thuộc vào]
FROM tblDependent d
INNER JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE d.depSex = 'M';
GO

-- -------------------------------------------------------------------------------------
-- Câu 10: Cho biết những nơi làm việc của phòng ban có tên: Phòng Nghiên cứu và phát triển.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
-- -------------------------------------------------------------------------------------
SELECT 
    d.depNum AS [Mã phòng ban],
    d.depName AS [Tên phòng ban],
    l.locName AS [Tên nơi làm việc]
FROM tblDepartment d
INNER JOIN tblDepLocation dl ON d.depNum = dl.depNum
INNER JOIN tblLocation l ON dl.locNum = l.locNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
GO

-- -------------------------------------------------------------------------------------
-- Câu 11: Cho biết các dự án làm việc tại Tp. HCM.
-- Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    d.depName AS [Tên phòng ban chịu trách nhiệm]
FROM tblProject p
INNER JOIN tblLocation l ON p.locNum = l.locNum
INNER JOIN tblDepartment d ON p.depNum = d.depNum
WHERE l.locName LIKE N'%HCM%' OR l.locName LIKE N'%Hồ Chí Minh%';
GO

-- -------------------------------------------------------------------------------------
-- Câu 12: Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
-- Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ
-- -------------------------------------------------------------------------------------
SELECT 
    e.empName AS [Tên nhân viên],
    d.depName AS [Tên người phụ thuộc],
    d.depRelationship AS [Mối liên hệ]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblDependent d ON e.empSSN = d.empSSN
WHERE dep.depName = N'Phòng Nghiên cứu và phát triển'
  AND d.depSex = 'F';
GO

-- -------------------------------------------------------------------------------------
-- Câu 13: Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
-- Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ
-- -------------------------------------------------------------------------------------
SELECT 
    e.empName AS [Tên nhân viên],
    d.depName AS [Tên người phụ thuộc],
    d.depRelationship AS [Mối liên hệ]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblDependent d ON e.empSSN = d.empSSN
WHERE dep.depName = N'Phòng Nghiên cứu và phát triển'
  AND DATEADD(YEAR, 18, d.depBirthdate) < GETDATE();
GO

-- -------------------------------------------------------------------------------------
-- Câu 14: Cho biết số lượng người phụ thuộc theo giới tính.
-- Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT 
    d.depSex AS [Giới tính],
    COUNT(*) AS [Số lượng người phụ thuộc]
FROM tblDependent d
GROUP BY d.depSex;
GO

-- -------------------------------------------------------------------------------------
-- Câu 15: Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên.
-- Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT 
    d.depRelationship AS [Mối liên hệ],
    COUNT(*) AS [Số lượng người phụ thuộc]
FROM tblDependent d
GROUP BY d.depRelationship;
GO

-- -------------------------------------------------------------------------------------
-- Câu 16: Cho biết số lượng người phụ thuộc theo mỗi phòng ban.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(d.depName) AS [Số lượng người phụ thuộc]
FROM tblDepartment dep
LEFT JOIN tblEmployee e ON dep.depNum = e.depNum
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY dep.depNum, dep.depName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 17: Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(d.depName) AS [Số lượng người phụ thuộc]
FROM tblDepartment dep
LEFT JOIN tblEmployee e ON dep.depNum = e.depNum
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY dep.depNum, dep.depName
ORDER BY [Số lượng người phụ thuộc] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 18: Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(d.depName) AS [Số lượng người phụ thuộc]
FROM tblDepartment dep
LEFT JOIN tblEmployee e ON dep.depNum = e.depNum
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY dep.depNum, dep.depName
ORDER BY [Số lượng người phụ thuộc] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 19: Cho biết tổng số giờ tham gia dự án của mỗi nhân viên.
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    dep.depName AS [Tên phòng ban],
    SUM(w.workHours) AS [Tổng số giờ làm]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, dep.depName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 20: Cho biết tổng số giờ làm dự án của mỗi phòng ban.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, tổng số giờ
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    SUM(w.workHours) AS [Tổng số giờ]
FROM tblDepartment dep
INNER JOIN tblEmployee e ON dep.depNum = e.depNum
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY dep.depNum, dep.depName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 21: Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất.
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    SUM(w.workHours) AS [Tổng số giờ tham gia dự án]
FROM tblEmployee e
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY [Tổng số giờ tham gia dự án] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 22: Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất.
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    SUM(w.workHours) AS [Tổng số giờ tham gia dự án]
FROM tblEmployee e
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY [Tổng số giờ tham gia dự án] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 23: Cho biết những nhân viên nào lần đầu tiên tham gia dụ án (tham gia đúng 1 dự án).
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    dep.depName AS [Tên phòng ban]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, dep.depName
HAVING COUNT(w.proNum) = 1;
GO

-- -------------------------------------------------------------------------------------
-- Câu 24: Cho biết những nhân viên nào lần thứ hai tham gia dụ án (tham gia đúng 2 dự án).
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    dep.depName AS [Tên phòng ban]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, dep.depName
HAVING COUNT(w.proNum) = 2;
GO

-- -------------------------------------------------------------------------------------
-- Câu 25: Cho biết những nhân viên nào tham gia tối thiểu hai dụ án (từ 2 dự án trở lên).
-- Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Tên nhân viên],
    dep.depName AS [Tên phòng ban]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, dep.depName
HAVING COUNT(w.proNum) >= 2;
GO

-- -------------------------------------------------------------------------------------
-- Câu 26: Cho biết số lượng thành viên của mỗi dự án.
-- Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    COUNT(w.empSSN) AS [Số lượng thành viên]
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 27: Cho biết tổng số giờ làm của mỗi dự án.
-- Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    ISNULL(SUM(w.workHours), 0) AS [Tổng số giờ làm]
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 28: Cho biết dự án nào có số lượng thành viên là ít nhất.
-- Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    COUNT(w.empSSN) AS [Số lượng thành viên]
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName
ORDER BY [Số lượng thành viên] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 29: Cho biết dự án nào có số lượng thành viên là nhiều nhất.
-- Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    COUNT(w.empSSN) AS [Số lượng thành viên]
FROM tblProject p
INNER JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName
ORDER BY [Số lượng thành viên] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 30: Cho biết dự án nào có tổng số giờ làm là ít nhất.
-- Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    ISNULL(SUM(w.workHours), 0) AS [Tổng số giờ làm]
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName
ORDER BY [Tổng số giờ làm] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 31: Cho biết dự án nào có tổng số giờ làm là nhiều nhất.
-- Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    p.proNum AS [Mã dự án],
    p.proName AS [Tên dự án],
    SUM(w.workHours) AS [Tổng số giờ làm]
FROM tblProject p
INNER JOIN tblWorksOn w ON p.proNum = w.proNum
GROUP BY p.proNum, p.proName
ORDER BY [Tổng số giờ làm] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 32: Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc.
-- Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
-- -------------------------------------------------------------------------------------
SELECT 
    l.locName AS [Tên nơi làm việc],
    COUNT(dl.depNum) AS [Số lượng phòng ban]
FROM tblLocation l
LEFT JOIN tblDepLocation dl ON l.locNum = dl.locNum
GROUP BY l.locName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 33: Cho biết số lượng chỗ làm việc theo mỗi phòng ban.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
-- -------------------------------------------------------------------------------------
SELECT 
    d.depNum AS [Mã phòng ban],
    d.depName AS [Tên phòng ban],
    COUNT(dl.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment d
LEFT JOIN tblDepLocation dl ON d.depNum = dl.depNum
GROUP BY d.depNum, d.depName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 34: Cho biết phòng ban nào có nhiều chỗ làm việc nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    d.depNum AS [Mã phòng ban],
    d.depName AS [Tên phòng ban],
    COUNT(dl.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment d
INNER JOIN tblDepLocation dl ON d.depNum = dl.depNum
GROUP BY d.depNum, d.depName
ORDER BY [Số lượng chỗ làm việc] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 35: Cho biết phòng ban nào có it chỗ làm việc nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    d.depNum AS [Mã phòng ban],
    d.depName AS [Tên phòng ban],
    COUNT(dl.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment d
LEFT JOIN tblDepLocation dl ON d.depNum = dl.depNum
GROUP BY d.depNum, d.depName
ORDER BY [Số lượng chỗ làm việc] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 36: Cho biết địa điểm nào có nhiều phòng ban làm việc nhất.
-- Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    l.locName AS [Tên nơi làm việc],
    COUNT(dl.depNum) AS [Số lượng phòng ban]
FROM tblLocation l
INNER JOIN tblDepLocation dl ON l.locNum = dl.locNum
GROUP BY l.locName
ORDER BY [Số lượng phòng ban] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 37: Cho biết địa điểm nào có ít phòng ban làm việc nhất.
-- Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    l.locName AS [Tên nơi làm việc],
    COUNT(dl.depNum) AS [Số lượng phòng ban]
FROM tblLocation l
LEFT JOIN tblDepLocation dl ON l.locNum = dl.locNum
GROUP BY l.locName
ORDER BY [Số lượng phòng ban] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 38: Cho biết nhân viên nào có nhiều người phụ thuộc nhất.
-- Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Họ tên nhân viên],
    COUNT(d.depName) AS [Số lượng người phụ thuộc]
FROM tblEmployee e
INNER JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY [Số lượng người phụ thuộc] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 39: Cho biết nhân viên nào có ít người phụ thuộc nhất (trong số những người có NPT >= 1).
-- Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Họ tên nhân viên],
    COUNT(d.depName) AS [Số lượng người phụ thuộc]
FROM tblEmployee e
INNER JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY [Số lượng người phụ thuộc] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 40: Cho biết nhân viên nào không có người phụ thuộc.
-- Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Họ tên nhân viên],
    dep.depName AS [Tên phòng ban]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE NOT EXISTS (
    SELECT 1 
    FROM tblDependent d 
    WHERE d.empSSN = e.empSSN
);
GO

-- -------------------------------------------------------------------------------------
-- Câu 41: Cho biết phòng ban nào không có người phụ thuộc.
-- Thông tin yêu cầu: mã số phòng ban, tên phòng ban
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã số phòng ban],
    dep.depName AS [Tên phòng ban]
FROM tblDepartment dep
WHERE NOT EXISTS (
    SELECT 1
    FROM tblEmployee e
    INNER JOIN tblDependent d ON e.empSSN = d.empSSN
    WHERE e.depNum = dep.depNum
);
GO

-- -------------------------------------------------------------------------------------
-- Câu 42: Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào.
-- Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã số nhân viên],
    e.empName AS [Tên nhân viên],
    dep.depName AS [Tên phòng ban]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE NOT EXISTS (
    SELECT 1 
    FROM tblWorksOn w 
    WHERE w.empSSN = e.empSSN
);
GO

-- -------------------------------------------------------------------------------------
-- Câu 43: Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án.
-- Thông tin yêu cầu: mã số phòng ban, tên phòng ban
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã số phòng ban],
    dep.depName AS [Tên phòng ban]
FROM tblDepartment dep
WHERE NOT EXISTS (
    SELECT 1
    FROM tblEmployee e
    INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
    WHERE e.depNum = dep.depNum
);
GO

-- -------------------------------------------------------------------------------------
-- Câu 44: Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA.
-- Thông tin yêu cầu: mã số phòng ban, tên phòng ban
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã số phòng ban],
    dep.depName AS [Tên phòng ban]
FROM tblDepartment dep
WHERE NOT EXISTS (
    SELECT 1
    FROM tblEmployee e
    INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
    INNER JOIN tblProject p ON w.proNum = p.proNum
    WHERE e.depNum = dep.depNum
      AND p.proName = 'ProjectA'
);
GO

-- -------------------------------------------------------------------------------------
-- Câu 45: Cho biết số lượng dự án được quản lý theo mỗi phòng ban.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(p.proNum) AS [Số lượng dự án]
FROM tblDepartment dep
LEFT JOIN tblProject p ON dep.depNum = p.depNum
GROUP BY dep.depNum, dep.depName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 46: Cho biết phòng ban nào quản lý it dự án nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(p.proNum) AS [Số lượng dự án]
FROM tblDepartment dep
LEFT JOIN tblProject p ON dep.depNum = p.depNum
GROUP BY dep.depNum, dep.depName
ORDER BY [Số lượng dự án] ASC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 47: Cho biết phòng ban nào quản lý nhiều dự án nhất.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
-- -------------------------------------------------------------------------------------
SELECT TOP 1 WITH TIES 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(p.proNum) AS [Số lượng dự án]
FROM tblDepartment dep
INNER JOIN tblProject p ON dep.depNum = p.depNum
GROUP BY dep.depNum, dep.depName
ORDER BY [Số lượng dự án] DESC;
GO

-- -------------------------------------------------------------------------------------
-- Câu 48: Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì.
-- Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý
-- -------------------------------------------------------------------------------------
SELECT 
    dep.depNum AS [Mã phòng ban],
    dep.depName AS [Tên phòng ban],
    COUNT(DISTINCT e.empSSN) AS [Số lượng nhân viên],
    p.proName AS [Tên dự án quản lý]
FROM tblDepartment dep
INNER JOIN tblEmployee e ON dep.depNum = e.depNum
INNER JOIN tblProject p ON dep.depNum = p.depNum
GROUP BY dep.depNum, dep.depName, p.proName
HAVING COUNT(DISTINCT e.empSSN) > 5;
GO

-- -------------------------------------------------------------------------------------
-- Câu 49: Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc.
-- Thông tin yêu cầu: mã nhân viên, họ tên nhân viên
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Họ tên nhân viên]
FROM tblEmployee e
INNER JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE dep.depName LIKE N'%Phòng Nghiên cứu%'
  AND NOT EXISTS (
      SELECT 1 
      FROM tblDependent d 
      WHERE d.empSSN = e.empSSN
  );
GO

-- -------------------------------------------------------------------------------------
-- Câu 50: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc.
-- Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Họ tên nhân viên],
    ISNULL(SUM(w.workHours), 0) AS [Tổng số giờ làm]
FROM tblEmployee e
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE NOT EXISTS (
    SELECT 1 
    FROM tblDependent d 
    WHERE d.empSSN = e.empSSN
)
GROUP BY e.empSSN, e.empName;
GO

-- -------------------------------------------------------------------------------------
-- Câu 51: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc.
-- Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Họ tên nhân viên],
    dc.numberOfDependents AS [Số lượng người phụ thuộc],
    wh.totalHours AS [Tổng số giờ làm]
FROM tblEmployee e
INNER JOIN (
    SELECT empSSN, COUNT(*) AS numberOfDependents
    FROM tblDependent
    GROUP BY empSSN
    HAVING COUNT(*) > 3
) dc ON e.empSSN = dc.empSSN
INNER JOIN (
    SELECT empSSN, SUM(workHours) AS totalHours
    FROM tblWorksOn
    GROUP BY empSSN
) wh ON e.empSSN = wh.empSSN;
GO

-- -------------------------------------------------------------------------------------
-- Câu 52: Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát của Mai Duy An.
-- Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm
-- -------------------------------------------------------------------------------------
SELECT 
    e.empSSN AS [Mã nhân viên],
    e.empName AS [Họ tên nhân viên],
    SUM(w.workHours) AS [Tổng số giờ làm]
FROM tblEmployee e
INNER JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE s.empName = N'Mai Duy An'
GROUP BY e.empSSN, e.empName;
GO
