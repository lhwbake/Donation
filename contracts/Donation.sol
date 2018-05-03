pragma solidity ^0.4.17;

//每一个不曾起舞的日子，都是对生命的辜负！
contract Donation {

	address public beneficiary;
	address public organizer;
	uint public numPledge;
	
	event Donate(address from, uint amount);
	event ReFund(address to, uint amount);
	event Transfer(address to, uint amount);
	
	struct Pledge {
		address tonator;
		uint amount;
	}

	Pledge[] pledges;//捐助记录

	function Donation(address owner) public {
		organizer = msg.sender;
		beneficiary = owner;
		numPledge = 0;
	}
	
	function getPot() constant public returns(uint) {
	    require(msg.sender == organizer);
		address myAddress = this;
		return myAddress.balance;
	}

	function pledge() public payable {
		require(msg.sender.balance>=msg.value);
		pledges.push(Pledge({
			tonator : msg.sender,
			amount : msg.value
		}));
		numPledge++;
		emit Donate(msg.sender, msg.value);
	}

	function refund() public {
		require(msg.sender == organizer);
		for (uint i=0; i<pledges.length; i++) {
        	address tonator = pledges[i].tonator;
        	uint amount = pledges[i].amount;
        	pledges[i].amount = 0;
        	tonator.transfer(amount);
        	numPledge--;
        	emit ReFund(tonator, amount);
    	}

	}

	function drawdown() public {
		require(msg.sender == organizer);
		emit Transfer(beneficiary, getPot());
		selfdestruct(beneficiary);
	}

}
