# First  I create the Network Security Group

$SecurityRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
-SourceAddressPrefix * -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 3389

$NetworkSecurityGroupName="app-nsg"
$ResourceGroupName ="powershell-grp"
$Location="East US"

$NetworkSecurityGroup=New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-SecurityRules $SecurityRule1

# Get the Interface name
$VmName="appvm"
$Vm=Get-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName

$NetworkInterfaceId=$Vm.NetworkProfile.NetworkInterfaces[0].Id
$NetworkInterface= Get-AzNetworkInterface -ResourceId $NetworkInterfaceId

$NetworkInterface.NetworkSecurityGroup=$NetworkSecurityGroup
$NetworkInterface | Set-AzNetworkInterface