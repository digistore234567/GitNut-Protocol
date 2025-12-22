# Monitoring

GitNut should be monitored across:
- availability
- correctness
- latency
- security signals

## Metrics

### API
- request rate
- error rate
- p95 latency
- auth failures
- rate limit triggers
- DB pool saturation

### Worker
- queue depth
- job throughput
- job failures by stage
- build duration distribution
- sandbox timeouts
- storage upload/download latency
- Solana tx failures

### Indexer
- slot lag
- event processing rate
- RPC error rate
- checkpoint progress

## Logs
- structured JSON logs
- include requestId/jobId
- redact secrets

## Tracing
- OpenTelemetry traces across API and Worker
- propagate trace headers between services

## Alerts
- API 5xx spikes
- Worker queue depth > threshold
- Solana tx failure rate > threshold
- Indexer lag > threshold
- Storage error rate spikes
