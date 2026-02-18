import SwiftUI

struct YearPicker: View {
    @Binding var selectedYear: Int

    var startYear: Int = 1950
    var endYear: Int = 2012

    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        GeometryReader { outerGeometry in
            let centerY = outerGeometry.size.height / 2

            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        // Top spacer to allow first item to reach center
                        Spacer()
                            .frame(height: centerY - rowHeight / 2)

                        ForEach(startYear...endYear, id: \.self) { year in
                            GeometryReader { itemGeometry in
                                let itemCenterY = itemGeometry.frame(in: .named(coordinateSpaceName)).midY
                                let distanceFromCenter = abs(itemCenterY - centerY)
                                let maxDistance: CGFloat = centerY
                                let normalizedDistance = min(distanceFromCenter / maxDistance, 1.0)

                                let scale = 1.0 - (normalizedDistance * scaleFactor)
                                let opacity = 1.0 - (normalizedDistance * opacityFactor)

                                Text("\(year)")
                                    .font(normalizedDistance < snapThreshold ? AppTheme.Fonts.title1 : AppTheme.Fonts.title3)
                                    .foregroundColor(
                                        normalizedDistance < snapThreshold
                                            ? AppTheme.Colors.textPrimary
                                            : AppTheme.Colors.textTertiary
                                    )
                                    .scaleEffect(scale)
                                    .opacity(opacity)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: rowHeight)
                                    .onChange(of: normalizedDistance < snapThreshold) { isCenter in
                                        if isCenter {
                                            selectedYear = year
                                        }
                                    }
                            }
                            .frame(height: rowHeight)
                            .id(year)
                        }

                        // Bottom spacer to allow last item to reach center
                        Spacer()
                            .frame(height: centerY - rowHeight / 2)
                    }
                }
                .coordinateSpace(name: coordinateSpaceName)
                .onAppear {
                    proxy.scrollTo(selectedYear, anchor: .center)
                }
                .onChange(of: selectedYear) { newYear in
                    withAnimation(AppTheme.Animation.spring) {
                        proxy.scrollTo(newYear, anchor: .center)
                    }
                }
            }

            // Selection indicator lines
            VStack {
                Spacer()

                Rectangle()
                    .fill(AppTheme.Colors.divider)
                    .frame(height: indicatorLineHeight)
                    .padding(.horizontal, AppTheme.Spacing.xxxl)

                Spacer()
                    .frame(height: rowHeight)

                Rectangle()
                    .fill(AppTheme.Colors.divider)
                    .frame(height: indicatorLineHeight)
                    .padding(.horizontal, AppTheme.Spacing.xxxl)

                Spacer()
            }
            .allowsHitTesting(false)
        }
        .frame(height: pickerHeight)
    }

    // MARK: - Constants

    private var rowHeight: CGFloat { AppTheme.Spacing.xxxl }
    private var pickerHeight: CGFloat { 250 }
    private var scaleFactor: CGFloat { 0.4 }
    private var opacityFactor: CGFloat { 0.7 }
    private var snapThreshold: CGFloat { 0.15 }
    private var indicatorLineHeight: CGFloat { 1 }
    private var coordinateSpaceName: String { "yearPickerScroll" }
}

#Preview {
    struct PreviewWrapper: View {
        @State var year = 2000

        var body: some View {
            VStack(spacing: AppTheme.Spacing.xl) {
                Text("Selected: \(year)")
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                YearPicker(selectedYear: $year)
            }
            .padding(AppTheme.Spacing.xl)
        }
    }

    return PreviewWrapper()
}
