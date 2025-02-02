# Install chocolately
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Terminal
choco install microsoft-windows-terminal -y

## Start Terminal

# Install Azure CLI
choco install azure-cli -y
# Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi

# Install Kubernetes CLI
choco install kubernetes-cli -y

# Install Helm CLI
choco install kubernetes-helm -y

# Install Terraform
choco install terraform -y

# Install jq
choco install jq -y

# Install VS Code
choco install vscode -y

# Install Edge
choco install microsoft-edge -y

# Install Git
choco install git -y

# Install Azure Storage Explorer
choco install microsoftazurestorageexplorer -y

# Install curl
choco install curl -y

# (Optional) Install Docker for Desktop
# choco install docker-desktop -y
# choco install docker-cli -y

# Configure Auto-Complete
Set-ExecutionPolicy RemoteSigned
# Create profile when not exist
if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts)) {
  New-Item -ItemType File -Path $PROFILE.CurrentUserAllHosts -Force
}
# Open the profile with an editor (e.g. good old Notepad)
# ii $PROFILE.CurrentUserAllHosts
# In the editor add the following lines to the profile:
$powershellProfile=@"
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module posh-git

Import-Module PSReadLine
Set-PSReadLineOption -colors @{ Default = "Green"}
Set-PSReadLineOption -colors @{ Parameter = "Blue"}
Set-PSReadLineOption -colors @{ Command = "Magenta"}

Set-Alias -Name k -Value kubectl

Clear

pwd

"@

$powershellProfile > $PROFILE.CurrentUserAllHosts

## Restart Terminal

# Install Terraform extension in VS Code
code --install-extension hashicorp.terraform

cd .\Desktop\
git clone https://github.com/HoussemDellai/private-aks
cd private-aks
Code .

az login
az account set --subscription "Microsoft Azure #5"
az aks list -o table
az aks get-credentials -g demo0051-aks-rg -n demo0051-aks

cd stage3
terraform init
terraform plan -out tfplan




Invoke-Command -ScriptBlock {Start-Process PowerShell; choco install curl -y; choco install jq -y}