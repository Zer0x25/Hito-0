# Spec: [Resultado o capacidad]

> Estado: Borrador | En revisión | Aprobada | Implementada
> Perfil: [Nombre del perfil y ADR de arquitectura aplicables]
> ADR relacionados: [Rutas o `Ninguno`]
> Meta: [IDs de aceptación de PROMPT-MAESTRO.md o `Mantenimiento de semilla`]
> Aceptación: [Quién, fecha y autoridad; si autoaceptada, referencia a la delegación y motivo de estar dentro del alcance]

## 1. Problema, resultado y límites

- **Problema que se resuelve:** [Quién necesita qué y por qué]
- **Resultado observable:** [Qué podrá comprobar un usuario u otro sistema]
- **Incluye:** [Capacidades cubiertas]
- **No incluye:** [Límites explícitos]

## 2. Usuarios y flujos

[Actores y pasos principales, estados vacíos y fallos que importan. Escribe `No aplica` cuando la capacidad no tenga usuarios o flujos propios.]

## 3. Contratos y datos

[Entradas, salidas, eventos, formatos, validaciones y compatibilidad usando la tecnología elegida. No impongas un lenguaje o librería en esta sección.]

## 4. Invariantes y fallos

### Garantías

- [Estado o resultado que siempre debe mantenerse]

### Casos prohibidos

- [Estado o resultado que nunca debe ocurrir]
- [Respuesta esperada ante el caso prohibido]

## 5. Controles condicionales

Completa solo las subsecciones que correspondan; elimina las demás antes de aprobar la spec.

### Permisos y alcance de datos

[Quién puede leer, cambiar o administrar qué. Incluye casos permitidos, denegados y sin alcance cuando existan roles o tenants.]

### Persistencia y ciclo de vida

[Relaciones, estados y transiciones, atomicidad, concurrencia, retención, archivo/borrado y auditoría cuando haya datos persistentes.]

### Integraciones y resiliencia

[Timeouts, reintentos, idempotencia, límites de fallos y diagnóstico para dependencias externas.]

### Interfaz y accesibilidad

[Estados de carga, vacío y error; navegación, accesibilidad y localizadores estables para pruebas cuando exista una interfaz.]

### Preparación y repetibilidad de pruebas

[Fixtures aislados, preparación/restauración del estado y uso de identificadores devueltos por la preparación cuando existan pruebas de integración o E2E. No dependas de datos residuales ni IDs estáticos.]

### Migración y operación

[Compatibilidad, despliegue, reversión, observabilidad y operación cuando afecte un sistema desplegado.]

## 6. Archivos y límites de cambio

- **Editables autorizados:**
  - `[rutas exactas o patrón acotado]`
- **Protegidos:**
  - `[rutas exactas o límites]`
- Si el alcance requiere archivos adicionales, actualiza esta spec antes de modificarlos.

## 7. Criterios de aceptación y pruebas

Vincula cada criterio a una prueba o verificación adecuada al perfil. Cada criterio debe ser observable y tener un resultado esperado.

| ID | Criterio verificable | Prueba/verificación | Resultado esperado |
|---|---|---|---|
| CA-1 | [Comportamiento] | [Unit, integración, E2E, seguridad, build u otra] | [Resultado] |

Para mutaciones persistentes, comprueba el estado leído después de la operación. Para seguridad, cubre al menos el acceso permitido y la denegación esperada. Para interfaces, espera estados explícitos y evita aserciones que pasen si el control no aparece.

## 8. Decisiones pendientes y supuestos

- **Pendientes que bloquean:** [Resolver antes de implementar o registrar `Ninguno`]
- **Supuestos aceptados para este alcance:** [Declararlos o `Ninguno`]
- **Riesgos y trade-offs:** [Impactos que se aceptan]

## 9. Quality Gate y cierre

- **Comandos requeridos:** [Comandos exactos del perfil]
- **Pruebas requeridas:** [Suites necesarias para esta spec]
- **Cierre:** todos los criterios pasan; registra comandos, resultados y cualquier verificación pendiente en `STATE.md`.
- **Aprendizaje:** [Hallazgo y evidencia en `docs/learning.md` para proyectos inicializados]
- **Commit:** [Política autorizada, mensaje previsto y resultado; si es requerido y falta, cierre pendiente]
- **Continuidad:** [Siguiente spec/paso en STATE y compactación automática, manual o no disponible]
