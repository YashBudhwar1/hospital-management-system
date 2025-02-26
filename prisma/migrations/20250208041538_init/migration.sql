/*
  Warnings:

  - You are about to drop the column `insurance_id` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `insurance_name` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `insurance_provide` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `phone_number` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `first_name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `last_name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `password_hash` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `Patient` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `emergency_contact_name` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `emergency_contact_number` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `marital_status` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `medical_consent` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `privacy_consent` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `service_consent` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'NURSE', 'DOCTOR', 'LAB_TECHNICIAN', 'LABORATORY', 'PATIENT', 'CASHIER', 'PHARMACY');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACTIVE', 'INACTIVE', 'DORMANT');

-- CreateEnum
CREATE TYPE "JOBTYPE" AS ENUM ('FULL', 'PART');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "AppointmentStatus" AS ENUM ('PENDING', 'SCHEDULED', 'CANCELLED', 'COMPLETED');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CASH', 'CARD', 'ONLINE');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PAID', 'UNPAID');

-- CreateEnum
CREATE TYPE "LeaveType" AS ENUM ('SICK', 'VACATION', 'PERSONAL', 'OTHER');

-- CreateEnum
CREATE TYPE "LeaveStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "TestStatus" AS ENUM ('PENDING', 'CANCELLED', 'COMPLETED');

-- CreateEnum
CREATE TYPE "Department" AS ENUM ('GENERAL', 'LABORATORY');

-- CreateEnum
CREATE TYPE "PrescriptionStatus" AS ENUM ('PENDING', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "DrugCategory" AS ENUM ('ANTIBIOTICS', 'PAINKILLERS', 'ANTIVIRAL', 'CARDIOVASCULAR', 'RESPIRATORY', 'OTHER');

-- CreateEnum
CREATE TYPE "InvoiceStatus" AS ENUM ('PENDING', 'PAID', 'CANCELLED', 'RECEIVED');

-- CreateEnum
CREATE TYPE "StockUpdateType" AS ENUM ('RESTOCK', 'ISSUANCE');

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "insurance_id",
DROP COLUMN "insurance_name",
DROP COLUMN "insurance_provide",
DROP COLUMN "phone_number",
ADD COLUMN     "colorCode" TEXT,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "emergency_contact_name" TEXT NOT NULL,
ADD COLUMN     "emergency_contact_number" TEXT NOT NULL,
ADD COLUMN     "gender" "Gender" NOT NULL DEFAULT 'MALE',
ADD COLUMN     "img" TEXT,
ADD COLUMN     "insurance_number" TEXT,
ADD COLUMN     "insurance_provider" TEXT,
ADD COLUMN     "marital_status" TEXT NOT NULL,
ADD COLUMN     "medical_consent" BOOLEAN NOT NULL,
ADD COLUMN     "phone" TEXT NOT NULL,
ADD COLUMN     "physician_id" TEXT,
ADD COLUMN     "privacy_consent" BOOLEAN NOT NULL,
ADD COLUMN     "service_consent" BOOLEAN NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "first_name",
DROP COLUMN "last_name",
DROP COLUMN "password_hash",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "lastLogin" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "role" "Role" NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "Doctor" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "specialization" TEXT NOT NULL,
    "license_number" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "department" TEXT,
    "img" TEXT,
    "colorCode" TEXT,
    "availability_status" TEXT,
    "type" "JOBTYPE" NOT NULL DEFAULT 'FULL',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Doctor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkingDays" (
    "id" SERIAL NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "start_time" TEXT NOT NULL,
    "close_time" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WorkingDays_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Staff" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "department" TEXT,
    "img" TEXT,
    "license_number" TEXT,
    "colorCode" TEXT,
    "role" "Role" NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Staff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appointment" (
    "id" SERIAL NOT NULL,
    "patient_id" TEXT NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "appointment_date" TIMESTAMP(3) NOT NULL,
    "time" TEXT NOT NULL,
    "status" "AppointmentStatus" NOT NULL DEFAULT 'PENDING',
    "type" TEXT NOT NULL,
    "note" TEXT,
    "reason" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Appointment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" SERIAL NOT NULL,
    "bill_id" INTEGER,
    "patient_id" TEXT NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "bill_date" TIMESTAMP(3) NOT NULL,
    "payment_date" TIMESTAMP(3) NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL,
    "total_amount" DOUBLE PRECISION NOT NULL,
    "amount_paid" DOUBLE PRECISION NOT NULL,
    "payment_method" "PaymentMethod" NOT NULL DEFAULT 'CASH',
    "status" "PaymentStatus" NOT NULL DEFAULT 'UNPAID',
    "receipt_number" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PatientBills" (
    "id" SERIAL NOT NULL,
    "bill_id" INTEGER NOT NULL,
    "service_id" INTEGER NOT NULL,
    "service_date" TIMESTAMP(3) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit_cost" DOUBLE PRECISION NOT NULL,
    "total_cost" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PatientBills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTest" (
    "id" SERIAL NOT NULL,
    "record_id" INTEGER NOT NULL,
    "patient_id" TEXT NOT NULL,
    "test_date" TIMESTAMP(3),
    "result" TEXT,
    "resultNote" TEXT,
    "status" "TestStatus" NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,
    "service_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LabTest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalRecords" (
    "id" SERIAL NOT NULL,
    "patient_id" TEXT NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "treatment_plan" TEXT,
    "lab_request" TEXT,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MedicalRecords_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VitalSigns" (
    "id" SERIAL NOT NULL,
    "patient_id" TEXT NOT NULL,
    "medical_id" INTEGER NOT NULL,
    "body_temperature" DOUBLE PRECISION NOT NULL,
    "systolic" INTEGER NOT NULL,
    "diastolic" INTEGER NOT NULL,
    "heartRate" TEXT NOT NULL,
    "respiratory_rate" INTEGER,
    "oxygen_saturation" INTEGER,
    "weight" DOUBLE PRECISION NOT NULL,
    "height" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VitalSigns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Diagnosis" (
    "id" SERIAL NOT NULL,
    "patient_id" TEXT NOT NULL,
    "medical_id" INTEGER NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "symptoms" TEXT NOT NULL,
    "diagnosis" TEXT NOT NULL,
    "notes" TEXT,
    "prescribed_medications" TEXT,
    "follow_up_plan" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Diagnosis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "record_id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "details" TEXT,
    "model" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rating" (
    "id" SERIAL NOT NULL,
    "staff_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Rating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Services" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "description" TEXT,
    "department" "Department" NOT NULL DEFAULT 'GENERAL',
    "price" DECIMAL(10,2) NOT NULL,
    "tat" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "message" TEXT NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Leave" (
    "id" SERIAL NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "type" "LeaveType" NOT NULL,
    "reason" TEXT NOT NULL,
    "status" "LeaveStatus" NOT NULL DEFAULT 'PENDING',
    "rejectionReason" TEXT,
    "modifiedStartDate" TIMESTAMP(3),
    "modifiedEndDate" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Leave_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Prescription" (
    "id" SERIAL NOT NULL,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "notes" TEXT,
    "status" "PrescriptionStatus" NOT NULL DEFAULT 'PENDING',
    "diagnosisId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Prescription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PrescribedDrug" (
    "id" TEXT NOT NULL,
    "prescriptionId" INTEGER NOT NULL,
    "drugId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "instructions" TEXT,
    "frequency" TEXT,
    "duration" INTEGER,

    CONSTRAINT "PrescribedDrug_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Drug" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "batchNumber" TEXT NOT NULL,
    "manufacturer" TEXT NOT NULL,
    "expiryDate" TIMESTAMP(3) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "pricePerUnit" DOUBLE PRECISION NOT NULL,
    "category" "DrugCategory" NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Drug_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockUpdate" (
    "id" TEXT NOT NULL,
    "drugId" TEXT NOT NULL,
    "previousQuantity" INTEGER NOT NULL,
    "newQuantity" INTEGER NOT NULL,
    "type" "StockUpdateType" NOT NULL DEFAULT 'ISSUANCE',
    "userId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,

    CONSTRAINT "StockUpdate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DrugIssuance" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "prescriptionId" INTEGER NOT NULL,
    "pharmacistId" TEXT NOT NULL,
    "issuedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "totalCost" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "DrugIssuance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IssuedDrug" (
    "id" TEXT NOT NULL,
    "issuanceId" TEXT NOT NULL,
    "drugId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "pricePerUnit" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "IssuedDrug_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invoice" (
    "id" TEXT NOT NULL,
    "providerName" TEXT NOT NULL,
    "purchaseDate" TIMESTAMP(3) NOT NULL,
    "totalCost" DOUBLE PRECISION NOT NULL,
    "status" "InvoiceStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchasedDrug" (
    "id" TEXT NOT NULL,
    "invoiceId" TEXT NOT NULL,
    "drugId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "pricePerUnit" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "PurchasedDrug_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Doctor_email_key" ON "Doctor"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Staff_email_key" ON "Staff"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_appointment_id_key" ON "Payment"("appointment_id");

-- CreateIndex
CREATE INDEX "Prescription_patientId_idx" ON "Prescription"("patientId");

-- CreateIndex
CREATE INDEX "Prescription_doctorId_idx" ON "Prescription"("doctorId");

-- CreateIndex
CREATE INDEX "Prescription_status_idx" ON "Prescription"("status");

-- CreateIndex
CREATE INDEX "PrescribedDrug_prescriptionId_idx" ON "PrescribedDrug"("prescriptionId");

-- CreateIndex
CREATE INDEX "PrescribedDrug_drugId_idx" ON "PrescribedDrug"("drugId");

-- CreateIndex
CREATE INDEX "Drug_category_idx" ON "Drug"("category");

-- CreateIndex
CREATE INDEX "Drug_expiryDate_idx" ON "Drug"("expiryDate");

-- CreateIndex
CREATE INDEX "StockUpdate_drugId_idx" ON "StockUpdate"("drugId");

-- CreateIndex
CREATE INDEX "StockUpdate_userId_idx" ON "StockUpdate"("userId");

-- CreateIndex
CREATE INDEX "StockUpdate_updatedAt_idx" ON "StockUpdate"("updatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "DrugIssuance_prescriptionId_key" ON "DrugIssuance"("prescriptionId");

-- CreateIndex
CREATE INDEX "DrugIssuance_patientId_idx" ON "DrugIssuance"("patientId");

-- CreateIndex
CREATE INDEX "DrugIssuance_prescriptionId_idx" ON "DrugIssuance"("prescriptionId");

-- CreateIndex
CREATE INDEX "IssuedDrug_issuanceId_idx" ON "IssuedDrug"("issuanceId");

-- CreateIndex
CREATE INDEX "IssuedDrug_drugId_idx" ON "IssuedDrug"("drugId");

-- CreateIndex
CREATE INDEX "Invoice_purchaseDate_idx" ON "Invoice"("purchaseDate");

-- CreateIndex
CREATE INDEX "Invoice_status_idx" ON "Invoice"("status");

-- CreateIndex
CREATE INDEX "PurchasedDrug_invoiceId_idx" ON "PurchasedDrug"("invoiceId");

-- CreateIndex
CREATE INDEX "PurchasedDrug_drugId_idx" ON "PurchasedDrug"("drugId");

-- CreateIndex
CREATE UNIQUE INDEX "Patient_email_key" ON "Patient"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Patient" ADD CONSTRAINT "Patient_physician_id_fkey" FOREIGN KEY ("physician_id") REFERENCES "Doctor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkingDays" ADD CONSTRAINT "WorkingDays_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "Doctor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "Doctor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "Appointment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientBills" ADD CONSTRAINT "PatientBills_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "Services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientBills" ADD CONSTRAINT "PatientBills_bill_id_fkey" FOREIGN KEY ("bill_id") REFERENCES "Payment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "Services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_record_id_fkey" FOREIGN KEY ("record_id") REFERENCES "MedicalRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecords" ADD CONSTRAINT "MedicalRecords_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "Appointment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecords" ADD CONSTRAINT "MedicalRecords_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VitalSigns" ADD CONSTRAINT "VitalSigns_medical_id_fkey" FOREIGN KEY ("medical_id") REFERENCES "MedicalRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Diagnosis" ADD CONSTRAINT "Diagnosis_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "Doctor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Diagnosis" ADD CONSTRAINT "Diagnosis_medical_id_fkey" FOREIGN KEY ("medical_id") REFERENCES "MedicalRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "Doctor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Leave" ADD CONSTRAINT "Leave_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prescription" ADD CONSTRAINT "Prescription_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prescription" ADD CONSTRAINT "Prescription_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prescription" ADD CONSTRAINT "Prescription_diagnosisId_fkey" FOREIGN KEY ("diagnosisId") REFERENCES "Diagnosis"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrescribedDrug" ADD CONSTRAINT "PrescribedDrug_prescriptionId_fkey" FOREIGN KEY ("prescriptionId") REFERENCES "Prescription"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrescribedDrug" ADD CONSTRAINT "PrescribedDrug_drugId_fkey" FOREIGN KEY ("drugId") REFERENCES "Drug"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockUpdate" ADD CONSTRAINT "StockUpdate_drugId_fkey" FOREIGN KEY ("drugId") REFERENCES "Drug"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockUpdate" ADD CONSTRAINT "StockUpdate_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DrugIssuance" ADD CONSTRAINT "DrugIssuance_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DrugIssuance" ADD CONSTRAINT "DrugIssuance_prescriptionId_fkey" FOREIGN KEY ("prescriptionId") REFERENCES "Prescription"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DrugIssuance" ADD CONSTRAINT "DrugIssuance_pharmacistId_fkey" FOREIGN KEY ("pharmacistId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedDrug" ADD CONSTRAINT "IssuedDrug_issuanceId_fkey" FOREIGN KEY ("issuanceId") REFERENCES "DrugIssuance"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedDrug" ADD CONSTRAINT "IssuedDrug_drugId_fkey" FOREIGN KEY ("drugId") REFERENCES "Drug"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchasedDrug" ADD CONSTRAINT "PurchasedDrug_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchasedDrug" ADD CONSTRAINT "PurchasedDrug_drugId_fkey" FOREIGN KEY ("drugId") REFERENCES "Drug"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
