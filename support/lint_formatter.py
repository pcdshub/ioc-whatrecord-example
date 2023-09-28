import json
import subprocess
import sys

import apischema
import whatrecord.shell


last_hash = subprocess.check_output("git rev-parse HEAD", shell=True).decode("utf-8").strip()


ioc = apischema.deserialize(whatrecord.shell.LoadedIoc, json.load(sys.stdin))
for line in ioc.script.lines:
    if line.error and line.context:
        first_line = line.error.splitlines()[0].rstrip()
        ctx = line.context[-1]
        print(f"{ctx.name}: line {ctx.line}, col 1, Error - {last_hash} {first_line} (unknown)")
