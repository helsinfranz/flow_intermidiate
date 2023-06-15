import SwapperContract from 0x02

transaction () {
    prepare (signer: AuthAccount) {
        signer.save(<- SwapperContract.mintSwapper(), to: /storage/rTSwapper)
        log("Swapper Minted")
    }
}