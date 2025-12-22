import { Command } from 'commander';

export function cmdAttest(program: Command) {
  program
    .command('attest')
    .description('No-op placeholder: attest happens in the worker pipeline')
    .action(async () => {
      process.stdout.write('Attestation is executed by the worker pipeline.\n');
    });
}
