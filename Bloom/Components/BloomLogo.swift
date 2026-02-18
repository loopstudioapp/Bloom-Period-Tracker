// /Users/infinity/Desktop/Period Tracker/Bloom/Components/BloomLogo.swift
import SwiftUI

struct BloomLogo: View {
    var size: BloomLogoSize = .large
    var color: Color = AppTheme.Colors.primaryPink

    enum BloomLogoSize {
        case small, medium, large

        var fontSize: CGFloat {
            switch self {
            case .small: return 24
            case .medium: return 36
            case .large: return 48
            }
        }

        var petalSize: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 30
            case .large: return 40
            }
        }
    }

    var body: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            // Flower icon
            ZStack {
                ForEach(0..<5, id: \.self) { i in
                    Ellipse()
                        .fill(color.opacity(0.7))
                        .frame(width: size.petalSize * 0.5, height: size.petalSize * 0.8)
                        .offset(y: -size.petalSize * 0.3)
                        .rotationEffect(.degrees(Double(i) * 72))
                }
                Circle()
                    .fill(color)
                    .frame(width: size.petalSize * 0.35, height: size.petalSize * 0.35)
            }
            .frame(width: size.petalSize, height: size.petalSize)

            Text("Bloom")
                .font(.system(size: size.fontSize, weight: .bold, design: .rounded))
                .foregroundColor(color)
        }
    }
}
