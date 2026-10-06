# Protocolo Operativo para Agentes de Software

Hito 0 proporciona un núcleo de **Spec-Driven Development (SDD)**, **Architecture Decision Records (ADR)**, **BDD**, **TDD** y **Quality Gates**, con alcance en PRD y cierre por DoD. La arquitectura concreta se define por proyecto en `docs/adr/0002-arquitectura-base.md` y se resume en `.agents/project-profile.conf`.

## Estado inicial: semilla Hito 0

Mientras `STATE.md` indique Hito 0 y `.agents/project-profile.conf` declare `phase=seed`, cuando el usuario pida iniciar un proyecto lee y ejecuta `.agents/bootstrap.md`. Para revisar o mantener esta plantilla, no inicies la entrevista; sigue la spec de mantenimiento aplicable y crea una aprobada antes de editar si no existe.

## Reglas de gobernanza

### 1. Fuente de contexto y decisiones

1. Consulta `STATE.md`, el perfil y los ADR aplicables al inicio del trabajo.
2. Los ADR aceptados son registros históricos inmutables. No los edites. Si una petición requiere cambiar una decisión, redacta un nuevo ADR que enlace y, cuando corresponda, reemplace el anterior; espera su aceptación antes de implementar el cambio arquitectónico. ADR 0003 permite aceptar decisiones dentro de una delegación confirmada en `PROMPT-MAESTRO.md`; fuera de ella, acepta el usuario.
3. Distingue decisiones confirmadas, supuestos, pendientes y elementos no aplicables. No presentes una inferencia como decisión aprobada.

### 2. SDD y Agentic TDD

1. Todo cambio de comportamiento o producción requiere una spec en `specs/*.md` con estado y criterios de aceptación verificables.
2. Lee la spec activa y los ADR relacionados antes de diseñar o modificar.
3. Crea primero contratos y pruebas adecuados al perfil del proyecto.
4. Ejecuta las pruebas antes de implementar y confirma que fallan por la condición esperada; luego implementa lo mínimo y vuelve a ejecutarlas.
5. Cada criterio de aceptación debe corresponder a una verificación observable. Elige pruebas unitarias, integración, extremo a extremo, estáticas u operativas según el cambio.
6. Si una prueba necesita estado previo, define preparación y restauración repetibles; usa los identificadores que entrega el fixture y no datos residuales o IDs supuestos.
7. En proyectos inicializados, vincula specs con los requisitos del PRD. Puedes autoaceptarlas solo dentro de la delegación confirmada, registrando autoridad y justificación; las que excedan el alcance requieren aprobación. Para documentación sin cambios de comportamiento usa revisión de consistencia y gate; no inventes una fase roja artificial.

### 3. Límites de cambio

- Modifica solo los archivos autorizados en la spec activa.
- Si necesitas otro archivo, actualiza primero la spec y registra el motivo antes de editarlo.
- No alteres módulos adyacentes, configuraciones globales ni archivos protegidos sin autorización explícita en la spec.
- No instales ni actualices dependencias sin autorización explícita o una decisión aceptada que lo permita.

### 4. Contratos, fallos y seguridad

- Usa el mecanismo de contratos y errores definido por el stack elegido. Los códigos de error estables y el mapeo semántico al transporte aplican cuando el perfil los requiera.
- Valida entradas en los límites de confianza definidos por la arquitectura; no confíes en restricciones de interfaz para autorizar acciones.
- Si existen roles, tenants o ámbitos de datos, aplica denegación segura en la capa autoritativa que controla el acceso y prueba los casos permitidos, denegados y sin alcance asignado.
- Nunca incluyas secretos reales en código, specs, logs, fixtures, documentación ni repositorio. Documenta solo nombres y valores ficticios.
- Para integraciones externas, define cuando aplique timeout, reintentos, idempotencia, aislamiento de fallos y diagnóstico.

### 5. Especificación de datos y estado

Cuando la funcionalidad maneje datos persistentes, documenta según corresponda las relaciones, invariantes, estados y transiciones, concurrencia, atomicidad, auditoría, retención, migración y reversión. Las operaciones mutantes deben verificarse mediante el estado persistido, no solo por el código de respuesta.

### 6. Commits

Si el usuario autoriza o solicita crear commits, sigue Conventional Commits con un tipo y descripción concretos, por ejemplo `feat: agregar exportación` o `fix(auth): rechazar sesión expirada`. La política confirmada en el prompt maestro puede autorizar un commit por spec probado. Antes de commitear revisa Git, añade solo archivos o cambios del alcance y comprueba el diff staged; no incluyas cambios ajenos ni uses `git add .` indiscriminadamente. Sin autorización, no hagas commits. El permiso de commit no concede push, merge ni despliegue.

### 7. Quality Gate

Toda entrega debe ejecutar `./scripts/verify.sh` y reportar el resultado. El comando delega según la fase y los comandos declarados por el perfil; no presupongas npm, un lenguaje ni una clase de pruebas determinada. Los pasos requeridos deben propagar errores y no ocultarlos con `|| true`.

La semilla valida su propia estructura y contrato de fases. Un proyecto inicializado valida además los comandos definidos en `scripts/verify-project.sh`; declara por separado si sus pruebas E2E, seguridad, build u otras verificaciones forman parte del gate completo.

### 8. Desarrollo y continuidad de sesión

En Hito 1, al invocar `PROMPT-MAESTRO.md`, inicia o retoma la meta solicitada mediante las capacidades disponibles y registra su estado en STATE. PRD define alcance y aceptación final; el prompt referencia esa meta y define invocación y autoridad; AGENTS contiene reglas y DoD; ADR decisiones; specs contratos y escenarios; STATE progreso; `docs/learning.md` aprendizaje. No dupliques esos registros.

