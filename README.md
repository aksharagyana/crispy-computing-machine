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


