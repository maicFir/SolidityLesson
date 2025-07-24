pragma solidity ^0.8.20;

struct Funder {
    address addr;
    uint amount;
}
contract CrowFunding {
    struct Campaign {
        address payable bebeneficiary;
        uint fundingGoal;
        uint numFounders;
        uint amount;
        mapping(uint => Funder) funders;
    }
    uint numCampaigns;
    mapping(uint => Campaign) campaigns; // mapping of campaign id to campaign

    function newCampaign(
        address payable beneficiary,
        uint goal
    ) public returns (uint compaignID) {
        compaignID = numCampaigns++;
        Campaign storage c = campaigns[compaignID];
        c.bebeneficiary = beneficiary;
        c.fundingGoal = goal;
    }
    function contribute(uint compaignID) public payable {
        Campaign storage c = campaigns[compaignID];
        c.funders[c.numFounders++] = Funder({
            addr: msg.sender,
            amount: msg.value
        });
        c.amount += msg.value;
    }

    // function checkGoalReached(
    //     uint campaignID
    // ) public view returns (bool reached) {
    //     Campaign storage c = campaigns[campaignID];
    //     if (c.amount < c.fundingGoal) {
    //         return false;
    //     }
    //     uint amount = c.amount;
    //     c.amount = 0;
    //     c.bebeneficiary.transfer(amount);
    //     return true;
    // }
}

contract InfoFeed {
    function info() public payable returns (uint ret) {
        return 42;
    }
}

contract Consumer {
    InfoFeed feed;
    mapping(uint => uint) public info;
    function setFeed(InfoFeed addr) public {
        feed = addr;
    }
    function callFeed() public {
        feed.info{value: 10, gas: 800}();
    }
    function set(uint x, uint y) public {
        info[x] = y;
    }
    function setInfo() public {
        // set({x: 1, y: 1});
        set({y: 1, x: 1});
    }
}
