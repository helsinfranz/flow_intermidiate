import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

transaction (_amount: UFix64, _from: Address) {
    let admin: &RupeeToken.Admin
    let adminRTVault: &RupeeToken.Vault{FungibleToken.Receiver}

    prepare (signer: AuthAccount) {
        pre {
            _amount > UFix64(0): " You can only take tokens greater than zero from rT user "
        }
        self.admin = signer.borrow<&RupeeToken.Admin>(from: RupeeToken.AdminStoragePath) ?? panic (" You are not the admin")
        self.adminRTVault = signer.borrow<&RupeeToken.Vault{FungibleToken.Receiver}>(from: RupeeToken.VaultStoragePath) ?? panic (" error with admin vault")
    } 

    execute {
        let tokensSwapped <-self.admin.AdminSwap(amount: _amount, from: _from)
        self.adminRTVault.deposit(from: <- tokensSwapped)
        log("admin swapped")
    }
    
}