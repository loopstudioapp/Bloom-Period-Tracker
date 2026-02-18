import SwiftUI

enum PillButtonStyle {
    case primary
    case secondary
    case text
    case teal
}

struct PillButton: View {
    let title: String
    var style: PillButtonStyle = .primary
    var isEnabled: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTheme.Fonts.bodyBold)
                .frame(maxWidth: .infinity)
                .frame(height: buttonHeight)
                .foregroundColor(foregroundColor)
                .background(backgroundContent)
                .clipShape(Capsule())
                .overlay(overlayContent)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
        .animation(AppTheme.Animation.quick, value: isEnabled)
    }

    // MARK: - Private Helpers

    private var buttonHeight: CGFloat {
        switch style {
        case .primary, .teal:
            return AppTheme.ButtonHeight.primary
        case .secondary, .text:
            return AppTheme.ButtonHeight.secondary
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary, .teal:
            return AppTheme.Colors.textWhite
        case .secondary:
            return AppTheme.Colors.primaryPink
        case .text:
            return AppTheme.Colors.primaryPink
        }
    }

    @ViewBuilder
    private var backgroundContent: some View {
        switch style {
        case .primary:
            AppTheme.Colors.primaryGradient
        case .teal:
            AppTheme.Colors.tealGradient
        case .secondary, .text:
            Color.clear
        }
    }

    @ViewBuilder
    private var overlayContent: some View {
        switch style {
        case .secondary:
            Capsule()
                .stroke(AppTheme.Colors.primaryPink, lineWidth: 2)
        default:
            EmptyView()
        }
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.md) {
        PillButton(title: "Continue", style: .primary) {}
        PillButton(title: "Teal Button", style: .teal) {}
        PillButton(title: "Secondary", style: .secondary) {}
        PillButton(title: "Disabled", style: .primary, isEnabled: false) {}
    }
    .padding(AppTheme.Spacing.xl)
}
