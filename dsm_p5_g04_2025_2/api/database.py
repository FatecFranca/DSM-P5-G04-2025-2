from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# ATENÇÃO: Substitua com suas credenciais do MySQL
# Formato: "mysql+mysqlconnector://USER:PASSWORD@HOST/DATABASE_NAME"
SQLALCHEMY_DATABASE_URL = "mysql+mysqlconnector://root:password@localhost/cafezen_db"

engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


# Dependency to get a DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
