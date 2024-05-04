import os
curdir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SECRET_KEY = os.environ["SECRET_KEY"]
    MAX_CONTENT_LENGTH = int(os.getenv("MAX_CONTENT_LENGTH", 5 * 1024 * 1024))
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URI",
        "sqlite:///" + os.path.join(curdir, "db.db"),
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    UPLOAD_FOLDER = os.getenv("UPLOAD_FOLDER", os.path.join(curdir, "static", "pr"))
    ALLOWED_EXTENSIONS = set(
        os.getenv("ALLOWED_EXTENSIONS", "png,jpg,jpeg,mp4,gif,webp").split(",")
    )
    # Time for each PR in seconds
    PR_TIME = int(os.getenv("PR_TIME", 30))
    # How often the PR list is fetched
    PR_FETCH_TIME = int(os.getenv("PR_FETCH_TIME", 120))
