from fastapi import FastAPI
from .database import engine
from . import models
from .routers import user, form

# Cria as tabelas no banco de dados (se não existirem)
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Inclui os routers (as rotas da API)
# Por enquanto eles estão vazios, vamos preenchê-los em seguida
app.include_router(user.router)
app.include_router(form.router)


@app.get("/")
def read_root():
    return {"message": "Bem-vindo à API CafeZen"}
