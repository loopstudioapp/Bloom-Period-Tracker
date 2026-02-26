import SwiftUI

struct AppSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("useMetricSystem") private var metricSystem: Bool = false
    @State private var showHealthKitInfo: Bool = false

    var body: some View {
        List {
            // Settings rows section
            Section {
                NavigationLink(destination: AppDesignSettingsView()) {
                    settingsRow(
                        icon: "paintpalette",
                        iconColor: AppTheme.Colors.tealAccent,
                        title: "App design settings"
                    )
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
                .listRowSeparator(.hidden)

                Button {
                    showHealthKitInfo = true
                } label: {
                    settingsRow(
                        icon: "heart",
                        iconColor: AppTheme.Colors.tealAccent,
                        title: "The Health app"
                    )
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
                .listRowSeparator(.hidden)

                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    settingsRow(
                        icon: "globe",
                        iconColor: AppTheme.Colors.tealAccent,
                        title: "Change language"
                    )
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
                .listRowSeparator(.hidden)
            }

            // Metric system toggle section
            Section {
                HStack {
                    Text("Metric system")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    Toggle("", isOn: $metricSystem)
                        .labelsHidden()
                        .tint(AppTheme.Colors.toggleOnTrack)
                }
                .padding(.vertical, AppTheme.Spacing.xs)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.Colors.backgroundLight)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .accessibilityLabel("Back")
            }
        }
        .alert("Apple Health Integration", isPresented: $showHealthKitInfo) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("HealthKit integration is coming soon. This will allow Bloom to sync your cycle data with Apple Health for a more complete health picture.")
        }
    }

    @ViewBuilder
    private func settingsRow(icon: String, iconColor: Color, title: String) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: AppTheme.Spacing.md) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 40, height: 40)

                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(iconColor)
                }

                Text(title)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }
            .padding(.vertical, AppTheme.Spacing.md)

            Divider()
                .background(AppTheme.Colors.divider)
        }
    }
}

#Preview {
    NavigationStack {
        AppSettingsView()
    }
}
