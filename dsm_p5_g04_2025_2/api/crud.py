from sqlalchemy.orm import Session
import bcrypt
from . import models, schemas

def get_user_by_email(db: Session, email: str):
    return db.query(models.Usuario).filter(models.Usuario.Email == email).first()

def get_user_by_cpf(db: Session, cpf: str):
    return db.query(models.Usuario).filter(models.Usuario.CPF == cpf).first()

def create_user(db: Session, user: schemas.UsuarioCreate):
    # Gera o "sal" e cria o hash da senha
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(user.Senha.encode('utf-8'), salt)
    
    db_user = models.Usuario(
        Email=user.Email,
        Nome=user.Nome,
        CPF=user.CPF,
        Cep=user.Cep,
        data_nasc=user.data_nasc,
        Senha=hashed_password.decode('utf-8') # Decodifica para armazenar como string
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user
