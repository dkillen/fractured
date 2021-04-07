// © 2021. David Killen
// SPDX-License-Identifier: MIT
pragma solidity 0.8.3;

// Property contract represents a parcel of land (and its fixtures) where owndership of the land
// is intended to be fratctional.
// It shouold be noted that this contract and the others forming a part of this project do not
// have any regard to the laws relating to ownership of land. The contract is intended to be part
// of a proof of concept project only and should not be relied upon to be any kind of complete
// solution for fractional ownership of land. This project is not inteded to be a land title
// registry. 
contract Property {

    // Properties representing the distinguishing details of the property.

    // propertyAddress: the address of the property
    string public propertyAddress;

    // titleParticulars: the particulars of the land used by the local land registry.
    // This is based on the torrens title system (used in Australia) where a central regtister of land
    // is the definitive source for determining the legal ownership of land.
    // E.g.: Lot 32 in Deposited Plan 123456 or 32/123456
    string public titleParticulars;

    // maxShares: The maximum number of shares  in the property available.
    uint8 public maxShares;
    
    // allocatedShares: The number of shares currently allocated.
    uint8 public allocatedShares;

    // trustee: the address for the trustee of the property.
    address public trustee;

    // ownerShares: a mapping of ower addresses to the number of shares in the property held by that owner
    mapping(address => uint8) private _ownerShares;

    // balance: the total balance of any ethereum held in the contract
    uint256 balance;

    constructor(
        string memory _propertyAddress,
        string memory _titleParticulars,
        uint8 _maxShares,
        address _trustee
    ) {
        propertyAddress = _propertyAddress;
        titleParticulars = _titleParticulars;
        maxShares = _maxShares;
        allocatedShares = 0;
        balance = 0;
        trustee = _trustee;
    }

    // Allocate function to allocate (quantity) shares to an (owner) address
    function allocate(address owner, uint8 quantity) public {
        require(quantity > 0);
        if (_ownerShares[owner] > 0) {
            _ownerShares[owner] = _ownerShares[owner] + quantity;
        } else {
            _ownerShares[owner] = quantity;
        }
        allocatedShares = allocatedShares + quantity;
    }

    // 
    function shares() public view returns(uint8) {
        return _ownerShares[msg.sender];
    }

    receive() external payable {
        balance = balance + msg.value;
    }
}
