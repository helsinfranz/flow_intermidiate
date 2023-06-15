import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

pub fun main (_address: Address): [Wallet] {

  let Vaults : [Wallet] = []

  let account: AuthAccount = getAuthAccount(_address)

  // the other way to make sure the vault is the correct type is implemented here, we simply borrow a RupeeToken Token instead of an AnyResource type
  let rTVault = account.borrow<&RupeeToken.Vault>(from: RupeeToken.VaultStoragePath) ?? panic("The Address does not have a rT vault")
  let flowVault = account.borrow<&FlowToken.Vault>(from: /storage/flowToken) ?? panic("The Address does not have a flow vault")


  // makes sure the vault is the correct type (RupeeToken)
  assert(
    rTVault.getType() == Type<@RupeeToken.Vault>(),
    message: "This is not the correct type. No hacking me today!"
  )

  assert (
    flowVault.getType() == Type<@FlowToken.Vault>(),
    message: " This is not the correct type. No hacking me today!"
  )
      

  account.unlink(/public/rT)
  account.link<&RupeeToken.Vault{FungibleToken.Balance}>(/public/rT, target: RupeeToken.VaultStoragePath)
  let rTwallet = getAccount(_address).getCapability<&RupeeToken.Vault{FungibleToken.Balance}>(/public/rT).borrow() ?? panic ("error0")
  Vaults.append(Wallet("RupeeToken", rTwallet.balance))

  account.unlink(/public/flowToken)
  account.link<&FlowToken.Vault{FungibleToken.Balance}>(/public/flowToken, target: /storage/flowToken)
  let flowwallet = getAccount(_address).getCapability<&FlowToken.Vault{FungibleToken.Balance}>(/public/flowToken).borrow() ?? panic("error1")
  Vaults.append(Wallet("Flow Token", flowwallet.balance))

  log("will return flow and RT token data as structs")
  log(Vaults)
  return Vaults
}

pub struct Wallet {
  pub let tokenName: String
  pub let tokenBalance: UFix64

  init (_ name: String, _ balance: UFix64){
    self.tokenName = name
    self.tokenBalance = balance
  }
}