#!/usr/bin/env bash
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEMP_ROOT"' EXIT

PASS_COUNT=0
FAIL_COUNT=0

make_seed_fixture() {
  local dir="$1"
  mkdir -p "$dir/.agents" "$dir/docs/adr" "$dir/specs/templates" "$dir/scripts/tests" "$dir/.githooks" "$dir/.github/workflows"
  cp "$REPO_ROOT/scripts/verify.sh" "$dir/scripts/verify.sh"
  touch \
    "$dir/AGENTS.md" \
    "$dir/README.md" \
    "$dir/STATE.md" \
    "$dir/.agents/bootstrap.md" \
    "$dir/.agents/stack-presets.md" \
    "$dir/.agents/master-prompt.template.md" \
    "$dir/.agents/prd.template.md" \
    "$dir/docs/adr/0000-adopcion-gobernanza-agentica.md" \
    "$dir/docs/adr/0000-template.md" \
    "$dir/docs/adr/0001-perfiles-y-aplicabilidad.md" \
    "$dir/docs/adr/0003-autonomia-y-continuidad.md" \
    "$dir/docs/adr/0004-producto-comportamiento-y-cierre.md" \
    "$dir/specs/templates/feature.template.md" \
    "$dir/.env.example" \
    "$dir/scripts/install-hooks.sh" \
    "$dir/scripts/tests/verify-contract.sh" \
    "$dir/.githooks/pre-commit" \
    "$dir/.github/workflows/verify.yml"
  printf 'phase=seed\n' > "$dir/.agents/project-profile.conf"
}

make_project_manifest() {
  local dir="$1"
  printf 'phase=project\napplication_kind=web\nsurfaces=browser\nlanguage=python\nruntime=cpython\nframework=flask\npersistence=sqlite\nci_platform=github-actions\n' > "$dir/.agents/project-profile.conf"
  mkdir -p "$dir/docs/adr" "$dir/specs/templates"
  touch "$dir/docs/adr/0002-arquitectura-base.md" "$dir/specs/templates/feature.md" "$dir/PROMPT-MAESTRO.md" "$dir/PRD.md" "$dir/docs/learning.md"
}

assert_status() {
  local expected="$1"
  local dir="$2"
  local label="$3"
  local output
  local actual

  if output="$(cd "$dir" && bash scripts/verify.sh 2>&1)"; then
    actual=0
  else
    actual=$?
  fi

  if [[ "$actual" -eq "$expected" ]]; then
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf 'FAIL: %s (expected exit %s, got %s)\n%s\n' "$label" "$expected" "$actual" "$output"
  fi
}

assert_output_contains() {
  local dir="$1"
  local expected="$2"
  local label="$3"
  local output

  if output="$(cd "$dir" && bash scripts/verify.sh 2>&1)" && [[ "$output" == *"$expected"* ]]; then
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf 'FAIL: %s (expected output to contain: %s)\n%s\n' "$label" "$expected" "${output:-<no output>}"
  fi
}

assert_failure_contains() {
  local dir="$1"
  local expected="$2"
  local label="$3"
  local output
  local actual

  if output="$(cd "$dir" && bash scripts/verify.sh 2>&1)"; then
    actual=0
  else
    actual=$?
  fi

  if [[ "$actual" -ne 0 && "$output" == *"$expected"* ]]; then
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf 'FAIL: %s (expected a failing gate mentioning: %s)\n%s\n' "$label" "$expected" "${output:-<no output>}"
  fi
}

VALID_SEED="$TEMP_ROOT/valid-seed"
make_seed_fixture "$VALID_SEED"
assert_status 0 "$VALID_SEED" "accept a complete technology-neutral seed without package.json"

for required in .agents/stack-presets.md .agents/master-prompt.template.md .agents/prd.template.md; do
  fixture="$TEMP_ROOT/missing-$(basename "$required")"
  make_seed_fixture "$fixture"
  rm "$fixture/$required"
  assert_failure_contains "$fixture" "$required" "reject seed without $required"
done

MISSING_SEED="$TEMP_ROOT/missing-seed"
make_seed_fixture "$MISSING_SEED"
rm "$MISSING_SEED/docs/adr/0001-perfiles-y-aplicabilidad.md"
assert_status 1 "$MISSING_SEED" "reject a seed missing a required governance artifact"

