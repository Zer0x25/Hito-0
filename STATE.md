# Estado del Proyecto: Semilla Hito 0

Este archivo es el tablero de trabajo de la plantilla. `Hito 0` describe el estado del molde; `.agents/project-profile.conf` es el marcador legible por scripts que distingue semilla de aplicación inicializada.

## Fase actual: Hito 0 — Plantilla agnóstica

- **Estado:** Semilla lista para inicializar proyectos; este repositorio sigue siendo el molde maestro.
- **Perfil:** `phase=seed` (sin stack ni dominio de aplicación seleccionados).
- **Especificación de mantenimiento:** [`specs/seed-005-prd-bdd-dod.md`](specs/seed-005-prd-bdd-dod.md) — implementada y verificada. Seeds 001–004 completadas.
- **Última verificación completada:** Seed 005: contrato del gate 16/16, sintaxis Bash, `./scripts/verify.sh` y whitespace (salida 0); escenarios documentales revisados. Valida la semilla; no se generó ni probó una app derivada. Evidencia y aprendizaje en la spec.

## Registro de hitos

- [x] **Hito -1: Blueprint inicial** — gobernanza SDD/ADR, entrevista Hito 0 y quality gate semilla.
- [x] **Hito 0: Núcleo neutral y perfiles** — desacople de stack, entrevista adaptativa, plantillas condicionales, perfil explícito y gate por fase. Verificación estructural superada; todavía no existe una aplicación inicializada en este repositorio.
- [x] **Hito 0: Recomendaciones por despliegue** — catálogo opcional VPS, Cloudflare, Cloud Run y personalizado; selección y generación según requisitos y confirmación en entrevista.
- [x] **Hito 0: Producto, comportamiento y cierre** — PRD como fuente de alcance, BDD dentro de specs, DoD común y política de falta de progreso.
- [ ] **Hito 0 de una aplicación derivada:** pendiente. Se inicia en un repositorio creado desde esta plantilla con `Inicia Hito 0`.
- [ ] **Hito 1:** primera spec de producto en el repositorio derivado.

## Registro de tareas recientes

| Fecha | Autor | Acción | Resultado |
|---|---|---|---|
| 2026-10-03 | Antigravity | Inicializó el blueprint agnóstico | Semilla vinculada a GitHub |
| 2026-10-06 | Codex | Separó gobernanza común de perfiles de aplicación | Contrato de gate: 9/9; gate semilla y revisión de whitespace: salida 0 |
| 2026-10-06 | Codex | Incorporó recomendaciones de stack por destino al bootstrap | Cinco escenarios revisados documentalmente; gate semilla y whitespace: salida 0 |
| 2026-10-06 | Codex | Añadió oferta de SQLite y PostgreSQL según alcance en entrevista | Cuatro escenarios revisados documentalmente; gate semilla y whitespace: salida 0 |
| 2026-10-06 | Codex | Integró PRD, BDD, DoD y detección de repetición improductiva | Contrato 16/16; gate, sintaxis y formato: salida 0 |

## Checkpoint del molde

- **Meta de mantenimiento:** integrar PRD, BDD, DoD y política de falta de progreso; evidencia en Seed 005.
- **Commit de cierre:** Seed 005, identificable por `feat(seed): integrar PRD BDD DoD y control de progreso`; comprobar `git log -1` y `git status` al reanudar. Si no existe, cierre Git pendiente. Push a origin/main autorizado; comprobar igualdad del hash remoto y local antes de informar publicación.
- **Siguiente paso:** crear un repositorio derivado e iniciar Hito 0. La entrevista generará el prompt de esa app; no existe una goal de producto en el molde.
- **Continuidad:** aprendizaje de mantenimiento en Seed 005; `/learn` y `/compact` no ejecutados en esta sesión. El usuario puede compactar después del cierre y retomar desde estos archivos.
- **Pendiente de evidencia:** una app derivada que complete entrevista, sellado y desarrollo; las pruebas del despachador no sustituyen esa validación.
