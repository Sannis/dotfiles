#!/usr/bin/env bash
# Tests for gcloud-permissions.sh

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOK="$SCRIPT_DIR/gcloud-permissions.sh"

pass=0
fail=0

run_hook() {
    local command="$1"
    jq -n --arg cmd "$command" '{"tool_name":"Bash","tool_input":{"command":$cmd}}' | bash "$HOOK"
}

assert_approved() {
    local command="$1"
    local output decision
    output=$(run_hook "$command")
    decision=$(printf '%s' "$output" | jq -r '.hookSpecificOutput.permissionDecision // empty')
    if [[ "$decision" == "allow" ]]; then
        echo "PASS  approved: $command"
        pass=$((pass + 1))
    else
        echo "FAIL  expected approved, got '${decision:-empty}': $command"
        fail=$((fail + 1))
    fi
}

assert_deferred() {
    local command="$1"
    local output
    output=$(run_hook "$command")
    if [[ -z "$output" ]]; then
        echo "PASS  deferred: $command"
        pass=$((pass + 1))
    else
        local decision
        decision=$(printf '%s' "$output" | jq -r '.hookSpecificOutput.permissionDecision // empty')
        echo "FAIL  expected deferred (no output), got '$decision': $command"
        fail=$((fail + 1))
    fi
}

echo "=== Read commands (should be auto-approved) ==="
assert_approved "gcloud compute instances list"
assert_approved "gcloud compute instances list --format=json --filter=status:RUNNING"
assert_approved "gcloud sql instances describe my-instance --project=my-project"
assert_approved "gcloud iam service-accounts get-iam-policy sa@project.iam.gserviceaccount.com"
assert_approved "gcloud projects list"
assert_approved "gcloud config list"
assert_approved "gcloud info"
assert_approved "gcloud version"

echo ""
echo "=== Write commands (should be deferred) ==="
assert_deferred "gcloud compute instances create my-vm --zone=us-central1-a"
assert_deferred "gcloud sql instances delete my-instance"
assert_deferred "gcloud iam service-accounts create my-sa --display-name=test"
assert_deferred "gcloud compute firewall-rules update allow-http --allow=tcp:80,tcp:443"
assert_deferred "gcloud projects delete my-project"

echo ""
echo "=== Command injection attempts (should be deferred even with a read verb) ==="
assert_deferred "gcloud compute instances list; rm -rf ~"
assert_deferred "gcloud compute instances list && cat /etc/passwd"
assert_deferred "gcloud compute instances list | tee /tmp/out"
assert_deferred "gcloud compute instances list \$(echo pwned)"

echo ""
echo "=== Non-gcloud commands (should be deferred) ==="
assert_deferred "ls -la"
assert_deferred "kubectl get pods"
assert_deferred "terraform plan"

echo ""
echo "Results: $pass passed, $fail failed"
[[ $fail -eq 0 ]]
