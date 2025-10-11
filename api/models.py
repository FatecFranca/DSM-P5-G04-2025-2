from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Integer, String, Date, Float, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
import bcrypt

db = SQLAlchemy()

class Usuario(db.Model):
    __tablename__ = 'Usuario'
    Id_usuario = Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    Nome = Mapped[str] = mapped_column(String(100), nullable=False)
    CPF = Mapped[str] = mapped_column(String(14), unique=True, nullable=False)
    Email = Mapped[str] = mapped_column("E-mail", String(100), unique=True, nullable=False)
    Senha = Mapped[str] = mapped_column(String(255), nullable=False)
    Cep = Mapped[str] = mapped_column(String(9), nullable=False)
    data_nasc = Mapped[Date] = mapped_column(Date, nullable=False)

    forms = relationship("Form", back_populates="usuario")

    def set_password(self, password):
        self.Senha = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    def check_password(self, password):
        return bcrypt.checkpw(password.encode('utf-8'), self.Senha.encode('utf-8'))

class Form(db.Model):
    __tablename__ = 'Form'
    Id_form = Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    Id_usuario = Mapped[int] = mapped_column(Integer, ForeignKey('Usuario.Id_usuario'), nullable=False)
    Idade = Mapped[int] = mapped_column(Integer)
    Genero = Mapped[str] = mapped_column(String(50))
    Pais = Mapped[str] = mapped_column("País", String(50))
    xicarasDiaCafe = Mapped[int] = mapped_column(Integer)
    cafeinaEstimada = Mapped[int] = mapped_column(Integer)
    horasSono = Mapped[int] = mapped_column(Integer)
    qualidadeDeSono = Mapped[int] = mapped_column(Integer)
    IMC = Mapped[float] = mapped_column(Float)
    frequenciaCardio = Mapped[int] = mapped_column(Integer)
    problemasDeSaude = Mapped[str] = mapped_column("problemasDeSaude", String(100))
    atvFisicaSemanalHrs = Mapped[int] = mapped_column(Integer)
    Ocupacao = Mapped[str] = mapped_column(String(100))
    Fuma = Mapped[str] = mapped_column(String(10))
    Alcool = Mapped[str] = mapped_column(String(10))

    usuario = relationship("Usuario", back_populates="forms")