PROJECT="$TEMP_ROOT/project-without-package"
make_seed_fixture "$PROJECT"
make_project_manifest "$PROJECT"
cat > "$PROJECT/scripts/verify-project.sh" <<'SCRIPT'
#!/usr/bin/env bash
printf 'PROJECT_GATE_REACHED\n'
SCRIPT
chmod +x "$PROJECT/scripts/verify-project.sh"
assert_status 0 "$PROJECT" "dispatch project verification from the explicit phase without package.json"
assert_output_contains "$PROJECT" "PROJECT_GATE_REACHED" "run the profile-specific verifier"

for required in PROMPT-MAESTRO.md docs/learning.md PRD.md; do
  fixture="$TEMP_ROOT/missing-project-$(basename "$required")"
  make_seed_fixture "$fixture"
  make_project_manifest "$fixture"
  cp "$PROJECT/scripts/verify-project.sh" "$fixture/scripts/verify-project.sh"
  chmod +x "$fixture/scripts/verify-project.sh"
  rm "$fixture/$required"
  assert_failure_contains "$fixture" "$required" "reject project without $required"
done

FAILED_PROJECT="$TEMP_ROOT/failed-project-gate"
make_seed_fixture "$FAILED_PROJECT"
make_project_manifest "$FAILED_PROJECT"
printf '#!/usr/bin/env bash\nexit 7\n' > "$FAILED_PROJECT/scripts/verify-project.sh"
chmod +x "$FAILED_PROJECT/scripts/verify-project.sh"
assert_status 7 "$FAILED_PROJECT" "propagate the project verifier failure without declaring success"

MISSING_PROJECT_GATE="$TEMP_ROOT/missing-project-gate"
make_seed_fixture "$MISSING_PROJECT_GATE"
make_project_manifest "$MISSING_PROJECT_GATE"
assert_status 1 "$MISSING_PROJECT_GATE" "reject project phase without a project verifier"

INCOMPLETE_PROFILE="$TEMP_ROOT/incomplete-profile"
make_seed_fixture "$INCOMPLETE_PROFILE"
make_project_manifest "$INCOMPLETE_PROFILE"
awk -F= '$1 != "framework"' "$INCOMPLETE_PROFILE/.agents/project-profile.conf" > "$INCOMPLETE_PROFILE/.agents/project-profile.conf.tmp"
mv "$INCOMPLETE_PROFILE/.agents/project-profile.conf.tmp" "$INCOMPLETE_PROFILE/.agents/project-profile.conf"
assert_failure_contains "$INCOMPLETE_PROFILE" "framework" "report an unset project profile field"

DUPLICATE_PROFILE="$TEMP_ROOT/duplicate-profile-field"
make_seed_fixture "$DUPLICATE_PROFILE"
make_project_manifest "$DUPLICATE_PROFILE"
printf 'language=rust\n' >> "$DUPLICATE_PROFILE/.agents/project-profile.conf"
assert_failure_contains "$DUPLICATE_PROFILE" "exactamente una vez: language" "reject a duplicate project profile field"

INVALID_PHASE="$TEMP_ROOT/invalid-phase"
make_seed_fixture "$INVALID_PHASE"
printf 'phase=unknown\n' > "$INVALID_PHASE/.agents/project-profile.conf"
assert_status 1 "$INVALID_PHASE" "reject an unknown phase"

HOOK_REPO="$TEMP_ROOT/hook-install"
mkdir -p "$HOOK_REPO/scripts" "$HOOK_REPO/.githooks"
git -C "$HOOK_REPO" init --quiet
cp "$REPO_ROOT/scripts/install-hooks.sh" "$HOOK_REPO/scripts/install-hooks.sh"
cp "$REPO_ROOT/.githooks/pre-commit" "$HOOK_REPO/.githooks/pre-commit"
chmod +x "$HOOK_REPO/scripts/install-hooks.sh" "$HOOK_REPO/.githooks/pre-commit"
if output="$(bash "$HOOK_REPO/scripts/install-hooks.sh" 2>&1)" && [[ "$(git -C "$HOOK_REPO" config --local --get core.hooksPath)" == ".githooks" ]]; then
  PASS_COUNT=$((PASS_COUNT + 1))
else
  FAIL_COUNT=$((FAIL_COUNT + 1))
  printf 'FAIL: install the local hook in a new clone\n%s\n' "${output:-<no output>}"
fi

printf 'verify contract: %s passed, %s failed\n' "$PASS_COUNT" "$FAIL_COUNT"
[[ "$FAIL_COUNT" -eq 0 ]]
