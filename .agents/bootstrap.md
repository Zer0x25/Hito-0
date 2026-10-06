# Protocolo de Inicialización: Hito 0

Actúas como facilitador de arquitectura. Hito 0 define el propósito y las reglas del nuevo proyecto antes del desarrollo de producción. La plantilla no elige tecnología ni dominio por el usuario.

## Principios

1. Pregunta como máximo dos cosas por turno y usa lenguaje claro.
2. Recoge decisiones confirmadas, supuestos, pendientes y elementos no aplicables por separado.
3. No inventes un stack, política, requisito ni comando para completar un documento. Cuando falte una decisión necesaria, presenta alternativas comprensibles y pregunta.
4. Consulta `STATE.md`, `AGENTS.md`, ADR 0000, ADR 0001 y ADR 0003 antes de editar.
5. No instales dependencias sin autorización explícita o una decisión aceptada que lo autorice.
6. Mantén los ADR aceptados como historia inmutable; registra cambios posteriores en ADR nuevos con referencias explícitas.

## Fase 0: Protección de la plantilla

Determina el remoto canónico de Git normalizando HTTPS y SSH. Si el remoto corresponde a `Zer0x25/Hito-0`, explica que se recomienda crear un repositorio con “Use this template” y pregunta si quiere continuar en el molde maestro. Si no hay remoto, usa el nombre de carpeta como señal de advertencia, no como prueba concluyente. Una respuesta afirmativa permite continuar.

No comiences esta entrevista si la solicitud es revisar o mantener la plantilla Hito 0; en ese caso trabaja con la spec de mantenimiento activa.

## Fase 1: Integridad y fase

Lee `.agents/project-profile.conf`. Continúa solo si `phase=seed` y `scripts/verify.sh` acepta la estructura. Comprueba que estén presentes ADR 0000, ADR 0001 y la plantilla SDD neutral. No crees carpetas de aplicación antes de escoger el perfil.

## Fase 2: Entrevista adaptativa

Mantén un registro provisional de decisiones con estado `confirmada`, `pendiente`, `supuesto` o `no_aplica`. Pregunta en grupos de hasta dos elementos, adaptándote a lo que ya respondió el usuario. Cubre lo pertinente de estas áreas:

- Nombre, problema, resultado esperado y qué queda fuera.
- Actores, flujos principales, entidades o datos y sus relaciones.
- Invariantes, fallos intolerables, permisos, privacidad, retención o auditoría, si aplican.
- Superficies de la aplicación: por ejemplo API, navegador, móvil, CLI, biblioteca, proceso batch o infraestructura; pueden combinarse o ser otras.
- Lenguaje, runtime, framework, persistencia, integraciones y dependencias preferidas o prohibidas. Si el usuario no tiene preferencia, explica las opciones antes de recomendar una.
- Despliegue, operación, restricciones de red/costo, rendimiento, disponibilidad, pruebas y mantenimiento, en la medida que el producto lo necesite.

### Meta de entrega y autonomía

Define una primera entrega finita: capacidades incluidas, exclusiones, flujos completos, requisitos de calidad y evidencia que demostrará cada resultado. Aclara si la entrega termina en ejecución local, staging o producción; un despliegue requiere autorización propia. No uses «app completa» como criterio sin concretarlo.

Acuerda la delegación conforme a ADR 0003: autoaceptación de specs dentro del alcance, decisiones técnicas que puede aceptar en ADR nuevos, autorización acotada de dependencias, commit por spec probado y política de aprendizaje/compactación. Presenta como flujo recomendado specs autónomas dentro de límites, commit local por spec y continuidad entre specs; registra la respuesta confirmada. No conviertas permiso de commit en permiso de push, merge o despliegue. Las decisiones materiales fuera de la delegación se consultan.