Por cada spec:

1. Redacta y acepta según delegación, incluyendo rutas de la spec, STATE y aprendizaje y AGENTS si necesita ajustes. Define contratos y escenarios BDD Dado/Cuando/Entonces para comportamientos relevantes, incluyendo alternativas y rechazos. Vincula requisito del PRD, escenario y prueba. Para cambios puramente técnicos usa verificaciones adecuadas; no exijas Cucumber ni Gherkin artificial. Las ambigüedades de negocio críticas se consultan, sin resolverlas por autoaceptación.
2. Ejecuta contratos/pruebas, implementación y gate; corrige fallos antes del cierre. No avances como si una verificación requerida hubiera pasado cuando está pendiente.
3. Registra en la spec comandos/resultados y en `docs/learning.md` una entrada breve con spec, hallazgo, evidencia y aplicación futura si existe un aprendizaje útil; si no, registra «sin hallazgos nuevos» en el cierre, sin inventarlos. No guardes secretos ni conviertas una observación en regla arquitectónica sin ADR.
4. Actualiza STATE con cobertura de la meta, spec actual/siguiente, pendientes, pruebas y checkpoint. Ajusta AGENTS a comandos o estructura reales solo si está autorizado; conserva gobernanza y evita añadir el historial de sesiones.
5. Crea el commit autorizado del alcance probado, incluyendo spec y registros. Si falla o falta autorización, registra cierre pendiente. Tras éxito informa el hash; el checkpoint puede referirse al commit de la spec por su ID para evitar un segundo commit solo para registrar su propio hash.
6. Después del commit, completa el aprendizaje con `/learn` solo si existe y es invocable con el alcance autorizado; si genera cambios de repo, revisa y commitea ese aprendizaje antes de compactar. El registro local ya satisface el aprendizaje aunque el comando no exista. No escribas memorias globales por inferencia de esta política local.
7. Invoca `/compact` solo mediante una capacidad disponible. Si requiere acción del usuario, entrega el checkpoint y señala que debe ejecutarlo; no lo simules desde shell. Si no hay compactación, reanuda desde los archivos. Tras compactar, vuelve a leer contexto y continúa con la siguiente spec sin reiniciar la meta.

Checkpoint mínimo en STATE: meta y criterios pendientes, spec terminada/activa, referencia al commit, evidencia y bloqueos, siguiente spec y primer paso. Si una goal sigue activa y la compactación es manual, registra ese punto de control; no marques la goal completa ni pausada por iniciativa propia.

Solo declara la app completa cuando cumple aceptación final del PRD y DoD. Un gate verde de Hito 0 únicamente acredita la inicialización.

### 9. Definition of Done (DoD)

Personaliza los comandos y controles aplicables al perfil durante Hito 0; la DoD no cambia por iniciativa del agente para obtener verde. No copies la lista común en cada spec: referencia esta sección y añade solo condiciones propias.

Una spec queda terminada cuando:

- Cumple los criterios aceptados, contratos e invariantes; los escenarios BDD pertinentes tienen pruebas con el resultado esperado.
- Pasan pruebas pertinentes y gate acordado; no hay verificaciones obligatorias pendientes ni cambios que debiliten expectativas para ocultar fallos.
- Se revisó el diff contra alcance y decisiones; controles de seguridad, datos, interfaz u operación aplicables están comprobados.
- Documentación afectada, evidencia de la spec, aprendizaje y checkpoint están actualizados; el commit requerido está realizado según autorización.

La app queda terminada cuando todos los requisitos de la entrega del PRD tienen evidencia satisfactoria, pasan flujos integrados y verificaciones de calidad acordadas, y se entregan instrucciones reproducibles de ejecución/operación y commits requeridos. Un despliegue es condición de cierre solo si se acordó en el PRD y fue autorizado. Las mejoras opcionales van a trabajo futuro; no reabras una spec cerrada por perfeccionamiento sin un defecto o requisito concreto.

### 10. Falta de progreso y salida del ciclo

Mantén una spec activa por unidad de trabajo. Cada intento sobre un fallo tiene hipótesis, acción y evidencia; actualiza el resumen del problema en STATE, sin acumular logs completos. Progreso es resolver un criterio, reducir reproduciblemente el fallo o descartar una hipótesis con evidencia útil para una alternativa distinta. Repetir comandos, renombrar specs o reformular documentos sin evidencia no cuenta.

Usa el umbral positivo confirmado en el prompt (referencia de entrevista: tres intentos consecutivos sin progreso). Al alcanzarlo, detén los reintentos del mismo problema, conserva cambios/checkpoint e informa: resultado esperado y observado, hipótesis probadas, evidencia y dato, permiso o decisión concreta necesaria. No inventes una alternativa para reiniciar el contador. Otra tarea solo avanza si es independiente, autorizada y no disfraza el mismo bloqueo.

Compactar, cambiar de sesión o renombrar la spec no reinicia el contador: consérvalo en STATE y actualízalo solo con progreso verificable o una intervención que habilite una hipótesis nueva. No declares éxito, reduzcas PRD/DoD, elimines pruebas ni amplíes permisos para escapar del bloqueo. Los cambios de alcance requieren aprobación. Los estados de una goal del anfitrión siguen las reglas de sus herramientas; esta política permite diagnosticar y escalar el problema, sin autorizar pausarla o marcarla bloqueada por inferencia.

Antes de cada reanudación comprueba el checkpoint para evitar repetir aprendizaje, compactación o arranque sobre una spec ya cerrada. Al cumplir DoD, cierra y avanza; al cubrir el PRD, termina la meta.
