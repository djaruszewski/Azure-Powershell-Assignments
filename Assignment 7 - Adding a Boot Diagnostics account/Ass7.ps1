# First I create a new storage account

$AccountName = "vmdiagnostics61393"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"
$ResourceGroupName="powershell-grp"
$Location = "East US"

New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU

# Then get the VM details
$VmName="appvm"
$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

# Then set the diagnostics details
Set-AzVMBootDiagnostic -VM $Vm -ResourceGroupName $ResourceGroupName `
-StorageAccountName $AccountName -Enable

# Then I just need to update the virtual machine
Update-AzVM -ResourceGroupName $ResourceGroupName -VM $Vm