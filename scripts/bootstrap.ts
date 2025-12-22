import { execa } from "execa";
import fs from "node:fs";
import path from "node:path";

type Step = {
  name: string;
  run: () => Promise<void>;
};

function log(msg: string) {
  process.stdout.write(`[bootstrap] ${msg}\n`);
}

function ensureFile(src: string, dst: string) {
  if (!fs.existsSync(dst)) {
    fs.copyFileSync(src, dst);
    log(`Created ${dst}`);
  } else {
    log(`Exists  ${dst}`);
  }
}

async function runCmd(cmd: string, args: string[], cwd?: string) {
  log(`$ ${cmd} ${args.join(" ")}`);
  await execa(cmd, args, { stdio: "inherit", cwd });
}

async function main() {
  const repoRoot = process.cwd();
  const steps: Step[] = [
    {
      name: "Verify pnpm workspace",
      run: async () => {
        const pnpmWorkspace = path.join(repoRoot, "pnpm-workspace.yaml");
        if (!fs.existsSync(pnpmWorkspace)) {
          throw new Error("pnpm-workspace.yaml not found. Run from repo root.");
        }
      },
    },
    {
      name: "Install dependencies",
      run: async () => {
        await runCmd("pnpm", ["install", "--frozen-lockfile=false"], repoRoot);
      },
    },
    {
      name: "Seed environment files",
      run: async () => {
        ensureFile(path.join(repoRoot, ".env.example"), path.join(repoRoot, ".env"));
        ensureFile(path.join(repoRoot, ".env.localnet.example"), path.join(repoRoot, ".env.localnet"));
      },
    },
    {
      name: "Build packages",
      run: async () => {
        await runCmd("pnpm", ["-r", "build"], repoRoot);
      },
    },
    {
      name: "Run unit tests",
      run: async () => {
        await runCmd("pnpm", ["test:unit"], repoRoot);
      },
    },
  ];

  for (const step of steps) {
    log(`==> ${step.name}`);
    await step.run();
  }

  log("Bootstrap complete.");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
