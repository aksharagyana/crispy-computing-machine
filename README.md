# crispy-computing-machine

## GPG

1. Create a GPG key
`export KEY_NAME="tf_state_encrpt"
export KEY_COMMENT="Encrypt TF state"
gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF`
2. List keys - `gpg -k`
3. Export Public Key. This command will export an ascii armored version of the public key:

`gpg --output public.pgp --armor --export 5E9B922FF457700C2673DCF83B4E4CF8A75DA160`

4. Export Secret Key. This command will export an ascii armored version of the secret key:

`gpg --output private.pgp --armor --export-secret-key 5E9B922FF457700C2673DCF83B4E4CF8A75DA160`

6. GPG import private key - `gpg --import /code/azure/private.pgp`


## sops
1. Encrypt - `sops -p 5E9B922FF457700C2673DCF83B4E4CF8A75DA160  -e terraform.tfstate > encrpted_terraform.tstate`

2. Decrypt - `sops -p 5E9B922FF457700C2673DCF83B4E4CF8A75DA160  -d encrpted_terraform.tstate > decrypted_terraform.tfstate`

3. SOPS Configuration -  let SOPS know we will use the previously generated PGP key for encryption/decryption. To do so, create a file named .sops.yaml
`creation_rules:
    - pgp: >-
      5E9B922FF457700C2673DCF83B4E4CF8A75DA160`

Notes: (https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/azure-policy-recommended-practices/ba-p/3798024)https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/azure-policy-recommended-practices/ba-p/3798024
https://mthai.medium.com/how-to-run-terraform-tasks-in-azure-devops-273935089536


TerraformTaskV4
https://github.com/microsoft/azure-pipelines-terraform/tree/main/Tasks/TerraformTask/TerraformTaskV4
Parameters of the task

    Display name*: Provide a name to identify the task among others in your pipeline.

    Provider*: Select the provider in which your resources will be managed by Terraform. Currently, the following providers are supported:
        azurerm
        aws
        gcp

    Command*: Select the terraform command to execute. Currently, the following commands are supported:
        init
        validate
        plan
        apply
        destroy
        show
        output
        custom

    Configuration directory*: Select the directory that contains all the relevant terraform config (.tf) files. The task intends to use Terraform to build infrastructure on one provider at a time. So, all the config files in the configuration directory together should not specify more than one provider.

    Additional command arguments*: Provide any additional arguments for the selected command either as key-value pairs(-key=value) or as command line flags(-flag). Multiple options can also be provided delimited by spaces(-key1=value1 -key2=value2 -flag1 -flag2).

Examples: - -out=tfplan (for terraform plan) - tfplan -auto-approve (for terraform apply)

Options specific to terraform init command

    Options specific to AzureRM backend configuration
        Azure subscription*: Select the Azure subscription to use for AzureRM backend configuration
        Resource group*: Select the name of the resource group in which you want to store the terraform remote state file
        Storage account*: Select the name of the storage account belonging to the selected resource group in which you want to store the terraform remote state file
        Container*: Select the name of the Azure Blob container belonging to the storage account in which you want to store the terraform remote state file
        Key*: Specify the relative path to the state file inside the selected container. For example, if you want to store the state file, named terraform.tfstate, inside a folder, named tf, then give the input "tf/terraform.tfstate"

Standard terraform run commands in Ado - https://spacelift.io/blog/terraform-azure-devops
