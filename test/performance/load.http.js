// Minimal load generator using undici (Node 18+).
// Run: node test/performance/load.http.js
import { request } from "undici";

const base = process.env.API_BASE || "http://localhost:8080";
const concurrency = Number(process.env.CONCURRENCY || "25");
const seconds = Number(process.env.SECONDS || "10");

let ok = 0;
let fail = 0;

async function worker() {
  const end = Date.now() + seconds * 1000;
  while (Date.now() < end) {
    try {
      const { statusCode, body } = await request(`${base}/health`, { method: "GET" });
      await body.text();
      if (statusCode === 200) ok++;
      else fail++;
    } catch {
      fail++;
    }
  }
}

async function main() {
  console.log(`Running load: ${concurrency} workers for ${seconds}s -> ${base}`);
  await Promise.all(Array.from({ length: concurrency }, () => worker()));
  console.log({ ok, fail });
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
