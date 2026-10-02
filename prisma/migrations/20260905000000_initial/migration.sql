-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'MANAGER', 'ANALYST');

-- CreateTable
CREATE TABLE "User" (
    "active" BOOLEAN NOT NULL DEFAULT true,
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ANALYST',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "actorId" TEXT,
    "actorName" TEXT,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "detail" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowAnalysis" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "workflow" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "input" JSONB NOT NULL,
    "evidence" JSONB NOT NULL,
    "evidenceHash" TEXT NOT NULL,
    "result" JSONB NOT NULL,
    "model" TEXT NOT NULL,
    "receipt" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkflowAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordReview" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RecordReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsageBucket" (
    "id" TEXT NOT NULL,
    "calls" INTEGER NOT NULL,

    CONSTRAINT "UsageBucket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IssuedCredential" (
    "token" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "assertion" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMP(3),

    CONSTRAINT "IssuedCredential_pkey" PRIMARY KEY ("token")
);

-- CreateTable
CREATE TABLE "DomainArtifact" (
    "id" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "contentHash" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "approvedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainArtifact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordApproval" (
    "id" TEXT NOT NULL,
    "version" TEXT NOT NULL,

    CONSTRAINT "RecordApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DomainExecution" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "connectorId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "result" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainExecution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkSession" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "respondentId" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "questions" JSONB NOT NULL,
    "answers" JSONB NOT NULL,
    "currentQuestion" TEXT,
    "status" TEXT NOT NULL,
    "deadline" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SessionMedia" (
    "id" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "contentType" TEXT NOT NULL,
    "bytes" BYTEA NOT NULL,
    "contentHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SessionMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppSetting" (
    "id" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DosimetryProgram" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "licenseNumber" TEXT NOT NULL,
    "employer" TEXT NOT NULL,
    "radiationOfficer" TEXT NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DosimetryProgram_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MonitoredWorker" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "employeeCode" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "jobTitle" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MonitoredWorker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DosimeterBadge" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "monitoredWorkerId" TEXT NOT NULL,
    "badgeNumber" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL,
    "returnedAt" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DosimeterBadge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DoseResult" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "dosimeterBadgeId" TEXT NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "doseType" TEXT NOT NULL,
    "doseMsv" DOUBLE PRECISION NOT NULL,
    "sourceReference" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DoseResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriorExposure" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "monitoredWorkerId" TEXT NOT NULL,
    "employer" TEXT NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "doseMsv" DOUBLE PRECISION NOT NULL,
    "evidence" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PriorExposure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DoseThreshold" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "doseType" TEXT NOT NULL,
    "thresholdMsv" DOUBLE PRECISION NOT NULL,
    "averagingPeriod" TEXT NOT NULL,
    "ruleVersion" TEXT NOT NULL,
    "effectiveAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DoseThreshold_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DoseInvestigation" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "monitoredWorkerId" TEXT NOT NULL,
    "openedAt" TIMESTAMP(3) NOT NULL,
    "reason" TEXT NOT NULL,
    "findings" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DoseInvestigation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkerAcknowledgement" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "monitoredWorkerId" TEXT NOT NULL,
    "acknowledgedAt" TIMESTAMP(3) NOT NULL,
    "reportReference" TEXT NOT NULL,
    "evidence" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WorkerAcknowledgement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendorReconciliation" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "receivedAt" TIMESTAMP(3) NOT NULL,
    "expectedBadges" INTEGER NOT NULL,
    "receivedResults" INTEGER NOT NULL,
    "discrepancies" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VendorReconciliation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OperationalTask" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "done" BOOLEAN NOT NULL,
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OperationalTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RuleVersion" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurisdiction" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "effectiveAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "sourceUrl" TEXT NOT NULL,
    "requirementText" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RuleVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentRequirement" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "requiredBy" TIMESTAMP(3) NOT NULL,
    "sourceReference" TEXT NOT NULL,
    "evidenceReference" TEXT,
    "reviewNotes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "dosimetryProgramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "WorkflowAnalysis_workflow_createdAt_idx" ON "WorkflowAnalysis"("workflow", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "RecordReview_entity_entityId_version_actorId_key" ON "RecordReview"("entity", "entityId", "version", "actorId");

-- CreateIndex
CREATE INDEX "IssuedCredential_entity_entityId_createdAt_idx" ON "IssuedCredential"("entity", "entityId", "createdAt");

-- CreateIndex
CREATE INDEX "DomainArtifact_subjectEntity_subjectId_idx" ON "DomainArtifact"("subjectEntity", "subjectId");

-- CreateIndex
CREATE INDEX "WorkSession_respondentId_createdAt_idx" ON "WorkSession"("respondentId", "createdAt");

-- CreateIndex
CREATE INDEX "SessionMedia_sessionId_idx" ON "SessionMedia"("sessionId");

-- CreateIndex
CREATE INDEX "DosimetryProgram_createdAt_idx" ON "DosimetryProgram"("createdAt");

-- CreateIndex
CREATE INDEX "MonitoredWorker_createdAt_idx" ON "MonitoredWorker"("createdAt");

-- CreateIndex
CREATE INDEX "MonitoredWorker_dosimetryProgramId_idx" ON "MonitoredWorker"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "DosimeterBadge_createdAt_idx" ON "DosimeterBadge"("createdAt");

-- CreateIndex
CREATE INDEX "DosimeterBadge_dosimetryProgramId_idx" ON "DosimeterBadge"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "DoseResult_createdAt_idx" ON "DoseResult"("createdAt");

-- CreateIndex
CREATE INDEX "DoseResult_dosimetryProgramId_idx" ON "DoseResult"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "PriorExposure_createdAt_idx" ON "PriorExposure"("createdAt");

-- CreateIndex
CREATE INDEX "PriorExposure_dosimetryProgramId_idx" ON "PriorExposure"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "DoseThreshold_createdAt_idx" ON "DoseThreshold"("createdAt");

-- CreateIndex
CREATE INDEX "DoseThreshold_dosimetryProgramId_idx" ON "DoseThreshold"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "DoseInvestigation_createdAt_idx" ON "DoseInvestigation"("createdAt");

-- CreateIndex
CREATE INDEX "DoseInvestigation_dosimetryProgramId_idx" ON "DoseInvestigation"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "WorkerAcknowledgement_createdAt_idx" ON "WorkerAcknowledgement"("createdAt");

-- CreateIndex
CREATE INDEX "WorkerAcknowledgement_dosimetryProgramId_idx" ON "WorkerAcknowledgement"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "VendorReconciliation_createdAt_idx" ON "VendorReconciliation"("createdAt");

-- CreateIndex
CREATE INDEX "VendorReconciliation_dosimetryProgramId_idx" ON "VendorReconciliation"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "OperationalTask_createdAt_idx" ON "OperationalTask"("createdAt");

-- CreateIndex
CREATE INDEX "OperationalTask_dosimetryProgramId_idx" ON "OperationalTask"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "RuleVersion_createdAt_idx" ON "RuleVersion"("createdAt");

-- CreateIndex
CREATE INDEX "RuleVersion_dosimetryProgramId_idx" ON "RuleVersion"("dosimetryProgramId");

-- CreateIndex
CREATE INDEX "DocumentRequirement_createdAt_idx" ON "DocumentRequirement"("createdAt");

-- CreateIndex
CREATE INDEX "DocumentRequirement_dosimetryProgramId_idx" ON "DocumentRequirement"("dosimetryProgramId");

-- AddForeignKey
ALTER TABLE "MonitoredWorker" ADD CONSTRAINT "MonitoredWorker_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DosimeterBadge" ADD CONSTRAINT "DosimeterBadge_monitoredWorkerId_fkey" FOREIGN KEY ("monitoredWorkerId") REFERENCES "MonitoredWorker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DosimeterBadge" ADD CONSTRAINT "DosimeterBadge_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoseResult" ADD CONSTRAINT "DoseResult_dosimeterBadgeId_fkey" FOREIGN KEY ("dosimeterBadgeId") REFERENCES "DosimeterBadge"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoseResult" ADD CONSTRAINT "DoseResult_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriorExposure" ADD CONSTRAINT "PriorExposure_monitoredWorkerId_fkey" FOREIGN KEY ("monitoredWorkerId") REFERENCES "MonitoredWorker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriorExposure" ADD CONSTRAINT "PriorExposure_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoseThreshold" ADD CONSTRAINT "DoseThreshold_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoseInvestigation" ADD CONSTRAINT "DoseInvestigation_monitoredWorkerId_fkey" FOREIGN KEY ("monitoredWorkerId") REFERENCES "MonitoredWorker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoseInvestigation" ADD CONSTRAINT "DoseInvestigation_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkerAcknowledgement" ADD CONSTRAINT "WorkerAcknowledgement_monitoredWorkerId_fkey" FOREIGN KEY ("monitoredWorkerId") REFERENCES "MonitoredWorker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkerAcknowledgement" ADD CONSTRAINT "WorkerAcknowledgement_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorReconciliation" ADD CONSTRAINT "VendorReconciliation_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OperationalTask" ADD CONSTRAINT "OperationalTask_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RuleVersion" ADD CONSTRAINT "RuleVersion_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentRequirement" ADD CONSTRAINT "DocumentRequirement_dosimetryProgramId_fkey" FOREIGN KEY ("dosimetryProgramId") REFERENCES "DosimetryProgram"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

