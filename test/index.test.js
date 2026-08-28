import test from 'node:test';
import assert from 'node:assert/strict';
import { health } from '../src/index.js';

test('health returns an ok status', () => {
  assert.deepEqual(health(), { status: 'ok' });
});
