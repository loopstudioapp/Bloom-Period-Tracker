import SwiftUI

struct NumberOneHeroIllustration: View {
    var body: some View {
        ZStack {
            FlowerWreath(size: 300)

            VStack(spacing: AppTheme.Spacing.xs) {
                HStack(alignment: .top, spacing: 0) {
                    Text("#")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.primaryPink)
                        .offset(y: 20)

                    Text("1")
                        .font(.system(size: 160, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }

                VStack(spacing: AppTheme.Spacing.xxs) {
                    Text("women's")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.primaryPink)

                    Text("health app*")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
                .offset(y: -20)
            }
        }
        .frame(height: 320)
        .accessibilityLabel("Number one women's health app illustration")
    }
}

#Preview {
    NumberOneHeroIllustration()
}
