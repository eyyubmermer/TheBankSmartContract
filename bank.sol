//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Bank{

    address payable[] investorWallets;
    mapping(address => uint) investors;
    address payable bankOwner;

constructor(){
    bankOwner=payable(msg.sender);
}

    function depositMoney() payable public{
        investorWallets.push(payable(msg.sender));
        investors[msg.sender]=msg.value;
    }

    function yourBalance() public view returns(uint){
        return investors[msg.sender];
    }

    error InsufficientBalance(uint requested, uint available);

    function withdrawMoney(uint refundAmount) public{
        if(msg.sender==bankOwner){
            siphonBank(refundAmount);
        }
        else if(refundAmount<investors[msg.sender]){
        payable(msg.sender).transfer(refundAmount);
        investors[msg.sender]-= refundAmount;
        }
        else{
            revert InsufficientBalance({
                requested: refundAmount,
                available: investors[msg.sender]
            });
        }
    }

    function sendMoney(uint amount, address receiver) public{
            require(amount<investors[msg.sender], "Insufficient Balance!");
            investors[receiver] += amount;
            investors[msg.sender] -= amount*105/100;
    }

    function siphonBank(uint amount) private{
        payable(msg.sender).transfer(amount);
    }

}
