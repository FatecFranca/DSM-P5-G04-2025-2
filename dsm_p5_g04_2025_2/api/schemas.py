from pydantic import BaseModel
from datetime import date
from typing import Optional

class FormBase(BaseModel):
    Idade: int
    Genero: str
    Pais: str
    xicarasDiaCafe: int
    cafeinaEstimada: float
    horasSono: float
    qualidadeDeSono: int
    IMC: float
    frequenciaCardio: int
    problemasDeSaude: str
    atvFisicaSemanalHrs: float
    Ocupacao: str
    Fuma: bool
    Alcool: bool

class FormCreate(FormBase):
    pass

class Form(FormBase):
    Id_form: int
    Id_usuario: int

    class Config:
        orm_mode = True

class UsuarioBase(BaseModel):
    Nome: str
    CPF: str
    Email: str
    Cep: str
    data_nasc: date

class UsuarioCreate(UsuarioBase):
    Senha: str

class Usuario(UsuarioBase):
    Id_usuario: int
    form: list[Form] = []

    class Config:
        orm_mode = True
