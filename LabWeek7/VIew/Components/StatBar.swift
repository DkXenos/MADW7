import SwiftUI

struct StatBar: View {
    let title: String
    let stat: Stat
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 14)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .frame(width: max(0, CGFloat(stat.value) / CGFloat(stat.maxValue) * 120), height: 14)
                
                Text("\(stat.value) / \(stat.maxValue)")
                    .font(.system(size: 8))
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: 120)
        }
    }
}
