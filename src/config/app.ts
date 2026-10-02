export interface PageConfig {
  label: string;
  href: string;
  description: string;
  entities: string[];
  workflows: string[];
}

export interface EntityConfig {
  name: string;
  label: string;
  fields: Array<{ name: string; kind: "string" | "number" | "boolean" | "date" }>;
}

export interface WorkflowConfig {
  slug: string;
  title: string;
  description: string;
  prompt: string;
  fields: string[];
}

export const appConfig = {
  "slug": "ai-occupational-radiation-dose-records",
  "title": "Occupational Radiation Dose Records",
  "tagline": "Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records.",
  "accent": "rose"
};
export const pages: PageConfig[] = [
  {
    "label": "Intake & registers",
    "href": "/registers",
    "description": "Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records.",
    "entities": [
      "DosimetryProgram",
      "MonitoredWorker",
      "DosimeterBadge"
    ],
    "workflows": [
      "vendor-report-extraction",
      "badge-assignment-reconciliation"
    ]
  },
  {
    "label": "Operational records",
    "href": "/workflow",
    "description": "Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records.",
    "entities": [
      "DoseResult",
      "PriorExposure",
      "DoseThreshold"
    ],
    "workflows": [
      "cumulative-exposure-record-summary",
      "missing-report-follow-up"
    ]
  },
  {
    "label": "Review & delivery",
    "href": "/delivery",
    "description": "Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records.",
    "entities": [
      "DoseInvestigation",
      "WorkerAcknowledgement",
      "VendorReconciliation"
    ],
    "workflows": [
      "investigation-narrative",
      "worker-report-explanation"
    ]
  },
  {
    "label": "Tasks & requirements",
    "href": "/operations",
    "description": "Assignments, versioned rules and document requirements.",
    "entities": [
      "OperationalTask",
      "RuleVersion",
      "DocumentRequirement"
    ],
    "workflows": [
      "evidence-completeness-review",
      "operations-handoff-draft"
    ]
  }
];
export const entities: Record<string, EntityConfig> = {
  "DosimetryProgram": {
    "name": "DosimetryProgram",
    "label": "Dosimetry Program",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "licenseNumber",
        "kind": "string"
      },
      {
        "name": "employer",
        "kind": "string"
      },
      {
        "name": "radiationOfficer",
        "kind": "string"
      },
      {
        "name": "periodStart",
        "kind": "date"
      },
      {
        "name": "periodEnd",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      }
    ]
  },
  "MonitoredWorker": {
    "name": "MonitoredWorker",
    "label": "Monitored Worker",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "employeeCode",
        "kind": "string"
      },
      {
        "name": "department",
        "kind": "string"
      },
      {
        "name": "jobTitle",
        "kind": "string"
      },
      {
        "name": "startedAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "DosimeterBadge": {
    "name": "DosimeterBadge",
    "label": "Dosimeter Badge",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "monitoredWorkerId",
        "kind": "string"
      },
      {
        "name": "badgeNumber",
        "kind": "string"
      },
      {
        "name": "vendor",
        "kind": "string"
      },
      {
        "name": "assignedAt",
        "kind": "date"
      },
      {
        "name": "returnedAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "DoseResult": {
    "name": "DoseResult",
    "label": "Dose Result",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "dosimeterBadgeId",
        "kind": "string"
      },
      {
        "name": "periodStart",
        "kind": "date"
      },
      {
        "name": "periodEnd",
        "kind": "date"
      },
      {
        "name": "doseType",
        "kind": "string"
      },
      {
        "name": "doseMsv",
        "kind": "number"
      },
      {
        "name": "sourceReference",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "PriorExposure": {
    "name": "PriorExposure",
    "label": "Prior Exposure",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "monitoredWorkerId",
        "kind": "string"
      },
      {
        "name": "employer",
        "kind": "string"
      },
      {
        "name": "periodStart",
        "kind": "date"
      },
      {
        "name": "periodEnd",
        "kind": "date"
      },
      {
        "name": "doseMsv",
        "kind": "number"
      },
      {
        "name": "evidence",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "DoseThreshold": {
    "name": "DoseThreshold",
    "label": "Dose Threshold",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "doseType",
        "kind": "string"
      },
      {
        "name": "thresholdMsv",
        "kind": "number"
      },
      {
        "name": "averagingPeriod",
        "kind": "string"
      },
      {
        "name": "ruleVersion",
        "kind": "string"
      },
      {
        "name": "effectiveAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "DoseInvestigation": {
    "name": "DoseInvestigation",
    "label": "Dose Investigation",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "monitoredWorkerId",
        "kind": "string"
      },
      {
        "name": "openedAt",
        "kind": "date"
      },
      {
        "name": "reason",
        "kind": "string"
      },
      {
        "name": "findings",
        "kind": "string"
      },
      {
        "name": "action",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "WorkerAcknowledgement": {
    "name": "WorkerAcknowledgement",
    "label": "Worker Acknowledgement",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "monitoredWorkerId",
        "kind": "string"
      },
      {
        "name": "acknowledgedAt",
        "kind": "date"
      },
      {
        "name": "reportReference",
        "kind": "string"
      },
      {
        "name": "evidence",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "VendorReconciliation": {
    "name": "VendorReconciliation",
    "label": "Vendor Reconciliation",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "vendor",
        "kind": "string"
      },
      {
        "name": "receivedAt",
        "kind": "date"
      },
      {
        "name": "expectedBadges",
        "kind": "number"
      },
      {
        "name": "receivedResults",
        "kind": "number"
      },
      {
        "name": "discrepancies",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "OperationalTask": {
    "name": "OperationalTask",
    "label": "Operational Task",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "priority",
        "kind": "string"
      },
      {
        "name": "startAt",
        "kind": "date"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "done",
        "kind": "boolean"
      },
      {
        "name": "notes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "RuleVersion": {
    "name": "RuleVersion",
    "label": "Rule Version",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurisdiction",
        "kind": "string"
      },
      {
        "name": "version",
        "kind": "string"
      },
      {
        "name": "effectiveAt",
        "kind": "date"
      },
      {
        "name": "expiresAt",
        "kind": "date"
      },
      {
        "name": "sourceUrl",
        "kind": "string"
      },
      {
        "name": "requirementText",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  },
  "DocumentRequirement": {
    "name": "DocumentRequirement",
    "label": "Document Requirement",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "category",
        "kind": "string"
      },
      {
        "name": "requiredBy",
        "kind": "date"
      },
      {
        "name": "sourceReference",
        "kind": "string"
      },
      {
        "name": "evidenceReference",
        "kind": "string"
      },
      {
        "name": "reviewNotes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "dosimetryProgramId",
        "kind": "string"
      }
    ]
  }
};
export const workflows: WorkflowConfig[] = [
  {
    "slug": "vendor-report-extraction",
    "title": "Vendor report extraction",
    "description": "Vendor report extraction using selected dosimetry program records and supplied evidence.",
    "prompt": "Vendor report extraction for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "badge-assignment-reconciliation",
    "title": "Badge assignment reconciliation",
    "description": "Badge assignment reconciliation using selected dosimetry program records and supplied evidence.",
    "prompt": "Badge assignment reconciliation for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "cumulative-exposure-record-summary",
    "title": "Cumulative exposure record summary",
    "description": "Cumulative exposure record summary using selected dosimetry program records and supplied evidence.",
    "prompt": "Cumulative exposure record summary for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "missing-report-follow-up",
    "title": "Missing report follow-up",
    "description": "Missing report follow-up using selected dosimetry program records and supplied evidence.",
    "prompt": "Missing report follow-up for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "investigation-narrative",
    "title": "Investigation narrative",
    "description": "Investigation narrative using selected dosimetry program records and supplied evidence.",
    "prompt": "Investigation narrative for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "worker-report-explanation",
    "title": "Worker report explanation",
    "description": "Worker report explanation using selected dosimetry program records and supplied evidence.",
    "prompt": "Worker report explanation for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "evidence-completeness-review",
    "title": "Evidence completeness review",
    "description": "Evidence completeness review using selected dosimetry program records and supplied evidence.",
    "prompt": "Evidence completeness review for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "operations-handoff-draft",
    "title": "Operations handoff draft",
    "description": "Operations handoff draft using selected dosimetry program records and supplied evidence.",
    "prompt": "Operations handoff draft for Occupational Radiation Dose Records. Operational scope: Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records. Specific AI scope: Match reports to staff and draft discrepancy summaries for the radiation-safety officer. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  }
];
export function findPage(href:string){return pages.find(p=>p.href===href);}
