import { execa } from "execa";
import path from "node:path";

function log(msg: string) {
  process.stdout.write(`[publish-sdk] ${msg}\n`);
}

async function run(cmd: string, args: string[], cwd: string) {
  log(`$ ${cmd} ${args.join(" ")}`);
  await execa(cmd, args, { cwd, stdio: "inherit" });
}

async function main() {
  const repoRoot = process.cwd();
  const sdkDir = path.join(repoRoot, "packages", "sdk");

  log("Building SDK...");
  await run("pnpm", ["build"], sdkDir);

  log("Publishing (dry-run by default)...");
  const dryRun = process.env.DRY_RUN !== "0";
  const args = ["publish", "--access", "public"];
  if (dryRun) args.push("--dry-run");

  await run("pnpm", args, sdkDir);
  log(dryRun ? "Dry-run publish completed." : "Publish completed.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
