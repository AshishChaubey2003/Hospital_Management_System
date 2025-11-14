-- =============================================
-- UTILITY QUERIES FOR DATA MANAGEMENT
-- =============================================

-- Check all tables data
SELECT 'Patients' AS Table_Name, COUNT(*) AS Record_Count FROM Patients
UNION ALL
SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL
SELECT 'Appointments', COUNT(*) FROM Appointments
UNION ALL
SELECT 'Billing', COUNT(*) FROM Billing;

-- View all constraints
SELECT table_name, constraint_name, constraint_type 
FROM user_constraints 
WHERE table_name IN ('PATIENTS', 'DOCTORS', 'APPOINTMENTS', 'BILLING');

-- Test the stored procedure
BEGIN
    Add_Bill(1, 3500.00, 'Credit Card');
END;
/

-- View daily appointments
SELECT * FROM Daily_Appointments;

-- View doctor performance
SELECT * FROM Doctor_Performance;

-- Cleanup script (if needed)
/*
DROP TRIGGER auto_bill_after_appointment;
DROP TRIGGER prevent_duplicate_appointments;
DROP PROCEDURE Add_Bill;
DROP VIEW Daily_Appointments;
DROP VIEW Doctor_Performance;
DROP TABLE Billing;
DROP TABLE Appointments;
DROP TABLE Doctors;
DROP TABLE Patients;
*/