pragma solidity 0.8.1;

contract Practice {
    string message;
    mapping (address => uint) balance;
    address owner;
    modifier onlyOwner {
        require(msg.sender == owner);
        _; //run function that the modifier is tied to. 
    }
    
    // will have value of 
    constructor(string memory _message){
        owner = msg.sender; // msg.sender in constructor is contract owner. 
        message = _message;
    }
    // view can not change state vars but can read them 
    //pure means function is not enteracting with any other state var or functions
    function hello() public returns(string memory){
        return message;
    }
    // types int, string, bool, uint (non-neg), address. 
    
    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    function transfer(address recipient, uint amt) public {
        require(balance[msg.sender] >= amt, "balance not sufficient!");
        require(msg.sender != recipient, "don't transfermoney to urself");
        uint prevSenderBal = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amt);
        
        assert(balance[msg.sender] == prevSenderBal - amt); //only throws if something v. off
        //event logs further checks
    }
    function _transfer(address from, address to, uint amt) private {
        if (balance[from] >= amt) {
            balance[from] -= amt;
            balance[to] += amt;
        }
    }
    
    
    
    
    
    
    
}
