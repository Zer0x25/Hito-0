# Hito 0 — Semilla agnóstica para proyectos guiados por agentes

Hito 0 ofrece un flujo de constitución para acordar el propósito, las decisiones arquitectónicas y los límites de trabajo antes de desarrollar una aplicación. Su núcleo no selecciona un dominio, lenguaje, runtime, framework, transporte, base de datos ni proveedor de CI.

## Crear un proyecto

1. En GitHub usa **Use this template** para crear un repositorio propio y clónalo.
2. Abre el repositorio clonado en tu entorno de desarrollo.
3. Activa el hook local con `./scripts/install-hooks.sh`.
4. En el chat del agente, escribe `Inicia Hito 0`.

El repositorio maestro está protegido por una comprobación del remoto canónico. La carpeta por sí sola no determina si se trabaja en el molde maestro.

## Qué ocurre en Hito 0

El agente guía una entrevista adaptativa de hasta dos preguntas por turno. Recoge el problema, actores y flujos, reglas críticas, superficies de aplicación, stack y restricciones, y necesidades operativas pertinentes. Cada dato queda marcado como confirmado, supuesto, pendiente o no aplicable. Las decisiones arquitectónicas se presentan para confirmación antes de aceptarlas.

Luego se genera la arquitectura del proyecto en `docs/adr/0002-arquitectura-base.md`, el perfil en `.agents/project-profile.conf`, una plantilla SDD adecuada al proyecto y el andamiaje mínimo elegido. Las herramientas, carpetas y comandos se crean según el perfil; la plantilla no obliga a usar TypeScript, Node, Zod, HTTP o npm.

### Del Hito 0 a una app completa

La entrevista confirma un **PRD breve** con alcance, exclusiones, requisitos y aceptación final, junto con DoD y autonomía. Genera `PRD.md` desde [su plantilla](.agents/prd.template.md) y **`PROMPT-MAESTRO.md`** desde [la plantilla de inicio](.agents/master-prompt.template.md). El prompt referencia el PRD; AGENTS contiene reglas y DoD; STATE registra cobertura y avance. El sellado archiva el bootstrap y deja Hito 1 preparado cuando pasa el gate de inicialización.

Para iniciar la primera interacción de desarrollo, escribe:

> Lee y ejecuta PROMPT-MAESTRO.md para iniciar Hito 1; crea o retoma la goal de entrega definida allí y sigue el ciclo por specs de AGENTS.md.

El agente divide los requisitos del PRD en specs SDD con escenarios BDD pertinentes (Dado/Cuando/Entonces), los acepta dentro de la delegación y usa pruebas antes de implementar. Cucumber no es obligatorio. Cada spec cierra al cumplir aceptación y DoD, con aprendizaje, estado y commit autorizado; luego se prepara la compactación acordada. La app cierra con evidencia de todo el PRD y flujos integrados.

Para evitar repetición improductiva, cada intento sobre un fallo tiene hipótesis y evidencia. La entrevista confirma un umbral positivo de intentos sin progreso (referencia: tres); al alcanzarlo se conserva el checkpoint y se solicita una intervención concreta. Compactar no reinicia el contador. El agente no amplía el alcance ni reduce pruebas o DoD para terminar. Los ADR registran decisiones significativas; las mejoras opcionales quedan para una entrega futura.

