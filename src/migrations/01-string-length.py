from tv import app, db
from sqlalchemy import text

def retype(table, column, newtype):
    # sql injection is my passion :) [its ok cause the inputs are just hardcoded constants]
    db.session.execute(text(f"ALTER TABLE {table} ADD COLUMN {column}_new {newtype}"))
    db.session.execute(text(f"UPDATE {table} SET {column}_new = {column}"))
    db.session.execute(text(f"ALTER TABLE {table} DROP COLUMN {column}"))
    db.session.execute(text(f"ALTER TABLE {table} RENAME COLUMN {column}_NEW TO {column}"))


def upgrade():
    with app.app_context():
        db.session.execute(text('DROP INDEX ix_user_username'))

        retype("user", "username", "VARCHAR")
        retype("user", "password_hash", "VARCHAR")
        retype("user", "role", "VARCHAR")

        db.session.execute(text('CREATE UNIQUE INDEX ix_user_username ON user (username)'))

        retype("pr", "desc", "VARCHAR")
        retype("pr", "file_name", "VARCHAR")
        retype("pr", "owner", "VARCHAR")

        db.session.commit()
