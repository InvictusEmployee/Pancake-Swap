# Pancake-Swap
# Disclaimer, Thanks to the contributor of pancake swap and uniswap project. Also this fork is the project the me and my team made, not a one person's effort. Shout out to all the contribution from a hardworking and dedicated team. This repo is just a fraction of what the complete project looks like, just to show you the prototype of our work. 

## Purpose of this project

  to create and modifiy a new platform from PancakeSwap in order for users to have more various coins offered in the platform other than the ones that are already in BSC. 
  
  to configure the network configuration in order to use with other blockchain network and modify any parameter as we want to.
  
## Instruction

  There are three main components in order to perform a token swap which are 
  #### core > compose of pancakeFactory and pancakePair contracts as the main contracts.
  
  A pancakeFactory contract, a factory contract that calls the pancakePair co
  ntract to create a new liquility pair when user add the first two tokens as the first liquidity pool of its kind. This pair contract also has its own BEP20 and AMM calculation integrated in its contract)
  
 #### periphery > compose of pancakeRouter as a main contract
 
  pancakeRouter contract is a contract that all users will solely interact with for all services whether it be a swapping exact tokens for the others (both ERC20 and native BNB itself which interact with WETH contract to change it to wrapped BNB form), swapping native BNB to ERC20, add liquidity, remove liquidity, etc.
 
  Note : every time we relaunch the pancakeFactory contract, the init_code_hash parameter in pancakeLibrary contract must be changed and hardcode in the contract.
  
  #### frontend > this integrate all the contracts, web3 and backend, React in the same file
  
  all the configuration of blockchain ID, smart contract address and RPC urls, etc. are hardcoded all over the place including src/config/constant, hooks folder, env. folder which needs extensive care from developer to change all of it to be applicable to the new blockchain network, new smart contract addresses, etc. Right now, I and my team are making the instruction for all the configuration that have to be made to make it easiest as it could to fork the pancakeSwap to your blockchain preference.
