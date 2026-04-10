import SwiftUI

struct ActionButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 120, height: 35)
                .background(isDisabled ? Color.gray : color)
                .cornerRadius(10)
        }
        .disabled(isDisabled)
    }
}
