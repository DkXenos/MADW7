import Foundation
import Combine
import SwiftUI

class PetViewModel: ObservableObject {
    @Published var pet: Pet
    @Published var lastEvent: String? = nil
    @Published var eventColor: Color = .black
    
    private var timer: Timer?

    init() {
        self.pet = Pet(
            name: "Jason Tio",
            hunger: Stat(value: 80, maxValue: 150),
            cleanliness: Stat(value: 110, maxValue: 150),
            fun: Stat(value: 100, maxValue: 150),
            energy: Stat(value: 120, maxValue: 150),
            wallet: 100
        )
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.drainStats()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func drainStats() {
        guard pet.isAlive else {
            stopTimer()
            return
        }
        
        pet.hunger.value = max(0, pet.hunger.value - 5)
        pet.cleanliness.value = max(0, pet.cleanliness.value - 5)
        pet.fun.value = max(0, pet.fun.value - 5)
        pet.energy.value = max(0, pet.energy.value - 5)
        
        if !pet.isAlive {
            stopTimer()
        }
    }

    func play() {
        guard pet.isAlive else { return }
            
        let funGain = 25
        let moneyGain = 20
        let energyLoss = 15
        let cleanLoss = 10
        
        pet.fun.value = min(pet.fun.maxValue, pet.fun.value + funGain)
        pet.wallet += moneyGain
        pet.energy.value = max(0, pet.energy.value - energyLoss)
        pet.cleanliness.value = max(0, pet.cleanliness.value - cleanLoss)
        
        showEvent("+25 Fun  +\(moneyGain) Wallet  -15 Energy  -10 Cleanliness", color: .green)
        
        checkDeath()
    }

    func clean() {
        guard pet.isAlive else { return }
        
        // increases “cleanliness” but reduces fun and energy
        let cleanGain = 25
        let funLoss = 10
        let energyLoss = 10
        
        pet.cleanliness.value = min(pet.cleanliness.maxValue, pet.cleanliness.value + cleanGain)
        pet.fun.value = max(0, pet.fun.value - funLoss)
        pet.energy.value = max(0, pet.energy.value - energyLoss)
        
        showEvent("+25 Cleanliness  -10 Fun  -10 Energy", color: .blue)
        
        checkDeath()
    }

    func feed() {
        guard pet.isAlive else { return }
        guard pet.wallet >= 5 else { return }
        
        // increases “hunger” but reduces “cleanliness” and costs $5 every press.
        let hungerGain = 25
        let cleanLoss = 10
        let cost = 5
        
        pet.hunger.value = min(pet.hunger.maxValue, pet.hunger.value + hungerGain)
        pet.cleanliness.value = max(0, pet.cleanliness.value - cleanLoss)
        pet.wallet -= cost
        
        showEvent("+25 Hunger  -$5 Wallet  -10 Cleanliness", color: .orange)
        
        checkDeath()
    }

    func rest() {
        guard pet.isAlive else { return }
        
        let energyGain = 25
        let funLoss = 10
        let hungerLoss = 10
        
        pet.energy.value = min(pet.energy.maxValue, pet.energy.value + energyGain)
        pet.fun.value = max(0, pet.fun.value - funLoss)
        pet.hunger.value = max(0, pet.hunger.value - hungerLoss)
        
        showEvent("+25 Energy  -10 Fun  -10 Hunger", color: .purple)
        
        checkDeath()
    }

    func revive() {
        guard !pet.isAlive else { return }
        pet.wallet = 0
        pet.hunger.value = pet.hunger.maxValue / 2
        pet.cleanliness.value = pet.cleanliness.maxValue / 2
        pet.fun.value = pet.fun.maxValue / 2
        pet.energy.value = pet.energy.maxValue / 2
        
        lastEvent = nil
        startTimer()
    }

    func upgradeHunger() {
        guard pet.wallet >= 50 else { return }
        pet.wallet -= 50
        pet.hunger.maxValue += 20
    }

    func upgradeCleanliness() {
        guard pet.wallet >= 50 else { return }
        pet.wallet -= 50
        pet.cleanliness.maxValue += 20
    }

    func upgradeFun() {
        guard pet.wallet >= 50 else { return }
        pet.wallet -= 50
        pet.fun.maxValue += 20
    }

    func upgradeEnergy() {
        guard pet.wallet >= 50 else { return }
        pet.wallet -= 50
        pet.energy.maxValue += 20
    }

    private func showEvent(_ msg: String, color: Color) {
        lastEvent = msg
        eventColor = color
    }
    
    private func checkDeath() {
        if !pet.isAlive {
            stopTimer()
        }
    }
}
