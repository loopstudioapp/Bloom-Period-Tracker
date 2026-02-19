import SwiftUI

struct FullCalendarScreen: View {
    @StateObject private var viewModel = CalendarViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var showDayDetail: Bool = false

    private let calendar = Calendar.current

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // MARK: - Navigation Bar
                navBar

                // MARK: - Segmented Picker
                segmentedPicker
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.sm)

                // MARK: - Calendar Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTheme.Spacing.xxl) {
                        // Current month
                        FullCalendarGrid(viewModel: viewModel)

                        // Next month
                        let nextMonth = calendar.date(byAdding: .month, value: 1, to: viewModel.displayedMonth)!
                        nextMonthGrid(for: nextMonth)
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.md)
                    .padding(.bottom, showDayDetail ? AppTheme.Spacing.calendarDetailPadding : AppTheme.Spacing.calendarBottomPadding)
                    .constrainedWidth()
                }
            }
            .background(AppTheme.Colors.background)

            // MARK: - Edit Period Dates Button
            if !showDayDetail {
                editPeriodDatesButton
                    .padding(.bottom, AppTheme.Spacing.xxl)
                    .transition(.opacity)
            }

            // MARK: - Day Detail Panel
            if showDayDetail, let selectedDay = viewModel.selectedDay {
                dayDetailView(for: selectedDay)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(AppTheme.Animation.standard, value: showDayDetail)
        .onChange(of: viewModel.selectedDay) {
            withAnimation(AppTheme.Animation.standard) {
                showDayDetail = viewModel.selectedDay != nil
            }
        }
    }

    // MARK: - Navigation Bar

    private var navBar: some View {
        HStack {
            // Close button
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(width: 36, height: 36)
            }
            .accessibilityLabel("Close calendar")

            Spacer()

            // Today link
            Button(action: {
                viewModel.displayedMonth = Date()
                viewModel.selectedDay = Date()
            }) {
                Text("Today")
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(AppTheme.Colors.addLogFAB)
            }
            .accessibilityLabel("Go to today")
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.sm)
    }

    // MARK: - Segmented Picker

    private var segmentedPicker: some View {
        Picker("View Mode", selection: $viewModel.viewMode) {
            ForEach(CalendarViewMode.allCases, id: \.self) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(AppTheme.Colors.segmentedControlBg)
    }

    // MARK: - Next Month Grid

    private func nextMonthGrid(for month: Date) -> some View {
        let nextVM = makeNextMonthViewModel(for: month)
        return FullCalendarGrid(viewModel: nextVM, onDayTap: { date in
            viewModel.selectedDay = date
        })
    }

    private func makeNextMonthViewModel(for month: Date) -> CalendarViewModel {
        let vm = CalendarViewModel()
        vm.displayedMonth = month
        return vm
    }

    // MARK: - Edit Period Dates Button

    private var editPeriodDatesButton: some View {
        Button(action: {}) {
            Text("Edit period dates")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textWhite)
                .padding(.horizontal, AppTheme.Spacing.xl)
                .padding(.vertical, AppTheme.Spacing.md)
                .background(AppTheme.Colors.editPeriodDatesBtnBg)
                .clipShape(Capsule())
        }
        .cardShadow()
    }

    // MARK: - Day Detail View

    private func dayDetailView(for date: Date) -> some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        let dateString = formatter.string(from: date)

        let cycleDayNumber = max(1, (calendar.dateComponents([.day], from: viewModel.periodStartDate, to: date).day ?? 0) + 1)

        return VStack(spacing: 0) {
            // Drag handle
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.loggingSheetHandle)
                .frame(width: 36, height: AppTheme.Spacing.xs)
                .padding(.top, AppTheme.Spacing.sm)
                .padding(.bottom, AppTheme.Spacing.sm)

            DayDetailPanel(
                dateText: dateString,
                cycleDay: cycleDayNumber,
                dayLog: viewModel.dayLog(for: date),
                insights: MainInsightData.todayInsights,
                onClose: {
                    viewModel.selectedDay = nil
                }
            )
        }
        .background(
            AppTheme.Colors.dayDetailBg
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))
                .ignoresSafeArea(edges: .bottom)
        )
        .elevatedShadow()
    }
}

#Preview {
    FullCalendarScreen()
}
