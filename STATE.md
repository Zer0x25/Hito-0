# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 014 (V5.4) — Robustez de base

- Meta: dos robustecimientos de base con evidencia de la auditoría del flujo y del derivado. (1) El gate deja de contradecir la política de Tier 3 (fix F-04). (2) Decisiones transversales obligatorias antes de tocar un dominio (F-05).
- Unidad: [Seed 014](specs/seed-014-robustez-base.md), Tier 1; autoridad del usuario «hazlo», 2026-10-12.
- Decisión de diseño: (1) `verify-scope.sh` reconoce `LIG-*` y verifica el alcance contra las rutas del bloque de STATE (fail-safe); ruta fuera de lista sigue siendo violación y una unidad sin spec ni LIG sigue siendo violación — el fix es quirúrgico, no abre la puerta a commits sin alcance. (2) Errores / tenant-auth / estrategia de tests se cierran una vez por dominio en el ADR base, validadas por el humano y reutilizadas por módulos siguientes; documentado en AGENTS §7 + PROMPT-MAESTRO; el gate no lee ADRs de dominio. Rojo primero (control bloqueante modificado). Sin ADR de proyecto nuevo (espacio 0007+ libre); ADR 0000–0006 intactos.
- Estado: cerrada; CA-1–CA-6 verificados. F-04 y F-05 cerradas en harness-metrics. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` salida 0; contrato 97/97 (BDD-1/2/3 nuevos, 94 previos intactos; BDD-1 RED pre-fix confirmada); `bash -n scripts/verify-scope.sh` OK; `git diff --check` 0; ADR 0000–0006 intactos byte a byte vs v5.2.0.
- Nota de supervisión: GYM-2026 permanece en V5.0 por diseño — no se le empujan los fixes del molde; las fricciones se aprenden sobre su base congelada.
- Commit: pendiente de autorización del usuario. Probable release V5.4 (commit + tag v5.4.0 + release) tras autorización.
- Siguiente paso: definir próxima fricción/unidad. F-02 (revisiones humanas sin mecanismo de cierre) sigue como observación. Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
