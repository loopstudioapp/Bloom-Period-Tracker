import SwiftUI

struct AppTheme {

    // MARK: - Colors
    struct Colors {
        // Primary palette — dusty rose (distinct from Flo's bright coral-pink)
        static let primaryPink = Color(hex: "#E8738A")
        static let primaryPinkDark = Color(hex: "#D45A7A")
        static let primaryGradientStart = Color(hex: "#E8738A")
        static let primaryGradientEnd = Color(hex: "#D45A7A")

        // Backgrounds — warmer peach-rose tones
        static let background = Color.white
        static let backgroundPink = Color(hex: "#FDF5F3")
        static let backgroundWarm = Color(hex: "#FFF9F2")
        static let backgroundLight = Color(hex: "#FAFAF9")
        static let optionBackground = Color(hex: "#F5F5F4")
        static let selectedOptionBackground = Color(hex: "#FCEEE9")

        // Text
        static let textPrimary = Color(hex: "#1A1A1A")
        static let textSecondary = Color(hex: "#999999")
        static let textTertiary = Color(hex: "#BBBBBB")
        static let textWhite = Color.white

        // Accents — sage-teal instead of bright teal
        static let tealAccent = Color(hex: "#3AAFA9")
        static let blueAccent = Color(hex: "#5B9BD5")
        static let orangeAccent = Color(hex: "#F5A657")
        static let coralAccent = Color(hex: "#E87272")

        // Card & UI
        static let cardBackground = Color.white
        static let divider = Color(hex: "#E8E8E8")
        static let checkmark = Color(hex: "#E8738A")

        // Feature card colors — warmer tones
        static let featureBlueGray = Color(hex: "#EAF0F4")
        static let featurePeach = Color(hex: "#FDE8E0")
        static let featurePink = Color(hex: "#F9E0E8")
        static let featureLightBlue = Color(hex: "#E4F0FF")

        // Cycle phases
        static let periodPhase = Color(hex: "#E8738A")
        static let follicularPhase = Color(hex: "#C4C4C4")
        static let fertilePhase = Color(hex: "#3AAFA9")
        static let lutealPhase = Color(hex: "#666666")

        // Avatar colors
        static let avatarPink = Color(hex: "#EE94A6")
        static let avatarTeal = Color(hex: "#5DD5B8")
        static let avatarCoral = Color(hex: "#F08080")
        static let avatarPurple = Color(hex: "#B388FF")

        // Part 2 — additional colors
        static let tealButton = Color(hex: "#3AAFA9")
        static let periodRed = Color(hex: "#D94452")
        static let periodRedDark = Color(hex: "#8B1A2B")
        static let dischargePurple = Color(hex: "#9B72CF")
        static let dischargePurpleLight = Color(hex: "#E8D5F5")
        static let normalGreen = Color(hex: "#34C759")
        static let irregularOrange = Color(hex: "#FF9500")
        static let irregularYellow = Color(hex: "#FFFBE6")
        static let navyDark = Color(hex: "#2B5F7E")
        static let lightBlueIllustration = Color(hex: "#C8DBF0")
        static let coralGradientStart = Color(hex: "#F09080")
        static let coralGradientEnd = Color(hex: "#E8738A")
        static let skinTone = Color(hex: "#F5D0B0")
        static let selectionPurple = Color(hex: "#7B61FF")

        // Part 3 — additional colors
        static let goldStar = Color(hex: "#FFD700")
        static let skinToneMedium = Color(hex: "#C68642")
        static let skinToneDark = Color(hex: "#8D5524")
        static let skinToneLight = Color(hex: "#D4A373")
        static let hairDark = Color(hex: "#3D2B1F")
        static let underwearRed = Color(hex: "#E74C3C")
        static let limeGreen = Color(hex: "#84CC16")
        static let tealShirt = Color(hex: "#2DD4BF")
        static let progressTrack = Color(hex: "#E5E7EB")
        static let articleBlue = Color(hex: "#6BA3D6")
        static let articlePurple = Color(hex: "#9B72CF")
        static let articlePeach = Color(hex: "#FFAA85")
        static let shieldPinkLight = Color(hex: "#F5B8C8")
        static let shieldPinkMedium = Color(hex: "#EE94A6")
        static let goldRibbon = Color(hex: "#DAA520")

