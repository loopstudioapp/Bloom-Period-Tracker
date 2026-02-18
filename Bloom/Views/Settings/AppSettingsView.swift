import SwiftUI

struct AppSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var metricSystem: Bool = false

    var body: some View {
        List {
            // Settings rows section
            Section {
                AnalysisMenuItem(
                    icon: "paintpalette",
                    iconColor: AppTheme.Colors.tealAccent,
                    title: "App design settings",
                    onTap: {}
                )
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
                .listRowSeparator(.hidden)

                AnalysisMenuItem(
                    icon: "heart",
                    iconColor: AppTheme.Colors.tealAccent,
                    title: "The Health app",
                    onTap: {}
                )
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
                .listRowSeparator(.hidden)

                AnalysisMenuItem(
                    icon: "globe",
                    iconColor: AppTheme.Colors.tealAccent,
                    title: "Change language",
                    onTap: {}
                )
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
    }
}

#Preview {
    NavigationStack {
        AppSettingsView()
    }
}
