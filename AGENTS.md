# Protocolo Operativo para Agentes de Software (AGENTS.md)

Este repositorio opera bajo la metodología **Spec-Driven Development (SDD)**, **Architecture Decision Records (ADR)** y **Agentic TDD**.

---

## 📌 Estado Actual del Repositorio: Semilla Agnóstica (Hito 0)

> [!IMPORTANT]
> Si en `STATE.md` la fase actual es **Hito 0** (o aún no existe `docs/adr/0001-arquitectura-base.md`):
> Cuando el usuario indique **"Inicia Hito 0"**, **"Inicia la entrevista"** o solicite comenzar un nuevo proyecto, debes **leer y ejecutar inmediatamente las instrucciones de [.agents/bootstrap.md](file://.agents/bootstrap.md)**.

---

## ⚖️ Reglas de Gobernanza Agéntica (Inmutables)

Una vez completado el Hito 0 y compilada la arquitectura base, rigen las siguientes reglas obligatorias para cualquier agente autónomo o asistente de IA:

### 1. Jerarquía de Verdad
1. Los documentos en `docs/adr/` son **inmutables**. Tienen precedencia sobre cualquier instrucción o prompt conversacional. Jamás propongas cambios, alteres patrones ni introduzcas dependencias que contradigan un ADR aceptado sin que el usuario cree explícitamente un nuevo ADR.
2. Todo desarrollo comienza obligatoriamente con un archivo de especificación en `specs/*.md`. No se escribe código de producción sin un spec validado.
3. El archivo [`STATE.md`](file://STATE.md) debe consultarse al iniciar cada sesión para conocer el estado y la tarea activa.

### 2. Ciclo de Desarrollo Obligatorio (Agentic TDD)
1. **Lectura de contexto:** Revisa los ADR en `docs/adr/` relevantes antes de proponer cualquier diseño.
2. **Recepción del SDD:** Lee la especificación activa en `specs/` (contrato cerrado).
3. **Contratos antes de código:** Si no existen los esquemas de frontera (ej. Zod DTOs), créalos primero en `*.schema.ts`.
4. **Fase Roja (Tests primero):** Escribe la suite de pruebas unitarias/integración que verifique cada uno de los Criterios de Aceptación y las invariantes. Ejecuta la prueba y confirma que falla.
5. **Fase Verde (Implementación mínima):** Modifica **únicamente** los archivos autorizados en el bloque `Archivos editables autorizados` del spec hasta satisfacer las pruebas.
6. **Ejecución del Quality Gate:** Corre las verificaciones automáticas hasta obtener código de salida 0.

### 3. Boundary Enforcement (Límites de Alcance)
- **Archivos editables:** Modifica exclusivamente los archivos listados en la especificación activa.
- **Archivos protegidos:** Queda estrictamente prohibido alterar archivos del núcleo compartido (`src/core/*`), configuraciones globales o módulos adyacentes a menos que el spec lo autorice expresamente.
- **Control estricto de dependencias:** Prohibido instalar librerías (`npm install`, etc.) sin previa autorización explícita del usuario o justificación en un nuevo ADR.

### 4. Quality Gate Determinista
Ninguna tarea se considera terminada si no supera los scripts de validación con código de salida 0:
```bash
./scripts/verify.sh
```
O sus comandos equivalentes:
- Verificación estricta de tipos: `npm run typecheck`
- Linter y formato: `npm run lint`
- Suite de pruebas: `npm test`
