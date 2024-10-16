from tv import app, db
from sqlalchemy import text
import os
import re
import importlib

def ensure_migration_table():
    with app.app_context():
        table = db.session.execute(text("SELECT name FROM sqlite_master WHERE type='table' AND name='migration'"))
        if len(table.fetchall()) != 1:
            print("Creating migration table")
            db.session.execute(text("CREATE TABLE IF NOT EXISTS migration ("
                "id INTEGER PRIMARY KEY CHECK (id = 0),"
                "version INTEGER"
            ")"))
            db.session.execute(text("INSERT INTO migration (id, version) VALUES (0, 0)"))
        db.session.commit()

def get_migration_version():
    ensure_migration_table()
    with app.app_context():
        version = db.session.execute(text("SELECT version FROM migration")).fetchall()[0][0]
        db.session.commit()
        return version

def set_migration_version(version):
    ensure_migration_table()
    with app.app_context():
        db.session.execute(text(f"UPDATE MIGRATION SET version = {version}"))
        db.session.commit()

def do_migrations():
    # only consider files of form N-name.py where N is a number and name is non-whitespace
    pyfiles = filter(lambda x: re.match(r"^(\d+)-\S+\.py$", x), os.listdir("migrations"))
    # group number with filepath
    pyfiles = [(f, int(f.split("-")[0])) for f in pyfiles]
    # sort by number
    pyfiles = sorted(pyfiles, key=lambda x: x[1])
    print("========================================")
    print("=          Running Migrations          =")
    print("========================================")
    curr_version = get_migration_version()
    for path, n in pyfiles:
        if n <= curr_version:
            print(f"Skipping migration {path}")
            continue

        print(f"Running migration {path}")
        mod = importlib.import_module(f"migrations.{os.path.splitext(path)[0]}")
        mod.upgrade()
        set_migration_version(n)
    print("========================================")
    print("=        Done Running Migrations       =")
    print("========================================")
