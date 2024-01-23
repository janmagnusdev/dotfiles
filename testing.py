import pathlib

HOME = pathlib.Path.home()
HERE = pathlib.Path(__file__).parent.resolve()

for p in HERE.glob("**/*"):
    if not p.is_dir():
        print(p.name)