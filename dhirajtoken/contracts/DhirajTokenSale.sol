pragma solidity ^0.4.2;

import "./DhirajToken.sol";

contract DhirajTokenSale {
   address admin;
   DhirajToken public tokenContract;
   uint256 public tokenPrice;
   uint256 public tokensSold;

   event Sell(address _buyer, uint256 _amount);
   
   function DhirajTokenSale(DhirajToken _tokenContract, uint256 _tokenPrice) public {
   //assign an admin with special previledges
    admin = msg.sender;
    
   //assign token contract
    tokenContract = _tokenContract;
   //token price
   tokenPrice = _tokenPrice;

   }

  //multiply
  function multiply(uint x, uint y) internal pure returns (uint z) {
  require(y == 0 || (z = x * y) / y == x);
  }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(this) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        tokensSold += _numberOfTokens;

        Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));

        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        admin.transfer(address(this).balance);
    }
}