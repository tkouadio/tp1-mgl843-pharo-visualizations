import { EXPECTED_HEADER, isExpectedHeaderRow } from "../src/csvSchema.js";

test("CSV header schema is stable", () => {
  expect(EXPECTED_HEADER).toEqual([
    "className",
    "numberOfAttributes",
    "numberOfMethods",
    "loc"
  ]);
});

test("Header validator works", () => {
  expect(isExpectedHeaderRow([
    "className",
    "numberOfAttributes",
    "numberOfMethods",
    "loc"
  ])).toBe(true);

  expect(isExpectedHeaderRow(["className", "x"])).toBe(false);
});
