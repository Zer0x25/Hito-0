# Estado del Proyecto: Semilla Hito 0

- Fase: `seed`; molde maestro, sin stack ni producto seleccionado.
- Base revisada: `46c519b` (Seed 007).
- Historia conservada: [Seeds 001–007](docs/history/seed-001-007.md). Sus permisos de publicación no se reutilizan para esta unidad.

## Última unidad — Seed 015 (V5.5) — Higiene del molde

- Meta: dos higienas sin cambio de comportamiento. (1) Extraer las capacidades acumuladas de AGENTS a `docs/flujo-capacidades.md`. (2) Desacoplar el ritual de cierre de sesión de `hermes sessions export` en los documentos vivos.
- Unidad: [Seed 015](specs/seed-015-higiene-molde.md), Tier 1 (toca política viva); autoridad del usuario «aprobado», 2026-10-12.
- Decisión de diseño: los bloques de Seeds 009/010/011/013/014 se MUDAN íntegros (no se resumen) a `docs/flujo-capacidades.md`; AGENTS queda como protocolo estable con punteros. El archivo de capacidades es referenciado por enlace y NO entra a los requeridos del gate (anti-sobreingeniería). La convención de sesión pasa a genérica; el comando concreto de Hermes vive solo como ejemplo en el archivo de capacidades. El registro histórico de Seed 011 (export verificado) se preserva intacto — es evidencia, no política viva. Sin cambios de comportamiento → verificación en verde, sin fase roja artificial (AGENTS §2.7). Sin ADR nuevo (espacio 0007+ libre); ADR 0000–0006 intactos.
- Estado: cerrada; CA-1–CA-6 verificados. Cambios locales sin commit (sin política de commits autorizada).
- Evidencia: `./scripts/verify.sh` exit 0, contrato 97/97 (scripts intactos byte a byte); `grep hermes AGENTS.md README.md .agents/bootstrap.md` sin coincidencias; specs seed-001..014 intactas; anclas del piloto presentes (AGENTS L5/L9); AGENTS 25.2K→20.8K, flujo-capacidades.md 8.2K con bloques íntegros.
- Nota de supervisión: GYM-2026 permanece en V5.0 por diseño — no se le empujan los fixes del molde; las fricciones se aprenden sobre su base congelada.
- Commit: pendiente de autorización del usuario. Probable release V5.5 (commit + tag v5.5.0 + release) tras autorización.
- Siguiente paso: definir próxima unidad. F-02 (revisiones humanas sin mecanismo de cierre) sigue como observación. Sin unidad activa.
- Falta de progreso: contador 0, sin bloqueo.

## Cobertura y límites

La inicialización real de un proyecto de usuario sigue pendiente. El piloto temporal usa decisiones simuladas, no certifica entrevista ni stacks alternativos. El perfil offline-first continúa propuesto y sin implementación. Una aplicación completa requiere PRD y evidencia propios.