        // Part 4 — Paywall & Commitment colors
        static let paywallDarkPurple = Color(hex: "#1A0A2E")
        static let paywallDeepPurple = Color(hex: "#2D1B4E")
        static let paywallAccentPurple = Color(hex: "#7C4DFF")
        static let paywallGold = Color(hex: "#FFD700")
        static let paywallCardBackground = Color(hex: "#2A1845")
        static let paywallCardBorder = Color(hex: "#7C4DFF").opacity(0.3)
        static let paywallSelectedBorder = Color(hex: "#7C4DFF")
        static let paywallTextMuted = Color(hex: "#B8A9D4")
        static let paywallBadgeGreen = Color(hex: "#4CAF50")
        static let commitmentPinkLight = Color(hex: "#F9E0E8")
        static let confettiGold = Color(hex: "#FFD700")
        static let confettiPurple = Color(hex: "#7C4DFF")
        static let confettiTeal = Color(hex: "#3AAFA9")
        static let sadGrayBackground = Color(hex: "#F0F0F0")
        static let sadBlueGray = Color(hex: "#8E99A4")
        static let bloomGreen = Color(hex: "#4CAF50")
        static let comparisonCardShadow = Color.black.opacity(0.08)

        // Part 5 — Main App colors

        // Tab Bar
        static let tabBarBg = Color.white
        static let tabBarActiveTint = Color(hex: "#1A1A2E")
        static let tabBarInactiveTint = Color(hex: "#9CA3AF")
        static let tabBarBadgeBg = Color(hex: "#E8738A")

        // Today Screen — Period Circle & Hero
        static let periodCircleBg = Color(hex: "#E8738A")
        static let periodCircleText = Color.white
        static let periodDayNumbers = Color(hex: "#E8738A")
        static let periodDayNormal = Color(hex: "#1A1A2E")
        static let todayBadgeBg = Color(hex: "#E8738A")
        static let predictedDayDash = Color(hex: "#E8738A")
        static let heroSubtitleText = Color(hex: "#3D3D3D")
        static let heroDaysText = Color(hex: "#1A1A1A")

        // Self-care section
        static let selfCareBg = Color(hex: "#FDF5F3")
        static let selfCareDivider = Color(hex: "#F0D5CC")

        // Insight card colors
        static let insightPurpleBg = Color(hex: "#D8CCF0")
        static let insightCoralBg = Color(hex: "#F5C4C0")
        static let insightLavenderBg = Color(hex: "#C8B8E8")

        // Daily Insights Cards
        static let insightCardBorder = Color(hex: "#E8738A")
        static let insightCardBg = Color.white
        static let insightCardTitle = Color(hex: "#E8738A")

        // Daily Logging Sheet
        static let loggingSheetBg = Color(hex: "#F8F8F7")
        static let loggingSheetHandle = Color(hex: "#D1D5DB")
        static let searchBarBg = Color(hex: "#E5E7EB")
        static let emojiCircleBg = Color(hex: "#FDF0EE")
        static let selectedChipBg = Color(hex: "#F9DDE3")
        static let selectedChipBorder = Color(hex: "#E8738A")
        static let unselectedChipBg = Color(hex: "#FDF0EE")
        static let checkmarkBadgeBg = Color(hex: "#E8D5F5")

        // Cycle Sections
        static let sectionCardBg = Color.white
        static let sectionDivider = Color(hex: "#F2F2F7")
        static let dotPeriod = Color(hex: "#E8738A")
        static let dotFertile = Color(hex: "#B8E6E0")
        static let dotOvulation = Color(hex: "#3AAFA9")
        static let dotNormal = Color(hex: "#E5E7EB")
        static let abnormalBadgeBg = Color(hex: "#FFA502")
        static let normalBadgeBg = Color(hex: "#34C759")

        // Calendar
        static let calendarFertileText = Color(hex: "#3AAFA9")
        static let calendarPeriodCircle = Color(hex: "#E8738A")
        static let calendarTodayCircle = Color(hex: "#6B7280")
        static let editPeriodDatesBtnBg = Color(hex: "#E8738A")
        static let segmentedControlBg = Color(hex: "#E5E7EB")

        // Day Detail
        static let dayDetailBg = Color.white
        static let dayDetailSummaryBg = Color(hex: "#F2F2F7")
        static let addLogFAB = Color(hex: "#3AAFA9")

        // Health Assistant
        static let assistantBubbleBg = Color(hex: "#F2F2F7")
        static let assistantBubbleText = Color(hex: "#1A1A2E")
        static let assistantAvatarBg = Color(hex: "#E8738A")
        static let assistantPopupBg = Color.white
        static let assistantPopupShadow = Color.black.opacity(0.1)
        static let progressBarThin = Color(hex: "#E8738A")

