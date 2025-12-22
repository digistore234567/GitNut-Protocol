import hashlib
import json
import os
import sys
import time
import click

def sha256_file(path: str) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while True:
            b = f.read(1024 * 1024)
            if not b:
                break
            h.update(b)
    return h.hexdigest()

@click.command()
@click.option("--path", "path_", required=True, help="Path to file")
def main(path_: str):
    if not os.path.exists(path_):
        print("File not found", file=sys.stderr)
        sys.exit(2)

    out = {
        "path": os.path.abspath(path_),
        "sha256": sha256_file(path_),
        "ts": time.time(),
    }
    print(json.dumps(out, indent=2))

if __name__ == "__main__":
    main()
