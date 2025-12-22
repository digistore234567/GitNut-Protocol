import 'dotenv/config';
import { Command } from 'commander';
import { cmdDoctor } from './commands/doctor.js';
import { cmdInit } from './commands/init.js';
import { cmdImport } from './commands/import.js';
import { cmdNormalize } from './commands/normalize.js';
import { cmdBuild } from './commands/build.js';
import { cmdStore } from './commands/store.js';
import { cmdAttest } from './commands/attest.js';
import { cmdAnchor } from './commands/anchor.js';
import { cmdPublish } from './commands/publish.js';
import { cmdVerify } from './commands/verify.js';

const program = new Command();

program
  .name('gitnut')
  .description('GitNut CLI')
  .version('0.1.0');

cmdDoctor(program);
cmdInit(program);
cmdImport(program);
cmdNormalize(program);
cmdBuild(program);
cmdStore(program);
cmdAttest(program);
cmdAnchor(program);
cmdPublish(program);
cmdVerify(program);

program.parseAsync(process.argv);
