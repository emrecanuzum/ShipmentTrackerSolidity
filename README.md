# ShipmentTrackerSolidity
 Shipment Tracking System with Solidity ^0.8.0

This code is a smart contract written in the Solidity programming language for the Ethereum blockchain. The contract is called ShipmentTracker and it allows for tracking the location of shipments using a mapping of shipment ID to location data. The contract also has a feature for scheduling updates of the location of a shipment. The contract is using the OpenZeppelin library's SafeMath library, which provides a safe and secure way to perform arithmetic operations on the uint256 data type.

###The contract has the following structure and functions:

owner: The address of the contract owner, which is set to the address of the account that deployed the contract during its construction.
locations: A public mapping of shipment ID to location data, which is represented by the LocationData struct.
LocationUpdated: An event that is emitted when the location of a shipment is updated, which includes the shipment ID and the location as indexed and non-indexed parameters respectively.
LocationData: A struct that represents the location data of a shipment and contains the location and a timestamp.
constructor(): The constructor function is called when the contract is deployed and it sets the owner address to the address of the account that deployed the contract.
scheduleUpdates: function for schedule updates of the location of a shipment, it uses the timestamp from the latest block to calculate the timestamp of the next 10-minute interval and stores the timestamp, shipment ID and location in storage.
getLocation: A view function returns the current location of a shipment.
executeScheduledUpdates: A function to execute any scheduled updates, it check if the scheduled time has reached or passed and then updates the location accordingly if it has, then removes the scheduled update from storage.
The updateLocation function is used to update the location of a shipment. This function can only be called by the owner of the contract, as specified by the require(msg.sender == owner, "Only the contract owner can update the location of a shipment"); line. If the caller is not the owner, the transaction will be reverted with an error message.

The scheduleUpdates function is used to schedule updates of the location of a shipment. This function requires a shipment ID and a location as input, and it calculates the timestamp of the next 10-minute interval using the block.timestamp variable and the arithmetic operation to reach next 10-minute. It then stores the timestamp, shipment ID, and location in storage arrays.

The getLocation function is a view function that returns the current location of a shipment. It takes a shipment ID as input and returns the location data for that shipment ID from the locations mapping.

The executeScheduledUpdates function is used to execute any scheduled updates. It iterates through the scheduled updates and checks if the current scheduled update is due by comparing the scheduledTimestamps[i] with the block.timestamp variable. If the scheduled update is due, it calls the updateLocation function with the appropriate shipment ID and location, and then removes the scheduled update from storage.

The contract also uses OpenZeppelin's SafeMath library to perform arithmetic operations on the uint256 data type. This is specified by the using SafeMath for uint256; line at the top of the contract. This is important to prevent overflow and underflow errors that can occur when working with large integers.

Finally, the license of the code is specified by the "SPDX-License-Identifier" at the top of the code, it is currently set to "SPDX-License", which indicates that the license for this code is not specified. It is recommended to specify the appropriate license for your code so that others know how they can use it.
