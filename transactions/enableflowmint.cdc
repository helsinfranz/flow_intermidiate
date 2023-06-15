import FungibleToken from 0x01
import FlowToken from 0x01

transaction () {
    let admin : &FlowToken.Administrator

    prepare (signer: AuthAccount) {
        self.admin = signer.borrow<&FlowToken.Administrator>(from: /storage/flowTokenAdmin) ?? panic("You are not the admin")
        signer.save(<- self.admin.createNewMinter(allowedAmount: 1000.0), to: /storage/flowTokenMinter)
    }

    execute {
        log("flow minter created successfully")
    }
}