pragma solidity ^0.4.0;
contract Ballot{


	// STRUCTURES

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

	// VARIABLES

	Proposal[] public _proposals; // create dynamix array
	mapping(address => Voter) public _voters;


	// CONSTRUCTOR
	function Ballot(bytes32[] _allProposals, uint _maxVote){

		Voter _sender;
		_sender.maxOfVote = _maxVote;
		for(uint i = 0; i<_allProposals.length; i++)
		{
			Proposal _p;
			_p.propTitle = _allProposals[i];
			_p.nbVote = 0;

			_proposals.push(_p);
		}
	}

	// MODIFIER

	function vote(uint _proposal){

		Voter _sender;

		if(_sender.hasVoted){
			throw;
		}
		if ( _sender.numberOfVote < _sender.maxOfVote)
		{
			_sender.hasVoted = true;
			_sender.vote = _proposal;

			_proposals[_proposal].nbVote +=1;
			_sender.numberOfVote +=1;
		}
	}

	// FUNCTIONS

	function winningProposal() constant returns(uint winningProposal){

		uint _winningVoteCount = 0;

		for(uint i = 0; i<_proposals.length; i++)
		{
			if(_proposals[i].nbVote > _winningVoteCount)
			{
				_winningVoteCount = _proposals[i].nbVote;
				winningProposal = i;
			}
		}
	}

	function winner() constant returns (bytes32 winner){

		winner = _proposals[winningProposal()].propTitle;
	}

}