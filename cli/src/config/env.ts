import { z } from 'zod';

const Env = z.object({
  GITNUT_API_BASE_URL: z.string().default('http://localhost:8080'),
  GITNUT_API_TOKEN: z.string().optional(),
  SOLANA_RPC_URL: z.string().default('http://127.0.0.1:8899'),
});

export function readEnv() {
  const parsed = Env.safeParse(process.env);
  if (!parsed.success) throw new Error(parsed.error.message);
  return parsed.data;
}
