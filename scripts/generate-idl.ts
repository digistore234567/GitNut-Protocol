import fs from "node:fs";
import path from "node:path";
import { execa } from "execa";

function log(msg: string) {
  process.stdout.write(`[idl] ${msg}\n`);
}

async function run(cmd: string, args: string[], cwd: string) {
  log(`$ ${cmd} ${args.join(" ")}`);
  await execa(cmd, args, { cwd, stdio: "inherit" });
}

async function main() {
  const repoRoot = process.cwd();
  const programDir = path.join(repoRoot, "programs", "gitnut-registry");
  const idlDir = path.join(programDir, "idl");

  if (!fs.existsSync(programDir)) {
    throw new Error("programs/gitnut-registry not found");
  }

  log("Building Anchor program and generating IDL...");
  await run("anchor", ["build"], programDir);

  // Anchor writes IDL into target/idl/<program>.json
  const targetIdl = path.join(programDir, "target", "idl", "gitnut_registry.json");
  if (!fs.existsSync(targetIdl)) {
    throw new Error("Anchor did not generate target/idl/gitnut_registry.json");
  }

  fs.mkdirSync(idlDir, { recursive: true });
  const outIdl = path.join(idlDir, "gitnut_registry.json");
  fs.copyFileSync(targetIdl, outIdl);
  log(`Copied IDL to ${outIdl}`);

  log("Done.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
