#!/bin/sh

# Step 1 : Create a backup vault
aws backup create-backup-vault --cli-input-json file://my-app-backup-vault-create.json > /dev/null

# Step 2 : Create a backup plan and store id into local variable
plan_id="$(aws backup create-backup-plan --cli-input-json file://my-app-backup-plan-create.json | awk '$2 == "BackupPlanId" { print $4 }')"
echo "Backup plan id : $plan_id"

# Step 3 : Update the plan id in the respective json files
sed -i "/BackupPlanId/c\    \"BackupPlanId\": \"$plan_id\"" my-app-backup-plan-delete.json
sed -i "/BackupPlanId/c\    \"BackupPlanId\": \"$plan_id\"," EFS-backup-selection-create.json
sed -i "/BackupPlanId/c\    \"BackupPlanId\": \"$plan_id\"," EFS-backup-selection-delete.json

# Step 4 : Create a backup selection with given resources and store id into local variable
selection_id="$(aws backup create-backup-selection --cli-input-json file://EFS-backup-selection-create.json | awk 'FNR == 6 { print $4 }')"
echo "Backup selection id : $selection_id"

# Step 5 : Store backup selection id in respective json files
sed -i "/SelectionId/c\    \"SelectionId\": \"$selection_id\"" EFS-backup-selection-delete.json
