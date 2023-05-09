// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract realEstate {
	

	uint8 public avgBlockTime;                          
	uint8 private decimals;                             
	uint8 public tax;                               	
	uint8 public rentalLimitMonths;                     
	uint256 public rentalLimitBlocks;                   
	uint256 constant private MAX_UINT256 = 2**256 - 1;  
	uint256 public totalSupply;                         
	uint256 public totalSupply2;                        
	uint256 public rentPer30Day;                       
	uint256 public accumulated;                         
	uint256 public blocksPer30Day;                      
	uint256 public rentalBegin;                         
	uint256 public occupiedUntill;                      
	uint256 private taxdeduct;                         


	string public name;                                
	string public symbol;                               

	address public gov = msg.sender;    	            
	address public mainPropertyOwner;                   
	address public tenant;                              

	address[] public stakeholders;                      

	mapping (address => uint256) public revenues;       
	mapping (address => uint256) public shares;         
	mapping (address => mapping (address => uint256)) private allowed;   
	mapping (address => uint256) public rentpaidUntill; 
	mapping (address => uint256) public sharesOffered;  
    mapping (address => uint256) public shareSellPrice; 




	// Define events


	event ShareTransfer(address indexed from, address indexed to, uint256 shares);
	event Seizure(address indexed seizedfrom, address indexed to, uint256 shares);
	event ChangedTax(uint256 NewTax);
	event MainPropertyOwner(address NewMainPropertyOwner);
	event NewStakeHolder(address StakeholderAdded);
	event CurrentlyEligibletoPayRent(address Tenant);
	event PrePayRentLimit (uint8 Months);
	event AvgBlockTimeChangedTo(uint8 s);
	event RentPer30DaySetTo (uint256 WEIs);
	event StakeHolderBanned (address banned);
	event RevenuesDistributed (address shareholder, uint256 gained, uint256 total);
	event Withdrawal (address shareholder, uint256 withdrawn);
	event Rental (uint256 date, address renter, uint256 rentPaid, uint256 tax, uint256 distributableRevenue, uint256 rentedFrom, uint256 rentedUntill);
	event SharesOffered(address Seller, uint256 AmmountShares, uint256 PricePerShare);
	event SharesSold(address Seller, address Buyer, uint256 SharesSold,uint256 PricePerShare);

    	constructor (string memory _propertyID, string memory _propertySymbol, address _mainPropertyOwner, uint8 _tax, uint8 _avgBlockTime) {
		shares[_mainPropertyOwner] = 100;                   
		totalSupply = 100;                                  
		totalSupply2 = totalSupply**2;                      
		name = _propertyID;
		decimals = 0;
		symbol = _propertySymbol;
		tax = _tax;                                         
		mainPropertyOwner = _mainPropertyOwner;
		stakeholders.push(gov);                             
		stakeholders.push(mainPropertyOwner);
		allowed[mainPropertyOwner][gov] = MAX_UINT256;      
		avgBlockTime = _avgBlockTime;                       
	    blocksPer30Day = 60*60*24*30/avgBlockTime;
	    rentalLimitMonths = 12;                                   
	    rentalLimitBlocks = rentalLimitMonths * blocksPer30Day;
	}

	// Define modifiers in this section

	modifier onlyGov{
	  require(msg.sender == gov);
	  _;
	}
	modifier onlyPropOwner{
	    require(msg.sender == mainPropertyOwner);
	    _;
	}
	modifier isMultipleOf{
	   require(msg.value % totalSupply2 == 0);              
	    _;
	}
	modifier eligibleToPayRent{                             
	    require(msg.sender == tenant);
	    _;
	}


	// Define functions in this section

//viewable functions

	function showSharesOf(address _owner) public view returns (uint256 balance) {       
		return shares[_owner];
	}

	 function isStakeholder(address _address) public view returns(bool, uint256) {      
	    for (uint256 s = 0; s < stakeholders.length; s += 1){
	        if (_address == stakeholders[s]) return (true, s);
	    }
	    return (false, 0);
	 }

    function currentTenantCheck (address _tenantcheck) public view returns(bool,uint256){               
        require(occupiedUntill == rentpaidUntill[tenant], "The entered address is not the current tenant");
        if (rentpaidUntill[_tenantcheck] > block.number){
        uint256 daysRemaining = (rentpaidUntill[_tenantcheck] - block.number)*avgBlockTime/86400;       
        return (true, daysRemaining);                                                                   
        }
        else return (false, 0);
    }

    receive () external payable {                   
        (msg.sender).transfer(msg.value);
        }
}