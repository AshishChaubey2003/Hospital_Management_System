-- =============================================
-- AUTOMATION: VIEWS AND TRIGGERS
-- =============================================

-- VIEW 1: Daily Appointments Overview
CREATE OR REPLACE VIEW Daily_Appointments AS
SELECT 
    p.PatientName, 
    d.DoctorName, 
    d.Specialization,
    a.Disease, 
    a.AppointmentDate
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate;

-- VIEW 2: Doctor Performance Dashboard
CREATE OR REPLACE VIEW Doctor_Performance AS
SELECT 
    d.DoctorID,
    d.DoctorName,
    d.Specialization,
    COUNT(a.AppointmentID) AS TotalAppointments,
    AVG(b.TotalAmount) AS AverageBillAmount
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN Billing b ON a.PatientID = b.PatientID
GROUP BY d.DoctorID, d.DoctorName, d.Specialization;

-- STORED PROCEDURE: Add New Bill
CREATE OR REPLACE PROCEDURE Add_Bill(
    p_PatientID IN INT,
    p_Amount IN NUMBER,
    p_Method IN VARCHAR2
)
AS
    v_BillID INT;
BEGIN
    -- Generate new BillID
    SELECT NVL(MAX(BillID), 2000) + 1 INTO v_BillID FROM Billing;
    
    -- Insert new bill
    INSERT INTO Billing (BillID, PatientID, TotalAmount, PaymentDate, PaymentMethod)
    VALUES (v_BillID, p_PatientID, p_Amount, SYSDATE, p_Method);
    
    DBMS_OUTPUT.PUT_LINE('Bill created successfully. Bill ID: ' || v_BillID);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating bill: ' || SQLERRM);
        ROLLBACK;
END;
/

-- TRIGGER 1: Auto-Generate Bill After Appointment
CREATE OR REPLACE TRIGGER auto_bill_after_appointment
AFTER INSERT ON Appointments
FOR EACH ROW
DECLARE
    v_BillID INT;
BEGIN
    -- Generate new BillID
    SELECT NVL(MAX(BillID), 2000) + 1 INTO v_BillID FROM Billing;
    
    -- Auto-create bill with consultation fee
    INSERT INTO Billing (BillID, PatientID, TotalAmount, PaymentDate, PaymentMethod)
    VALUES (v_BillID, :NEW.PatientID, 500.00, SYSDATE, 'Pending');
    
    DBMS_OUTPUT.PUT_LINE('Auto-generated bill for appointment: ' || :NEW.AppointmentID);
END;
/

-- TRIGGER 2: Prevent Duplicate Appointments
CREATE OR REPLACE TRIGGER prevent_duplicate_appointments
BEFORE INSERT ON Appointments
FOR EACH ROW
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Appointments
    WHERE PatientID = :NEW.PatientID 
    AND DoctorID = :NEW.DoctorID 
    AND AppointmentDate = :NEW.AppointmentDate;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Patient already has an appointment with this doctor on the same date');
    END IF;
END;
/