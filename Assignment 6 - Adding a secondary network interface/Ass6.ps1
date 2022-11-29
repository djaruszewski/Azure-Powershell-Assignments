$VmName="appvm"
$ResourceGroupName="powershell-grp"
$Location="East US"

# First we need to stop the VM
Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Force

$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

$NetworkInterfaceName="secondary-interface"

$NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-Subnet $Subnet

# Then we need to add the network interface to the Azure VM
$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

# We need to set the primary interface currently attached to the VM as true
$Vm.NetworkProfile.NetworkInterfaces[0].Primary=$true

Add-AzVMNetworkInterface -VM $Vm -Id $NetworkInterface.Id

# We then need to update the VM with the new network interface details
Update-AzVM -ResourceGroupName $ResourceGroupName -VM $Vm

# Then we need to ensure the VM is back in the running state
Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName