# Incident Response

This document outlines the incident response process for GitNut.

## Severity levels
- SEV-1: total outage or security compromise
- SEV-2: major feature degraded, publish blocked
- SEV-3: partial degradation, intermittent failures
- SEV-4: minor issues

## Roles
- Incident Commander (IC)
- Communications lead
- Scribe
- Subject matter experts

## Timeline
1. Detect and declare incident.
2. Stabilize service.
3. Identify root cause.
4. Apply fix or rollback.
5. Post-incident review.

## First actions
- confirm scope and blast radius
- stop unsafe operations (disable publishing if needed)
- preserve logs and evidence
- rotate secrets if compromise suspected

## Security incidents
If you suspect:
- signer key compromise
- unauthorized publish
- storage tampering

Then:
- disable publish endpoints
- rotate signer keys
- publish a public advisory if necessary
- re-verify recent releases

## Postmortem
Include:
- what happened
- impact
- timeline
- root cause
- corrective actions
