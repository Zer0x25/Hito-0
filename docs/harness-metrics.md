# Harness Metrics — Auditorías del molde Hito-0

> Registro de auditorías del supervisor (rol del usuario/MIA sobre el molde). Vive en el **molde**, no en los derivados: el derivado no carga con ninguna métrica. El supervisor escribe aquí cuando audita un derivado, con fricciones y señales de que el flujo funciona, cada una con evidencia archivo:línea.
>
> Convención: una auditoría por derivado/fecha. Las fricciones marcadas "candidata a seed" alimentan la hoja de ruta V5.x. El gate NUNCA lee este archivo; es aprendizaje del supervisor, no control.

## [AAAA-MM-DD] — Auditoría: [nombre del derivado] ([fase, HEAD])

### Fricciones observadas

#### [F-01] [título corto de la fricción]

- **Qué pasa:** [descripción del problema en el flujo gobernado]
- **Evidencia:** [archivo:línea + cita textual breve]
- **Severidad:** baja | media | alta
- **Candidata a seed:** sí | no — [si sí, referencia la seed futura]

### Señales de que el flujo funciona

- [qué partes del flujo aportan valor real, con evidencia]

### Recomendación

- [qué fricciones justifican tocar el molde y cuáles son ruido]

---

## 2026-10-11 — Auditoría: GYM-2026 (phase=project, HEAD 81203c0)

### Fricciones observadas

#### [F-01] Contradicción gate↔política de HITO0_PENDING

- **Qué pasa:** el gate `verify-structure.sh` prohíbe la cadena `HITO0_PENDING` en PRD/PROMPT-MAESTRO/ADR-0002, pero la política del bootstrap manda usarla para campos críticos sin resolver. El derivado tuvo que redactar esos archivos sin el marcador y concentrar los pendientes en STATE.md y specs.
- **Evidencia:** `scripts/verify-structure.sh` líneas 48-52; `docs/learning.md` del derivado (entrada 2026-10-11); STATE.md del derivado (pendientes en STATE, no en archivos gateados).
- **Severidad:** media — workaround en cada derivado con pendientes reales.
- **Candidata a seed:** sí — alinear el gate con la política de HITO0_PENDING (permitir el marcador en archivos aprobados durante initializing/project).

#### [F-02] Unidades "pendiente de revisión humana" sin mecanismo de cierre explícito

- **Qué pasa:** varias unidades quedan implementadas y verificadas pero "pendiente de revisión humana del usuario antes de cerrar/sellar". No hay un paso mecánico ni un recordatorio en el gate que fuerce o facilite esa revisión; queda a disciplina del agente y del humano.
- **Evidencia:** STATE.md del derivado — unidad 001 ("Revisión Tier 1: pendiente de revisión humana del usuario antes de sellar") y unidad 002 ("pendiente de revisión humana del usuario antes de cerrar").
- **Severidad:** baja — el flujo lo cubre por política, pero podría formalizarse.
- **Candidata a seed:** no por ahora — observar si se acumulan unidades sin revisar.

### Señales de que el flujo funciona

- Modo A de Notion (V5) trasladó 55 decisiones y redujo la entrevista a validación. Evidencia: STATE.md del derivado, `docs/learning.md`.
- Gate del derivado verde tras dos unidades Tier 1 reales con evidencia por criterio CA. Evidencia: `./scripts/verify.sh` salida 0, tests del monorepo en verde.

### Recomendación

- F-01 justifica tocar el molde (seed futura: alinear gate↔HITO0_PENDING). F-02 es observación, no acción todavía.
