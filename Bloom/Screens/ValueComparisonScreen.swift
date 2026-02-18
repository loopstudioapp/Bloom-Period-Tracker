import SwiftUI

struct ValueComparisonScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var appeared = false

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    // Header
                    VStack(spacing: AppTheme.Spacing.md) {
                        BloomLogo(size: .medium, color: AppTheme.Colors.primaryPink)
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : -20)

                        Text("When you Bloom,\nyou know")
                            .font(AppTheme.Fonts.title1)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)

                        Text("See the difference Bloom makes in understanding your body")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)
                    }
                    .padding(.top, AppTheme.Spacing.xxl)

                    // Comparison cards
                    VStack(spacing: AppTheme.Spacing.lg) {
                        ForEach(Array(OnboardingData.comparisonItems.enumerated()), id: \.element.id) { index, item in
                            ComparisonCard(item: item)
                                .opacity(appeared ? 1 : 0)
                                .offset(y: appeared ? 0 : 20)
                                .animation(AppTheme.Animation.standard.delay(Double(index) * 0.1), value: appeared)
                        }
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Continue") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            withAnimation(AppTheme.Animation.slow) {
                appeared = true
            }
        }
    }
}

#Preview {
    ValueComparisonScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