Usa `.agents/master-prompt.template.md` para preparar el resumen de alcance y aceptación final. El prompt maestro será el registro de la entrevista y el punto de inicio de Hito 1; STATE llevará el avance. Comprueba las capacidades de goal, `/learn` y `/compact` del entorno; si no existen o son manuales, registra la alternativa documental. No generes comandos ficticios.

### Selección guiada del stack

Tras conocer propósito, superficies y flujos, lee `.agents/stack-presets.md`. Usa sus perfiles VPS, Cloudflare y Cloud Run como referencias opcionales y conserva la opción `custom` para otro destino o stack. Pregunta primero el destino de despliegue y las restricciones operativas, con hasta dos preguntas por turno. Si el destino está pendiente, compara alternativas según producto, experiencia del equipo y presupuesto total antes de cerrar la arquitectura.

Recomienda un perfil y una alternativa pertinente, explicando ajuste, límites, esfuerzo operativo y costos que deben verificarse. No presentes «moderno» o «ampliamente usado» como justificación suficiente. Consulta fuentes oficiales actuales antes de fijar versiones, compatibilidad, límites o precios; registra fecha y fuentes o deja la comprobación pendiente. Prefiere componentes estables con soporte activo y adapta la base a los conocimientos del equipo.

Selecciona cada componente por una necesidad: frontend solo si hay navegador, persistencia solo si hay datos duraderos, caché o colas solo si un flujo las requiere. En Cloudflare distingue Workers + Static Assets de la variante Pages, comprueba el ajuste de D1 y la consistencia eventual de KV. En Cloud Run verifica estado externo y contrato del contenedor; en VPS dimensionamiento y recuperación de datos. Sigue las condiciones de operación y verificación del catálogo.

Registra provisionalmente perfil base, variantes, componentes incluidos y descartados con sus razones, incompatibilidades y decisiones pendientes. La recomendación se convierte en arquitectura aceptada tras la confirmación de la Fase 3.

### Elección de base de datos

En el bloque de persistencia presenta siempre **SQLite y PostgreSQL**, con una explicación breve y una recomendación según el alcance real de la app. Evalúa escritores concurrentes, número de instancias, consultas, crecimiento, durabilidad, presupuesto y mantenimiento; no decidas solo por cantidad de usuarios ni asumas PostgreSQL por el perfil VPS. Sigue la comparación y las condiciones de despliegue en `.agents/stack-presets.md`.

Mantén hasta dos preguntas por turno. Confirma la elección antes de generar el acceso a datos y registra motor, modalidad de almacenamiento, razones y alternativa descartada en ADR 0002 y el resumen de persistencia del perfil. Si la app no requiere datos duraderos, explica ambas opciones brevemente y registra persistencia como `not_applicable`, sin añadir una base por defecto.

No trates esta lista como formulario obligatorio. Marca lo irrelevante como `no_aplica`. Si hay una decisión crítica pendiente, no la aceptes en el ADR ni construyas sobre ella.

## Fase 3: Confirmación y constitución

Antes de crear artefactos, presenta un resumen breve con decisiones confirmadas, supuestos, asuntos pendientes y trade-offs. Incluye meta, criterios finales y límites de delegación. Pide que el usuario confirme las decisiones arquitectónicas y el prompt maestro propuesto. No cierres con alcance, aceptación o autoridad críticos pendientes. Tras confirmación:

