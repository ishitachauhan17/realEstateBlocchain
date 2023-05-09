// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RealEstateSale {
    address payable public seller;
    address payable public buyer;
    string public propertyAddress;
    uint public purchasePrice;
    bool public isPaid;

    constructor(address payable _seller, string memory _propertyAddress, uint _purchasePrice) {
        seller = _seller;
        propertyAddress = _propertyAddress;
        purchasePrice = _purchasePrice;
    }

    function buy() public payable {
        require(msg.value == purchasePrice, "Insufficient payment");
        buyer = payable(msg.sender);
        isPaid = true;
    }

    function transfer() public {
        require(msg.sender == buyer, "Unauthorized transfer");
        seller.transfer(address(this).balance);
    }
}
