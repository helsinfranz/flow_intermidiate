import FungibleToken from 0x01
import RupeeToken from 0x02

transaction () {

    let VaultAccess: &RupeeToken.Vault?

    let VaultCapability: Capability<&RupeeToken.Vault{FungibleToken.Balance, FungibleToken.Receiver}>

    prepare (signer: AuthAccount) {

        self.VaultAccess =  signer.borrow<&RupeeToken.Vault>(from: RupeeToken.VaultStoragePath)
        self.VaultCapability = signer.getCapability<&RupeeToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, RupeeToken.adminAccess}>(/public/rT)

        var condition = (self.VaultAccess.getType() == Type<&RupeeToken.Vault?>()) ? true  : false

        if condition {
            if self.VaultCapability.check() {
                log("Vault is set up properly")
            } else {
                signer.unlink(/public/rT)
                signer.link<&RupeeToken.Vault{FungibleToken.Receiver, FungibleToken.Balance, RupeeToken.adminAccess}>(/public/rT, target: RupeeToken.VaultStoragePath)
            }   
        } else {
                let newVault <- RupeeToken.createEmptyVault()
                signer.unlink(/public/rT)
                signer.save(<- newVault, to: RupeeToken.VaultStoragePath)
                signer.link<&RupeeToken.Vault{FungibleToken.Receiver, FungibleToken.Balance, RupeeToken.adminAccess}>(/public/rT, target: RupeeToken.VaultStoragePath)
        }
    }

    execute {
        log("rT vault set-up correctly")
    }

}
 
