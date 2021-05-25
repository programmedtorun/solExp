pragma solidity 0.7.5;

contract Ownable {
    address owner;
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    constructor(){
        owner = msg.sender; // msg.sender in constructor is contract owner.
    }
}