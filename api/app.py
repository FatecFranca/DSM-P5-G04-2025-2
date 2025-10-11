from flask import Flask
from flask_bcrypt import Bcrypt
from flask_migrate import Migrate
from config import Config
from models import db
from routes import init_routes

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)
migrate = Migrate(app, db)
bcrypt = Bcrypt(app)

init_routes(app)

if __name__ == '__main__':
    app.run(debug=True)
