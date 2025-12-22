export function printJson(obj: any) {
  process.stdout.write(JSON.stringify(obj, null, 2) + '\n');
}
