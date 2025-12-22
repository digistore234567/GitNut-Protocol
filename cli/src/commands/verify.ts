import { Command } from 'commander';
import { readEnv } from '../config/env.js';
import { ApiClient } from '../api/client.js';
import { printJson } from '../utils/output.js';

export function cmdVerify(program: Command) {
  program
    .command('verify')
    .description('Verify a release by asking the API to validate attestations and hashes')
    .requiredOption('--project-id <uuid>', 'Project ID')
    .requiredOption('--version <v>', 'Version identifier (e.g. commit prefix)')
    .action(async (opts) => {
      const env = readEnv();
      const api = new ApiClient(env.GITNUT_API_BASE_URL, env.GITNUT_API_TOKEN);
      const res = await api.get(`/v1/releases/verify?projectId=${encodeURIComponent(opts.projectId)}&version=${encodeURIComponent(opts.version)}`);
      printJson(res);
    });
}
