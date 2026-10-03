#!/usr/bin/env bash
# ==============================================================================
# Script de Quality Gate Determinista para Antigravity y Agentes Autónomos
# ==============================================================================
# Este script actúa como barrera inmutable. Si algún paso falla (código != 0),
# la ejecución se detiene de inmediato con salida 1, forzando al agente a autocorregir.
# ==============================================================================

set -euo pipefail

# Colores para salida de terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   QUALITY GATE DETERMINISTA - VERIFICACIÓN DE REPO   ${NC}"
echo -e "${BLUE}======================================================${NC}"

# Si el repositorio aún está en fase inicial (Hito 0 previo a andamiaje)
if [ ! -f "package.json" ]; then
  echo -e "${YELLOW}[AVISO] No se detectó 'package.json'.${NC}"
  echo -e "${YELLOW}El repositorio se encuentra en estado de semilla (Hito 0).${NC}"
  echo -e "${YELLOW}Ejecuta el protocolo de entrevista en '.antigravity/bootstrap.md' para compilar la arquitectura inicial.${NC}"
  echo -e "${GREEN}Verificación estructural preliminar: APROBADA (Semilla lista).${NC}"
  exit 0
fi

# 1. Chequeo de Tipos Estricto
echo -e "\n${BLUE}--> [Paso 1/3] Verificación de Tipos (Typecheck)...${NC}"
if npm run typecheck; then
  echo -e "${GREEN}✓ Typecheck superado sin errores.${NC}"
else
  echo -e "${RED}✗ Error en Typecheck. Corrige los tipos antes de continuar.${NC}"
  exit 1
fi

# 2. Análisis Estático y Linter
echo -e "\n${BLUE}--> [Paso 2/3] Análisis Estático (Linter)...${NC}"
if npm run lint; then
  echo -e "${GREEN}✓ Linter superado sin advertencias críticas.${NC}"
else
  echo -e "${RED}✗ Error de Linter. Corrige el formato o las reglas violadas.${NC}"
  exit 1
fi

# 3. Suite de Pruebas Automatizadas
echo -e "\n${BLUE}--> [Paso 3/3] Suite de Pruebas (Tests)...${NC}"
if npm test; then
  echo -e "${GREEN}✓ Todos los tests pasaron exitosamente (100%).${NC}"
else
  echo -e "${RED}✗ Pruebas fallidas. El código no satisface los criterios de aceptación.${NC}"
  exit 1
fi

echo -e "\n${GREEN}======================================================${NC}"
echo -e "${GREEN}   ✓ QUALITY GATE CUMPLIDO: CÓDIGO DE SALIDA 0        ${NC}"
echo -e "${GREEN}======================================================${NC}"
exit 0
