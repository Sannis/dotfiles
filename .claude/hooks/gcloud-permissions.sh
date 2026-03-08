#!/usr/bin/env bash
# PreToolUse hook: auto-approve gcloud read-only commands.
# Write commands produce no output, deferring to Claude's normal approval.
#
# Input:  JSON on stdin (tool_name, tool_input.command)
# Output: JSON permissionDecision if approved, nothing if deferred
#
# Install: symlink or copy to ~/.claude/hooks/ and register in ~/.claude/settings.json

set -eo pipefail

input=$(cat)
command=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')

# Only handle gcloud commands
[[ "$command" =~ ^gcloud[[:space:]] ]] || exit 0

# Defer if the command contains shell metacharacters that could chain other commands
# (e.g. "gcloud compute instances list; rm -rf ~" must not be auto-approved)
# Pattern must be in a variable — bash misparses these chars as literals in [[ =~ ]]
injection_re='[&;|`$]'
if [[ "$command" =~ $injection_re ]]; then
    exit 0
fi

# Extract positional arguments (skip flags starting with -)
positionals=()
read -ra words <<< "$command"
for word in "${words[@]:1}"; do
    [[ "$word" == -* ]] || positionals+=("$word")
done

# Auto-approve if any positional word is a known read-only verb
[[ ${#positionals[@]} -eq 0 ]] && exit 0

for word in "${positionals[@]}"; do
    case "$word" in
        list|describe|export|info|version|help|get|get-*)
            jq -n '{
                hookSpecificOutput: {
                    hookEventName: "PreToolUse",
                    permissionDecision: "allow",
                    permissionDecisionReason: "gcloud read command — pre-approved"
                }
            }'
            exit 0
            ;;
    esac
done

# No read verb found — exit without output, Claude handles approval normally
