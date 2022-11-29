$ResourceGroupName="powershell-grp"
$VirtualNetworkName="app-network"

# Get the virtual network object first
$VirtualNetwork=Get-AzVirtualNetwork -ResourceGroup $ResourceGroupName -Name $VirtualNetworkName

# Access the array of Subnets and the index of the subnet,
# then access the Network Security Group property of that subnet
$NetworkSecurityGroup=$VirtualNetwork.Subnets[0].NetworkSecurityGroup

# Access the Id property of the Network Security Group
$NetworkSecurityGroupId=$NetworkSecurityGroup.Id

# The NSG Id is a string separated with '/', with the string name of the NSG at the very end
$Length=$NetworkSecurityGroupId.Length
$Position=$NetworkSecurityGroupId.LastIndexOf('/')

# Using the Substring method to grab JUST the NSG name (StartingIndexPosition, NumberOfCharacters)
$NetworkSecurityGroupName=$NetworkSecurityGroupId.Substring($Position+1,$Length-$Position-1)

# Network Security Groups cannot be deleted when in use by subnets or network interfaces
#Remove-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NetworkSecurityGroupName -Force

# Hence we first need to ensure that we remove the association of the Network Security Group
$VirtualNetwork.Subnets[0].NetworkSecurityGroup=$null

$VirtualNetwork | Set-AzVirtualNetwork

Remove-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NetworkSecurityGroupName -Force
