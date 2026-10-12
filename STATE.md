# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 012 (V5.2)

- Meta: alinear el gate con la política de HITO0_PENDING — cerrar la fricción F-01 del harness-metrics.
- Unidad: [Seed 012](specs/seed-012-gate-pendientes.md), Tier 1; autoridad del usuario «aprobado», 2026-10-12.
- Decisión de diseño: `HITO0_PENDING` sale del patrón de placeholders críticos y pasa a pendiente legítimo rastreado. El gate lo cuenta y advierte por fase (initializing advierte; project advierte + exige registro en STATE o falla; seed no corre). Los demás placeholders `[...]` siguen bloqueando igual (quirúrgico). Sin ADR de proyecto nuevo (espacio 0007+ libre). ADR anteriores intactos.
- Estado: cerrada; CA-1–CA-5 verificados con ciclo rojo→verde a nivel de contrato. F-01 cerrada en harness-metrics. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` salida 0; contrato 94/94 (90 previos + 4 de Seed 012, con rojo confirmado pre-fix volteado a verde); `git diff --check` 0; ADR 0000–0006 intactos.
- Commit: pendiente de autorización del usuario. Probable release V5.2 (commit + tag v5.2.0 + release) tras autorización.
- Siguiente paso: definir próxima fricción/unidad. F-02 (unidades "pendiente de revisión humana" sin mecanismo de cierre) queda como observación. Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
