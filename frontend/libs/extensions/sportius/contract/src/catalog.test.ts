import { describe, expect, it } from 'vitest';
import { roleCatalog } from './index.js';

describe('roleCatalog', () => {
  it('uses unique stable codes and localisation keys', () => {
    const ids = roleCatalog.map((role) => role.id);
    expect(new Set(ids).size).toBe(ids.length);
    expect(roleCatalog.every((role) => role.labelKey.startsWith('sportius.role.'))).toBe(true);
  });

  it('keeps the default personal selector compact', () => {
    const defaults = roleCatalog.filter((role) => role.defaultPersonal);
    expect(defaults.length).toBeGreaterThan(0);
    expect(defaults.length).toBeLessThanOrEqual(8);
  });
});
