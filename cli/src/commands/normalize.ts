import { Command } from 'commander';

export function cmdNormalize(program: Command) {
  program
    .command('normalize')
    .description('No-op placeholder: normalization happens in the worker pipeline')
    .action(async () => {
      process.stdout.write('Normalization is executed by the worker pipeline.\n');
    });
}
