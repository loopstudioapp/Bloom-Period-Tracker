// /Users/infinity/Desktop/Period Tracker/Bloom/Components/ConfettiView.swift
import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let color: Color
    let size: CGFloat
    let rotation: Double
    let speed: Double
    let shape: ConfettiShape

    enum ConfettiShape {
        case circle, rectangle, triangle
    }
}

struct ConfettiView: View {
    @State private var pieces: [ConfettiPiece] = []
    @State private var animating = false

    let colors: [Color] = [
        AppTheme.Colors.confettiGold,
        AppTheme.Colors.primaryPink,
        AppTheme.Colors.confettiPurple,
        AppTheme.Colors.confettiTeal,
        AppTheme.Colors.textWhite
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(pieces) { piece in
                    confettiPieceView(piece)
                        .offset(x: piece.x, y: animating ? geo.size.height + 50 : piece.y)
                        .rotationEffect(.degrees(animating ? piece.rotation + 360 : piece.rotation))
                        .opacity(animating ? 0 : 1)
                }
            }
            .onAppear {
                generatePieces(in: geo.size)
                withAnimation(.easeIn(duration: 3.0)) {
                    animating = true
                }
            }
        }
        .allowsHitTesting(false)
    }

    @ViewBuilder
    private func confettiPieceView(_ piece: ConfettiPiece) -> some View {
        switch piece.shape {
        case .circle:
            Circle()
                .fill(piece.color)
                .frame(width: piece.size, height: piece.size)
        case .rectangle:
            Rectangle()
                .fill(piece.color)
                .frame(width: piece.size, height: piece.size * 0.6)
        case .triangle:
            Triangle()
                .fill(piece.color)
                .frame(width: piece.size, height: piece.size)
        }
    }

    private func generatePieces(in size: CGSize) {
        pieces = (0..<40).map { _ in
            ConfettiPiece(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: -100...(-10)),
                color: colors.randomElement()!,
                size: CGFloat.random(in: 6...12),
                rotation: Double.random(in: 0...360),
                speed: Double.random(in: 2...4),
                shape: [.circle, .rectangle, .triangle].randomElement()!
            )
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
