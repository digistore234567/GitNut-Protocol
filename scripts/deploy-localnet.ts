import { execa } from "execa";
import path from "node:path";
import fs from "node:fs";

function log(msg: string) {
  process.stdout.write(`[deploy-localnet] ${msg}\n`);
}

async function run(cmd: string, args: string[], cwd?: string) {
  log(`$ ${cmd} ${args.join(" ")}`);
  await execa(cmd, args, { cwd, stdio: "inherit" });
}

async function main() {
  const repoRoot = process.cwd();
  const cfgDir = path.join(repoRoot, "configs", "localnet");

  const airdrop = path.join(cfgDir, "airdrop.sh");
  const deployPrograms = path.join(cfgDir, "deploy-programs.sh");

  if (!fs.existsSync(airdrop) || !fs.existsSync(deployPrograms)) {
    throw new Error("Missing localnet scripts in configs/localnet");
  }

  await run("bash", [airdrop]);
  await run("bash", [deployPrograms]);

  log("Localnet deployment done.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
