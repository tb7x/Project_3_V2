//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Poll 
{

    //code for Poll considerations from members

    // I am creating my own data types using struct

    struct Considerations 
    {
       
    string names; // this is the name of each individual consideration
    uint256 ticketNum; // the total number of combined considerations 
    }


    // Voters struct determines if members can access the voting, counts the number of votes, and if the members chose vote
    struct Members
    {
        bool voterAccess; //determines if members can access the voting
        uint256 voteTracker; //tracks the number of votes
        uint256 didVote; //this many people chose to vote

    }  


    Considerations[] public considerations;

    mapping(address => Members) public voters;

    address public moderator;

    // the names being considered will only be stored temporarily until the voting is over because we are using memory and not storage
    constructor(string[] memory considerationName) 
    {

        // we will give the moderator the msg.sender role in order to allow them to have control over the contract

        moderator = msg.sender; 

        // the moderator will be counted as 1 vote so we add that here 
        voters[moderator].voteTracker = 1;

        // this for loop will add the considered names for the contract when it is launched
        for(uint256 c=0; c<considerationName.length; c++)
        {
            considerations.push(Considerations
            ({
                names: considerationName[c],
                // we start the vote count at zero in ordre to make sure there is no unfair advantage
                ticketNum: 0

            }));
        }
    }

    function allowAccessToVote(address member) public 
    {
        require (msg.sender == moderator,
        'You may vote once the moderator allows you access to the poll');

        require(!voters[member].voterAccess,// the .voterAccess boolean is to allow access or not depending on if they had previosly voted and .didVote is
        'Only one vote per member');        //  a numeric variable required to equal 0 in order for the member to vot
        require(voters[member].didVote == 0);
        
        voters[member]didVote = 1;
    }
     function vote(uint256 consideration) public
        {
            Members storage sender c = voters[msg.sender];
            require(!sender.voterAccess, 'You have already voted for the poll');
            require(sender.didVote !=0, 'This poll has already been voted on and your access has been removed');
            sender.voted = true;
            sender.vote = consideration;

            ideas[idea].ticketNumb = considerations[consideration].ticketNumb + sender.didVote;
        }

        function theSuperiorCArtist()public view returns (uint256 theSuperiorArtist_) 
        {  
            uint256 highestVoteCount = 0;
            for (uint256 c = 0; c < considerations.length; c ++)
            {
                if(considerations[c].ticketNumb > highestVoteCount)
                {
                    highestVoteCount = considerations[c].ticketNumb;
                    theSuperiorArtist_ = c;
                }
            }
        }

        function superiorArtist() public view returns (string superiorArtist_) 
        {
            superiorArtist_ = considerations[superiorArtist()].name;

        }
}