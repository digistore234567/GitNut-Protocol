import { describe, it, expect } from "vitest";
import fetch from "node-fetch";

const base = process.env.API_BASE || "http://localhost:8080";

describe("API health", () => {
  it("returns ok", async () => {
    const res = await fetch(`${base}/health`);
    expect(res.status).toBe(200);
    const json = await res.json();
    expect(json.ok).toBe(true);
  });
});
