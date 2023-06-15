import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

transaction (amount: UFix64, receipient: Address) {

    let minter: &RupeeToken.Admin
    let receiver: &RupeeToken.Vault{FungibleToken.Receiver}

    prepare (signer: AuthAccount) {
        self.minter = signer.borrow<&RupeeToken.Admin>(from:RupeeToken.AdminStoragePath) ?? panic ("You are not the rT admin")
        self.receiver = getAccount(receipient).getCapability<&RupeeToken.Vault{FungibleToken.Receiver}>(/public/rT).borrow() ?? panic ("Error, Check your receiver's rT Vault status")
    }

    execute {
        let tokens <- self.minter.mint(amount: amount)
        self.receiver.deposit(from: <- tokens)
        log("Mint rT tokens successfully")
        log(amount.toString().concat(" Tokens minted"))
    }
}