# Spec: [Nombre de la Funcionalidad o Caso de Uso]

> **Instrucción para el Agente:** Este documento es un contrato cerrado. No implementes código de producción sin antes escribir las pruebas unitarias que satisfagan estos criterios de aceptación (Agentic TDD).

---

## 1. Alcance y Límites de Archivos

- **Objetivo:** [Descripción precisa y concisa de lo que se va a implementar]
- **Archivos editables autorizados:**
  - `src/modules/[modulo]/[modulo].schema.ts`
  - `src/modules/[modulo]/[modulo].service.ts`
  - `src/modules/[modulo]/[modulo].controller.ts`
  - `src/modules/[modulo]/[modulo].repository.ts`
  - `tests/modules/[modulo]/[modulo].service.test.ts`
  - `tests/modules/[modulo]/[modulo].controller.test.ts`
- **Archivos protegidos (solo lectura / prohibido modificar):**
  - `src/core/*`
  - `docs/adr/*`
  - Todo archivo fuera de `src/modules/[modulo]/` y `tests/modules/[modulo]/`

---

## 2. Contrato Funcional de Datos (Zod Schemas)

### A. Contrato de Entrada (Input DTO)
```typescript
// Esquema requerido para validar la carga de entrada
// Ej: [Entidad]InputSchema
```
- `campoId`: Formato y tipo (ej. `z.string().uuid()`)
- `campoTexto`: Validaciones (ej. `z.string().trim().min(2).max(100)`)
- `campoEnum`: Valores permitidos (ej. `z.enum(["VALOR_A", "VALOR_B"])`)

### B. Contrato de Salida (Output DTO / Respuestas HTTP)
```typescript
// Esquema de respuesta segura (sin datos sensibles ni hashes)
// Ej: [Entidad]ResponseSchema
```
- Salida esperada (HTTP 200/201):
  - `id`: Identificador único generado.
  - `status`: Estado resultante.
  - `createdAt`: Timestamp en UTC.
  - *(Garantía: ningun campo sensible o privado expuesto).*

---

## 3. Invariantes del Negocio (Reglas Duras y Negativas)

1. **[Invariante 1]:** [Qué nunca debe ocurrir. Ej. Una operación no puede ejecutarse si el estado es diferente a X].
2. **[Invariante 2 - Atomicidad]:** [Toda operación que modifique múltiples entidades debe ser atómica mediante transacciones de DB].
3. **[Invariante 3 - Manejo de Errores]:** [Si una validación o dependencia falla, revertir cambios y retornar un error de dominio controlado específico].
4. **[Invariante 4 - Pureza de Capas]:**
   - El controlador solo valida payloads vía Zod y mapea errores de dominio a códigos HTTP.
   - El servicio contiene la lógica pura de negocio y las invariantes.
   - El repositorio encapsula exclusivamente la persistencia y queries a la base de datos.

---

## 4. Criterios de Aceptación (Definition of Done)

- [ ] **Tests de Esquemas de Validación (Zod):**
  - [ ] Rechazo de entradas incompletas o tipos erróneos con mensajes claros.
  - [ ] Normalización correcta de datos de entrada (ej. emails a minúsculas, trims).
- [ ] **Tests de Servicio (Vitest / Framework de pruebas):**
  - [ ] Ejecución exitosa de flujo principal con persistencia simulada por mocks.
  - [ ] Rechazo de operaciones duplicadas o no autorizadas arrojando el error de dominio correspondiente.
  - [ ] Confirmación de que las invariantes negativas no se vulneran.
- [ ] **Quality Gate Determinista (Salida obligatoria: Código 0):**
  - [ ] `npm run typecheck` (sin errores de tipos en modo estricto)
  - [ ] `npm run lint` (sin advertencias ni errores de estilo)
  - [ ] `npm test tests/modules/[modulo]` (100% de tests pasando)
