from flask import Flask, render_template, flash, redirect, request, json, send_from_directory

from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from datetime import datetime
import os

from config import Config as config

app = Flask(__name__)
app.config.from_object(config)

with app.app_context():
    db = SQLAlchemy(app)
    db.create_all()

login_manager = LoginManager(app)
login_manager.login_view = '/login'

from data import PR, User, create_db

# Init user table if it doesn't exist
with app.app_context():
    try:
        User.query.all()
    except:
        print("Data base does not exist, creating a new one")
        create_db()

import migrate
migrate.do_migrations()

from users import users_page
app.register_blueprint(users_page)

from admin import admin_page
app.register_blueprint(admin_page)

from login import login_page
app.register_blueprint(login_page)

@app.route('/')
@app.route('/index')
def index():
    return render_template("pr.html", pr_time = config.PR_TIME, pr_fetch_time = config.PR_FETCH_TIME)

# Delete old PRs
def pr_cleanup():
    PR.query.filter(PR.end_date < datetime.now()).delete()
    db.session.commit()

# Return a JSON list of PRs to currently be displayed
@app.route("/pr")
def pr():
    pr_cleanup()

    # Check if priority PR exists
    priority = PR.query.filter(PR.priority==1, PR.start_date < datetime.now()).first() 
    if priority != None:
        return json.jsonify(
            { "iframe": priority.is_iframe,
              "link": priority.file_name if priority.is_iframe else "/img/" + priority.file_name}
        )

    # Return all active PRs
    return json.jsonify(
        [{"iframe": user.is_iframe,
          "link": user.file_name if user.is_iframe else "/img/" + user.file_name
         }
            for user in PR.query.filter(PR.start_date < datetime.now()).all()]
        )

@app.route('/img/<path:path>')
def static_pr(path):
    return send_from_directory(config.UPLOAD_FOLDER, path)
