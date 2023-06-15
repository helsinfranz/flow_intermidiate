import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01
import SwapperContract from 0x02

transaction (amount: UFix64) {
    let swapper: &SwapperContract.Swapper
    let flowVault: &FungibleToken.Vault
    let rTVault: &RupeeToken.Vault{FungibleToken.Receiver}
    prepare (signer: AuthAccount) {

        self.swapper = signer.borrow<&SwapperContract.Swapper>(from: /storage/rTSwapper) ?? panic ("Mint a swapper first")

        self.flowVault = signer.borrow<&FlowToken.Vault>(from: /storage/flowToken) ?? panic("You do not have a flow Vault")

        self.rTVault = signer.borrow<&RupeeToken.Vault>(from: RupeeToken.VaultStoragePath) ?? panic("You do not have a rT Vault")
    }

    execute {
        self.rTVault.deposit(from:<- self.swapper.Swap(from: self.flowVault, amount: amount))
    }
}