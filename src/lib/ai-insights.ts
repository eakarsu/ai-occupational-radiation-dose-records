// Deterministic operational insights over this workspace's own dose records.
// Operational records support only — no diagnosis or clinical interpretation.
export type DoseInsightInput = {
  doseResults: { doseMsv: number; doseType: string; status: string }[];
  investigations: { status: string }[];
  reconciliations: { expectedBadges: number; receivedResults: number; status: string }[];
  openTasks: number;
  overdueTasks: number;
};
export const INSIGHT_TYPES = ["exposure-ledger", "investigation-queue", "vendor-reconciliation"] as const;
const LABELS: Record<string, string> = {
  "exposure-ledger": "Dose ledger summary",
  "investigation-queue": "Investigation queue summary",
  "vendor-reconciliation": "Vendor reconciliation summary",
};
export function buildDoseInsight(type: string, data: DoseInsightInput) {
  if (!LABELS[type]) throw new Error("Unknown insight type");
  const totalDose = data.doseResults.reduce((s, r) => s + (Number(r.doseMsv) || 0), 0);
  const missing = data.reconciliations.reduce((s, r) => s + Math.max(0, (r.expectedBadges || 0) - (r.receivedResults || 0)), 0);
  const openInvestigations = data.investigations.filter((i) => !["Approved", "Closed"].includes(i.status)).length;
  const sections = [
    { title: "Dose result count", detail: String(data.doseResults.length) },
    { title: "Recorded dose total (mSv)", detail: String(totalDose) },
    { title: "Open investigations", detail: String(openInvestigations) },
    { title: "Missing vendor results", detail: String(missing) },
    { title: "Open tasks", detail: String(data.openTasks) },
    { title: "Overdue tasks", detail: String(data.overdueTasks) },
  ];
  return {
    type, title: LABELS[type], aiGenerated: false, mode: "deterministic-fallback", source: "own-records",
    note: "Deterministic summary of this workspace's own saved dose records. No provider call was made; a qualified radiation safety reviewer must validate source evidence. Operational records support only — no diagnosis.",
    metrics: [
      { label: "Dose results", value: data.doseResults.length },
      { label: "Recorded dose total (mSv)", value: totalDose },
      { label: "Open investigations", value: openInvestigations },
      { label: "Missing vendor results", value: missing },
    ],
    sections,
  };
}
