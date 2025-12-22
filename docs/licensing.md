# Licensing

GitNut is open-source. This document describes how to handle licensing correctly.

## Repository license

Your repo root should include:
- `LICENSE` (chosen open-source license)
- `NOTICE` (if required by dependencies)
- `DISCLAIMER.md` (for safety and no-warranty language)

## Imported project licenses

GitNut can detect licenses, but detection is not perfect.
You should treat license metadata as:
- best-effort
- subject to human review when required

## License policy engine

A license policy can:
- allowlist acceptable licenses (e.g., MIT, Apache-2.0, BSD-3-Clause)
- block copyleft licenses if your org requires it (e.g., GPL-3.0)
- require explicit override approvals for unknown licenses

## Recommendations

- Default to a conservative allowlist for public registries.
- Store detected license files in the source archive.
- Record the detected SPDX identifier in the manifest and attestation.

## Legal note

This documentation is not legal advice.
If licensing is critical, consult counsel.
