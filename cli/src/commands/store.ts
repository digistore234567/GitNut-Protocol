import { Command } from 'commander';

export function cmdStore(program: Command) {
  program
    .command('store')
    .description('No-op placeholder: store happens in the worker pipeline')
    .action(async () => {
      process.stdout.write('Store is executed by the worker pipeline.\n');
    });
}
