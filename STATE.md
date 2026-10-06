# Estado del Proyecto: Semilla Hito 0

Este archivo es el tablero de trabajo de la plantilla. `Hito 0` describe el estado del molde; `.agents/project-profile.conf` es el marcador legible por scripts que distingue semilla de aplicación inicializada.

## Fase actual: Hito 0 — Plantilla agnóstica

- **Estado:** Semilla lista para inicializar proyectos; este repositorio sigue siendo el molde maestro.
- **Perfil:** `phase=seed` (sin stack ni dominio de aplicación seleccionados).
- **Especificación de mantenimiento:** [`specs/seed-004-prompt-maestro-continuidad.md`](specs/seed-004-prompt-maestro-continuidad.md) — implementada. Seeds 001–003 completadas.
- **Última verificación completada:** Seed 004: contrato del gate 13/13, sintaxis Bash y `./scripts/verify.sh` (salida 0); revisión staged de formato con excepción de línea vacía final en ADR 0001 inmutable, documentada en la spec. Valida la semilla; no se generó ni desplegó una aplicación. Evidencia documental y aprendizaje en Seed 004; las anteriores conservan su evidencia.

## Registro de hitos

- [x] **Hito -1: Blueprint inicial** — gobernanza SDD/ADR, entrevista Hito 0 y quality gate semilla.
- [x] **Hito 0: Núcleo neutral y perfiles** — desacople de stack, entrevista adaptativa, plantillas condicionales, perfil explícito y gate por fase. Verificación estructural superada; todavía no existe una aplicación inicializada en este repositorio.
- [x] **Hito 0: Recomendaciones por despliegue** — catálogo opcional VPS, Cloudflare, Cloud Run y personalizado; selección y generación según requisitos y confirmación en entrevista.
- [ ] **Hito 0 de una aplicación derivada:** pendiente. Se inicia en un repositorio creado desde esta plantilla con `Inicia Hito 0`.
- [ ] **Hito 1:** primera spec de producto en el repositorio derivado.

## Registro de tareas recientes

| Fecha | Autor | Acción | Resultado |
|---|---|---|---|
| 2026-10-03 | Antigravity | Inicializó el blueprint agnóstico | Semilla vinculada a GitHub |
| 2026-10-06 | Codex | Separó gobernanza común de perfiles de aplicación | Contrato de gate: 9/9; gate semilla y revisión de whitespace: salida 0 |
| 2026-10-06 | Codex | Incorporó recomendaciones de stack por destino al bootstrap | Cinco escenarios revisados documentalmente; gate semilla y whitespace: salida 0 |
| 2026-10-06 | Codex | Añadió oferta de SQLite y PostgreSQL según alcance en entrevista | Cuatro escenarios revisados documentalmente; gate semilla y whitespace: salida 0 |

## Checkpoint del molde

- **Meta de mantenimiento:** preparar prompt maestro, delegación y continuidad; criterios Seed 004 verificados.
- **Commit de cierre:** consolidación Seeds 001–004, identificable por `feat(seed): incorporar prompt maestro y continuidad por specs`; comprobar `git log -1` y `git status` al reanudar. Si no existe, cierre Git pendiente.
- **Siguiente paso:** crear un repositorio derivado e iniciar Hito 0. La entrevista generará el prompt de esa app; no existe una goal de producto en el molde.
- **Continuidad:** aprendizaje de mantenimiento en Seed 004; `/learn` y `/compact` no ejecutados en esta sesión. El usuario puede compactar después del cierre y retomar desde estos archivos.
- **Pendiente de evidencia:** una app derivada que complete entrevista, sellado y desarrollo; las pruebas del despachador no sustituyen esa validación.
