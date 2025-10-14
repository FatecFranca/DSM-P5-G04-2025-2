from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Date, Float
from sqlalchemy.orm import relationship

from .database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    Id_usuario = Column(Integer, primary_key=True, index=True)
    Nome = Column(String(100), nullable=False)
    CPF = Column(String(14), unique=True, index=True, nullable=False)
    Email = Column(String(100), unique=True, index=True, nullable=False)
    Senha = Column(String(255), nullable=False)
    Cep = Column(String(9), nullable=False)
    data_nasc = Column(Date, nullable=False)

    form = relationship("Form", back_populates="owner")


class Form(Base):
    __tablename__ = "forms"

    Id_form = Column(Integer, primary_key=True, index=True)
    Idade = Column(Integer)
    Genero = Column(String(50))
    Pais = Column(String(50))
    xicarasDiaCafe = Column(Integer)
    cafeinaEstimada = Column(Float)
    horasSono = Column(Float)
    qualidadeDeSono = Column(Integer)
    IMC = Column(Float)
    frequenciaCardio = Column(Integer)
    problemasDeSaude = Column(String(255))
    atvFisicaSemanalHrs = Column(Float)
    Ocupacao = Column(String(100))
    Fuma = Column(Boolean)
    Alcool = Column(Boolean)
    
    Id_usuario = Column(Integer, ForeignKey("usuarios.Id_usuario"))
    owner = relationship("Usuario", back_populates="form")