        // Trackers
        static let waterIconColor = Color(hex: "#4FC3F7")
        static let trackerButtonBg = Color(hex: "#E5E7EB")
        static let weightIconColor = Color(hex: "#6B7280")
        static let tempIconColor = Color(hex: "#9B59B6")

        // Partner Tab
        static let partnerGradientStart = Color(hex: "#E8D5F5")
        static let partnerGradientEnd = Color(hex: "#F9DDE3")
        static let partnerPhoneMockBg = Color(hex: "#F8F0FF")
        static let partnerYellowCard = Color(hex: "#FFF3CD")
        static let partnerPinkCard = Color(hex: "#F9DDE3")
        static let partnerTealCard = Color(hex: "#E0F7FA")

        // Settings
        static let settingsProfileCardBg = Color(hex: "#2D2D3A")
        static let settingsProfileText = Color.white
        static let settingsAlertBg = Color(hex: "#E74C3C")
        static let settingsAlertText = Color.white
        static let goalPillSelectedBg = Color(hex: "#E8738A")
        static let goalPillUnselectedBg = Color(hex: "#F2F2F7")

        // Reminders
        static let toggleOnTrack = Color(hex: "#3AAFA9")
        static let toggleOffTrack = Color(hex: "#D1D5DB")
        static let sectionHeaderBg = Color(hex: "#F2F2F7")
        static let sectionHeaderText = Color(hex: "#6B7280")
        static let addPillReminderText = Color(hex: "#E8738A")

        // Reports & Analytics
        static let reportCardBg = Color.white
        static let reportBorderLeft = Color(hex: "#E8738A")
        static let reportHeaderText = Color(hex: "#E8738A")
        static let cycleLengthBarPeriod = Color(hex: "#E8738A")
        static let cycleLengthBarRest = Color(hex: "#E5E7EB")
        static let averageLine = Color(hex: "#6B7280")
        static let sendPrintText = Color(hex: "#3AAFA9")

        // Graphs & Analytics
        static let graphIconCycle = Color(hex: "#B8E6E0")
        static let graphIconPeriod = Color(hex: "#4FC3F7")
        static let graphIconPatterns = Color(hex: "#3AAFA9")
        static let graphIconGraphs = Color(hex: "#B8E6E0")
        static let weightChartDot = Color(hex: "#4FC3F7")
        static let weightChartLine = Color(hex: "#3AAFA9")

        // Auth
        static let authGoogleBg = Color(hex: "#F2F2F7")
        static let backgroundCardGray = Color(hex: "#F2F2F7")
        static let flowerPeach = Color(hex: "#FFDAB9")
        static let bearAvatarBlue = Color(hex: "#4FC3F7")

        // Gradients — warmer, more distinct from Flo
        static let primaryGradient = LinearGradient(
            colors: [primaryGradientStart, primaryGradientEnd],
            startPoint: .leading,
            endPoint: .trailing
        )

