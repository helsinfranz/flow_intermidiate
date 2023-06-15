import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

transaction(recipient: Address, amount: UFix64) {

  // Local variables
  let Vault: &RupeeToken.Vault
  let RecipientVault: &RupeeToken.Vault{FungibleToken.Receiver}

  prepare(signer: AuthAccount) {
    // Borrow signer's `&RupeeToken.Vault`
    self.Vault = signer.borrow<&RupeeToken.Vault>(from: RupeeToken.VaultStoragePath) ?? panic ("You do not own a Vault")
    // Borrow recipient's `&RupeeToken.Vault{FungibleToken.Receiver}`
    self.RecipientVault = getAccount(recipient).getCapability(/public/rT)
              .borrow<&RupeeToken.Vault{FungibleToken.Receiver}>() ?? panic ("The receipient does not own a vault")
  }

  // All execution
  execute {
    let tokens <- self.Vault.withdraw(amount: amount)
    self.RecipientVault.deposit(from: <- tokens)

    log ("Transfer Succesfully")
    log(amount.toString().concat(" Transferred to"))
    log(recipient)
  }
}
