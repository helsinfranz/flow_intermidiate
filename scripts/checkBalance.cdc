import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

pub fun main (_address: Address): UFix64 {

    let account: AuthAccount = getAuthAccount(_address)

    // the other way to make sure the vault is the correct type is implemented here, we simply borrow a RupeeToken Token instead of an AnyResource type
    let Vault = account.borrow<&RupeeToken.Vault>(from: RupeeToken.VaultStoragePath) ?? panic("the address does not have a vault")


    // I couldn't use the type identifier because of the buggy flow playground
    // otherwise the code would have been like:
    // Vault.getType().identifier == "A.02.RupeeToken.Vault"
    // makes sure the vault is the correct type (RupeeToken)
    assert(
        Vault.getType() == Type<@RupeeToken.Vault>(),
        message: "This is not the correct type. No hacking me today!"
        )

      account.unlink(/public/rT)
      account.link<&RupeeToken.Vault{FungibleToken.Balance}>(/public/rT, target: RupeeToken.VaultStoragePath)
      let wallet = getAccount(_address).getCapability<&RupeeToken.Vault{FungibleToken.Balance}>(/public/rT).borrow() ?? panic ("error")


    log("will return Vault balance")
    log(wallet.balance)
    return wallet.balance
}









