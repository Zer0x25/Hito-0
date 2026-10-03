# Blueprint Agnóstico — Hito 0 (Template Repo)

> **Semilla de Gobernanza Agéntica Agnóstica** diseñada para el desarrollo de software de alta fidelidad con agentes autónomos (Google Antigravity, Claude Code, Cursor, Roo Code, etc.). Basado en **Spec-Driven Development (SDD)**, **Architecture Decision Records (ADR)**, **Agentic TDD** y **Quality Gates Deterministas**.

---

## 💡 ¿Por qué existe este Blueprint?

En el desarrollo de software asistido por IA, la premisa fundamental es:
> *Un agente sin especificaciones formales alucina, improvisa dependencias y degrada la arquitectura. El humano diseña contratos, restricciones e invariantes; el agente implementa y valida contra esas restricciones.*

Este repositorio sirve como **plantilla inicial (Template Repo)** para cualquier nuevo proyecto. En lugar de configurar manualmente linters, tipados, carpetas y reglas cada vez, este repositorio empaqueta el **Hito 0 (Bootstrap Constitucional)**: una entrevista técnica interactiva guiada por el agente para compilar automáticamente la arquitectura, las invariantes y los mecanismos de control.

---

## 🚀 Cómo iniciar un nuevo proyecto (Flujo de 3 Pasos)

### 1. Crear nuevo repositorio desde la Plantilla
- En GitHub o GitLab, utiliza este repositorio como **Template** (`Use this template`).
- Asigna el nombre de tu nuevo proyecto y clónalo en tu entorno local.

### 2. Abrir en tu Entorno Agéntico
- Abre la carpeta del proyecto en **Antigravity IDE** (o tu arnés agéntico preferido).

### 3. Ejecutar el Protocolo de Hito 0
En la consola de chat del agente, simplemente escribe:
```text
Inicia Hito 0
```
*(O de forma explícita: `"Ejecuta el protocolo en .agents/bootstrap.md"`)*.

---

## 🎙️ ¿Qué sucede durante el Hito 0?

El agente asumirá el rol de **Principal Software Architect** y te guiará en una entrevista breve (máximo 2 preguntas por turno en lenguaje claro) cubriendo 4 dimensiones:

```mermaid
flowchart TD
    A[Usuario: 'Inicia Hito 0'] --> B[Agente: Principal Architect]
    B --> C1[Dimensión 1: Dominio y Actores]
    C1 --> C2[Dimensión 2: Invariantes Críticas y Negativas]
    C2 --> C3[Dimensión 3: Stack Tecnológico y Persistencia]
    C3 --> C4[Dimensión 4: Restricciones y Prácticas Prohibidas]
    C4 --> D[Compilación Constitucional Autónoma]
    D --> E1[docs/adr/0001-arquitectura-base.md]
    D --> E2[AGENTS.md actualizado con Quality Gate]
    D --> E3[STATE.md actualizado a Hito 1]
    D --> E4[specs/templates/feature.md personalizada]
    D --> E5[Andamiaje base: package.json, linter, tests]
    D --> F[Listo para Hito 1: Primer Feature Spec]
```

### Artefactos Gestionados y Generados:
| Artefacto | Rol y Propósito |
| :--- | :--- |
| [`docs/adr/0001-arquitectura-base.md`](file://docs/adr/0001-arquitectura-base.md) | Registra el stack tecnológico y las decisiones arquitectónicas como memoria inmutable. |
| [`AGENTS.md`](file://AGENTS.md) | Reglas de gobernanza universales y obligatorias para cualquier arnés de IA. |
| [`STATE.md`](file://STATE.md) | Tablero de control y memoria de estado persistente entre sesiones de trabajo. |
| [`specs/templates/feature.md`](file://specs/templates/feature.md) | Plantilla SDD adaptada con los actores, vocabulario e invariantes de tu negocio. |
| **Andamiaje de Configuración** | Configuración de dependencias base (`package.json`, `tsconfig.json`) y suite de tests. |

---

## 📁 Estructura del Repositorio

```text
├── .agents/
│   └── bootstrap.md            # Motor del Hito 0: Protocolo de entrevista constituyente
├── docs/
│   └── adr/
│       ├── .gitkeep
│       └── 0000-template.md    # Plantilla estándar para futuros ADRs
├── specs/
│   ├── .gitkeep
│   └── templates/
│       ├── .gitkeep
│       └── feature.template.md # Plantilla base de Spec-Driven Development (SDD)
├── src/
│   ├── core/                   # Núcleo compartido (DB, loggers, middlewares)
│   └── modules/                # Dominios verticales cerrados
├── tests/
│   └── modules/                # Pruebas unitarias/integración por módulo
├── scripts/
│   ├── .gitkeep
│   └── verify.sh               # Script de Quality Gate determinista (código 0 o 1)
├── .gitignore                  # Exclusiones estándar para desarrollo limpio
├── AGENTS.md                   # Reglas maestras de gobernanza universales
├── STATE.md                    # Tablero de control de estado del proyecto
└── README.md                   # Este documento
```

---

## 🔄 Flujo de Trabajo en el Día a Día (Hito 1 en adelante)

Una vez completado el Hito 0, tu interacción con el agente se vuelve determinista y sin fricción de sintaxis manual:

1. **Creación del Requerimiento:**
   Copias [`specs/templates/feature.md`](file://specs/templates/feature.md) a `specs/feat-001-<modulo>.md` y completas:
   - Alcance y límites de archivos permitidos/protegidos.
   - Contratos de entrada y salida (Zod Schemas).
   - Invariantes de negocio (garantías positivas y prohibiciones duras).
   - Criterios de aceptación (Definition of Done).

2. **Entrega al Agente:**
   > *"Implementa la especificación en `specs/feat-001-<modulo>.md`"*

3. **Ciclo Agentic TDD:**
   - El agente genera primero las pruebas unitarias que satisfacen los criterios de aceptación (**Fase Roja**).
   - Implementa el código de producción mínimo en los archivos autorizados (**Fase Verde**).
   - Ejecuta `./scripts/verify.sh` en un bucle cerrado de autocorrección hasta que linters, tipos y tests devuelvan **código de salida 0**.
   - Actualiza [`STATE.md`](file://STATE.md) con el nuevo estado del proyecto.

---

## 🛡️ Verificación Determinista (Quality Gate)

Puedes ejecutar la barrera de calidad en cualquier momento con:
```bash
./scripts/verify.sh
```

El script verificará:
1. En **Hito 0**: Integridad de todos los archivos y plantillas del blueprint.
2. En **Hito 1+**: `typecheck` (tipado estricto), `lint` (estilo estático) y `test` (100% pruebas aprobadas).
