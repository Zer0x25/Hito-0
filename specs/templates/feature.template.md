# Spec: [Resultado verificable]

> Estado: Borrador | Aprobada | Implementada | Cerrada
> Requisitos: [IDs de PRD.md o mantenimiento de semilla]
> ADR aplicables: [Rutas o ninguno]
> Aceptación: [Quién, fecha y autoridad; delegación y justificación si autoaceptada]

## 1. Objetivo y alcance

- **Resultado observable:** [Problema y capacidad que se entrega]
- **Incluye / excluye:** [Límites concretos]
- **Pendientes críticos / supuestos aceptados:** [Resolver los críticos antes de implementar]

## 2. Contratos e invariantes

[Entradas, salidas, datos y validaciones conforme al stack aceptado. Garantías, estados prohibidos y respuesta esperada.]

Añade solo controles pertinentes: permisos y alcance de datos; estados, atomicidad y concurrencia; integraciones y resiliencia; interfaz y accesibilidad; fixtures y restauración; migración, reversión y operación. No repitas decisiones del ADR ni rellenes secciones irrelevantes.

## 3. Comportamientos BDD y aceptación

Documenta ejemplos de negocio relevantes con Dado/Cuando/Entonces, incluyendo alternativas y rechazos según el riesgo. No generes un escenario por cada detalle técnico ni exijas una librería BDD. Consulta ambigüedades críticas al usuario antes de autoaceptar.

```gherkin
Escenario BDD-1: [Comportamiento del requisito REQ-1]
  Dado [Estado inicial reproducible]
  Cuando [Acción]
  Entonces [Resultado observable]
  Y [Invariante que se conserva, si aplica]
```

| ID | Requisito PRD | Escenario / criterio | Prueba o verificación | Resultado esperado |
|---|---|---|---|---|
| CA-1 | REQ-1 | BDD-1 | [Prueba adecuada a la capa] | [Resultado concreto] |

Para cambios técnicos sin comportamiento de usuario, elimina el ejemplo Gherkin y usa criterios técnicos verificables. No copies los mismos escenarios a PRD y prompt. En mutaciones comprueba datos persistidos; en permisos cubre autorización y rechazo; en UI espera estados explícitos y evita pruebas que pasen si falta el control.

## 4. Archivos autorizados

- **Editables:** [Rutas exactas o patrón acotado; incluir spec, STATE y aprendizaje si se actualizan]
- **Protegidos:** [Rutas o límites]

Actualiza la spec antes de ampliar archivos; no cambia por sí misma arquitectura ni permisos de dependencias.

## 5. Verificación y DoD

- **DoD común:** AGENTS.md; añade aquí únicamente condiciones propias.
- **Comandos y suites:** [Exactos; TDD para comportamiento, revisión y gate para documentación]
- **Condiciones adicionales:** [Controles específicos o ninguno]

## 6. Cierre y continuidad

- **Evidencia:** [Criterios, comandos y resultados reales; verificaciones requeridas pendientes impiden cierre]
- **Aprendizaje:** [Hallazgo con evidencia en docs/learning.md o sin hallazgos nuevos; semilla puede registrarlo aquí]
- **Commit:** [Política, mensaje y resultado; requerido pendiente impide cierre]
- **Checkpoint en STATE:** [Cobertura del PRD, siguiente paso y bloqueos con contador/hipótesis si existen]
- **Compactación:** [Según política confirmada y capacidades disponibles; no reiniciar la meta ni contador por compactar]
