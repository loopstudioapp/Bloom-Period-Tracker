import SwiftUI

struct AppDesignSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("reduceAnimations") private var reduceAnimations: Bool = false

    var body: some View {
        List {
            // App icon section
            Section {
                HStack(spacing: AppTheme.Spacing.md) {
                    // App icon preview
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.Colors.primaryPink, AppTheme.Colors.primaryPink.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Bloom")
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textPrimary)

                        Text("Default app icon")
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }

                    Spacer()
                }
                .padding(.vertical, AppTheme.Spacing.xs)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
            } header: {
                Text("APP ICON")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }

            // Theme colors section
            Section {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                    themeColorRow(name: "Primary", color: AppTheme.Colors.primaryPink)
                    themeColorRow(name: "Teal Accent", color: AppTheme.Colors.tealAccent)
                    themeColorRow(name: "Fertile", color: AppTheme.Colors.fertileGreen)
                    themeColorRow(name: "Background", color: AppTheme.Colors.backgroundLight)
                }
                .padding(.vertical, AppTheme.Spacing.xs)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: AppTheme.Spacing.md,
                    bottom: 0,
                    trailing: AppTheme.Spacing.md
                ))
            } header: {
                Text("THEME COLORS")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }

            // Accessibility section
            Section {
                HStack {
                    Text("Reduce animations")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    Toggle("", isOn: $reduceAnimations)
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
            } header: {
                Text("ACCESSIBILITY")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            } footer: {
                Text("Reduces motion effects throughout the app for a calmer experience.")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.Colors.backgroundLight)
        .navigationTitle("App design")
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

    @ViewBuilder
    private func themeColorRow(name: String, color: Color) -> some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 28, height: 28)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )

            Text(name)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        AppDesignSettingsView()
    }
}
