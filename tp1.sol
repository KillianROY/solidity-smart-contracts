pragma solidity ^0.4.0;
contract Ballot{
	
	struct Voter{

		uint id; 
		bool hasVoted; //true if the voter has already voted
		uint vote; 		// 
		uint numberOfVote;
		uint maxOfVote;
	}

	struct Proposal{
		bytes32 propTitle;  //proposal name
		uint nbVote;	  //cumulated votes for this proposal
	}

	Proposal[] public proposals; // create dynamix array

	mapping(address => Voter) public voters;


	//Constructor
	function Ballot(bytes32[] allProposals, uint maxVote)
	{
		Voter sender;
		sender.maxOfVote = maxVote;
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
		if ( sender.numberOfVote < sender.maxOfVote)
		{
			sender.hasVoted = true;
			sender.vote = proposal;

			proposals[proposal].nbVote +=1;
			sender.numberOfVote +=1;
		}
	}

	function winningProposal() constant
				returns(uint winningProposal)
	{
		uint winningVoteCount = 0;

		for(uint i = 0; i<proposals.length; i++)
		{
			if(proposals[i].nbVote > winningVoteCount)
			{
				winningVoteCount = proposals[i].nbVote;
				winningProposal = i;
			}
		}
	}


	function winner() constant returns (bytes32 winner)
	{	
		winner = proposals[winningProposal()].propTitle;
	}

}