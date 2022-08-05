/* 
Joint Savings Account
---------------------
*/

pragma solidity ^0.5.0;

// Contract
contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Withdraw function with validations around account ownership and withdrawl amaounts
    function withdraw(uint amount, address payable recipient) public {
        require (recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require (address(this).balance > amount, "Insufficient funds!");

        // Conditionally set the last address to withdraw to the recipients address
        if (lastToWithdraw != recipient) {
             lastToWithdraw = recipient;
        }
        // Transfer amount indicated to rcipeint, set the amount last withdrawn and the new contract balance
        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance - amount;
    }

    // Deposit function to deposit funds to the contract address
    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    // Set accounts function to set the account addresses for the withdrawl transaction
    function setAccounts(address payable account1, address payable account2) public{
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function
      function() external payable {
  }
}
