pragma solidity >= 0.8.0<0.9.0;

contract Poll 
{

    //code for Poll ideas from members

    // I am creating my own data types using struct

    struct Idea 
    {
       
    string names; // this is the name of each individual idea
    uint ticketNum; // number of combined ideas 
    }


    // Voters struct determines if members can access the voting, counts the number of votes, and if the members chose vote
    struct Voters
    {
        bool didVote; //this many people chose to vote
        bool voterAccess; //determines if members can access the voting
        uint256 voteTracker; //tracks the number of votes
    }  


    Idea[] public ideas;

    mapping(address => Voters) public members;

    address public moderator;

    // the idea names will only be stored temporarilly until the voting is over
    constructor(string[] memory ideaName) 
    {

        // we will give the moderator the msg.sender role in order to allow them to have control over the contract

        moderator = msg.sender; 

        // the moderator will be counted as 1 vote so we add that here 
        members[moderator].voteTracker = 1;

        // this for loop will add the idea names for the contract when it is launched
        for(uint i=0; i<ideaName.length; i++)
        {
            ideas.push(Idea({
                names: ideaName[i],
                // we start the vote count at zero in ordre to make sure ther is no unfair advantage
                ticketNum: 0

            }));
        }
    }
}