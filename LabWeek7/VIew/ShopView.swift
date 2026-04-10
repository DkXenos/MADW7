import SwiftUI

struct ShopView: View {
    @ObservedObject var viewModel: PetViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Shop")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Balance")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(viewModel.pet.wallet)")
                        .font(.title)
                        .bold()
                }
                Spacer()
                Image(systemName: "banknote")
                    .font(.title)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)
            
            Text("UPGRADES")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                UpgradeRow(title: "Max Hunger", currentMax: viewModel.pet.hunger.maxValue, action: viewModel.upgradeHunger, icon: "fork.knife", color: .orange, wallet: viewModel.pet.wallet)
                UpgradeRow(title: "Max Cleanliness", currentMax: viewModel.pet.cleanliness.maxValue, action: viewModel.upgradeCleanliness, icon: "sparkles", color: .blue, wallet: viewModel.pet.wallet)
                UpgradeRow(title: "Max Fun", currentMax: viewModel.pet.fun.maxValue, action: viewModel.upgradeFun, icon: "figure.walk", color: .red, wallet: viewModel.pet.wallet)
                UpgradeRow(title: "Max Energy", currentMax: viewModel.pet.energy.maxValue, action: viewModel.upgradeEnergy, icon: "bolt.fill", color: .purple, wallet: viewModel.pet.wallet)
            }
            
            Spacer()
        }
    }
}

struct UpgradeRow: View {
    let title: String
    let currentMax: Int
    let action: () -> Void
    let icon: String
    let color: Color
    let wallet: Int
    let cost: Int = 50
    
    var disabled: Bool {
        return wallet < cost
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.2))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("\(title) [Current Max: \(currentMax)]")
                    .font(.subheadline)
                    .bold()
                Text("Increases limit by 20")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: action) {
                Text("BUY $\(cost)")
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(disabled ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(disabled)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}
