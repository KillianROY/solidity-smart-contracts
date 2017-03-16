pragma solidity ^0.4.0;

contract Token {

    /// @return total amount of tokens
    function totalSupply() constant returns (uint256 supply) {}

    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) constant returns (uint256 balance) {}

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) returns (bool success) {}

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) returns (bool success) {}

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract LocalCurrency is Token {

    // VARIABLES

    mapping (address => uint256) public balanceOf;
    string public name;
    uint256 public totalSupply;
    
    // MODIFIER

    // CONSTRUCTOR
    function localCurrency(string _coinName, uint256 _initialSupply){
        balanceOf[msg.sender] = _initialSupply;
        name = _coinName;
        totalSupply = _initialSupply;
    }
   

    // FUNCTIONS

    /// @param _owner The address of the account to add new localCurrency
    /// @param _LctoCreate The amount of localCurrency to create
    /// @return Wether the creation is succesful or note
    function createCurrency(address _owner, uint256 _LctoCreate) returns (bool success){
    
         if ( _LctoCreate > 0) {
            balanceOf[_owner] += _LctoCreate;
            totalSupply += _LctoCreate;
            return true;
        } else { return false; }
    }

    /// @param _owner The address of the account to subtract localCurrency
    /// @param _LctoDestruct The amount of localCurrency to destruct
    /// @return Wether the creation is succesful or note
    function destructCurrency(address _owner, uint256 _LctoDestruct) returns (bool success){
        
        if (balanceOf[_owner] >= _LctoDestruct && _LctoDestruct > 0) {
            balanceOf[_owner] -= _LctoDestruct;
            totalSupply -= _LctoDestruct;
            return true;
        } else { return false; }
    }
    
    /// @param _to The address of the account to transfer the amount of localCurrency
    /// @param _value The amount of localCurrency to transfer
    /// @return Wether the transfer is succesful or note
    function transfer(address _to, uint256 _value) returns (bool success) {
        
        if (balanceOf[msg.sender] >= _value && _value > 0) {
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Construct(address indexed _owner, uint256 _value);
    event Destruct(address indexed _owner, uint256 _value);
}

