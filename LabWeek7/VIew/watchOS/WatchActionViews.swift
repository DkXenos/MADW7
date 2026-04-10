import SwiftUI

struct WatchActionPageView: View {
    @ObservedObject var viewModel: PetViewModel
    
    var body: some View {
        TabView {
            WatchStatusView(viewModel: viewModel)
            
            WatchSingleActionView(
                title: "Energy",
                icon: "moon.fill",
                color: .purple,
                stat: viewModel.pet.energy,
                buttonTitle: "Rest",
                action: viewModel.rest
            )
            
            WatchSingleActionView(
                title: "Fun",
                icon: "figure.walk",
                color: .red,
                stat: viewModel.pet.fun,
                buttonTitle: "Play",
                action: viewModel.play
            )
            
            WatchSingleActionView(
                title: "Cleanliness",
                icon: "sparkles",
                color: .blue,
                stat: viewModel.pet.cleanliness,
                buttonTitle: "Clean",
                action: viewModel.clean
            )
            
            WatchSingleActionView(
                title: "Hunger",
                icon: "fork.knife",
                color: .orange,
                stat: viewModel.pet.hunger,
                buttonTitle: "Feed",
                action: viewModel.feed
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct WatchSingleActionView: View {
    let title: String
    let icon: String
    let color: Color
    let stat: Stat
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .bold()
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .frame(width: max(0, CGFloat(stat.value) / CGFloat(stat.maxValue) * 120), height: 8)
            }
            .frame(width: 120)
            
            Text("\(Int((Double(stat.value) / Double(stat.maxValue)) * 100))%")
                .font(.footnote)
            
            Button(action: action) {
                Text(buttonTitle)
                    .font(.subheadline)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(color)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal, 20)
        }
    }
}
