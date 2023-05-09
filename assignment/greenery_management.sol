//Greenery management system for BMU must include struct, mapping, inheritance and should be payable 

//SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <0.9.0;
contract greenery_mng {

    struct plants{
        uint workers;
        // uint trees;
        // uint flowers;
        // uint bushes;
        uint cost;
        uint expenditure;
        address bread;
    }

    // uint worker1 = 0;
    // uint tree1 = 0;

    mapping (unit => plants) public plantdetails;
    uint public nextPlantId = 1;  
    event NewPlant(uint PlantId, address bread, uint cost);

    function registerplant (uint cost ,uint expenditure ){
        NewPlant memory newplant = plants(msg.sender, cost , expenditure )
        newPlant[nextPlantId] = NewPlant;

        emit NewPlant(nextPlantId, msg.sender, cost);

        nextPlantId++;
    }

function getPlant(uint PlantItemId) public view returns (uint, uint, uint, addresses) {
       
        require(greeneryItemId < nextPlantId, "Plant does not exist");
        


    


}