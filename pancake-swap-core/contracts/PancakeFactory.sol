pragma solidity =0.5.16;

import './interfaces/IPancakeFactory.sol';
import './PancakePair.sol';

contract PancakeFactory is IPancakeFactory {
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(PancakePair).creationCode));

    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'Pancake: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); // condition check ? {return this if true} : {return this if false}
        require(token0 != address(0), 'Pancake: ZERO_ADDRESS'); //at the first execution, token0 will be address(0), so this will error? What changes the token0 address.
        require(getPair[token0][token1] == address(0), 'Pancake: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(PancakePair).creationCode; 
        //https://docs.soliditylang.org/en/v0.5.3/units-and-global-variables.html#meta-type
        //Memory byte array that contains the creation bytecode of the contract. 
        //This can be used in inline assembly to build custom creation routines, 
        //especially by using the create2 opcode.
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt) 
            //create2(v, n, p, s)	
            // >create new contract with code mem[p..(p+s)) at 
            //address keccak256(<address> . n . keccak256(mem[p..(p+s))) and send v wei and return the new address
            //mem[a...b) signifies the bytes of memory starting at position a up to (excluding) position b. 
            //Storage[p] signifies the storage contents at position p.
        }
        IPancakePair(pair).initialize(token0, token1); //initialize func in pancakePair.sol
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external { //set fee address function
        require(msg.sender == feeToSetter, 'Pancake: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external { //set fee setter function
        require(msg.sender == feeToSetter, 'Pancake: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
