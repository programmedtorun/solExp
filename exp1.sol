pragma solidity 0.7.5;



// when we deploy the Practice contract it will run the constructor of the Ownable
contract Practice is Ownable {
    mapping(address => uint) balance;
    event balanceAdded(uint amt, address indexed depositedTo);
    event depositEvt(uint val, address depositer);
    event transferEvt(address transferedTo, uint amt);


    // will have value of

    // view can not change state vars but can read them
    //pure means function is not enteracting with any other state var or functions
    // types int, string, bool, uint (non-neg), address.

    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        emit depositEvt(msg.value, msg.sender);
        return balance[msg.sender];
    }

    function withdraw(uint amt) public returns (uint){
        require(balance[msg.sender] >= amt);
        balance[msg.sender] -= amt;
        msg.sender.transfer(amt);
        // msg.sender.transfer(amt);

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
        emit transferEvt(recipient, amt);

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