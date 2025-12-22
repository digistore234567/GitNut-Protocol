# Redis (GitNut)

The docker-compose uses Redis 7 with AOF enabled.

If you need custom configuration:
- Mount a redis.conf and pass it to redis-server in compose
- Tune maxmemory and eviction policy based on workload

Common usage in GitNut:
- Queue backend (BullMQ)
- Short-lived cache (import status, repo metadata, rate limiting)
