contract GreeneryManagementSystem {
    
    // Structure for managing individual greenery items
    struct GreeneryItem {
        address owner;              // Address of the owner of the greenery item
        uint price;                 // Price of the greenery item in wei
        bool isForSale;             // Whether the greenery item is for sale or not
        uint upkeepCost;            // Monthly upkeep cost of the greenery item in wei
        uint lastUpkeepPaid;        // Timestamp of when the last upkeep payment was made
    }
    
    // Mapping to store all the greenery items and their corresponding IDs
    mapping(uint => GreeneryItem) public greeneryItems;
    
    // Variable to keep track of the next available greenery item ID
    uint public nextGreeneryItemId = 1;
    
    // Event that will be emitted when a new greenery item is added
    event NewGreeneryItemAdded(uint greeneryItemId, address owner, uint price);
    
    // Function to add a new greenery item
    function addGreeneryItem(uint price, uint upkeepCost) public {
        // Create a new GreeneryItem struct with the given parameters
        GreeneryItem memory newGreeneryItem = GreeneryItem(msg.sender, price, false, upkeepCost, block.timestamp);
        
        // Add the new greenery item to the mapping
        greeneryItems[nextGreeneryItemId] = newGreeneryItem;
        
        // Emit the NewGreeneryItemAdded event
        emit NewGreeneryItemAdded(nextGreeneryItemId, msg.sender, price);
        
        // Increment the next greenery item ID
        nextGreeneryItemId++;
    }
    
    // Function to get the details of a greenery item
    function getGreeneryItem(uint greeneryItemId) public view returns (address, uint, bool, uint, uint) {
        // Check if the greenery item exists
        require(greeneryItemId < nextGreeneryItemId, "Greenery item does not exist");
        
        // Get the greenery item from the mapping and return its details
        GreeneryItem storage greeneryItem = greeneryItems[greeneryItemId];
        return (greeneryItem.owner, greeneryItem.price, greeneryItem.isForSale, greeneryItem.upkeepCost, greeneryItem.lastUpkeepPaid);
    }
    
    // Function to put a greenery item up for sale
    function putGreeneryItemForSale(uint greeneryItemId) public {
        // Check if the greenery item exists
        require(greeneryItemId < nextGreeneryItemId, "Greenery item does not exist");
        
        // Check if the caller is the owner of the greenery item
        require(greeneryItems[greeneryItemId].owner == msg.sender, "You are not the owner of this greenery item");
        
        // Check if the greenery item is not already for sale
        require(!greeneryItems[greeneryItemId].isForSale, "This greenery item is already for sale");
        
        // Set the isForSale flag to true
        greeneryItems[greeneryItemId].isForSale = true;
    }
    
    // Function to buy a greenery item
    function buyGreeneryItem(uint greeneryItemId) public payable {
        // Check if the greenery item exists
        require(greeneryItemId < nextGreeneryItemId, "Greenery item does not exist");
        
        // Check if the greenery item is for sale
        require(greeneryItems[greeneryItemId].is

    }

