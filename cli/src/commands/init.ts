import { Command } from 'commander';
import fs from 'node:fs';
import path from 'node:path';

export function cmdInit(program: Command) {
  program
    .command('init')
    .description('Initialize a gitnut.json in the current directory')
    .option('--name <name>', 'Project name', 'my-project')
    .action(async (opts) => {
      const p = path.resolve(process.cwd(), 'gitnut.json');
      if (fs.existsSync(p)) throw new Error('gitnut.json already exists');

      const doc = {
        schema: 'gitnut.project.v1',
        name: String(opts.name),
        createdAt: new Date().toISOString(),
      };

      fs.writeFileSync(p, JSON.stringify(doc, null, 2));
      process.stdout.write(`created ${p}\n`);
    });
}
