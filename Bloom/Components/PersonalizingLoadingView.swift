import SwiftUI

struct PersonalizingLoadingView<Content: View>: View {
    let progress: Double
    let title: String
    let content: () -> Content

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xl) {
            // Upper content area (~50% of screen)
            content()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: UIScreen.main.bounds.height * contentHeightFraction)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.5), value: title)

            // Title
            Text(title)
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.5), value: title)

            // Circular progress indicator
            CircularProgressView(progress: progress)

            // Loading text
            Text("Personalizing your experience...")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.Colors.background)
    }

    // MARK: - Private Helpers

    private var contentHeightFraction: CGFloat { 0.5 }
}

#Preview {
    PersonalizingLoadingView(
        progress: 0.45,
        title: "Analyzing your cycle patterns..."
    ) {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.backgroundPink)
                .frame(width: 200, height: 200)

            Image(systemName: "waveform.path.ecg")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
    }
}
