import Foundation

struct Pet {
    var name: String
    var hunger: Stat
    var cleanliness: Stat
    var fun: Stat
    var energy: Stat
    var wallet: Int
    
    var isAlive: Bool {
        return hunger.value > 0 && cleanliness.value > 0 && fun.value > 0 && energy.value > 0
    }
}
