import { describe, it, expect } from "vitest";

function canonicalizeJson(input: unknown): string {
  // Minimal canonical JSON for tests: stable key order, no whitespace.
  // Production uses packages/shared/canonical-json.
  const sort = (v: any): any => {
    if (Array.isArray(v)) return v.map(sort);
    if (v && typeof v === "object") {
      const keys = Object.keys(v).sort();
      const out: any = {};
      for (const k of keys) out[k] = sort(v[k]);
      return out;
    }
    return v;
  };
  return JSON.stringify(sort(input));
}

describe("canonical JSON", () => {
  it("orders keys deterministically", () => {
    const a = { b: 1, a: 2, c: { z: 1, y: 2 } };
    const b = { c: { y: 2, z: 1 }, a: 2, b: 1 };
    expect(canonicalizeJson(a)).toEqual(canonicalizeJson(b));
  });

  it("preserves arrays", () => {
    const x = { a: [3, 2, 1] };
    expect(canonicalizeJson(x)).toContain("[3,2,1]");
  });
});
