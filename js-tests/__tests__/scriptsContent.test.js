import fs from "fs";
import path from "path";
import { PHARO_SCRIPTS_DIR } from "../src/paths.js";

function read(name) {
  return fs.readFileSync(path.join(PHARO_SCRIPTS_DIR, name), "utf8");
}

test("Each script starts with TP1 marker comment", () => {
  const scripts = [
    "00-bootstrap.st",
    "01-open-classes-map.st",
    "02-open-functions-map.st",
    "03-open-methods-map.st",
    "04-open-files-map.st",
    "05-export-classes-metrics-to-documents.st"
  ];
  for (const s of scripts) {
    expect(read(s)).toMatch(/"TP1\s*–/);
  }
});

test("Viz scripts call TP1Viz", () => {
  const scripts = [
    "01-open-classes-map.st",
    "02-open-functions-map.st",
    "03-open-methods-map.st",
    "04-open-files-map.st"
  ];
  for (const s of scripts) {
    expect(read(s)).toMatch(/TP1Viz\s+open/);
  }
});

test("Export script calls TP1CSVExporter", () => {
  expect(read("05-export-classes-csv.st")).toMatch(/TP1CSVExporter\s+exportClassesToCSV:/);
});
