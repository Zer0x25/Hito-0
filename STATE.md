# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 013 (V5.3)

- Meta: protocolo de preparación de capa — system design (ADR técnico) validado por el humano antes de tocar una capa nueva; cierra la fricción F-03.
- Unidad: [Seed 013](specs/seed-013-preparacion-capa.md), Tier 1; autoridad del usuario «aprobado», 2026-10-12.
- Decisión de diseño: el ciclo de una unidad dice *qué* hacer; este protocolo dice *cómo preparar la siguiente* cuando toca UI/frontend/offline. Si no hay ADR de system design de la capa, el agente lo escribe, lo presenta al humano (propone/valida) y recién implementa; la lógica de negocio y autorización quedan SOLO en backend; el ADR es reutilizable entre módulos. Es guía/secuencia, no toca el gate. Sin ADR de proyecto nuevo (espacio 0007+ libre). ADR anteriores intactos.
- Estado: cerrada; CA-1–CA-5 verificados. F-03 cerrada en harness-metrics. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` salida 0; contrato 94/94 (sin cambios de comportamiento); `git diff --check` 0; ADR 0000–0006 intactos.
- Nota de supervisión: GYM-2026 permanece en V5.0 por diseño — no se le empujan los fixes del molde; las fricciones se aprenden sobre su base congelada.
- Commit: pendiente de autorización del usuario. Probable release V5.3 (commit + tag v5.3.0 + release) tras autorización.
- Siguiente paso: definir próxima fricción/unidad. F-02 (revisiones humanas sin mecanismo de cierre) sigue como observación. Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
