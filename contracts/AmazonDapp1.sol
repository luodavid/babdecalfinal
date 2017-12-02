pragma solidity ^0.4.13;

contract AmazonDapp {

    mapping(address => Owner) owners;
    
    struct Owner {
        string name;
        address addr; 
        uint balance;
        uint[] ownedItems; 
    }
    uint[] public ids = new uint[](0); 
    uint numItems = 0;
    mapping(uint => Item) items;
    
    struct Item {
        uint id;
        uint price;
        string name;
        address[] history;
        bool forSale;
        address currentOwner;
    }

    modifier isItemOwner(uint id){
        require(items[id].currentOwner == msg.sender);
        _;
    }

    modifier hasJoined(){
        require(owners[msg.sender].addr != address(0));
        _;
    }

    modifier itemExistsAndIsItemOwner(uint item_id){
        require(items[item_id].id == item_id);
        require(items[item_id].currentOwner == msg.sender);
        _;
    }

    function addItem(uint serial, string n) public returns (string) {
        if (items[serial].id == serial) {
            return "Item already exists. Try again";
        }

        // price is the highest value, actually set the price later
        items[serial] = Item(serial, 99, n, new address[](0), false, msg.sender);
        items[serial].history.push(msg.sender); // set first owner of item
        ids[numItems++] = serial;
        
        return "You have successfully added an item";
    }

    

    function purchase(uint itemID) returns (string) {
        if (owners[msg.sender].balance < items[itemID].price) {
            return "Not enough funds to purchase this item.";
        }

        if (!items[itemID].forSale) {
            return "This item is not for sale.";
        }

        if (items[itemID].currentOwner == msg.sender) {
            return "You are already the owner of this item.";
        }

        owners[msg.sender].balance -= items[itemID].price;
        owners[items[itemID].currentOwner].balance += items[itemID].price;
        items[itemID].currentOwner = msg.sender;
        items[itemID].history.push(msg.sender);
    }
    
    function join(string name) public returns (string) { 
        if (owners[msg.sender].addr == msg.sender) {
            return "You are already part of the contract";
        }
        
        uint[] memory ownedItems;
        owners[msg.sender] = Owner(name, msg.sender, 0, ownedItems);
        return "You have joined the contract!";
    }

    function addFunds() public payable returns(string) {
        if (msg.value <= 0) {
          return "You must add a valid amount.";
      }
      owners[msg.sender].balance += msg.value;
      return "You have successfully added funds.";
    }

    function getFunds() returns (uint) {
        return owners[msg.sender].balance;
    }                               

    function changeToSellable(uint item_id) itemExistsAndIsItemOwner(item_id) {
        items[item_id].forSale = true;
    }

    function changeToNotSellable(uint item_id) itemExistsAndIsItemOwner(item_id) {
        items[item_id].forSale = false;
    }

    function setItemPrice(uint item_id, uint newPrice) itemExistsAndIsItemOwner(item_id){
        items[item_id].price = newPrice; 
    }

    function withdraw(uint amount) returns (string) {
        if (amount > owners[msg.sender].balance) {
            return "Insufficient funds";
        }

        owners[msg.sender].balance -= amount;
        msg.sender.transfer(amount);
        return "Successfully transferred";
    }


    function getOwnerName(address a) returns(string) {
        return owners[a].name;
    }

    function getOwnerBalance(address a) returns(uint) {
        return owners[a].balance;
    }

    function getOwnerItems(address a) returns(uint[]) {
        return owners[a].ownedItems;
    }

    function getItemPrice(uint id) returns(uint) {
        return items[id].price;
    }

    function getItemName(uint id) returns(string) {
        return items[id].name;
    }

    function getItemHistory(uint id) returns(address[]) {
        return items[id].history;
    }

    function getItemForSale(uint id) returns(bool) {
        return items[id].forSale;
    }

    function getItemOwner(uint id) returns(address) {
        return items[id].currentOwner;
    }

    function getAllId() returns(uint[]) {
        return ids;
    }

    function getNumItems() returns(uint) {
        return numItems;
    }

    function () payable {
        revert();
    }

}