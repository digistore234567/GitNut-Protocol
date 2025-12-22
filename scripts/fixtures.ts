import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";

export type FixtureProject = {
  id: string;
  owner: string;
  repo: string;
  ref: string;
  sourceHash: string;
  createdAt: string;
};

function sha256(buf: Buffer) {
  return crypto.createHash("sha256").update(buf).digest("hex");
}

export function generateFixtureProject(owner: string, repo: string, ref = "main"): FixtureProject {
  const createdAt = new Date().toISOString();
  const id = `${owner}/${repo}@${ref}`;
  const sourceHash = sha256(Buffer.from(`${id}:${createdAt}`));
  return { id, owner, repo, ref, sourceHash, createdAt };
}

export function writeFixture(dir: string, name: string, fixture: unknown) {
  fs.mkdirSync(dir, { recursive: true });
  const p = path.join(dir, `${name}.json`);
  fs.writeFileSync(p, JSON.stringify(fixture, null, 2), "utf-8");
  return p;
}
