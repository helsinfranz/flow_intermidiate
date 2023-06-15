import RupeeToken from 0x02

pub fun main (): UFix64 {
    log("rT total supply is: ".concat(RupeeToken.totalSupply.toString()))
    return RupeeToken.totalSupply
}