#!/bin/bash

echo "Iniciando a API CafeZen..."

# Navega para o diretório da API
# IMPORTANTE: Se o caminho para o projeto na sua VM for diferente, ajuste a linha abaixo.
cd /home/fukuta/DSM-P5-G04-2025-2/api

echo "Executando 'sudo npm run dev'. Por favor, digite sua senha se solicitado."
sudo npm run dev
