# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 011 (V5.1)

- Meta: aprendizaje auditable del molde — formato canónico de aprendizaje, auditoría del molde (harness-metrics) y ritual de cierre de sesión, todo convención documentada sin código en el gate.
- Unidad: [Seed 011](specs/seed-011-aprendizaje-auditable.md), Tier 1; autoridad del usuario «aprobado», 2026-10-12.
- Decisión de diseño: el derivado no carga con métricas — `docs/harness-metrics.md` vive en el molde y lo escribe el supervisor al auditar un derivado. El ritual de cierre de sesión es opt-in y sin hook (usa `hermes sessions export --format md`, redactado por defecto). El gate nunca lee sesiones ni aprendizaje (CA-4 verificado sobre `verify.sh`; las menciones previas de `learning.md` en scope/structure son controles estructurales, no dependencia de contenido). Sin ADR de proyecto nuevo (espacio 0007+ libre). ADR anteriores intactos.
- Estado: cerrada; CA-1–CA-5 verificados. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` salida 0; contrato 90/90 (sin cambios de comportamiento); `git diff --check` 0; ADR 0000–0006 intactos.
- Primeras entradas de harness-metrics: F-01 contradicción gate↔HITO0_PENDING (media, candidata a seed futura) y F-02 unidades "pendiente de revisión humana" sin mecanismo de cierre explícito (baja, observación), ambas con evidencia del derivado GYM-2026.
- Commit: pendiente de autorización del usuario.
- Siguiente paso: investigar V5.2 (alinear gate↔HITO0_PENDING u otra fricción a definir con el usuario). Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
