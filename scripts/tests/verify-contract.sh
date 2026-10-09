#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEMP_ROOT"' EXIT
PASS_COUNT=0
FAIL_COUNT=0

make_seed_fixture() {
  local dir="$1" file
  mkdir -p "$dir/.agents" "$dir/docs/adr" "$dir/specs/templates" "$dir/scripts/tests" "$dir/.githooks" "$dir/.github/workflows"
  for file in AGENTS.md README.md STATE.md .agents/bootstrap.md .agents/stack-presets.md \
    .agents/master-prompt.template.md .agents/prd.template.md docs/adr/0000-adopcion-gobernanza-agentica.md \
    docs/adr/0000-template.md docs/adr/0001-perfiles-y-aplicabilidad.md docs/adr/0003-autonomia-y-continuidad.md \
    docs/adr/0004-producto-comportamiento-y-cierre.md docs/adr/0005-gobernanza-proporcional-al-riesgo.md \
    docs/adr/0006-gobernanza-verificable.md specs/templates/feature.template.md .env.example \
    docs/agent-capabilities.md docs/seed-upgrades.md .github/workflows/verify.yml; do
    printf '# Fixture: %s\nContenido deliberado del contrato.\n' "$file" > "$dir/$file"
  done
  cp "$REPO_ROOT/scripts/verify.sh" "$dir/scripts/verify.sh"
  if [[ -f "$REPO_ROOT/scripts/verify-structure.sh" ]]; then
    cp "$REPO_ROOT/scripts/verify-structure.sh" "$dir/scripts/verify-structure.sh"
  fi
  cp "$REPO_ROOT/scripts/install-hooks.sh" "$dir/scripts/install-hooks.sh"
  cp "$REPO_ROOT/.githooks/pre-commit" "$dir/.githooks/pre-commit"
  # Stubs bound recursion; separate tests prove the root executes and propagates them.
  printf '#!/usr/bin/env bash\nprintf "CONTRACT_REACHED\\n"\n' > "$dir/scripts/tests/verify-contract.sh"
  printf '#!/usr/bin/env bash\nprintf "PILOT_REACHED\\n"\n' > "$dir/scripts/tests/bootstrap-pilot.sh"
  chmod +x "$dir/scripts/verify.sh"
  printf 'phase=seed\n' > "$dir/.agents/project-profile.conf"
}

make_project() {
  local dir="$1" file
  make_seed_fixture "$dir"
  printf 'phase=project\napplication_kind=cli\nsurfaces=terminal\nlanguage=bash\nruntime=bash\nframework=not_applicable\npersistence=not_applicable\nci_platform=not_applicable\n' > "$dir/.agents/project-profile.conf"
  for file in docs/adr/0002-arquitectura-base.md specs/templates/feature.md PROMPT-MAESTRO.md PRD.md docs/learning.md; do
    printf '# Fixture aprobada\nResultado y autoridad de prueba explícitos.\n' > "$dir/$file"
  done
  printf '#!/usr/bin/env bash\nprintf "PROJECT_GATE_REACHED\\n"\n' > "$dir/scripts/verify-project.sh"
  chmod +x "$dir/scripts/verify-project.sh"
}

assert_gate() {
  local expected="$1" dir="$2" label="$3" contains="${4:-}" output actual
  if output="$(cd "$dir" && bash scripts/verify.sh 2>&1)"; then actual=0; else actual=$?; fi
  if [[ "$actual" -eq "$expected" && "$output" == *"$contains"* ]]; then
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf 'FAIL: %s (expected %s and %s, got %s)\n%s\n' "$label" "$expected" "$contains" "$actual" "$output"
  fi
}

seed="$TEMP_ROOT/seed"
make_seed_fixture "$seed"
assert_gate 0 "$seed" 'neutral seed without package.json'
assert_gate 0 "$seed" 'root runs contract tests' CONTRACT_REACHED
assert_gate 0 "$seed" 'root runs pilot' PILOT_REACHED
for file in .agents/stack-presets.md .agents/master-prompt.template.md .agents/prd.template.md \
  docs/adr/0001-perfiles-y-aplicabilidad.md docs/adr/0005-gobernanza-proporcional-al-riesgo.md \
  docs/adr/0006-gobernanza-verificable.md; do
  dir="$TEMP_ROOT/missing-seed-$(basename "$file")"
  make_seed_fixture "$dir"
  rm "$dir/$file"
  assert_gate 1 "$dir" "missing seed $file" "$file"
done
for value in '' '   '; do
  dir="$TEMP_ROOT/empty-seed"
  make_seed_fixture "$dir"
  printf '%s\n' "$value" > "$dir/AGENTS.md"
  assert_gate 1 "$dir" 'empty/whitespace governance' AGENTS.md
done
for phase in unknown 'seed=project'; do
  printf 'phase=%s\n' "$phase" > "$seed/.agents/project-profile.conf"
  assert_gate 1 "$seed" 'invalid phase' phase
