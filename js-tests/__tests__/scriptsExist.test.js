import fs from "fs";
import path from "path";
import { PHARO_SCRIPTS_DIR, SCRIPTS } from "../src/paths.js";

test("All expected Pharo scripts exist", () => {
  for (const s of SCRIPTS) {
    const p = path.join(PHARO_SCRIPTS_DIR, s);
    expect(fs.existsSync(p)).toBe(true);
  }
});
