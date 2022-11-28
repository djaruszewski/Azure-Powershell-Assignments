$AccountName = "appstore40008989121"
$ResourceGroupName="powershell-grp"

# Load the storage account into memory to be used when creating containers
$StorageAccount = Get-AzStorageAccount -Name $AccountName `
-ResourceGroupName $ResourceGroupName

# Create a list of the names of the containers to create
$ContainerNames='containera','containerb','containerc'

# foreach loop that loops through the array and creates a container for each one
foreach($Container in $ContainerNames)
{
    New-AzStorageContainer -Name $Container -Context $StorageAccount.Context
}