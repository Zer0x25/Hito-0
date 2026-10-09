# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 008

- Meta: aplicar auditoría de gobernanza, simplificar operación y reforzar evidencia ejecutable.
- Unidad: [Seed 008](specs/seed-008-gobernanza-verificable.md), Tier 1; autoridad del usuario «aplica las mejoras», 2026-10-09.
- Decisión: [ADR 0006](docs/adr/0006-gobernanza-verificable.md); ADR anteriores intactos.
- Entrega Git: commit, push a origin/main y release con tag v4.0.0 autorizados por el usuario el 2026-10-09. Referencia: commit de Seed 008 `feat(seed): reforzar gobernanza y validacion de Hito 0`. Confirmar HEAD/main remoto/tag y release al concluir; no repetir si ya coinciden.
- Estado: cerrada; CA-1–CA-7 comprobados con los límites documentados en la spec.
- Evidencia: `./scripts/verify.sh`, salida 0; contrato 76/76; piloto con dos interrupciones recuperadas, rojo/verde Tier 2 y Tier 3 y reanudación. Sintaxis, enlaces, alcance, ADR históricos y `git diff --check` correctos.
- Siguiente paso: comprobar entrega de v4.0.0; si está publicada, ninguna unidad activa. En la próxima adopción autorizada, crear un derivado y probar una entrevista real siguiendo docs/seed-upgrades.md; no iniciar ni publicar automáticamente. No repetir Seed 008.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
