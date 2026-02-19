import SwiftUI

struct CredibilityScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    // Animation phases
    @State private var phase: Int = 0
    // Flower gentle floating
    @State private var floatOffset: CGFloat = 0

    var body: some View {
        ZStack {
            AppTheme.Colors.background
                .ignoresSafeArea()

            // Scattered flowers background (always visible, gently floating)
            flowersBackground

            // Animated text content in center
            VStack(spacing: AppTheme.Spacing.sm) {
                Spacer()

                // Phase 1-2: "Hello, I'm Bloom"
                if phase >= 1 && phase <= 2 {
                    VStack(spacing: AppTheme.Spacing.xs) {
                        Text("Hello,")
                            .font(.system(size: AppTheme.ResponsiveLayout.scaled(36), weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .transition(.opacity.combined(with: .scale(scale: 0.9)))

                        if phase >= 2 {
                            Text("I\u{2019}m Bloom")
                                .font(.system(size: AppTheme.ResponsiveLayout.scaled(36), weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.Colors.textPrimary)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                    .transition(.opacity)
                }

                // Phase 3+: "#1 female app..."
                if phase >= 3 {
                    VStack(spacing: AppTheme.Spacing.xxs) {
                        // "#1 female" on same baseline
                        HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                            Text("#")
                                .font(.system(size: AppTheme.ResponsiveLayout.scaled(28), weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            Text("1")
                                .font(.system(size: AppTheme.ResponsiveLayout.scaled(72), weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            Text("female")
                                .font(.system(size: AppTheme.ResponsiveLayout.scaled(32), weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.Colors.textPrimary)
                        }
                        .transition(.opacity.combined(with: .scale(scale: 0.85)))

                        if phase >= 4 {
                            Text("app for period and cycle tracking")
                                .font(.system(size: AppTheme.ResponsiveLayout.scaled(20), weight: .regular, design: .rounded))
                                .foregroundColor(AppTheme.Colors.textPrimary)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .transition(.opacity)
                }

                Spacer()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            coordinator.advance()
        }
        .onAppear {
            startAnimation()
        }
    }

    // MARK: - Animation Sequence

    private func startAnimation() {
        // Start gentle flower float
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            floatOffset = 6
        }

        // Phase 1: "Hello,"
        withAnimation(.easeOut(duration: 0.5)) {
            phase = 1
        }

        // Phase 2: "I'm Bloom"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeOut(duration: 0.4)) {
                phase = 2
            }
        }

        // Phase 3: Swap to "#1 female"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                phase = 3
            }
        }

        // Phase 4: "app for period and cycle tracking"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation(.easeOut(duration: 0.4)) {
                phase = 4
            }
        }

        // Auto-advance
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            coordinator.advance()
        }
    }

    // MARK: - Flowers Background

    private var flowersBackground: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                // Top-left cluster: bright pink flowers
                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink,
                    centerColor: Color.white,
                    size: 38,
                    petalCount: 5
                )
                .offset(x: w * 0.08, y: h * 0.06 + floatOffset * 0.5)

                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink,
                    centerColor: Color.white,
                    size: 30,
                    petalCount: 5
                )
                .offset(x: w * 0.15, y: h * 0.04 + floatOffset * 0.3)

                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink,
                    centerColor: Color.white,
                    size: 24,
                    petalCount: 5
                )
                .offset(x: w * 0.05, y: h * 0.1 + floatOffset * 0.7)

                // Stem lines from top-left flowers
                StemLine()
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.3), lineWidth: 1)
                    .frame(width: 30, height: 50)
                    .offset(x: w * 0.04, y: h * 0.13)

                // Top-right: dandelion/starburst
                DandelionView(
                    color: AppTheme.Colors.textTertiary,
                    size: 36
                )
                .offset(x: w * 0.88, y: h * 0.05 - floatOffset * 0.4)

                // Mid-top center: peach/beige flower
                FlowerView(
                    petalColor: AppTheme.Colors.featurePeach,
                    centerColor: AppTheme.Colors.textPrimary.opacity(0.7),
                    size: 44,
                    petalCount: 6
                )
                .offset(x: w * 0.45, y: h * 0.12 + floatOffset * 0.6)

                // Mid-left: small light flower
                FlowerView(
                    petalColor: AppTheme.Colors.textTertiary.opacity(0.5),
                    centerColor: AppTheme.Colors.textPrimary.opacity(0.6),
                    size: 22,
                    petalCount: 5
                )
                .offset(x: w * 0.1, y: h * 0.27 + floatOffset * 0.3)

                // Mid-right: pink tulip-like shape
                TulipView(color: AppTheme.Colors.primaryPink, size: 28)
                    .offset(x: w * 0.82, y: h * 0.22 - floatOffset * 0.5)

                // Stem near tulip
                StemLine()
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.25), lineWidth: 1)
                    .frame(width: 20, height: 40)
                    .offset(x: w * 0.88, y: h * 0.26)

                // Bottom-left: peach bell flower
                BellFlowerView(color: AppTheme.Colors.featurePeach, size: 26)
                    .offset(x: w * 0.1, y: h * 0.72 + floatOffset * 0.4)

                StemLine()
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.25), lineWidth: 1)
                    .frame(width: 15, height: 30)
                    .rotationEffect(.degrees(-20))
                    .offset(x: w * 0.06, y: h * 0.75)

                // Bottom-center: round dandelion-like
                DandelionView(
                    color: AppTheme.Colors.featurePeach,
                    size: 28,
                    lineCount: 10
                )
                .offset(x: w * 0.45, y: h * 0.82 - floatOffset * 0.3)

                // Small leaf
                LeafShape()
                    .fill(AppTheme.Colors.textPrimary.opacity(0.6))
                    .frame(width: 10, height: 16)
                    .rotationEffect(.degrees(45))
                    .offset(x: w * 0.44, y: h * 0.87)

                // Bottom-right: lavender flower
                FlowerView(
                    petalColor: AppTheme.Colors.textTertiary.opacity(0.4),
                    centerColor: AppTheme.Colors.textPrimary.opacity(0.6),
                    size: 40,
                    petalCount: 6
                )
                .offset(x: w * 0.85, y: h * 0.7 - floatOffset * 0.5)

                // Bottom-left large: bright pink flower
                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink,
                    centerColor: Color.white,
                    size: 50,
                    petalCount: 5
                )
                .offset(x: w * 0.18, y: h * 0.88 + floatOffset * 0.6)

                // Leaf from bottom-left flower
                LeafShape()
                    .fill(AppTheme.Colors.textPrimary.opacity(0.6))
                    .frame(width: 12, height: 20)
                    .rotationEffect(.degrees(-30))
                    .offset(x: w * 0.14, y: h * 0.93)

                // Bottom-right: smaller pink flower
                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink,
                    centerColor: Color.white,
                    size: 34,
                    petalCount: 5
                )
                .offset(x: w * 0.78, y: h * 0.88 - floatOffset * 0.4)

                // Extra small accent flowers
                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink.opacity(0.5),
                    centerColor: AppTheme.Colors.primaryPink,
                    size: 14,
                    petalCount: 5
                )
                .offset(x: w * 0.6, y: h * 0.18 + floatOffset * 0.2)

                FlowerView(
                    petalColor: AppTheme.Colors.primaryPink.opacity(0.4),
                    centerColor: AppTheme.Colors.primaryPink,
                    size: 12,
                    petalCount: 5
                )
                .offset(x: w * 0.32, y: h * 0.78 - floatOffset * 0.3)
            }
        }
    }
}

