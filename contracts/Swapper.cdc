import FungibleToken from 0x01
import RupeeToken from 0x02
import FlowToken from 0x01

pub contract SwapperContract {

    pub event Swapped (flowAmount: UFix64, RTAmount: UFix64 , by: Address)

    pub resource Swapper{
        init() {}

        pub fun Swap (from: &FungibleToken.Vault, amount: UFix64): @FungibleToken.Vault {

            let pool = SwapperContract.account.borrow<&FlowToken.Vault>(from: /storage/flowToken) ?? panic("Swapper account must have a flow Vault")
            
            pool.deposit(from: <- from.withdraw(amount: amount))
            let minter = SwapperContract.account.borrow<&RupeeToken.Admin>(from: RupeeToken.AdminStoragePath) ?? panic("Swapper Contract must be deployed to rT Admin address")
            return <- minter.mint(amount: 2.0 * amount)
        }

    }

    pub fun mintSwapper() :@Swapper{
        return <- create Swapper()
    }

    init() {
        let signer = self.account
}

}
