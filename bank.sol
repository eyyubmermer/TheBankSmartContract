//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract AddressWallets{

    address payable[] investorWallets;
    mapping(address => uint) investors;



    function ParaYatir() payable public{
        investorWallets.push(payable(msg.sender));
        investors[msg.sender]=msg.value;
    }

    function Bakiyeniz() public view returns(uint){
        return investors[msg.sender];
    }

    function ParaCek(uint refundAmount) public{
        require(refundAmount<investors[msg.sender], "Yetersiz Bakiye!");
        payable(msg.sender).transfer(refundAmount);
        investors[msg.sender]=investors[msg.sender]-refundAmount;
    }


}

