import SwiftUI

struct CommitmentPledgeScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var appeared = false
    @State private var pledgeCompleted = false

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    // Header
                    VStack(spacing: AppTheme.Spacing.md) {
                        Text("🌸")
                            .font(.system(size: 56))
                            .opacity(appeared ? 1 : 0)
                            .scaleEffect(appeared ? 1 : 0.5)

                        Text("My commitment\nto myself")
                            .font(AppTheme.Fonts.title1)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)

                        Text("Take a moment to promise yourself the care you deserve")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.md)
                            .opacity(appeared ? 1 : 0)
                    }
                    .padding(.top, AppTheme.Spacing.xxl)

                    // Pledge items
                    VStack(spacing: AppTheme.Spacing.md) {
                        ForEach(Array(OnboardingData.pledgeItems.enumerated()), id: \.element.id) { index, item in
                            HStack(spacing: AppTheme.Spacing.md) {
                                Text(item.emoji)
                                    .font(.system(size: 28))
                                    .frame(width: 44, height: 44)
                                    .background(AppTheme.Colors.commitmentPinkLight)
                                    .clipShape(Circle())

                                Text(item.text)
                                    .font(AppTheme.Fonts.body)
                                    .foregroundColor(AppTheme.Colors.textPrimary)
                                    .fixedSize(horizontal: false, vertical: true)

                                Spacer()
                            }
                            .padding(AppTheme.Spacing.md)
                            .background(AppTheme.Colors.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
                            .cardShadow()
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : 20)
                            .animation(AppTheme.Animation.standard.delay(0.3 + Double(index) * 0.1), value: appeared)
                        }
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            // Long press button
            VStack(spacing: AppTheme.Spacing.sm) {
                if !pledgeCompleted {
                    Text("Hold to commit")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                LongPressButton(title: "I commit to myself", duration: 1.5) {
                    pledgeCompleted = true
                    viewModel.completePledge()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        coordinator.advance()
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.commitmentGradient.ignoresSafeArea())
        .onAppear {
            withAnimation(AppTheme.Animation.slow) {
                appeared = true
            }
        }
    }
}

#Preview {
    CommitmentPledgeScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
