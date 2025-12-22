# Registry Program

The GitNut registry program (`programs/gitnut-registry`) is the on-chain anchor of truth.

Its responsibilities are intentionally minimal:
- define canonical PDA addresses for projects and versions
- store small metadata fields and integrity commitments
- enforce authority and immutability rules
- emit events for indexers

## Accounts

### Registry (global)
Stores:
- admin authority
- policy config pointers (optional)
- signer allowlists (optional)

### Project account
Derived PDA from:
- `project_slug` or `repo_id`
Stores:
- repo identity
- current maintainer authority set
- project status

### Version account
Derived PDA from:
- project PDA + `version_label` or `git_sha`
Stores:
- source hash + URI
- manifest hash + URI
- build hash + URIs (optional)
- attestation hashes + URIs
- publish timestamp
- verification status flags

## Instructions

- `initialize`
- `register_project`
- `publish_version`
- `set_maintainers`
- `set_policy`
- `verify_attestation` (optional)
- `deprecate_version`
- `transfer_project`
- `close_project` (admin only)

## Verification philosophy

The program should verify only what is cheap and deterministic:
- account ownership and PDAs
- signer/authority checks
- basic data shape constraints

Expensive checks (downloading artifacts) are off-chain.
Clients verify using hashes.

## Events

The program emits events such as:
- `ProjectRegistered`
- `VersionPublished`
- `MaintainersUpdated`
- `VersionDeprecated`

Indexers use these events to populate a query database.
