import FungibleToken from 0x01
import RupeeToken from 0x02

transaction () {

    prepare (signer: AuthAccount) {
        signer.unlink(/public/rT)
        signer.link<&RupeeToken.Vault{FungibleToken.Receiver, FungibleToken.Balance, RupeeToken.adminAccess}>(/public/rT, target: RupeeToken.VaultStoragePath)
    }

    execute {
        log("Link rT successfully")
    }
}