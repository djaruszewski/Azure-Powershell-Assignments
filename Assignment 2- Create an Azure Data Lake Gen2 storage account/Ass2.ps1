$AccountName = "datalake56663366"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"
$ResourceGroupName="powershell-grp"
$Location = "East US"

# Create the storage account
$StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU -EnableHierarchicalNamespace $true

# Create a container in the storage account
$ContainerName="data"
New-AzStorageContainer -Context $StorageAccount.Context -Name $ContainerName

# Creating a directory to the storage account

$DirectoryName="files"

New-AzDataLakeGen2Item -Context $StorageAccount.Context `
-FileSystem $ContainerName -Path $DirectoryName -Directory

# Uploading a file to the directory

$FileName="sample.txt"
$CompleteStoragePath="files\sample.txt"

New-AzDataLakeGen2Item -Context $StorageAccount.Context `
-FileSystem $ContainerName -Path $CompleteStoragePath `
-Source $FileName -Force