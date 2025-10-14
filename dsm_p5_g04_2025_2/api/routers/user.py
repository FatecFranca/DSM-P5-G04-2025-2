from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from .. import crud, schemas
from ..database import get_db

router = APIRouter(
    prefix="/usuarios",
    tags=["usuarios"],
)

@router.post("/", response_model=schemas.Usuario)
def create_user_endpoint(user: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    db_user_email = crud.get_user_by_email(db, email=user.Email)
    if db_user_email:
        raise HTTPException(status_code=400, detail="Email já cadastrado")
    
    db_user_cpf = crud.get_user_by_cpf(db, cpf=user.CPF)
    if db_user_cpf:
        raise HTTPException(status_code=400, detail="CPF já cadastrado")
        
    return crud.create_user(db=db, user=user)
