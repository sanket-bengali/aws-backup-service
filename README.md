# AWS Backup service sample scripts

[Introduction to AWS Backup service](https://medium.com/@sanketbengali.23/aws-backup-service-caf886bbfd59)

There are mainly 2 shell scripts to create and delete an EFS backup using [AWS Backup CLI](https://docs.aws.amazon.com/cli/latest/reference/backup/index.html) :

1. my-app-aws-backup-plan-create.sh executes below steps

   a. Create a backup vault
   
   -> Creates a backup vault using my-app-backup-vault-create.json
   
   -> Values to be replaced : <aws_region>, <aws_account_id>, <key_id>
   
   b. Create a backup plan and store id into local variable
   
   -> Creates a backup plan using my-app-backup-plan-create.json
   
   -> This plan schedules backup daily at 9 AM (using cron expression : "cron(0 9 ? * * *)") and retains for 1 day
   
   c. Update the plan id in the respective json files
   
   -> Updates the generated plan_id into respective json files (for backup_selection create and delete operations)
   
   d. Create a backup selection with given resources and store id into local variable
   
   -> Adds AWS resources for the backup to be taken (In this case, EFS)
   
   -> Values to be replaced : <aws_region>, <aws_account_id>, <efs_id>
   
   e. Store backup selection id in respective json files
   
   -> Stores the generated backup_selection_id in the respective json file (for backup_selection delete operation)
   
2. my-app-aws-backup-plan-delete.sh (to undo the create operations in reverse order) executes belows steps

   -> All the values are replaced by the create scripts, hence no need to replace anything in these scripts.
   
   a. Delete backup selection
   
   -> Using the json file : EFS-backup-selection-delete.json
   
   b. Delete backup plan
   
   -> Using the json file : my-app-backup-plan-delete.json
   
   c. Delete backup vault
   
   -> Using json file : my-app-backup-vault-delete.json

## To execute the scripts

#### Pre-requisite : AWS CLI is installed and configured [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

1. Clone this repository : ```git clone https://github.com/sanket-bengali/aws-backup-service.git```

2. Go to the directory : ```cd /path/to/repository/sample_scripts```

3. Replace the values as mentioned above

4. Run the scripts : 

   -> To create : ```./my-app-aws-backup-plan-create.sh```
   
   -> To delete : ```./my-app-aws-backup-plan-delete.sh```

# License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
