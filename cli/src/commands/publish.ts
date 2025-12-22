import { Command } from 'commander';
import { readEnv } from '../config/env.js';
import { ApiClient } from '../api/client.js';
import { printJson } from '../utils/output.js';

export function cmdPublish(program: Command) {
  program
    .command('publish')
    .description('Convenience alias for enqueueing a pipeline run')
    .requiredOption('--repo <url>', 'Repository URL')
    .requiredOption('--name <name>', 'Project name')
    .option('--ref <ref>', 'Branch or tag')
    .option('--commit <sha>', 'Commit hash')
    .option('--subdir <path>', 'Subdirectory within repo')
    .action(async (opts) => {
      const env = readEnv();
      const api = new ApiClient(env.GITNUT_API_BASE_URL, env.GITNUT_API_TOKEN);
      const res = await api.post('/v1/jobs/pipeline', {
        repoUrl: opts.repo,
        projectName: opts.name,
        ref: opts.ref,
        commit: opts.commit,
        subdir: opts.subdir,
      });
      printJson(res);
    });
}
