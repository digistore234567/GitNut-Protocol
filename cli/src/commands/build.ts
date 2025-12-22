import { Command } from 'commander';

export function cmdBuild(program: Command) {
  program
    .command('build')
    .description('No-op placeholder: build happens in the worker pipeline')
    .action(async () => {
      process.stdout.write('Build is executed by the worker pipeline.\n');
    });
}
