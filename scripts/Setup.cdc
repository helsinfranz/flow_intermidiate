import FungibleToken from 0x01
import RupeeToken from 0x02

pub fun main(_address: Address) {
    let vaultCapability= getAccount(_address).getCapability<&RupeeToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, RupeeToken.adminAccess}>(/public/rT)

    log("rT Vault set up correctly? T/F")
    log(vaultCapability.check())
}
