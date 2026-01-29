export const EXPECTED_HEADER = [
  "className",
  "numberOfAttributes",
  "numberOfMethods",
  "loc"
];

export function isExpectedHeaderRow(row) {
  if (!Array.isArray(row)) return false;
  if (row.length < EXPECTED_HEADER.length) return false;
  return EXPECTED_HEADER.every((col, i) => row[i] === col);
}
