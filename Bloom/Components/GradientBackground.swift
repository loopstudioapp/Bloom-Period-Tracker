// /Users/infinity/Desktop/Period Tracker/Bloom/Components/GradientBackground.swift
import SwiftUI

struct GradientBackground: View {
    let gradient: LinearGradient
    var showSparkles: Bool = false

    @State private var sparkleOpacity: Double = 0

    var body: some View {
        ZStack {
            gradient.ignoresSafeArea()

            if showSparkles {
                GeometryReader { geo in
                    ForEach(0..<15, id: \.self) { i in
                        Circle()
                            .fill(Color.white.opacity(0.15))
                            .frame(width: CGFloat.random(in: 3...8), height: CGFloat.random(in: 3...8))
                            .position(
                                x: CGFloat(i * 27 % Int(geo.size.width)),
                                y: CGFloat(i * 43 % Int(geo.size.height))
                            )
                            .opacity(sparkleOpacity)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                        sparkleOpacity = 1.0
                    }
                }
            }
        }
    }
}
