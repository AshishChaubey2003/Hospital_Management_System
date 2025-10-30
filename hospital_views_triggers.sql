-- Create a View for Daily Appointments
CREATE OR REPLACE VIEW Daily_Appointments AS
SELECT p.PatientName, d.DoctorName, a.Disease, a.AppointmentDate
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

-- Create a Stored Procedure to Add New Bill
CREATE OR REPLACE PROCEDURE Add_Bill(
  p_PatientID IN INT,
  p_Amount IN NUMBER,
  p_Method IN VARCHAR2
)
AS
BEGIN
  INSERT INTO Billing (BillID, PatientID, TotalAmount, PaymentDate, PaymentMethod)
  VALUES ((SELECT NVL(MAX(BillID),2000)+1 FROM Billing), p_PatientID, p_Amount, SYSDATE, p_Method);
END;
/

-- Create a Trigger to Auto-Generate Bill After Appointment
CREATE OR REPLACE TRIGGER bill_trigger
AFTER INSERT ON Appointments
FOR EACH ROW
BEGIN
  INSERT INTO Billing (BillID, PatientID, TotalAmount, PaymentDate, PaymentMethod)
  VALUES ((SELECT NVL(MAX(BillID),2000)+1 FROM Billing), :NEW.PatientID, 500.00, SYSDATE, 'Pending');
END;
/
