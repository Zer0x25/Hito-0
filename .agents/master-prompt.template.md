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
- **Niveles:** Clasificar por riesgo según AGENTS y ADR 0005. [Quién puede clasificar/aceptar Tier 2/1 y límites; ante incertidumbre conservar mayores controles].
- **Tier 3:** [Registro ligero en STATE autorizado y quién lo acepta / usar spec]. Correcciones de contrato confirmado; sin ampliar alcance ni modificar specs cerradas.
- **ADR técnicos:** [Decisiones que puede aceptar el agente y límites / aprobación humana]
- **Dependencias:** [Autorización específica, categorías acotadas o ninguna]
- **Commits de specs:** [Por spec verificada autorizado / confirmación por commit / no requerido para esta entrega]
- **Commits de registros ligeros:** [Por registro verificado autorizado / confirmación por commit / no requerido para esta entrega]. No inferir del permiso de commit por spec.
- **Verificación:** Consultar comandos y controles en AGENTS. [Chequeo rápido de iteración autorizado con su cobertura / ninguno]; el cierre de todos los niveles conserva el gate raíz y DoD.
- **Continuidad:** [Compactar por necesidad de contexto / entre unidades según preferencia; automática cuando invocable, manual con checkpoint]. No repetir por cada ajuste ligero sin necesidad.
- **Falta de progreso:** [Umbral positivo confirmado de intentos consecutivos sin progreso sobre el mismo problema; referencia: 3]. Seguir AGENTS, conservar el contador en STATE y solicitar la intervención concreta al alcanzarlo.
- **Aprendizaje:** `docs/learning.md`; [uso adicional de /learn solo si existe y su alcance está autorizado].
- **Requiere consulta:** cambios de alcance, stack, seguridad, costos o compromisos fuera de los límites anteriores. Push, merge y despliegue requieren su propia autorización.

## Invocación de inicio

Al pedirme «Lee y ejecuta PROMPT-MAESTRO.md para iniciar Hito 1», crea o retoma una goal cuyo objetivo sea esta meta, si el entorno lo admite. No reemplaces una goal activa diferente; consulta el conflicto. Si no hay herramienta de goals, lleva la meta y sus pendientes en STATE y declara esa modalidad. No inventes un presupuesto de tokens o tiempo.

Lee PRD, AGENTS, STATE, el perfil y los ADR aplicables. Comprueba el estado real de Git y del gate. Si la inicialización está pendiente, resuélvela antes de desarrollar producto. Descompón la meta en unidades pequeñas ordenadas por dependencias y clasifícalas antes de editar: specs para Tier 2/1, registro ligero para Tier 3 cuando esté autorizado. Vincula requisitos o correcciones justificadas, criterios y verificaciones pertinentes. Mantén una unidad activa; reanúdala antes de crear otra.

Sigue el ciclo de AGENTS: clasificación y registro aceptado → contratos/pruebas o revisión pertinente → implementación → gate y controles DoD → aprendizaje y estado → commit cuando requerido y autorizado → checkpoint → compactación según necesidad/política → siguiente unidad. Genera o actualiza instrucciones de proyecto cuando cambien los comandos o estructura bajo una decisión autorizada. Consulta ADR 0002 para stack y AGENTS para niveles; no dupliques esas reglas aquí.

## Cierre de meta

Antes de declarar la app completa, verifica todos los requisitos y evidencias finales del PRD y la DoD, incluidos flujos integrados y requisitos de calidad acordados. Entrega evidencia, comandos de ejecución y limitaciones reales. Con criterios, verificaciones o commits requeridos pendientes, conserva la meta abierta. No amplíes el alcance ni reduzcas los criterios para cerrar.

## Reanudación

Después de compactar o cambiar de sesión, consulta STATE, la spec o registro ligero activo, los ADR aplicables y el aprendizaje relevante. Verifica Git y los artefactos; usa el checkpoint para continuar sin repetir tareas concluidas. Reclasificar no reinicia el contador de falta de progreso. Las modificaciones posteriores al alcance de este prompt requieren aprobación y una referencia a la nueva decisión.