        static let splashGradient = LinearGradient(
            colors: [Color(hex: "#EE94A6"), Color(hex: "#D4607A")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        static let warmBackgroundGradient = LinearGradient(
            colors: [backgroundWarm, background],
            startPoint: .top,
            endPoint: .bottom
        )

        static let tealGradient = LinearGradient(
            colors: [tealButton, tealButton],
            startPoint: .leading,
            endPoint: .trailing
        )

        static let coralHeaderGradient = LinearGradient(
            colors: [coralGradientStart, coralGradientEnd],
            startPoint: .leading,
            endPoint: .trailing
        )

        static let paywallBackgroundGradient = LinearGradient(
            colors: [paywallDarkPurple, paywallDeepPurple],
            startPoint: .top,
            endPoint: .bottom
        )

        static let premiumConfirmationGradient = LinearGradient(
            colors: [Color(hex: "#E8738A"), Color(hex: "#D4607A"), Color(hex: "#C44A80")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        static let commitmentGradient = LinearGradient(
            colors: [Color(hex: "#FDF5F3"), Color(hex: "#F9E0E8")],
            startPoint: .top,
            endPoint: .bottom
        )

        static let todayHeaderGradient = LinearGradient(
            colors: [Color(hex: "#FCEAE3"), Color(hex: "#FFF6F0")],
            startPoint: .top,
            endPoint: .bottom
        )

        static let todayHeroGradient = LinearGradient(
            colors: [Color(hex: "#FCEAE3"), Color(hex: "#F8D4CE"), Color(hex: "#EDA8A8")],
            startPoint: .top,
            endPoint: .bottom
        )

        static let partnerCardGradient = LinearGradient(
            colors: [partnerGradientStart, partnerGradientEnd],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        static let fertileBarGradient = LinearGradient(
            colors: [Color(hex: "#B8E6E0"), Color(hex: "#3AAFA9")],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    // MARK: - Fonts
    struct Fonts {
        static let displayLarge = Font.system(size: 72, weight: .bold, design: .rounded)
        static let largeTitle = Font.system(size: 32, weight: .bold, design: .rounded)
        static let title1 = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title2 = Font.system(size: 24, weight: .bold, design: .rounded)
        static let title3 = Font.system(size: 20, weight: .semibold, design: .rounded)
        static let headline = Font.system(size: 17, weight: .semibold, design: .rounded)
        static let body = Font.system(size: 16, weight: .regular, design: .rounded)
        static let bodyBold = Font.system(size: 16, weight: .semibold, design: .rounded)
        static let subheadline = Font.system(size: 14, weight: .regular, design: .rounded)
        static let subheadlineBold = Font.system(size: 14, weight: .semibold, design: .rounded)
        static let footnote = Font.system(size: 13, weight: .regular, design: .rounded)
        static let caption = Font.system(size: 12, weight: .regular, design: .rounded)
        static let captionBold = Font.system(size: 12, weight: .semibold, design: .rounded)
        static let scriptLogo = Font.system(size: 36, weight: .bold, design: .rounded)
    }

    // MARK: - Spacing
    struct Spacing {
        static let xxs: CGFloat = 2
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 48

        // Calendar-specific spacing
        static let calendarBottomPadding: CGFloat = 120
        static let calendarDetailPadding: CGFloat = 320
    }

    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 20
        static let pill: CGFloat = 28
        static let pillLarge: CGFloat = 30
    }

    // MARK: - Shadows
    struct Shadows {
        static func subtle() -> some ViewModifier {
            ShadowModifier(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        }

        static func elevated() -> some ViewModifier {
            ShadowModifier(color: .black.opacity(0.1), radius: 16, x: 0, y: 4)
        }

        static func card() -> some ViewModifier {
            ShadowModifier(color: .black.opacity(0.08), radius: 12, x: 0, y: 3)
        }
    }

    // MARK: - Button Heights
    struct ButtonHeight {
        static let primary: CGFloat = 56
        static let secondary: CGFloat = 48
    }

    // MARK: - Animation
    struct Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let spring = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.8)
        static let slow = SwiftUI.Animation.easeInOut(duration: 0.6)
        static let quick = SwiftUI.Animation.easeOut(duration: 0.2)
    }

    // MARK: - Responsive Layout
    struct ResponsiveLayout {
        static let seWidth: CGFloat = 375
        static let standardWidth: CGFloat = 390
        static let proMaxWidth: CGFloat = 430
        static let iPadMinWidth: CGFloat = 768

        static var screenWidth: CGFloat {
            UIScreen.main.bounds.width
        }

        static var isIPad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }

        static var isSE: Bool {
            screenWidth <= seWidth
        }

        /// Scale factor relative to standard iPhone (390pt), capped at 1.25 for iPad
        static var scaleFactor: CGFloat {
            let raw = screenWidth / standardWidth
            return min(raw, 1.25)
        }

        /// Scale a base value proportionally to screen width
        static func scaled(_ base: CGFloat) -> CGFloat {
            base * scaleFactor
        }

        /// Max content width for iPad to prevent overly wide text/cards
        static let maxContentWidth: CGFloat = 600

        // Named component sizes
        static var periodCircleSize: CGFloat {
            isSE ? 240 : (isIPad ? 320 : 280)
        }

        static var periodCircleFontSize: CGFloat {
            isSE ? 40 : (isIPad ? 56 : 48)
        }

        static var insightCardWidth: CGFloat {
            isSE ? 145 : (isIPad ? 200 : 165)
        }

        static var insightCardHeight: CGFloat {
            isSE ? 190 : (isIPad ? 250 : 210)
        }

        static var symptomPatternHeight: CGFloat {
            isSE ? 340 : (isIPad ? 420 : 380)
        }
    }
}

// MARK: - Shadow Modifier
struct ShadowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content.shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension View {
    func subtleShadow() -> some View {
        modifier(AppTheme.Shadows.subtle())
    }

    func elevatedShadow() -> some View {
        modifier(AppTheme.Shadows.elevated())
    }

    func cardShadow() -> some View {
        modifier(AppTheme.Shadows.card())
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
