// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./main.sol";

contract mainPropertyOwner is main {

    function canPayRent(address _tenant) public onlyPropOwner{                  
	     tenant = _tenant;
	     emit CurrentlyEligibletoPayRent (tenant);
	}
	function limitadvancedrent(uint8 _monthstolimit) onlyPropOwner public{      
	    rentalLimitBlocks = _monthstolimit *blocksPer30Day;
	    emit PrePayRentLimit (_monthstolimit);
	}

    function setRentper30Day(uint256 _rent) public onlyPropOwner{               
	    rentPer30Day = _rent;
	    emit RentPer30DaySetTo (rentPer30Day);
    }

}
