-- =============================================
-- ADVANCED SQL QUERIES FOR REPORTING
-- =============================================

-- QUERY 1: Complete Patient-Doctor Appointment Details
SELECT 
    p.PatientName,
    p.Age,
    p.Gender,
    d.DoctorName,
    d.Specialization,
    a.Disease,
    a.AppointmentDate
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate DESC;

-- QUERY 2: Doctor Workload Analysis
SELECT 
    d.DoctorName,
    d.Specialization,
    COUNT(a.AppointmentID) AS TotalPatients,
    TO_CHAR(MIN(a.AppointmentDate), 'DD-MON-YYYY') AS FirstAppointment,
    TO_CHAR(MAX(a.AppointmentDate), 'DD-MON-YYYY') AS LatestAppointment
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorName, d.Specialization
ORDER BY TotalPatients DESC;

-- QUERY 3: Complete Billing Information
SELECT 
    p.PatientName,
    p.Phone,
    b.BillID,
    b.TotalAmount,
    b.PaymentMethod,
    TO_CHAR(b.PaymentDate, 'DD-MON-YYYY') AS PaymentDate,
    CASE 
        WHEN b.TotalAmount > 5000 THEN 'High Value'
        WHEN b.TotalAmount > 3000 THEN 'Medium Value'
        ELSE 'Standard Value'
    END AS BillCategory
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID
ORDER BY b.TotalAmount DESC;

-- QUERY 4: High-Value Patients Analysis
SELECT 
    p.PatientName,
    p.Age,
    p.Gender,
    SUM(b.TotalAmount) AS TotalSpent,
    COUNT(b.BillID) AS TotalBills,
    ROUND(AVG(b.TotalAmount), 2) AS AverageBillAmount
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
GROUP BY p.PatientID, p.PatientName, p.Age, p.Gender
HAVING SUM(b.TotalAmount) > 5000
ORDER BY TotalSpent DESC;

-- QUERY 5: Monthly Revenue Report
SELECT 
    TO_CHAR(PaymentDate, 'MON-YYYY') AS MonthYear,
    COUNT(BillID) AS TotalBills,
    SUM(TotalAmount) AS TotalRevenue,
    ROUND(AVG(TotalAmount), 2) AS AverageBillValue,
    PaymentMethod,
    COUNT(*) AS PaymentCount
FROM Billing
GROUP BY TO_CHAR(PaymentDate, 'MON-YYYY'), PaymentMethod
ORDER BY TotalRevenue DESC;

-- QUERY 6: Patient Visit Frequency
SELECT 
    p.PatientName,
    COUNT(a.AppointmentID) AS TotalVisits,
    TO_CHAR(MIN(a.AppointmentDate), 'DD-MON-YYYY') AS FirstVisit,
    TO_CHAR(MAX(a.AppointmentDate), 'DD-MON-YYYY') AS LastVisit
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PatientName
ORDER BY TotalVisits DESC;

-- QUERY 7: Specialization-wise Analysis
SELECT 
    d.Specialization,
    COUNT(DISTINCT a.PatientID) AS UniquePatients,
    COUNT(a.AppointmentID) AS TotalAppointments,
    ROUND(AVG(b.TotalAmount), 2) AS AverageFee
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN Billing b ON a.PatientID = b.PatientID
GROUP BY d.Specialization
ORDER BY TotalAppointments DESC;