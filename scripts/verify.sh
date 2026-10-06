#!/usr/bin/env bash
# Root quality gate: the phase is explicit and the project gate is generated
# for the selected application profile by the Hito 0 bootstrap.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PROFILE_FILE=".agents/project-profile.conf"

fail() {
  printf 'QUALITY GATE ERROR: %s\n' "$1" >&2
  exit 1
}

[[ -f "$PROFILE_FILE" ]] || fail "falta $PROFILE_FILE; no se puede determinar la fase del repositorio."

PHASE_COUNT="$(awk -F= '$1 == "phase" { count++ } END { print count + 0 }' "$PROFILE_FILE")"
[[ "$PHASE_COUNT" -eq 1 ]] || fail "$PROFILE_FILE debe declarar exactamente una línea phase=<seed|project>."

PHASE="$(awk -F= '$1 == "phase" { print $2 }' "$PROFILE_FILE")"

if [[ "$PHASE" == "seed" ]]; then
  REQUIRED_FILES=(
    "AGENTS.md"
    "README.md"
    "STATE.md"
    ".agents/bootstrap.md"
    ".agents/stack-presets.md"
    ".agents/master-prompt.template.md"
    ".agents/prd.template.md"
    ".agents/project-profile.conf"
    "docs/adr/0000-adopcion-gobernanza-agentica.md"
    "docs/adr/0000-template.md"
    "docs/adr/0001-perfiles-y-aplicabilidad.md"
    "docs/adr/0003-autonomia-y-continuidad.md"
    "docs/adr/0004-producto-comportamiento-y-cierre.md"
    "specs/templates/feature.template.md"
    ".env.example"
    "scripts/verify.sh"
    "scripts/install-hooks.sh"
    "scripts/tests/verify-contract.sh"
    ".githooks/pre-commit"
    ".github/workflows/verify.yml"
  )

  MISSING=0
  for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
      printf 'Falta archivo requerido para la semilla: %s\n' "$file" >&2
      MISSING=$((MISSING + 1))
    fi
  done

  [[ "$MISSING" -eq 0 ]] || fail "la semilla está incompleta ($MISSING archivos requeridos ausentes)."
  printf 'Semilla Hito 0 íntegra. Verificación estructural; no valida una aplicación inicializada.\n'
  exit 0
fi

if [[ "$PHASE" == "project" ]]; then
  for key in application_kind surfaces language runtime framework persistence ci_platform; do
    KEY_COUNT="$(awk -F= -v wanted="$key" '$1 == wanted { count++ } END { print count + 0 }' "$PROFILE_FILE")"
    [[ "$KEY_COUNT" -eq 1 ]] || fail "$PROFILE_FILE debe declarar exactamente una vez: $key."
    VALUE="$(awk -F= -v wanted="$key" '$1 == wanted { print substr($0, index($0, "=") + 1) }' "$PROFILE_FILE")"
    [[ -n "$VALUE" && "$VALUE" != "undecided" ]] || fail "$PROFILE_FILE debe declarar $key (usa not_applicable si corresponde)."
  done

  [[ -f "docs/adr/0002-arquitectura-base.md" ]] || fail "falta el ADR de arquitectura de la aplicación."
  [[ -f "specs/templates/feature.md" ]] || fail "falta la plantilla SDD personalizada para la aplicación."
  [[ -f "PROMPT-MAESTRO.md" ]] || fail "falta PROMPT-MAESTRO.md para iniciar y retomar Hito 1."
  [[ -f "PRD.md" ]] || fail "falta PRD.md como fuente de alcance y aceptación final."
  [[ -f "docs/learning.md" ]] || fail "falta docs/learning.md para registrar aprendizaje entre specs."
  [[ -x "scripts/verify-project.sh" ]] || fail "falta scripts/verify-project.sh ejecutable para el perfil seleccionado."
  exec ./scripts/verify-project.sh
fi

fail "fase desconocida '$PHASE' en $PROFILE_FILE; usa seed o project."
