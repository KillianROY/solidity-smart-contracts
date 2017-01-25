pragma solidity ^0.4.0;
contract Ballot{
	
	struct Voter{

		uint id; 
		bool hasVoted; //true if the voter has already voted
		uint vote; 		// 

	}

	struct Proposal{
		uint propTitle;  //proposal name
		uint nbVote;	  //cumulated votes for this proposal
	}

	Proposal[] public proposals; // create dynamix array

	mapping(address => Voter) public voters;


	//Constructor
	function Ballot(uint[] allProposals)
	{
		for(uint i = 0; i<allProposals.length; i++)
		{
			Proposal p;
			p.propTitle = allProposals[i];
			p.nbVote = 0;

			proposals.push(p);
		}
	}

	//Modifiers
	function vote(uint proposal)
	{
		Voter sender;

		if(sender.hasVoted){
			throw;
		}
		sender.hasVoted = true;
		sender.vote = proposal;

		proposals[proposal].nbVote +=1;
	}

	function winner()
	{
		uint winnerVote = 0;
		for(uint i = 0; i<proposals.length; i++)
		{
			if(proposals[i].nbVote > winnerVote)
			{
				winnerVote = proposals[i].nbVote;
			}
		}
	}

}