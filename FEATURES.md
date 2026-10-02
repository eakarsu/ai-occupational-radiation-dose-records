# Occupational Radiation Dose Records

Reconcile badge assignments, dosimeter-vendor results, cumulative occupational exposure and investigation records.

## Implemented records

- **Dosimetry Program**: name, license Number, employer, radiation Officer, period Start, period End, status.
- **Monitored Worker**: name, employee Code, department, job Title, started At, status.
- **Dosimeter Badge**: title, badge Number, vendor, assigned At, returned At, status.
- **Dose Result**: title, period Start, period End, dose Type, dose Msv, source Reference, status.
- **Prior Exposure**: title, employer, period Start, period End, dose Msv, evidence, status.
- **Dose Threshold**: title, dose Type, threshold Msv, averaging Period, rule Version, effective At, status.
- **Dose Investigation**: title, opened At, reason, findings, action, status.
- **Worker Acknowledgement**: title, acknowledged At, report Reference, evidence, status.
- **Vendor Reconciliation**: title, vendor, received At, expected Badges, received Results, discrepancies, status.
- **Operational Task**: title, owner, priority, start At, due At, done, notes, status.
- **Rule Version**: title, jurisdiction, version, effective At, expires At, source Url, requirement Text, status.
- **Document Requirement**: title, category, required By, source Reference, evidence Reference, review Notes, status.

## AI workflows

- Vendor report extraction: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Badge assignment reconciliation: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Cumulative exposure record summary: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Missing report follow-up: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Investigation narrative: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Worker report explanation: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Evidence completeness review: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Operations handoff draft: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.

## Calculations

- Occupational dose aggregation: Sum non-overlapping vendor measurements of one dose type and unit; compare a supplied review threshold.
- Dosimetry Program evidence checklist: Check source presence against an explicitly supplied document list; reviewer assesses adequacy.
- Operational deadline queue: Compute overdue items from entered dates and completed flags; no external notifications.

## Workspace features

Role-based login and account management; validated create/edit/delete; required parent and sibling relationships; search and pagination; atomic JSON imports; CSV/JSON exports; optimistic concurrency; two independent human reviews; immutable source-text uploads with independent review; dated task calendar; aggregate reports; searchable audit trail; model catalog and administrator AI settings; configured HTTPS connectors with approval, idempotency and receipt checks.

## Integration boundaries

A finite working scope, not every conceivable feature. No production regulator, insurer, carrier, court, university or clinical integration is preconfigured. Source uploads support text/CSV/JSON/Markdown, not OCR/PDF parsing. AI produces drafts and cannot authorize clinical handling, adjudicate rights, select recipients or jurors, establish eligibility, certify regulatory compliance or send submissions. Live external execution requires a configured adapter and independent human approval of the current record. Calculations use supplied rules and units; example rules are fictional.
