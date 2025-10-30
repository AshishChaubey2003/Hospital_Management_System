-- View Patient, Doctor, and Appointment Details
SELECT p.PatientName, d.DoctorName, a.Disease, a.AppointmentDate
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

-- Count Total Patients per Doctor
SELECT d.DoctorName, COUNT(a.PatientID) AS TotalPatients
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorName;

-- Billing Information with Patient Names
SELECT p.PatientName, b.TotalAmount, b.PaymentMethod, b.PaymentDate
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID;

-- Patients Who Paid More Than 5000
SELECT p.PatientName, b.TotalAmount
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
WHERE b.TotalAmount > 5000;

-- Doctor-Wise Appointment Count
SELECT DoctorID, COUNT(AppointmentID) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID;
