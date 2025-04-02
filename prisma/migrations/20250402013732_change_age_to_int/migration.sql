/*
  Warnings:

  - The values [ONLINE] on the enum `PaymentMethod` will be removed. If these variants are still used in the database, this will fail.
  - The values [LABORATORY,PHARMACY] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `patient_id` on the `LabTest` table. All the data in the column will be lost.
  - You are about to drop the column `resultNote` on the `LabTest` table. All the data in the column will be lost.
  - You are about to drop the column `physician_id` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `Services` table. All the data in the column will be lost.
  - You are about to drop the column `department` on the `Services` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Services` table. All the data in the column will be lost.
  - You are about to drop the column `tat` on the `Services` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Services` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,2)` to `DoublePrecision`.
  - You are about to drop the `Drug` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DrugIssuance` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Invoice` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IssuedDrug` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Leave` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PrescribedDrug` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Prescription` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PurchasedDrug` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `StockUpdate` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[service_id]` on the table `LabTest` will be added. If there are existing duplicate values, this will fail.
  - Made the column `test_date` on table `LabTest` required. This step will fail if there are existing NULL values in that column.
  - Made the column `result` on table `LabTest` required. This step will fail if there are existing NULL values in that column.
  - Changed the type of `status` on the `LabTest` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `service_name` to the `Services` table without a default value. This is not possible if the table is not empty.
  - Made the column `description` on table `Services` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "PaymentMethod_new" AS ENUM ('CASH', 'CARD', 'Online');
ALTER TABLE "Payment" ALTER COLUMN "payment_method" DROP DEFAULT;
ALTER TABLE "Payment" ALTER COLUMN "payment_method" TYPE "PaymentMethod_new" USING ("payment_method"::text::"PaymentMethod_new");
ALTER TYPE "PaymentMethod" RENAME TO "PaymentMethod_old";
ALTER TYPE "PaymentMethod_new" RENAME TO "PaymentMethod";
DROP TYPE "PaymentMethod_old";
ALTER TABLE "Payment" ALTER COLUMN "payment_method" SET DEFAULT 'CASH';
COMMIT;

-- AlterEnum
ALTER TYPE "PaymentStatus" ADD VALUE 'PART';

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'NURSE', 'DOCTOR', 'LAB_TECHNICIAN', 'PATIENT', 'CASHIER');
ALTER TABLE "Staff" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_doctor_id_fkey";

-- DropForeignKey
ALTER TABLE "DrugIssuance" DROP CONSTRAINT "DrugIssuance_patientId_fkey";

-- DropForeignKey
ALTER TABLE "DrugIssuance" DROP CONSTRAINT "DrugIssuance_pharmacistId_fkey";

-- DropForeignKey
ALTER TABLE "DrugIssuance" DROP CONSTRAINT "DrugIssuance_prescriptionId_fkey";

-- DropForeignKey
ALTER TABLE "IssuedDrug" DROP CONSTRAINT "IssuedDrug_drugId_fkey";

-- DropForeignKey
ALTER TABLE "IssuedDrug" DROP CONSTRAINT "IssuedDrug_issuanceId_fkey";

-- DropForeignKey
ALTER TABLE "LabTest" DROP CONSTRAINT "LabTest_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "Leave" DROP CONSTRAINT "Leave_userId_fkey";

-- DropForeignKey
ALTER TABLE "Patient" DROP CONSTRAINT "Patient_physician_id_fkey";

-- DropForeignKey
ALTER TABLE "PrescribedDrug" DROP CONSTRAINT "PrescribedDrug_drugId_fkey";

-- DropForeignKey
ALTER TABLE "PrescribedDrug" DROP CONSTRAINT "PrescribedDrug_prescriptionId_fkey";

-- DropForeignKey
ALTER TABLE "Prescription" DROP CONSTRAINT "Prescription_diagnosisId_fkey";

-- DropForeignKey
ALTER TABLE "Prescription" DROP CONSTRAINT "Prescription_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "Prescription" DROP CONSTRAINT "Prescription_patientId_fkey";

-- DropForeignKey
ALTER TABLE "PurchasedDrug" DROP CONSTRAINT "PurchasedDrug_drugId_fkey";

-- DropForeignKey
ALTER TABLE "PurchasedDrug" DROP CONSTRAINT "PurchasedDrug_invoiceId_fkey";

-- DropForeignKey
ALTER TABLE "StockUpdate" DROP CONSTRAINT "StockUpdate_drugId_fkey";

-- DropForeignKey
ALTER TABLE "StockUpdate" DROP CONSTRAINT "StockUpdate_userId_fkey";

-- AlterTable
ALTER TABLE "LabTest" DROP COLUMN "patient_id",
DROP COLUMN "resultNote",
ALTER COLUMN "test_date" SET NOT NULL,
ALTER COLUMN "result" SET NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "MedicalRecords" ADD COLUMN     "prescriptions" TEXT;

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "physician_id";

-- AlterTable
ALTER TABLE "Services" DROP COLUMN "category",
DROP COLUMN "department",
DROP COLUMN "name",
DROP COLUMN "tat",
ADD COLUMN     "service_name" TEXT NOT NULL,
ALTER COLUMN "description" SET NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DOUBLE PRECISION;

-- DropTable
DROP TABLE "Drug";

-- DropTable
DROP TABLE "DrugIssuance";

-- DropTable
DROP TABLE "Invoice";

-- DropTable
DROP TABLE "IssuedDrug";

-- DropTable
DROP TABLE "Leave";

-- DropTable
DROP TABLE "Notification";

-- DropTable
DROP TABLE "PrescribedDrug";

-- DropTable
DROP TABLE "Prescription";

-- DropTable
DROP TABLE "PurchasedDrug";

-- DropTable
DROP TABLE "StockUpdate";

-- DropTable
DROP TABLE "User";

-- DropEnum
DROP TYPE "Department";

-- DropEnum
DROP TYPE "DrugCategory";

-- DropEnum
DROP TYPE "InvoiceStatus";

-- DropEnum
DROP TYPE "LeaveStatus";

-- DropEnum
DROP TYPE "LeaveType";

-- DropEnum
DROP TYPE "PrescriptionStatus";

-- DropEnum
DROP TYPE "StockUpdateType";

-- DropEnum
DROP TYPE "TestStatus";

-- CreateIndex
CREATE UNIQUE INDEX "LabTest_service_id_key" ON "LabTest"("service_id");

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "Doctor"("id") ON DELETE CASCADE ON UPDATE CASCADE;
