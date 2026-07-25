import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const go = readFileSync(resolve(root, 'backend/catalog.go'), 'utf8');
const ts = readFileSync(
  resolve(root, 'frontend/libs/extensions/sportius/contract/src/index.ts'),
  'utf8',
);

function goConstants(typeName) {
  const entries = new Map();
  const expression = new RegExp(
    String.raw`^\s*(\w+)\s+${typeName}\s*=\s*"([^"]+)"`,
    'gm',
  );
  for (const match of go.matchAll(expression)) {
    entries.set(match[1], match[2]);
  }
  return entries;
}

function goCatalog(prefix, constants) {
  const result = [];
  const expression = new RegExp(
    String.raw`\{ID:\s*(\w+),\s*LabelKey:\s*"(sportius\.${prefix}\.[^"]+)"`,
    'g',
  );
  for (const match of go.matchAll(expression)) {
    const id = constants.get(match[1]);
    if (!id) {
      throw new Error(`Go ${prefix} catalogue uses unknown constant ${match[1]}`);
    }
    result.push(`${id}|${match[2]}`);
  }
  return result.sort();
}

function tsCatalog(prefix) {
  const result = [];
  const expression = new RegExp(
    String.raw`\{\s*id:\s*'([^']+)',\s*labelKey:\s*'(sportius\.${prefix}\.[^']+)'`,
    'g',
  );
  for (const match of ts.matchAll(expression)) {
    result.push(`${match[1]}|${match[2]}`);
  }
  return result.sort();
}

for (const [prefix, typeName] of [
  ['sport', 'SportID'],
  ['role', 'RoleID'],
]) {
  const goEntries = goCatalog(prefix, goConstants(typeName));
  const tsEntries = tsCatalog(prefix);
  if (JSON.stringify(goEntries) !== JSON.stringify(tsEntries)) {
    throw new Error(
      `${prefix} catalogue differs between Go and TypeScript\n` +
        `Go: ${goEntries.join(', ')}\nTS: ${tsEntries.join(', ')}`,
    );
  }
}
