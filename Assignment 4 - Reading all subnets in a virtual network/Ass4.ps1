$VirtualNetworkName="app-network"
$ResourceGroupName="powershell-grp"


# Load the virtual network into memory
$VirtualNetwork=Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName `
-Name $VirtualNetworkName

# load the subnet configurations of the virtual network into memory
$SubnetConfig = $VirtualNetwork | Get-AzVirtualNetworkSubnetConfig

# foreach loop to loop through each subnet and print the name + address of each
foreach($Subnet in $SubnetConfig)
{
    'The Subnet Name is ' + $Subnet.Name
    'The Subnet IP Address is ' + $Subnet.AddressPrefix
}