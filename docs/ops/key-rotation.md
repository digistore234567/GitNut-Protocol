# Key Rotation

GitNut uses several keys/secrets:
- session secret (API)
- GitHub OAuth client secret (API)
- storage credentials (worker/API)
- attestation signer keys (worker or KMS)
- Solana deploy and publish keys (operator wallets)

## Rotation cadence
- session secrets: quarterly
- OAuth secrets: semi-annually or on leak suspicion
- storage creds: quarterly
- signer keys: semi-annually or on leak suspicion

## Attestation signer rotation strategy
- introduce new key while old key remains trusted
- update allowlist (off-chain and/or on-chain)
- re-sign future releases with new key
- optionally re-attest older releases

## Solana keys
- keep deploy keys offline where possible
- use separate keys per environment
- never store private keys in CI logs
