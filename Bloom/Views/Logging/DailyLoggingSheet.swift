import SwiftUI

struct DailyLoggingSheet: View {
    @StateObject private var viewModel = DailyLoggingViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            AppTheme.Colors.loggingSheetBg
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: - Drag Handle
                sheetHandle
                    .padding(.top, AppTheme.Spacing.sm)

                // MARK: - Day Navigation Header
                dayNavigationHeader
                    .padding(.top, AppTheme.Spacing.md)

                // MARK: - Search Bar
                searchBar
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.md)

                // MARK: - Scrollable Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTheme.Spacing.md) {
                        feelingsCard
                        categoriesHeader
                        menstrualFlowCard
                        sexAndSexDriveCard
                        otherPillsCard
                        WaterTracker(intake: $viewModel.waterIntake, goal: viewModel.waterGoal)
                        WeightTracker(weight: viewModel.weight)
                        TemperatureTracker(temperature: viewModel.basalTemp)
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.md)
                    .padding(.bottom, AppTheme.Spacing.xxxl + AppTheme.Spacing.xxl)
                    .constrainedWidth()
                }
            }

            // MARK: - Pinned Apply Button
            applyButton
        }
    }

    // MARK: - Sheet Handle

    private var sheetHandle: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.pill)
            .fill(AppTheme.Colors.loggingSheetHandle)
            .frame(width: 40, height: 5)
    }

    // MARK: - Day Navigation Header

    private var dayNavigationHeader: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            HStack {
                Button {
                    // Navigate to previous day
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel("Previous day")

                Spacer()

                Text(viewModel.dateTitle)
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Button {
                    // Navigate to next day
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel("Next day")
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            Text("Cycle day \(viewModel.cycleDay)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(AppTheme.Colors.textSecondary)

            TextField("Search", text: $viewModel.searchText)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.sm)
        .background(AppTheme.Colors.searchBarBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))
        .accessibilityLabel("Search symptoms and categories")
    }

    // MARK: - Feelings Card

    private var feelingsCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("What are you feeling today?")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            FeelingSelector(
                feelings: MainAppData.feelings,
                selectedFeelings: viewModel.selectedFeelings,
                onToggle: viewModel.toggleFeeling
            )
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    // MARK: - Categories Header

    private var categoriesHeader: some View {
        HStack {
            Text("Categories")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Button {
                // Edit categories action
            } label: {
                Text("Edit")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.primaryPink)
            }
            .accessibilityLabel("Edit categories")
        }
        .padding(.horizontal, AppTheme.Spacing.xs)
    }

    // MARK: - Menstrual Flow Card

    private var menstrualFlowCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Menstrual flow")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Estimate your average daily flow")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            flowChipsRow
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    private var flowChipsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.sm) {
                ForEach(MenstrualFlow.allCases, id: \.self) { flow in
                    SymptomChip(
                        icon: flow.icon,
                        title: flow.rawValue,
                        isSelected: viewModel.selectedFlow == flow,
                        onTap: { viewModel.selectFlow(flow) }
                    )
                }
            }
        }
    }

    // MARK: - Sex and Sex Drive Card

    private var sexAndSexDriveCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Sex and sex drive")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: AppTheme.Spacing.sm),
                    GridItem(.flexible(), spacing: AppTheme.Spacing.sm)
                ],
                spacing: AppTheme.Spacing.sm
            ) {
                ForEach(MainAppData.sexActivities) { activity in
                    SymptomChip(
                        icon: activity.icon,
                        title: activity.name,
                        isSelected: viewModel.isSexActivitySelected(activity.name),
                        onTap: { viewModel.toggleSexActivity(activity.name) }
                    )
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    // MARK: - Other Pills Card

    private var otherPillsCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Other pills (non-OC)")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Log other pills you take a day")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Button {
                // Add pill action
            } label: {
                HStack(spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(AppTheme.Colors.primaryPink)

                    Text("Add pill")
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
            }
            .accessibilityLabel("Add a pill to your log")

            Divider()
                .background(AppTheme.Colors.divider)

            Button {
                // Set up reminders action
            } label: {
                HStack {
                    Text("Set up reminders")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }
            }
            .accessibilityLabel("Set up pill reminders")
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    // MARK: - Apply Button

    private var applyButton: some View {
        Button {
            viewModel.applyLog()
            dismiss()
        } label: {
            Text("Apply")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textWhite)
                .frame(maxWidth: .infinity)
                .frame(height: AppTheme.ButtonHeight.primary)
                .background(AppTheme.Colors.primaryPink)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.pill))
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.bottom, AppTheme.Spacing.xl)
        .background(
            LinearGradient(
                colors: [
                    AppTheme.Colors.loggingSheetBg.opacity(0),
                    AppTheme.Colors.loggingSheetBg
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 100)
            .allowsHitTesting(false)
        )
        .accessibilityLabel("Apply daily log")
    }
}

#Preview {
    DailyLoggingSheet()
}
