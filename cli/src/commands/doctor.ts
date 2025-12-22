import { Command } from 'commander';
import { readEnv } from '../config/env.js';
import { ApiClient } from '../api/client.js';
import { printJson } from '../utils/output.js';

export function cmdDoctor(program: Command) {
  program
    .command('doctor')
    .description('Check API connectivity and environment')
    .action(async () => {
      const env = readEnv();
      const api = new ApiClient(env.GITNUT_API_BASE_URL, env.GITNUT_API_TOKEN);

      const health = await api.get('/v1/health');
      printJson({ env, health });
    });
}
