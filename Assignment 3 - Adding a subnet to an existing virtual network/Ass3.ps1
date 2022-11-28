$ResourceGroupName ="powershell-grp"
$VirtualNetworkName="app-network"
$SubnetName="SubnetB"
$SubnetAddressSpace="10.0.1.0/24"

# Can add a new subnet configuration to the existing virtual network
# First need to get the existing virtual network details

$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName `
-ResourceGroupName $ResourceGroupName

Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace `
-VirtualNetwork $VirtualNetwork

# Then need to update the virtual network accordingly

$VirtualNetwork | Set-AzVirtualNetwork

# Then remove the subnet from the virtual network

Remove-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

$VirtualNetwork | Set-AzVirtualNetwork