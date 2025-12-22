import { performance } from "node:perf_hooks";
import crypto from "node:crypto";

type BenchResult = { name: string; iterations: number; ms: number; opsPerSec: number };

function sha256(data: Buffer) {
  return crypto.createHash("sha256").update(data).digest();
}

function benchHash(iterations: number): BenchResult {
  const name = "sha256(4KB)";
  const payload = crypto.randomBytes(4096);

  const start = performance.now();
  let x = payload;
  for (let i = 0; i < iterations; i++) {
    x = sha256(x);
  }
  const end = performance.now();
  const ms = end - start;
  const opsPerSec = iterations / (ms / 1000);
  return { name, iterations, ms, opsPerSec };
}

function benchJson(iterations: number): BenchResult {
  const name = "JSON.stringify(large)";
  const obj = { a: "x".repeat(1000), b: Array.from({ length: 200 }, (_, i) => ({ i, v: "y".repeat(256) })) };

  const start = performance.now();
  let s = "";
  for (let i = 0; i < iterations; i++) {
    s = JSON.stringify(obj);
  }
  const end = performance.now();
  const ms = end - start;
  const opsPerSec = iterations / (ms / 1000);
  return { name, iterations, ms, opsPerSec };
}

function main() {
  const it = Number(process.env.IT || "25000");
  const results = [benchHash(Math.max(1000, Math.floor(it / 5))), benchJson(Math.max(500, Math.floor(it / 20)))];

  for (const r of results) {
    console.log(`${r.name}: ${r.ms.toFixed(2)}ms, ${r.opsPerSec.toFixed(2)} ops/s (${r.iterations} iters)`);
  }
}

main();
