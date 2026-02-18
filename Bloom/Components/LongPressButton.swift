// /Users/infinity/Desktop/Period Tracker/Bloom/Components/LongPressButton.swift
import SwiftUI

struct LongPressButton: View {
    let title: String
    let duration: Double
    let onCompleted: () -> Void

    @State private var isPressed = false
    @State private var progress: CGFloat = 0
    @State private var timer: Timer?
    @State private var completed = false

    var body: some View {
        ZStack {
            // Background capsule
            Capsule()
                .fill(AppTheme.Colors.primaryGradient)
                .frame(height: AppTheme.ButtonHeight.primary)

            // Progress overlay
            GeometryReader { geo in
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: geo.size.width * progress, height: AppTheme.ButtonHeight.primary)
                    .animation(.linear(duration: 0.05), value: progress)
            }
            .frame(height: AppTheme.ButtonHeight.primary)
            .clipShape(Capsule())

            // Label
            HStack(spacing: AppTheme.Spacing.sm) {
                if completed {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                }
                Text(completed ? "Committed!" : title)
                    .font(AppTheme.Fonts.bodyBold)
            }
            .foregroundColor(AppTheme.Colors.textWhite)
        }
        .frame(height: AppTheme.ButtonHeight.primary)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(AppTheme.Animation.quick, value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    guard !completed else { return }
                    if !isPressed {
                        isPressed = true
                        startTimer()
                    }
                }
                .onEnded { _ in
                    guard !completed else { return }
                    isPressed = false
                    stopTimer()
                }
        )
    }

    private func startTimer() {
        let interval = 0.03
        let increment = CGFloat(interval / duration)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { t in
            progress += increment
            if progress >= 1.0 {
                progress = 1.0
                completed = true
                t.invalidate()
                timer = nil
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                onCompleted()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        withAnimation(AppTheme.Animation.standard) {
            progress = 0
        }
    }
}
