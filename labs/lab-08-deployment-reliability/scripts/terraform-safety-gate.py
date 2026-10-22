import json
import sys

with open("tfplan.json", "r", encoding="utf-8") as file:
    plan = json.load(file)

blocked = []
allowed = []

for change in plan.get("resource_changes", []):
    address = change.get("address", "")
    actions = change.get("change", {}).get("actions", [])

    if "delete" not in actions:
        continue

    if address == "aws_ecs_task_definition.app":
        allowed.append((address, actions))
    else:
        blocked.append((address, actions))

print("Allowed destructive/replacement changes:")
for address, actions in allowed:
    print(f"  ALLOWED: {address} -> {actions}")

print("Blocked destructive/replacement changes:")
for address, actions in blocked:
    print(f"  BLOCKED: {address} -> {actions}")

if blocked:
    print("ERROR: Terraform plan contains destructive infrastructure changes.")
    sys.exit(1)

print("Terraform safety gate passed.")