La continuidad se apoya en archivos del repo. `/learn` se usa si el entorno lo ofrece y su alcance está autorizado; no se presupone un comando universal. `/compact` depende de la interfaz: si es manual, el agente entrega un checkpoint para ejecutarlo. Sin herramientas de goals o compactación, STATE permite retomar la meta. Referencias de capacidades, consultadas el 2026-10-06: [comandos de Codex](https://learn.chatgpt.com/docs/developer-commands?surface=cli) y [goals](https://developers.openai.com/cookbook/examples/codex/using_goals_in_codex).

## Recomendaciones por destino de despliegue

La entrevista consulta el [catálogo de stacks](.agents/stack-presets.md) después de conocer el producto, el equipo y las restricciones. Propone una base coherente y explica sus compromisos antes de pedir confirmación:

| Perfil | Base propuesta para web/API |
|---|---|
| VPS | Node LTS + TypeScript + Fastify, React + Vite si hay SPA, SQLite o PostgreSQL según alcance, Docker Compose + Caddy |
| Cloudflare | TypeScript + Hono, Workers + Static Assets, React + Vite si hay SPA, D1 si encaja; KV según necesidad y tolerancia a consistencia eventual |
| Google Cloud Run | Backend Node LTS + TypeScript + Fastify en contenedor, SPA si aplica, PostgreSQL administrado y almacenamiento externo según necesidad |
| Personalizado | Otra combinación elegida según superficies, requisitos y experiencia del equipo |

Cloudflare incluye la variante Pages. SSR, API sin interfaz, procesos batch y equipos con otros lenguajes ajustan la recomendación. La entrevista comprueba documentación vigente y registra el stack aceptado, componentes, destino, fuentes y operación en ADR 0002. Las recomendaciones no crean infraestructura ni instalan dependencias por sí solas.

En el bloque de persistencia la entrevista siempre presenta **SQLite y PostgreSQL**, recomienda según concurrencia de escrituras, instancias, consultas y operación, y confirma la elección. Si no hacen falta datos duraderos, registra persistencia como no aplicable. La viabilidad de cada opción se evalúa en el destino elegido.

## Principios que entrega la semilla

- **PRD:** fuente única del alcance y aceptación del producto.
- **SDD + BDD:** specs acotadas con ejemplos de comportamiento vinculados a pruebas.
- **DoD:** condiciones comunes de calidad y cierre adaptadas al perfil.
- **ADRs append-only:** las decisiones aceptadas se conservan; los cambios se registran en ADR nuevos enlazados.
- **TDD apropiado al proyecto:** el tipo de prueba corresponde a la arquitectura y a los criterios de aceptación.
- **Límites de alcance:** la spec declara archivos editables y protegidos.
- **Verificación reproducible:** `./scripts/verify.sh` valida la semilla o delega al verificador generado para el perfil.
- **Seguridad de datos:** no guardar secretos reales en el repositorio y validar entradas en las fronteras de confianza que defina la arquitectura.

## Organización de la semilla

```text
├── .agents/
│   ├── bootstrap.md                         # Entrevista y generación por perfil
│   ├── stack-presets.md                     # Referencias VPS, Cloudflare, Cloud Run y custom
│   ├── master-prompt.template.md             # Invocación y delegación de Hito 1
│   ├── prd.template.md                       # Alcance y aceptación final
│   ├── project-profile.conf                 # Fase y metadatos no secretos
│   └── examples/node-typescript-api/        # Ejemplo opcional de un perfil
├── .github/workflows/verify.yml             # Comprueba contrato de la semilla
├── .githooks/pre-commit                     # Ejecuta el gate declarado
├── docs/adr/
│   ├── 0000-adopcion-gobernanza-agentica.md # Constitución de gobernanza
│   ├── 0000-template.md                     # Formato ADR
│   ├── 0001-perfiles-y-aplicabilidad.md     # Alcance neutral y perfiles
│   ├── 0003-autonomia-y-continuidad.md      # Delegación; 0002 reservado para producto
│   └── 0004-producto-comportamiento-y-cierre.md # PRD, BDD, DoD y progreso
├── specs/
│   ├── seed-*.md                            # Specs y evidencia de mantenimiento
│   └── templates/feature.template.md        # Base SDD adaptable
├── scripts/
│   ├── install-hooks.sh                     # Activa el hook en el clon local
│   ├── tests/verify-contract.sh             # Prueba el contrato del gate
│   └── verify.sh                            # Despachador de verificación por fase
├── AGENTS.md
├── STATE.md
└── README.md
```

El ADR 0001 explica qué es común y qué depende del perfil. El ADR 0002 se reserva para la arquitectura de la aplicación creada desde la plantilla.

## Trabajo posterior

1. Tras invocar el prompt maestro, crea una spec desde `specs/templates/feature.md`, la plantilla personalizada del proyecto; `feature.template.md` es la base de la semilla.
2. Vincula requisitos del PRD, contratos, escenarios pertinentes, archivos autorizados y pruebas; referencia la DoD común sin copiarla.
3. Ejecuta pruebas primero, implementa dentro del alcance autorizado y corre `./scripts/verify.sh`.
4. Registra resultados y aprendizaje, crea el commit autorizado y prepara el checkpoint para compactar y seguir con la siguiente spec, según AGENTS.

Las specs pueden añadir secciones de permisos, contratos de API, persistencia, ciclo de vida, integraciones, interfaz, migraciones u operación cuando correspondan. No marques secciones irrelevantes como requisitos obligatorios.

## Verificación

En el repositorio semilla, `./scripts/verify.sh` comprueba la presencia de los documentos base. GitHub Actions además prueba el comportamiento del despachador en fases `seed` y `project`.

Después de inicializar una aplicación, el bootstrap genera `scripts/verify-project.sh` y adapta la CI para preparar el runtime elegido. El gate raíz exige el manifiesto, el ADR de arquitectura, la plantilla personalizada, el PRD, el prompt maestro, el registro de aprendizaje y el verificador del proyecto. E2E, seguridad, build y verificaciones operacionales se declaran en el perfil según corresponda.

El hook local se activa por clon con `./scripts/install-hooks.sh`; la CI sigue siendo la verificación compartida del repositorio.
