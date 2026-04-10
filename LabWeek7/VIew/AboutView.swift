import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
                .padding(.top, 50)
            
            Text("Pet Simulator")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("**Name:** Jason Tio")
                Text("**NIM:** 0706012410006")
                Text("**Class:** MAD - Lab Week 7")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            Text("This app demonstrates cross-platform state management between iPadOS and watchOS.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
