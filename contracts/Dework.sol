// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

import {FreeLancerProfile, EmployerProfile} from "./types/DeworkTypes.sol";


contract Dework {
    uint connectFee = 100;
    address public initialOwner;

    FreeLancerProfile[] public freeLancerProifles;
    EmployerProfile[] public employerProfiles;

    constructor(address _initialOwner){
        initialOwner = _initialOwner;
    }
    
    function getNumberOfRegisterFreeLancers() public view returns(uint256){
       return freeLancerProifles.length;
    }

    function registerFreeLancerProfile(
         string calldata name,
         uint8 experienceYears,
         uint256 hourlyRateWei
    ) external  {
       uint256 freeLancerId = getNumberOfRegisterFreeLancers();

       FreeLancerProfile memory freeLancerProifle = FreeLancerProfile({
             id: freeLancerId,
             name: name,
             wallet: msg.sender,
             experienceYears: experienceYears,
             isAvailableHire:true,
             hourlyRateWei:hourlyRateWei
   
       });
       freeLancerProifles.push(freeLancerProifle);
    }

     function getFreeLancerProfile() public view returns(FreeLancerProfile[] memory) {
        return freeLancerProifles;
     }

     function updateHourlyRate(uint _hourlyRate) public{
       
     }

    //  function getHourlyRate() public view returns(uint){
    //     return hourlyRate;
    //  }

  
    function getNumberOfRegisteredEmployers() public view returns (uint256){
        return employerProfiles.length;
    }
    
    function registerEmployerProfile(string calldata employerName) external  {
        uint256 employerId = getNumberOfRegisteredEmployers();

        EmployerProfile memory employerProfile = EmployerProfile({
            id: employerId,
            name: employerName,
            wallet: msg.sender,
            isHired: true

        });
        employerProfiles.push(employerProfile);
    }    

}


    
   

