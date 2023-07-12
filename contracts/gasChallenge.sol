// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract gasChallenge {
    // Using a fixed-size array allocates memory for the array upfront, resulting in reduced gas consumption
    uint[10] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    //Function to check for sum of array
    //No changes required in this function
    function getSumOfArray() public view returns (uint256) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    function notOptimizedFunction() public {
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = 0;
        }
    }

    //Implementing Remaining Gas Optimization Techniques Here
    //Sum of elements in the numbers array should equal 0
    function optimizedFunction() public {
        // Cache the state variable accessing the local array
        // Accessing the local array instead of the state variable inside the loop reduces gas consumption
        uint[10] memory cachedNumbers = numbers;

        // Use unchecked block to skip overflow checks 
        // The loop that sets each element to 0 is enclosed within the unchecked block. 
        // This allows the contract to skip expensive overflow checks, resulting in reduced gas consumption
        unchecked {
            for (uint i = 0; i < cachedNumbers.length; i++) {
                cachedNumbers[i] = 0;
            }
        }
       
        // Assign the updated values back to the state variable
        // Using ++i syntax can potentially optimize gas consumption in certain situations
        // as it avoids an additional operation to store the incremented value
        for (uint i = 0; i < numbers.length; ++i) {
            numbers[i] = cachedNumbers[i]; 
        }
    }
}
