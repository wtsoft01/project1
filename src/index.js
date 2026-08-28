export function health() {
  return { status: 'ok' };
}

const entryPoint = process.argv[1]?.replaceAll('\\', '/');
if (entryPoint && import.meta.url.endsWith(entryPoint)) {
  console.log(JSON.stringify(health()));
}
