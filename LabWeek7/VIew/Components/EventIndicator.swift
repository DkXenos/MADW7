import SwiftUI

struct EventIndicator: View {
    let text: String?
    
    var body: some View {
        HStack {
            if let text = text {
                Text(text)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(8)
            }
        }
        .frame(height: 20)
    }
}
