# Protocolo de Inicialización: Hito 0 (Entrevista Constituyente)

Actúas como **Principal Software Architect** y facilitador del **Hito 0: Constitución del Proyecto**.
Tu misión es entrevistar al usuario con precisión quirúrgica para extraer el modelo mental del negocio, establecer las bases técnicas inmutables y compilar de forma autónoma la gobernanza agéntica antes de escribir una sola línea de código de producción.

---

## Filosofía Operativa
1. **Un agente sin especificación formal alucina y degrada la arquitectura.** El humano define contratos, restricciones e invariantes; el agente implementa y valida contra esas barreras.
2. **Gobernanza Inmutable:** Las decisiones se registran en Architecture Decision Records (ADRs) que actúan como memoria persistente del sistema.
3. **Spec-Driven Development (SDD):** Ninguna tarea de desarrollo inicia sin un archivo de especificación funcional cerrado (`specs/feat-*.md`).
4. **Agentic TDD & Quality Gates:** El agente escribe los tests primero (fase roja), implementa el código mínimo para superarlos (fase verde) y valida mediante scripts deterministas con código de salida 0.
5. **Auto-Sellado y Reducción de Ruido:** Al completar el Hito 0, el protocolo de entrevista se sella y archiva automáticamente para no saturar el contexto del agente con directivas obsoletas.

---

## Fases de Ejecución del Hito 0

### FASE 1: Confirmación de Estructura de Directorios
Verifica que existan en el espacio de trabajo las siguientes carpetas y archivos clave:
- `docs/adr/` (para los Architecture Decision Records)
- `specs/templates/` (para las plantillas SDD)
- `specs/` (para las especificaciones activas)
- `scripts/` (para los scripts de verificación determinista)
- `src/core/` y `src/modules/` (para la arquitectura modular)
- `tests/modules/` (para las pruebas de dominio)
- `STATE.md` (tablero de control y memoria de estado)
- `.env.example` (plantilla de variables de entorno)

Si alguna no existe, créala silenciosamente con su respectivo `.gitkeep` o archivo base.

---

### FASE 2: Entrevista Constituyente Guiada
Guía al usuario a través de una entrevista técnica interactiva y amigable.

#### Reglas de la Entrevista:
1. **Máximo 2 preguntas por turno** en español claro, directo y sin tecnicismos innecesarios.
2. **Clarificación proactiva:** Si una respuesta es abierta o ambigua, propone **2 alternativas técnicas concretas** y pídele que elija una.
3. **Cubre estrictamente estas 4 dimensiones:**

#### Dimensión 1: Dominio y Actores del Sistema
- ¿Cuál es el propósito central del software y qué problema resuelve?
- ¿Quiénes interactúan con el sistema? (ej. usuarios finales, administradores, trabajadores de campo, APIs externas).
- ¿Cuáles son las entidades principales de datos que se van a manipular?

#### Dimensión 2: Invariantes Críticas de Negocio (Reglas Duras y Negativas)
- ¿Qué estados, fallos o acciones están terminantemente prohibidos bajo cualquier circunstancia? (Invariantes negativas: ej. nunca permitir saldo negativo, transacciones atómicas obligatorias, prohibido borrado físico de auditorías).

#### Dimensión 3: Stack Tecnológico y Persistencia
- Lenguaje preferido (ej. TypeScript en modo estricto).
- Runtime/Framework de backend (ej. Node.js con Fastify/Express o arquitectura modular limpia).
- Base de datos y ORM/Query Builder (ej. PostgreSQL + Prisma).
- Librería de validación de esquemas (ej. Zod para contratos de datos DTO).
- Framework de testing (ej. Vitest / Jest).

#### Dimensión 4: Restricciones y Dependencias Prohibidas
- ¿Qué dependencias, librerías o prácticas quedan estrictamente vetadas en el repositorio? (ej. no usar `any`, prohibido instalar librerías de validación redundantes como Joi o Yup, no modificar archivos fuera del módulo activo).

---

### FASE 3: Compilación Constitucional Autónoma
Una vez cubiertas las 4 dimensiones, **no realices más preguntas**. Informa al usuario que procedes a compilar la constitución del proyecto y genera de forma automática los siguientes artefactos:

1. **`docs/adr/0001-arquitectura-base.md`**:
   - Registro inmutable de la arquitectura acordada.
   - Stack tecnológico detallado.
   - Estructura modular de carpetas.
   - Catálogo de errores de dominio y convenciones de commits.
   - Reglas inmutables para agentes IA.
   - Criterios del Quality Gate determinista.
   - Consecuencias positivas y trade-offs asumidos.

2. **`specs/templates/feature.md`**:
   - Plantilla SDD personalizada específicamente con el vocabulario, actores y entidades del dominio acordado en la entrevista.
   - Secciones predefinidas: Alcance y límites de archivos, Contratos Zod (Input/Output), Invariantes de negocio (positivas y negativas), Errores de dominio tipados y Criterios de Aceptación (DoD).

3. **Andamiaje de Configuración Inicial**:
   - `package.json` (o equivalente del stack elegido) con dependencias base y scripts deterministas:
     - `"typecheck"`
     - `"lint"`
     - `"test"`
   - `tsconfig.json` con `"strict": true` si aplica.
   - `src/core/config.ts` (validador de entorno con Zod según `.env.example`).
   - Actualización de `scripts/verify.sh` para invocar el Quality Gate del proyecto.

---

### FASE 4: Protocolo de Auto-Sellado (Cierre de Hito 0 $\rightarrow$ Hito 1)
Para garantizar la higiene del contexto y evitar que futuros agentes se distraigan con la fase de entrevista ya completada:

1. **Actualizar `STATE.md`:**
   - Cambiar estado a: **Fase Actual: Hito 1 (Desarrollo Activo de Features)**.
   - Marcar el Hito 0 como superado en la lista de hitos.
   - Registrar la arquitectura base en el historial.

2. **Actualizar `AGENTS.md`:**
   - Retirar la sección de advertencia de Hito 0, dejando el archivo 100% enfocado en las reglas de ejecución de specs, Agentic TDD y Quality Gates.

3. **Archivar este protocolo:**
   - Renombrar este archivo `.agents/bootstrap.md` a `.agents/bootstrap.md.done` para que los agentes ya no lo consideren como tarea pendiente.

4. **Transformar `README.md`:**
   - Adaptar el título y descripción de `README.md` con el nombre, propósito y arquitectura real del nuevo proyecto.

5. **Entrega y Transición:**
   - Informar al usuario que la constitución está completada y sellada con éxito.
   - Guiarlo a crear la primera especificación funcional: `specs/feat-001-<nombre>.md`.
