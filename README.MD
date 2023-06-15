# Flow Assignment

Going to use FlowToken, FTstandard, RupeeToken, Swapper contracts using flow playground.

## Description

Contract for creating a fungible token and able to do multiple tasks according to that like trading, admin power, minting, etc.

## Getting Started

## Initialize

Contract->


1. FlowToken:  The contract for flow tokens for our swap contract.

2. FTstandard:  The official contract interface for fungible tokens.

3. RupeeToken:  The actual fungible token contract for our project.

4. Swapper:   The contract for swapping of tokens for flow.


Scripts->


1. CheckBalance:   This script is used to check our rupee coin balance.

2. Setup: This script is used to check if vault is properly setup.

3. ft and rt:  This script is used to check the balances of flow and rupee token.

4. checkFT:   This script is used to check our flow token balance.

5. totalSupply:   This script is used to check the total supply of rupee token.


Transactions->


1. CreateflowVault:   This transaction is used to Create a flow vault.

2. createRupeeVault:  This transaction is used to Create a rupee vault.

3. enableFlowMint:   This transaction is used to Enable a user to be able to mint a limited number of flow tokens.

4. mint:   This transaction is used to mint rupee tokens to an address.

5. mintflow:   This transaction is used to mint flow tokens to an address.

6. mintSwapper:    This transaction is used to mint an address a swapper resource to be able to swap.

7. transferflow: This transaction is used to transfer flow tokens from one user to another.

8. transfertokens: This transaction is used to transfer rupee tokens from one user to another.

9. swap:   This transaction is used to do the same swap as admin swap but here the tokens are minted instead of transfering from admin.

10. adminswap:   This transaction is used to swap the flow tokens for rupee tokens.


### Executing program

1. Just deploy the contracts like FlowToken, FTstandard to 0x01 address and deploy RupeeToken, Swapper contracts to 0x02.
2. After that run the transaction according to that. 

CreateflowVault -> createRupeeVault -> enableFlowMint -> mintflow -> mint -> transferflow -> transfertokens -> adminswap -> mintSwapper -> swap

Note: remember that many transactions here are admin based and only be called by admins.
