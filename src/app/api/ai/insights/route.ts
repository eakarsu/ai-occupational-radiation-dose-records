import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireUser } from "@/lib/api-auth";
import { buildDoseInsight, INSIGHT_TYPES } from "@/lib/ai-insights";
export const dynamic = "force-dynamic";
export async function GET() {
  const user = await requireUser();
  if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  return NextResponse.json({ types: INSIGHT_TYPES });
}
export async function POST(request: NextRequest) {
  const user = await requireUser();
  if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
  const type = typeof body.type === "string" ? body.type : "exposure-ledger";
  const now = new Date();
  const [doseResults, investigations, reconciliations, openTasks, overdueTasks] = await Promise.all([
    prisma.doseResult.findMany({ select: { doseMsv: true, doseType: true, status: true }, take: 10000 }),
    prisma.doseInvestigation.findMany({ select: { status: true }, take: 10000 }),
    prisma.vendorReconciliation.findMany({ select: { expectedBadges: true, receivedResults: true, status: true }, take: 10000 }),
    prisma.operationalTask.count({ where: { done: false } }),
    prisma.operationalTask.count({ where: { done: false, dueAt: { lt: now } } }),
  ]);
  try {
    return NextResponse.json({ insight: buildDoseInsight(type, { doseResults, investigations, reconciliations, openTasks, overdueTasks }) });
  } catch {
    return NextResponse.json({ error: "Unknown insight type" }, { status: 400 });
  }
}
