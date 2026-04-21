# 🏥 Hospital Management System — Oracle SQL & PL/SQL

![Oracle](https://img.shields.io/badge/Oracle_SQL-Database-F80000?style=flat-square&logo=oracle)
![PLSQL](https://img.shields.io/badge/PL/SQL-Stored_Procedures-red?style=flat-square)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)

> A fully normalized relational database system built with Oracle SQL and PL/SQL to manage patients, doctors, appointments, and billing in a hospital environment.

---

## 📌 What This Project Does

Simulates a hospital's backend database operations — from patient registration and doctor appointment scheduling to automated billing and role-based data access — using pure SQL and PL/SQL.

---

## ✨ Features

- 🗃️ Fully normalized tables with relationships and constraints
- ⚙️ Automated billing via **Stored Procedures** and **Triggers**
- 📊 **Views** for daily appointment and billing reports
- 🚀 Query optimization using indexing, joins, and execution plan analysis
- 🔒 **GRANT / REVOKE** for role-based access control
- 💾 **COMMIT / ROLLBACK** for transaction consistency

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Oracle SQL | Database design & queries |
| PL/SQL | Stored procedures, triggers, functions |
| SQL Developer | Query execution & plan analysis |

---

## 📂 Files

| File | Description |
|------|-------------|
| `hospital_db_schema.sql` | Table creation, constraints, relationships |
| `hospital_queries.sql` | Reports, joins, analytical queries |
| `hospital_views_triggers.sql` | Views, triggers, stored procedures |
| `project_report.txt` | Project summary and documentation |

---

## 🧠 Key Concepts Implemented

- **Normalization** — 1NF, 2NF, 3NF applied across all tables
- **Triggers** — Auto-generate bills on appointment completion
- **Stored Procedures** — Reusable billing and report logic
- **Indexing** — On frequently queried columns (patient ID, date, doctor ID)
- **Execution Plans** — Analyzed and optimized slow queries
- **Transaction Control** — COMMIT/ROLLBACK for data integrity

---

## 🗄️ Schema Overview

```
Patients ──┐
           ├──► Appointments ──► Billing
Doctors  ──┘
```

| Table | Key Columns |
|-------|-------------|
| Patients | patient_id, name, age, contact |
| Doctors | doctor_id, name, specialization |
| Appointments | appt_id, patient_id, doctor_id, date |
| Billing | bill_id, appt_id, amount, status |

---

## 📄 License

MIT License — open source and free to use.

---

<p align="center">Built by <a href="https://github.com/AshishChaubey2003">Ashish Kumar Chaubey</a> — B.Tech CSE 2025 | Lucknow, India</p>
<p align="center">
  <a href="https://www.linkedin.com/in/ashishchaubey2dec/">LinkedIn</a> •
  <a href="mailto:sashishchaubey1234@gmail.com">Email</a>
</p>