// MARK: - Supporting Shapes

struct StemLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX + rect.width * 0.3, y: rect.height),
            control: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.height * 0.6)
        )
        return path
    }
}

struct TulipView: View {
    var color: Color
    var size: CGFloat

    var body: some View {
        ZStack {
            // Tulip petals
            Ellipse()
                .fill(color)
                .frame(width: size * 0.45, height: size * 0.65)
                .offset(x: -size * 0.12)
                .rotationEffect(.degrees(10))

            Ellipse()
                .fill(color.opacity(0.8))
                .frame(width: size * 0.45, height: size * 0.65)
                .offset(x: size * 0.12)
                .rotationEffect(.degrees(-10))

            // Stem
            Rectangle()
                .fill(AppTheme.Colors.textPrimary.opacity(0.3))
                .frame(width: 1, height: size * 0.4)
                .offset(y: size * 0.45)
        }
        .frame(width: size, height: size * 1.2)
    }
}

struct BellFlowerView: View {
    var color: Color
    var size: CGFloat

    var body: some View {
        ZStack {
            // Simple triangular bell shape
            TriangleShape()
                .fill(color)
                .frame(width: size, height: size * 0.8)

            // Stem
            Rectangle()
                .fill(AppTheme.Colors.textPrimary.opacity(0.3))
                .frame(width: 1, height: size * 0.3)
                .offset(y: -size * 0.5)
        }
        .frame(width: size, height: size)
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    CredibilityScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
