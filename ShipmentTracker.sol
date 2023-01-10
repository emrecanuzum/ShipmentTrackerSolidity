// SPDX-License-Identifier: <SPDX-License>
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract ShipmentTracker {
    
    using SafeMath for uint256;
    // The address of the contract owner
    address public owner;

    // The mapping of shipment ID to location data
    mapping(bytes32 => LocationData) public locations;

    // The event that is emitted when the location of a shipment is updated
    event LocationUpdated(bytes32 indexed shipmentId, string location);

    // The struct that represents the location data of a shipment
    struct LocationData {
        string location;
        uint256 timestamp;
    }

    constructor() {
        owner = msg.sender;
    }


 // The array of scheduled update timestamps
    uint256[] scheduledTimestamps;

    // The array of scheduled shipment IDs
    bytes32[] scheduledShipmentIds;

    // The array of scheduled locations
    string[] scheduledLocations;

    // The count of scheduled updates
    uint256 scheduledUpdatesCount;
    // Update the location of a shipment
    function updateLocation(bytes32 shipmentId, string memory location) public { // memory olmasının sebebi

    // ne kadar süre yol alacağı ve ne sıklıkla güncelleme atacağı bilgisi alınacak.
        // Only the owner of the contract can update the location
        require(msg.sender == owner, "Only the contract owner can update the location of a shipment");

        // Update the location data for the given shipment ID
        locations[shipmentId] = LocationData(location, block.timestamp);

        // Emit the LocationUpdated event
        emit LocationUpdated(shipmentId, location);
    }



    // Schedule the updateLocation function to be called every 10 minutes
    function scheduleUpdates(bytes32 shipmentId, string memory location) public {
    // Calculate the timestamp for the next 10-minute interval
    uint256 interval = 10 minutes;
    uint256 nextUpdateTimestamp = (block.timestamp + interval) / interval * interval;

    // Store the timestamp, shipment ID, and location in storage
    scheduledTimestamps[scheduledUpdatesCount] = nextUpdateTimestamp;
    scheduledShipmentIds[scheduledUpdatesCount] = shipmentId;
    scheduledLocations[scheduledUpdatesCount] = location;

    // Increment the scheduled updates count
    scheduledUpdatesCount = scheduledUpdatesCount.add(1);

    }
       // Get the current location of a shipment
    function getLocation(bytes32 shipmentId) public view returns (string memory) {
        // Return the location for the given shipment ID
        return locations[shipmentId].location;
    }
    
    // Execute any scheduled updates
    function executeScheduledUpdates() public {
        // Iterate through the scheduled updates
        for (uint256 i = 0; i < scheduledUpdatesCount; i++) {
        // Check if the current scheduled update is due
            if (scheduledTimestamps[i] <= block.timestamp) {
                // Get the shipment ID and location for the current scheduled update
                bytes32 shipmentId = scheduledShipmentIds[i];
                string memory location = scheduledLocations[i];

                // Update the location of the shipment
                updateLocation(shipmentId, location);

                // Remove the scheduled update from storage
                delete scheduledTimestamps[i];
                delete scheduledShipmentIds[i];
                delete scheduledLocations[i];

                // Decrement the scheduled updates count
                scheduledUpdatesCount = scheduledUpdatesCount.sub(1);
            }
        }
    }
}