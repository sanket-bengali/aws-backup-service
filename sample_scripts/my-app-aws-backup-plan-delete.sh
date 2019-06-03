#!/bin/sh

# Step 1 : Delete backup selection
aws backup delete-backup-selection --cli-input-json file://EFS-backup-selection-delete.json

# Step 2 : Delete backup plan
aws backup delete-backup-plan --cli-input-json file://my-app-backup-plan-delete.json

# Step 3 : Delete backup vault
aws backup delete-backup-vault --cli-input-json file://my-app-backup-vault-delete.json
