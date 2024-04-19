username="azureuser"

# Create the group
addgroup "$username"

# Create the user and assign the group
adduser --disabled-password --gecos "" --ingroup "$username" "$username"


apt-get update -y
apt-get install -y curl tar ca-certificates
mkdir -p /mnt/adoagent/
tar -xzf /agent/vsts-agent-linux-x64-3.236.1.tar.gz -C /mnt/adoagent

chown -R azureuser:azureuser /mnt/adoagent/
cd /mnt/adoagent/
./bin/installdependencies.sh

su -u azureuser

./config.sh --unattended --url "https://dev.azure.com/testtde" --auth pat --token "yfgregfyurgeyfgreyifriyf" --pool "ubuntu-vm" --agent "dev-ubuntu-agent" --replace --acceptTeeEula

sudo ./svc.sh install &
./runsvc.sh &

