import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: PetViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dashboard")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 5)
                
                VStack {
                    ZStack {
                        Image("my-face")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(15)
                            .grayscale(viewModel.pet.isAlive ? 0.0 : 1.0)
                            
                        if !viewModel.pet.isAlive {
                            Color.black.opacity(0.3)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                    
                    Text(viewModel.pet.isAlive ? viewModel.pet.name : "\(viewModel.pet.name) has died.")
                        .font(.title2)
                        .bold()
                    
                    if !viewModel.pet.isAlive {
                        Button(action: {
                            viewModel.revive()
                        }) {
                            Text("Revive")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                    }
                    
                    HStack(spacing: 30) {
                        VStack(spacing: 15) {
                            StatBar(title: "Hunger", stat: viewModel.pet.hunger, color: .orange)
                            ActionButton(title: "Feed", color: .orange, action: viewModel.feed, isDisabled: !viewModel.pet.isAlive || viewModel.pet.wallet < 5)
                            
                            StatBar(title: "Fun", stat: viewModel.pet.fun, color: .red)
                            ActionButton(title: "Play", color: .red, action: viewModel.play, isDisabled: !viewModel.pet.isAlive)
                        }
                        
                        VStack(spacing: 15) {
                            StatBar(title: "Cleanliness", stat: viewModel.pet.cleanliness, color: .blue)
                            ActionButton(title: "Clean", color: .blue, action: viewModel.clean, isDisabled: !viewModel.pet.isAlive)
                            
                            StatBar(title: "Energy", stat: viewModel.pet.energy, color: .purple)
                            ActionButton(title: "Rest", color: .purple, action: viewModel.rest, isDisabled: !viewModel.pet.isAlive)
                        }
                    }
                    .padding(.top, 10)
                    
                    Text("Wallet: $\(viewModel.pet.wallet)")
                        .font(.headline)
                        .bold()
                        .padding(.top, 20)
                        
                    EventIndicator(text: viewModel.lastEvent)
                        .padding(.top, 5)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}
