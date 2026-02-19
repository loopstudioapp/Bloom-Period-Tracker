import SwiftUI

struct PaywallScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Background
            AppTheme.Colors.paywallBackgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    // Logo and header
                    VStack(spacing: AppTheme.Spacing.md) {
                        BloomLogo(size: .medium, color: AppTheme.Colors.textWhite)
                            .opacity(appeared ? 1 : 0)

                        Text("Unlock Your\nFull Potential")
                            .font(AppTheme.Fonts.title1)
                            .foregroundColor(AppTheme.Colors.textWhite)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)

                        Text("Get personalized insights, accurate predictions, and expert guidance")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.paywallTextMuted)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.md)
                            .opacity(appeared ? 1 : 0)
                    }
                    .padding(.top, AppTheme.Spacing.xl)

                    // Feature list
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        featureRow(icon: "chart.line.uptrend.xyaxis", text: "AI-powered cycle predictions")
                        featureRow(icon: "heart.text.square", text: "Personalized health insights")
                        featureRow(icon: "person.2", text: "Access to expert community")
                        featureRow(icon: "bell.badge", text: "Smart notifications & reminders")
                        featureRow(icon: "lock.shield", text: "Private & secure data")
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .opacity(appeared ? 1 : 0)

                    // Subscription plans
                    VStack(spacing: AppTheme.Spacing.sm) {
                        ForEach(OnboardingData.subscriptionPlans) { plan in
                            SubscriptionPlanCard(
                                plan: plan,
                                isSelected: viewModel.selectedPlanId == plan.id
                            ) {
                                withAnimation(AppTheme.Animation.quick) {
                                    viewModel.selectPlan(plan.id)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)

                    // Reviews
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                        Text("What our users say")
                            .font(AppTheme.Fonts.headline)
                            .foregroundColor(AppTheme.Colors.textWhite)
                            .padding(.horizontal, AppTheme.Spacing.lg)

                        ReviewCarousel(reviews: OnboardingData.paywallReviews)
                    }

                    // CTA Button
                    VStack(spacing: AppTheme.Spacing.sm) {
                        if viewModel.selectedPlanId == "yearly" {
                            Text("Cancel anytime during trial period")
                                .font(AppTheme.Fonts.caption)
                                .foregroundColor(AppTheme.Colors.paywallTextMuted)
                        }

                        Button(action: {
                            viewModel.activatePremium()
                            coordinator.advance()
                        }) {
                            Text("Continue")
                                .font(AppTheme.Fonts.bodyBold)
                                .foregroundColor(AppTheme.Colors.textWhite)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.ButtonHeight.primary)
                                .background(
                                    LinearGradient(
                                        colors: [AppTheme.Colors.paywallAccentPurple, AppTheme.Colors.paywallAccentPurple.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .clipShape(Capsule())
                        }

                        Button(action: {
                            coordinator.advance()
                        }) {
                            Text("Restore purchases")
                                .font(AppTheme.Fonts.caption)
                                .foregroundColor(AppTheme.Colors.paywallTextMuted)
                        }

                        Text("Auto-renewable. Cancel anytime.")
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.paywallTextMuted.opacity(0.7))
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.xxl)
                }
            }
        }
        .onAppear {
            withAnimation(AppTheme.Animation.slow) {
                appeared = true
            }
        }
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(AppTheme.Colors.paywallAccentPurple)
                .frame(width: 32, height: 32)

            Text(text)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textWhite.opacity(0.9))
        }
    }
}

#Preview {
    PaywallScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
