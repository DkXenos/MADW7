import SwiftUI

struct WatchStatusView: View {
    @ObservedObject var viewModel: PetViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Status")
                    .font(.headline)
                    .bold()
                
                WatchStatBar(title: "Hunger", stat: viewModel.pet.hunger, color: .orange)
                WatchStatBar(title: "Clean", stat: viewModel.pet.cleanliness, color: .blue)
                WatchStatBar(title: "Energy", stat: viewModel.pet.energy, color: .purple)
                WatchStatBar(title: "Fun", stat: viewModel.pet.fun, color: .red)

            }
        }
    }
}

struct WatchStatBar: View {
    let title: String
    let stat: Stat
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.footnote)
            
            Spacer()
            
            Text("\(Int((Double(stat.value) / Double(stat.maxValue)) * 100))%")
                .font(.footnote)
                .bold()
                .foregroundColor(color)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
