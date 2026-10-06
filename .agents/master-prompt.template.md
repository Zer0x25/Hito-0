# Prompt maestro — [Nombre del proyecto]

> Generar como `PROMPT-MAESTRO.md` después de confirmar la entrevista. Resolver los campos críticos antes de aceptarlo; no usar esta plantilla sin personalizar.

- **Estado:** [Aceptado por el usuario, fecha y referencia de confirmación]
- **Arquitectura:** `docs/adr/0002-arquitectura-base.md`
- **Producto y aceptación:** `PRD.md` [Referencia a la versión/confirmación vigente]
- **Registro de entrevista:** decisiones confirmadas [resumen]; supuestos aceptados [lista]; pendientes [lista y efecto]; no aplicables [lista].

## Meta de la primera entrega

Entregar la primera versión definida en `PRD.md`, cumpliendo sus requisitos y evidencia final, y la DoD de AGENTS. Consultar allí alcance, exclusiones y restricciones; no mantener una copia aquí.

## Delegación confirmada

- **Specs:** [Autoaceptación dentro del alcance / aprobación humana]
- **ADR técnicos:** [Decisiones que puede aceptar el agente y límites / aprobación humana]
- **Dependencias:** [Autorización específica, categorías acotadas o ninguna]
- **Commits:** [Commit por spec probado autorizado / confirmación por commit]
- **Continuidad:** [Compactar entre specs; automática cuando invocable, manual con checkpoint]
- **Falta de progreso:** [Umbral positivo confirmado de intentos consecutivos sin progreso sobre el mismo problema; referencia: 3]. Seguir AGENTS, conservar el contador en STATE y solicitar la intervención concreta al alcanzarlo.
- **Aprendizaje:** `docs/learning.md`; [uso adicional de /learn solo si existe y su alcance está autorizado].
- **Requiere consulta:** cambios de alcance, stack, seguridad, costos o compromisos fuera de los límites anteriores. Push, merge y despliegue requieren su propia autorización.

## Invocación de inicio

Al pedirme «Lee y ejecuta PROMPT-MAESTRO.md para iniciar Hito 1», crea o retoma una goal cuyo objetivo sea esta meta, si el entorno lo admite. No reemplaces una goal activa diferente; consulta el conflicto. Si no hay herramienta de goals, lleva la meta y sus pendientes en STATE y declara esa modalidad. No inventes un presupuesto de tokens o tiempo.

Lee PRD, AGENTS, STATE, el perfil y los ADR aplicables. Comprueba el estado real de Git y del gate. Si la inicialización está pendiente, resuélvela antes de desarrollar producto. Descompón la meta en specs pequeñas y ordenadas por dependencias; vincula cada una con los IDs del PRD, escenarios BDD pertinentes y pruebas. Mantén una spec activa por unidad de trabajo; reanúdala antes de crear otra.

Sigue el ciclo de AGENTS: spec aceptada → contratos y pruebas → implementación → verificación → aprendizaje y estado → commit autorizado → checkpoint → compactación → siguiente spec. Genera o actualiza instrucciones de proyecto cuando cambien los comandos o estructura bajo una decisión autorizada. No repitas aquí reglas de stack: consulta ADR 0002.

## Cierre de meta

Antes de declarar la app completa, verifica todos los requisitos y evidencias finales del PRD y la DoD, incluidos flujos integrados y requisitos de calidad acordados. Entrega evidencia, comandos de ejecución y limitaciones reales. Con criterios, verificaciones o commits requeridos pendientes, conserva la meta abierta. No amplíes el alcance ni reduzcas los criterios para cerrar.

## Reanudación

Después de compactar o cambiar de sesión, consulta STATE, la spec activa, los ADR aplicables y el aprendizaje relevante. Verifica Git y los artefactos; usa el checkpoint para continuar sin repetir tareas concluidas. Las modificaciones posteriores al alcance de este prompt requieren aprobación y una referencia a la nueva decisión.
