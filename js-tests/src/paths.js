import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const REPO_ROOT = path.resolve(__dirname, "..", "..");
export const PHARO_SCRIPTS_DIR = path.join(REPO_ROOT, "pharo", "scripts");

export const SCRIPTS = [
  "00-bootstrap.st",
  "01-open-classes-map.st",
  "02-open-functions-map.st",
  "03-open-methods-map.st",
  "04-open-files-map.st",
  "05-export-classes-metrics-to-documents.st"
];
