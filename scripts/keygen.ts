import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

type KeyPairOut = {
  publicKeyPem: string;
  privateKeyPem: string;
  createdAt: string;
};

function log(msg: string) {
  process.stdout.write(`[keygen] ${msg}\n`);
}

function main() {
  const outDir = process.env.OUT_DIR || "keys";
  const name = process.env.NAME || "gitnut-attestor";
  const target = path.resolve(process.cwd(), outDir);
  fs.mkdirSync(target, { recursive: true });

  log(`Generating Ed25519 keypair: ${name}`);
  const { publicKey, privateKey } = crypto.generateKeyPairSync("ed25519");

  const out: KeyPairOut = {
    publicKeyPem: publicKey.export({ format: "pem", type: "spki" }).toString(),
    privateKeyPem: privateKey.export({ format: "pem", type: "pkcs8" }).toString(),
    createdAt: new Date().toISOString(),
  };

  const pubPath = path.join(target, `${name}.pub.pem`);
  const privPath = path.join(target, `${name}.pkcs8.pem`);
  fs.writeFileSync(pubPath, out.publicKeyPem, "utf-8");
  fs.writeFileSync(privPath, out.privateKeyPem, "utf-8");

  const metaPath = path.join(target, `${name}.json`);
  fs.writeFileSync(metaPath, JSON.stringify({ ...out, privateKeyPem: undefined }, null, 2), "utf-8");

  log(`Wrote: ${pubPath}`);
  log(`Wrote: ${privPath}`);
  log(`Wrote: ${metaPath}`);
  log("Done.");
}

main();
