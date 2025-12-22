import { execa } from "execa";
import path from "node:path";
import fs from "node:fs";

function log(msg: string) {
  process.stdout.write(`[localnet] ${msg}\n`);
}

async function run(cmd: string, args: string[], cwd?: string) {
  log(`$ ${cmd} ${args.join(" ")}`);
  await execa(cmd, args, { cwd, stdio: "inherit" });
}

async function main() {
  const repoRoot = process.cwd();
  const cfgDir = path.join(repoRoot, "configs", "localnet");

  const validatorScript = path.join(cfgDir, "solana-validator.sh");
  if (!fs.existsSync(validatorScript)) {
    throw new Error("configs/localnet/solana-validator.sh not found");
  }

  log("Starting localnet validator (foreground). Use another terminal for deploy.");
  await run("bash", [validatorScript]);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