1. Crea `docs/adr/0002-arquitectura-base.md` usando `docs/adr/0000-template.md`. Describe problema, alternativas relevantes, stack elegido, límites, estructura adecuada a las superficies, riesgos, consecuencias y verificación. Incluye perfil base o `custom`, variantes, componentes justificados, versiones compatibles, fuentes con fecha y responsabilidades operativas. Declara los pendientes sin resolverlos por inferencia.
2. Actualiza `.agents/project-profile.conf` con `phase=project` y los campos `application_kind`, `surfaces`, `language`, `runtime`, `framework`, `persistence` y `ci_platform`. Completa además `deployment_target` y `stack_preset` como metadatos informativos del destino y perfil elegidos; estos dos campos no agregan requisitos al gate actual. Cada valor debe reflejar una decisión o indicar `not_applicable`; no guardes secretos.
3. Genera `specs/templates/feature.md` desde `specs/templates/feature.template.md`, añadiendo solo las secciones que corresponden al perfil y vocabulario acordados.
4. Genera el andamiaje mínimo de la aplicación en la estructura que corresponda. Incluye pruebas de humo y los artefactos de build o configuración que haya acordado el usuario. No generes `package.json`, `tsconfig.json`, DTOs Zod, controladores HTTP ni `src/core/errors.ts` salvo que el perfil y las decisiones los requieran.
5. Crea `scripts/verify-project.sh` ejecutable con comandos exactos del perfil y configura la CI elegida para preparar ese runtime y ejecutar `./scripts/verify.sh`. Los pasos requeridos deben propagar errores; no uses `|| true` para ocultar fallos.
6. Si la arquitectura usa variables de entorno, documenta nombres ficticios en `.env.example` y explica la validación elegida. Nunca escribas credenciales reales.
7. Actualiza `.gitignore` con exclusiones apropiadas al perfil, conservando las exclusiones comunes de secretos y sistema.
8. Genera los artefactos de despliegue y el runbook acordados según el perfil: configuración de contenedores, proxy, bindings, recursos externos, migraciones y recuperación cuando apliquen. Define comandos locales reproducibles y comprobaciones remotas por separado. No crees recursos de nube ni despliegues como efecto automático de escoger un perfil.

9. Genera `PROMPT-MAESTRO.md` desde la plantilla, sin placeholders críticos: registra la entrevista confirmada, meta y criterios con IDs, autoridad y fuente de aprobación. En ADR 0002 referencia esa delegación. No reutilices 0003 para arquitectura: está ocupado por gobernanza; los ADR posteriores usan el siguiente número libre.
10. Crea `docs/learning.md` con el formato mínimo «fecha, spec, hallazgo, evidencia, aplicación futura» y personaliza `AGENTS.md` con estructura, comandos y límites de delegación confirmados, conservando reglas comunes. No copies allí el catálogo ni el historial. Prepara en STATE una secuencia inicial de specs vinculadas con la meta, pendientes y primer paso.

## Fase 4: Sellado y transición

Cuando estén creados el ADR, el perfil, la plantilla personalizada, el prompt maestro, aprendizaje, el verificador y la CI:

1. Actualiza `STATE.md` con el nombre, arquitectura, estado de decisiones pendientes y resultado real del quality gate. Distingue gate semilla de gate de aplicación.
2. Retira de `AGENTS.md` el aviso que dispara este bootstrap, conservando las reglas generales y la referencia al perfil del proyecto.
3. Renombra `.agents/bootstrap.md` a `.agents/bootstrap.md.done`.
4. Actualiza el README con propósito, stack y comandos reales del proyecto.
5. Ejecuta `./scripts/verify.sh` si el entorno necesario está disponible y su instalación está autorizada. Si no, registra el gate como pendiente; no afirmes que fue superado ni declares Hito 0 completado. Conserva bootstrap archivado y las instrucciones para reanudar la inicialización pendiente desde STATE. Con salida 0 registra «Hito 0 completado; Hito 1 preparado, pendiente de invocación». Todavía no se ha verificado la entrega final.
6. Informa qué decisiones quedaron aceptadas, qué quedó pendiente y qué comandos se ejecutaron. Aplica la política de commit confirmada al cierre de la inicialización; sin autorización no hagas commit. Entrega la instrucción de arranque: **«Lee y ejecuta PROMPT-MAESTRO.md para iniciar Hito 1; crea o retoma la goal de entrega definida allí y sigue el ciclo por specs de AGENTS.md»**. No inicies el desarrollo de producto hasta esa primera invocación.
