// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./main.sol";

contract renter is main {


    function payRent(uint8 _months) public payable isMultipleOf eligibleToPayRent{          
        uint256  _rentdue  = _months * rentPer30Day;
        uint256  _additionalBlocks  = _months * blocksPer30Day;
        require (msg.value == _rentdue && block.number + _additionalBlocks < block.number + rentalLimitBlocks);     
        _taxdeduct = (msg.value/totalSupply * tax);                                 
        accumulated += (msg.value - _taxdeduct);                                    
        revenues[gov] += _taxdeduct;                                                
        if (rentpaidUntill[tenant] == 0 && occupiedUntill < block.number) {         
            rentpaidUntill[tenant] = block.number + _additionalBlocks;              
            rentalBegin = block.number;
        }
        else if (rentpaidUntill[tenant] == 0 && occupiedUntill > block.number) {    
            rentpaidUntill[tenant] = occupiedUntill + _additionalBlocks;            
            rentalBegin = occupiedUntill;
        }
        else if ( rentpaidUntill[tenant] > block.number) {                          
            rentpaidUntill[tenant] += _additionalBlocks;                            
            rentalBegin = occupiedUntill;
        }
        else if (rentpaidUntill[tenant] < block.number && occupiedUntill>block.number) {    
            rentpaidUntill[tenant] = occupiedUntill +_additionalBlocks;                     
            rentalBegin = occupiedUntill;
        }
        else if (rentpaidUntill[tenant] < block.number && occupiedUntill<block.number) {    
            rentpaidUntill[tenant] = block.number + _additionalBlocks;                      
            rentalBegin = block.number;                                                     
        }
        occupiedUntill  = rentpaidUntill[tenant];                                           
        emit Rental (block.timestamp, msg.sender, msg.value, _taxdeduct, (msg.value - _taxdeduct), rentalBegin, occupiedUntill);
    }
}