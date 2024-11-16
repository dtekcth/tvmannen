from tv import app, db
from sqlalchemy import text

def upgrade():
    with app.app_context():

        db.session.execute(text(f"ALTER TABLE pr ADD COLUMN is_iframe BOOLEAN DEFAULT FALSE"))
        db.session.commit()
