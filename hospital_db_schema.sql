-- =============================================
-- HOSPITAL MANAGEMENT SYSTEM - DATABASE SCHEMA
-- Created by: Ashish Kr Chaubey
-- =============================================

-- PATIENTS TABLE: Stores patient information
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR2(50) NOT NULL,
    Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female')),
    Age INT CHECK (Age > 0),
    Phone VARCHAR2(15),
    Address VARCHAR2(100)
);

-- DOCTORS TABLE: Stores doctor information
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR2(50) NOT NULL,
    Specialization VARCHAR2(50),
    Phone VARCHAR2(15)
);

-- APPOINTMENTS TABLE: Manages patient-doctor appointments
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Disease VARCHAR2(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- BILLING TABLE: Handles payment records
CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    PatientID INT,
    TotalAmount NUMBER(10,2) CHECK (TotalAmount > 0),
    PaymentDate DATE,
    PaymentMethod VARCHAR2(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- =============================================
-- SAMPLE DATA INSERTION
-- =============================================

-- Insert Sample Patients
INSERT INTO Patients VALUES (1, 'Ravi Kumar', 'Male', 35, '9876543210', 'Lucknow');
INSERT INTO Patients VALUES (2, 'Priya Sharma', 'Female', 28, '9876501234', 'Delhi');
INSERT INTO Patients VALUES (3, 'Amit Verma', 'Male', 42, '9102837465', 'Mumbai');
INSERT INTO Patients VALUES (4, 'Sneha Singh', 'Female', 25, '9112233445', 'Bangalore');
INSERT INTO Patients VALUES (5, 'Rajesh Patel', 'Male', 50, '9887766554', 'Chennai');

-- Insert Sample Doctors
INSERT INTO Doctors VALUES (101, 'Dr. Mehta', 'Cardiologist', '8800223344');
INSERT INTO Doctors VALUES (102, 'Dr. Gupta', 'Dermatologist', '8800556677');
INSERT INTO Doctors VALUES (103, 'Dr. Singh', 'Neurologist', '8800778899');
INSERT INTO Doctors VALUES (104, 'Dr. Reddy', 'Orthopedic', '8800998877');
INSERT INTO Doctors VALUES (105, 'Dr. Kapoor', 'Pediatrician', '8800112233');

-- Insert Sample Appointments
INSERT INTO Appointments VALUES (1001, 1, 101, TO_DATE('2025-01-10','YYYY-MM-DD'), 'Chest Pain');
INSERT INTO Appointments VALUES (1002, 2, 102, TO_DATE('2025-01-12','YYYY-MM-DD'), 'Skin Allergy');
INSERT INTO Appointments VALUES (1003, 3, 103, TO_DATE('2025-01-15','YYYY-MM-DD'), 'Migraine');
INSERT INTO Appointments VALUES (1004, 4, 104, TO_DATE('2025-01-18','YYYY-MM-DD'), 'Knee Pain');
INSERT INTO Appointments VALUES (1005, 5, 105, TO_DATE('2025-01-20','YYYY-MM-DD'), 'Child Fever');

-- Insert Sample Billing Records
INSERT INTO Billing VALUES (2001, 1, 5000.00, TO_DATE('2025-01-11','YYYY-MM-DD'), 'Credit Card');
INSERT INTO Billing VALUES (2002, 2, 3000.00, TO_DATE('2025-01-13','YYYY-MM-DD'), 'Cash');
INSERT INTO Billing VALUES (2003, 3, 7000.00, TO_DATE('2025-01-16','YYYY-MM-DD'), 'UPI');
INSERT INTO Billing VALUES (2004, 4, 4500.00, TO_DATE('2025-01-19','YYYY-MM-DD'), 'Debit Card');
INSERT INTO Billing VALUES (2005, 5, 2500.00, TO_DATE('2025-01-21','YYYY-MM-DD'), 'Cash');

COMMIT;