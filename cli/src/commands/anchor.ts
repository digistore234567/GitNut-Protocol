import { Command } from 'commander';

export function cmdAnchor(program: Command) {
  program
    .command('anchor')
    .description('No-op placeholder: anchor happens in the worker pipeline')
    .action(async () => {
      process.stdout.write('Anchoring is executed by the worker pipeline.\n');
    });
}