done
printf 'phase=seed\nphase=seed\n' > "$seed/.agents/project-profile.conf"
assert_gate 1 "$seed" 'duplicate phase' phase
rm "$seed/.agents/project-profile.conf"
assert_gate 1 "$seed" 'missing profile' project-profile.conf
make_seed_fixture "$seed"
printf '#!/usr/bin/env bash\nexit 42\n' > "$seed/scripts/tests/verify-contract.sh"
assert_gate 42 "$seed" 'propagate contract failure'
make_seed_fixture "$seed"
printf '#!/usr/bin/env bash\nexit 43\n' > "$seed/scripts/tests/bootstrap-pilot.sh"
assert_gate 43 "$seed" 'propagate pilot failure'
make_seed_fixture "$seed"
printf '#!/usr/bin/env bash\nif\n' > "$seed/scripts/install-hooks.sh"
assert_gate 2 "$seed" 'reject invalid shell syntax' install-hooks.sh

project="$TEMP_ROOT/project"
make_project "$project"
assert_gate 0 "$project" 'project without package.json' PROJECT_GATE_REACHED
assert_gate 0 "$project" 'project also runs contract tests' CONTRACT_REACHED
for file in AGENTS.md STATE.md PRD.md PROMPT-MAESTRO.md docs/learning.md docs/adr/0002-arquitectura-base.md specs/templates/feature.md; do
  dir="$TEMP_ROOT/project-$(basename "$file")"
  make_project "$dir"
  rm "$dir/$file"
  assert_gate 1 "$dir" "missing project $file" "$file"
  printf ' \t\n' > "$dir/$file"
  assert_gate 1 "$dir" "empty project $file" "$file"
done
for marker in 'HITO0_PENDING' '[Nombre del producto y primera entrega]' 'Borrador | Aprobado'; do
  make_project "$project"
  printf '# PRD\n%s\n' "$marker" > "$project/PRD.md"
  assert_gate 1 "$project" 'unresolved critical template' PRD.md
done
for entry in 'PROMPT-MAESTRO.md|[Modalidad, responsable]' 'PROMPT-MAESTRO.md|[Registro ligero en STATE autorizado]' 'docs/adr/0002-arquitectura-base.md|[Detalla la decisión técnica]'; do
  file="${entry%%|*}"
  marker="${entry#*|}"
  make_project "$project"
  printf '# Documento pendiente\n%s\n' "$marker" > "$project/$file"
  assert_gate 1 "$project" 'critical authority or architecture field unresolved' "$file"
done
make_project "$project"
printf '# PRD\n[Guía](docs/learning.md) y REQ-1: salida verificable.\n' > "$project/PRD.md"
assert_gate 0 "$project" 'ordinary markdown links are valid'
printf '# Plantilla\n[Resultado verificable]\n' > "$project/specs/templates/feature.md"
assert_gate 0 "$project" 'reusable spec placeholders allowed'
printf '#!/usr/bin/env bash\nexit 7\n' > "$project/scripts/verify-project.sh"
assert_gate 7 "$project" 'propagate project verifier failure'
rm "$project/scripts/verify-project.sh"
assert_gate 1 "$project" 'missing project verifier' verify-project.sh
make_project "$project"
chmod -x "$project/scripts/verify-project.sh"
assert_gate 1 "$project" 'non-executable verifier' verify-project.sh
for key in application_kind surfaces language runtime framework persistence ci_platform; do
  make_project "$project"
  sed -i "/^$key=/d" "$project/.agents/project-profile.conf"
  assert_gate 1 "$project" "missing $key" "$key"
  printf '%s=undecided\n' "$key" >> "$project/.agents/project-profile.conf"
  assert_gate 1 "$project" "undecided $key" "$key"
  sed -i "s/^$key=.*/$key=   /" "$project/.agents/project-profile.conf"
  assert_gate 1 "$project" "whitespace $key" "$key"
  printf '%s=duplicate\n' "$key" >> "$project/.agents/project-profile.conf"
  assert_gate 1 "$project" "duplicate $key" "$key"
done
make_project "$project"
sed -i 's/phase=project/phase=initializing/' "$project/.agents/project-profile.conf"
assert_gate 0 "$project" 'initializing runs project gate and stays pending' 'pendiente de sellado'
rm "$project/.agents/bootstrap.md"
assert_gate 1 "$project" 'initialization retains recovery entrypoint' bootstrap.md

hook_repo="$TEMP_ROOT/hooks"
mkdir -p "$hook_repo/scripts" "$hook_repo/.githooks"
git -C "$hook_repo" init --quiet
cp "$REPO_ROOT/scripts/install-hooks.sh" "$hook_repo/scripts/"
cp "$REPO_ROOT/.githooks/pre-commit" "$hook_repo/.githooks/"
bash "$hook_repo/scripts/install-hooks.sh" >/dev/null
if [[ "$(git -C "$hook_repo" config --local --get core.hooksPath)" == .githooks ]]; then
  PASS_COUNT=$((PASS_COUNT + 1))
else
  FAIL_COUNT=$((FAIL_COUNT + 1))
  printf 'FAIL: hook installation\n'
fi
printf 'verify contract: %s passed, %s failed\n' "$PASS_COUNT" "$FAIL_COUNT"
[[ "$FAIL_COUNT" -eq 0 ]]
