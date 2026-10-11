# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 009 (V4.1)

- Meta: gobernanza ejecutable — scope-lock y evidencia mecánica en el gate; aclarar ADR del molde vs. proyecto y rol de las seeds.
- Unidad: [Seed 009](specs/seed-009-gobernanza-ejecutable.md), Tier 1; autoridad del usuario «aprobado», 2026-10-10.
- Decisión de diseño: los ADR 0000–0006 son del molde (ejemplo/guía); el proyecto derivado usa 0002 + 0007+. Sin ADR nuevo de proyecto (espacio 0007+ libre). ADR anteriores intactos.
- Estado: cerrada; CA-1–CA-7 verificados con fixtures deterministas del contrato. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` salida 0; contrato 84/84 (76 previos + 8 nuevos); rojo 74/10 expuso 4 bugs reales corregidos; piloto completo. `bash -n` de `verify-scope.sh` sin error.
- Commit: pendiente de autorización del usuario.
- Siguiente paso: definir política de commits y decidir entrega V4.1 (commit/tag/release) o dejarla en local. Integración Notion/Linear queda para V5. Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
