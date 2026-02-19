import SwiftUI

// MARK: - Referral Source
enum ReferralSource: String, CaseIterable, Identifiable, Codable {
    case appStore = "App Store"
    case googleSearch = "Google Search"
    case friendsFamily = "Friends or Family"
    case instagramFacebook = "Instagram or Facebook"
    case tikTok = "TikTok"
    case youTubeTV = "YouTube or TV"
    case influencer = "Influencer or Celebrity"
    case medicalProfessional = "Medical professional"
    case other = "Other"

    var id: String { rawValue }
}

// MARK: - Tracking For
enum TrackingFor: String, CaseIterable, Identifiable, Codable {
    case myself = "Yes"
    case partner = "No, I have a partner code"

    var id: String { rawValue }
}

// MARK: - Pregnancy Status
enum PregnancyStatus: String, CaseIterable, Identifiable, Codable {
    case tryingToConceive = "No, but I want to be"
    case understandBody = "No, I'm here to better understand my body"
    case pregnant = "Yes, I am"

    var id: String { rawValue }
}

// MARK: - Tracking Goal
enum TrackingGoal: String, CaseIterable, Identifiable, Codable {
    case periodComing = "To know when my period is coming"
    case cycleNormal = "To know if my cycle or symptoms are normal"
    case sexLife = "To improve my sex life"
    case pregnancyRisk = "To understand my risk of getting pregnant"
    case somethingElse = "Something else"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .periodComing:
            return "Get accurate predictions so you're never caught off guard. We'll learn your unique patterns over time."
        case .cycleNormal:
            return "Compare your cycle length, symptoms, and flow to understand what's typical for you."
        case .sexLife:
            return "Learn how your cycle affects desire, energy, and comfort throughout the month."
        case .pregnancyRisk:
            return "Track your fertile window and understand when conception is most and least likely."
        case .somethingElse:
            return "Tell us more about what you're looking for and we'll personalize your experience."
        }
    }
}

// MARK: - Period Feeling
enum PeriodFeeling: String, CaseIterable, Identifiable, Codable {
    case loveHate = "It's a love-hate relationship"
    case embarrassed = "Embarrassed"
    case hateIt = "Hate it"
    case understand = "I want to understand it better"
    case friends = "We've become friends"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .loveHate: return "🙄"
        case .embarrassed: return "🫣"
        case .hateIt: return "😡"
        case .understand: return "🤔"
        case .friends: return "😌"
        }
    }

    var description: String {
        switch self {
        case .loveHate:
            return "Some days it feels like a superpower, other days it's the worst. We get it — and we're here to help you navigate every phase."
        case .embarrassed:
            return "There's nothing to be embarrassed about. We'll help you understand your body and feel more confident about your cycle."
        case .hateIt:
            return "We hear you. Let's work together to make your period more manageable with tracking, insights, and tips."
        case .understand:
            return "Curiosity is a great starting point! We'll help you decode your cycle and learn what your body is telling you."
        case .friends:
            return "That's amazing! You're already in tune with your body. Let's help you learn even more about your unique cycle."
        }
    }
}

// MARK: - Help Preference
enum HelpPreference: String, CaseIterable, Identifiable, Codable {
    case syncSexLife = "Sync my sex life with my cycle"
    case masturbation = "Make masturbation work for me"
    case spotPCOS = "Spot signs of PCOS or Endometriosis"
    case decodeDischarge = "Decode my discharge"
    case manageSymptoms = "Manage symptoms and moods"
    case learnOrgasm = "Learn how to orgasm"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .syncSexLife: return "heart.fill"
        case .masturbation: return "hand.raised.fill"
        case .spotPCOS: return "waveform.path.ecg"
        case .decodeDischarge: return "drop.fill"
        case .manageSymptoms: return "flame.fill"
        case .learnOrgasm: return "sparkles"
        }
    }
}

// MARK: - Feature Item
struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let backgroundColor: Color
    let iconType: FeatureIconType
}

enum FeatureIconType {
    case alarmWithHearts
    case womanWithLightning
    case circularArrow
    case largeNumber
}

// MARK: - Review Item
struct ReviewItem: Identifiable {
    let id = UUID()
    let initial: String
    let username: String
    let text: String
    let avatarColor: Color
    let alignment: HorizontalAlignment
}

// MARK: - Community Post
struct CommunityPost: Identifiable {
    let id = UUID()
    let question: String
    let likes: String
    let comments: String
    let thumbnailColor: Color
}

// MARK: - Cycle Phase
struct CyclePhase: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let widthFraction: CGFloat
}

// MARK: - Mood Point
struct MoodPoint: Identifiable {
    let id = UUID()
    let label: String
    let emoji: String
    let value: CGFloat // 0.0 (low/sad) to 1.0 (high/energetic)
    let position: CGFloat // 0.0 to 1.0 across the chart
}

// MARK: - Birth Control Method
enum BirthControlMethod: String, CaseIterable, Identifiable {
    case nothing = "Nothing"
    case pillPatchRing = "Pill, patch or ring"
    case progestinOnly = "Progestin-only pill (POPs or Mini pills)"
    case implantInjection = "Implant or injection"
    case hormonalIUD = "Hormonal IUD"
    case copperIUD = "Copper IUD (Non-hormonal)"
    case condoms = "Condoms (male or female)"
    case pullOut = "Pull-out method"
    case trackingOvulation = "Tracking ovulation"
    case somethingElse = "Something else or prefer not to say"

    var id: String { rawValue }
}

// MARK: - Health Condition
enum HealthCondition: String, CaseIterable, Identifiable {
    case yeastInfections = "Yeast infections"
    case utis = "Urinary tract infections (UTIs)"
    case bacterialVaginosis = "Bacterial Vaginosis (BV)"
    case pcos = "Polycystic ovary syndrome (PCOS)"
    case endometriosis = "Endometriosis"
    case fibroids = "Fibroids"
    case notSure = "I'm not sure"
    case none = "No, none of the above"

    var id: String { rawValue }
}

// MARK: - Today Symptom
struct TodaySymptom: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let iconColor: Color
}

// MARK: - Cycle Related Symptom
enum CycleSymptom: String, CaseIterable, Identifiable {
    case cramps = "Cramps"
    case spotting = "Spotting"
    case bloating = "Bloating"
    case moodSwings = "Mood swings"
    case headaches = "Headaches"
    case fatigue = "Fatigue"
    case backache = "Backache"

    var id: String { rawValue }

    var expandedDescription: String {
        switch self {
        case .cramps:
            return "Cramps are caused by prostaglandins, which help your uterus shed its lining. Tracking when they occur can help you prepare and manage them better."
        case .spotting:
            return "Around 5% of women experience light vaginal bleeding when they ovulate, however, there are other causes that need to be checked out. Log it in Bloom and learn when it may be a good time to see a healthcare professional."
        case .bloating:
            return "Hormonal changes during your cycle can cause water retention and bloating. Tracking this symptom helps you understand your body's patterns."
        case .moodSwings:
            return "Fluctuating estrogen and progesterone levels can affect your mood throughout your cycle. Understanding the pattern can help you plan accordingly."
        case .headaches:
            return "Hormonal headaches are common and often occur during the premenstrual phase. Logging them helps identify triggers and patterns."
        case .fatigue:
            return "Changes in progesterone levels can affect your energy throughout your cycle. Tracking fatigue helps you plan rest and activity."
        case .backache:
            return "Lower back pain is common during menstruation due to prostaglandins. Tracking it helps you anticipate and manage discomfort."
        }
    }
}

// MARK: - Stat Question Option
struct StatQuestionOption: Identifiable {
    let id = UUID()
    let label: String
    let expandedDescription: String
}

// MARK: - Cycle Stats Row
struct CycleStatsRow: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let statusType: CycleStatusType
    let statusLabel: String
    let showInfoIcon: Bool
}

enum CycleStatusType {
    case normal
    case irregular
}

// MARK: - Health Assistant Chat Row
struct HealthAssistantChatRow: Identifiable {
    let id = UUID()
    let iconName: String
    let iconBackgroundColor: Color
    let title: String
    let time: String
    let descriptionText: String
    let showDotIndicator: Bool
}

// MARK: - Part 3: Mental Health Option
struct MentalHealthOption: Identifiable {
    let id = UUID()
    let label: String
    let expandedDescription: String
}

// MARK: - Part 3: Sexual Wellness Option
struct SexualWellnessOption: Identifiable {
    let id = UUID()
    let label: String
    let expandedDescription: String
}

// MARK: - Part 3: Enhance Sex Life Option
struct EnhanceSexLifeOption: Identifiable {
    let id = UUID()
    let label: String
}

// MARK: - Part 3: Personalizing Phase
struct PersonalizingPhase: Identifiable {
    let id = UUID()
    let title: String
    let progressStart: Double
    let progressEnd: Double
}

// MARK: - Part 3: Article Card
struct ArticleCardItem: Identifiable {
    let id = UUID()
    let title: String
    let backgroundColor: Color
    let iconName: String
    let width: CGFloat
    let height: CGFloat
}

// MARK: - Part 4: Subscription Plan
struct SubscriptionPlan: Identifiable {
    let id: String
    let title: String
    let price: String
    let perPeriod: String
    let savings: String?
    let trialText: String?
    let isMostPopular: Bool
}

// MARK: - Part 4: User Review (Paywall)
struct PaywallReview: Identifiable {
    let id = UUID()
    let name: String
    let initial: String
    let rating: Int
    let text: String
    let avatarColor: Color
}

// MARK: - Part 4: Comparison Item
struct ComparisonItem: Identifiable {
    let id = UUID()
    let feature: String
    let withoutBloom: String
    let withBloom: String
}

// MARK: - Part 4: Pledge Item
struct PledgeItem: Identifiable {
    let id = UUID()
    let emoji: String
    let text: String
}

// MARK: - Static Data
struct OnboardingData {

    static let featureItems: [FeatureItem] = [
        FeatureItem(
            title: "How my cycle impacts sex",
            subtitle: "",
            backgroundColor: AppTheme.Colors.featureBlueGray,
            iconType: .alarmWithHearts
        ),
        FeatureItem(
            title: "What do my PMS symptoms mean",
            subtitle: "",
            backgroundColor: AppTheme.Colors.featurePeach,
            iconType: .womanWithLightning
        ),
        FeatureItem(
            title: "Period could start today",
            subtitle: "",
            backgroundColor: AppTheme.Colors.featurePink,
            iconType: .circularArrow
        ),
        FeatureItem(
            title: "Dive into my cycle day",
            subtitle: "",
            backgroundColor: AppTheme.Colors.featureLightBlue,
            iconType: .largeNumber
        )
    ]

    static let reviewItems: [ReviewItem] = [
        ReviewItem(
            initial: "S",
            username: "sarah_k",
            text: "I've tried so many apps but Bloom is the only one that actually predicted my period correctly every single time.",
            avatarColor: AppTheme.Colors.avatarPink,
            alignment: .leading
        ),
        ReviewItem(
            initial: "M",
            username: "maya_j",
            text: "The insights about how my cycle affects my mood have been life-changing. I finally understand why I feel the way I do.",
            avatarColor: AppTheme.Colors.avatarTeal,
            alignment: .trailing
        ),
        ReviewItem(
            initial: "A",
            username: "alex_r",
            text: "Love the community! It's so nice to know other people experience the same things.",
            avatarColor: AppTheme.Colors.avatarCoral,
            alignment: .leading
        ),
        ReviewItem(
            initial: "L",
            username: "luna_w",
            text: "Best period tracker out there. The symptom logging is so detailed and actually useful.",
            avatarColor: AppTheme.Colors.avatarPurple,
            alignment: .trailing
        )
    ]

    static let communityPosts: [CommunityPost] = [
        CommunityPost(
            question: "Has anyone else noticed their skin breaking out right before their period? What helps?",
            likes: "19K",
            comments: "43K",
            thumbnailColor: AppTheme.Colors.featurePeach
        ),
        CommunityPost(
            question: "What's your go-to comfort food during your period? Need new ideas!",
            likes: "12K",
            comments: "28K",
            thumbnailColor: AppTheme.Colors.featurePink
        ),
        CommunityPost(
            question: "Does exercise actually help with cramps? Share your experience!",
            likes: "5K",
            comments: "12K",
            thumbnailColor: AppTheme.Colors.featureLightBlue
        )
    ]

    static let moodPoints: [MoodPoint] = [
        MoodPoint(label: "Sad", emoji: "😢", value: 0.2, position: 0.0),
        MoodPoint(label: "Energetic", emoji: "⚡️", value: 0.9, position: 0.3),
        MoodPoint(label: "Calm", emoji: "😌", value: 0.5, position: 0.6),
        MoodPoint(label: "Irritated", emoji: "😤", value: 0.7, position: 0.85)
    ]

    static let cyclePhases: [CyclePhase] = [
        CyclePhase(name: "Period", color: AppTheme.Colors.periodPhase, widthFraction: 0.2),
        CyclePhase(name: "Follicular", color: AppTheme.Colors.follicularPhase, widthFraction: 0.3),
        CyclePhase(name: "Fertile days", color: AppTheme.Colors.fertilePhase, widthFraction: 0.2),
        CyclePhase(name: "Luteal", color: AppTheme.Colors.lutealPhase, widthFraction: 0.3)
    ]

    // MARK: - Part 2 Static Data

    static let todaySymptoms: [TodaySymptom] = [
        TodaySymptom(name: "Cramps", iconName: "target", iconColor: AppTheme.Colors.skinTone),
        TodaySymptom(name: "Fatigue", iconName: "battery.25percent", iconColor: AppTheme.Colors.coralAccent),
        TodaySymptom(name: "Bloating", iconName: "aqi.medium", iconColor: AppTheme.Colors.avatarPink),
        TodaySymptom(name: "Tender breasts", iconName: "figure.stand", iconColor: AppTheme.Colors.skinTone),
        TodaySymptom(name: "Backache", iconName: "figure.walk", iconColor: AppTheme.Colors.skinTone),
        TodaySymptom(name: "None of these", iconName: "nosign", iconColor: AppTheme.Colors.textTertiary)
    ]

    static let cycleStatsRows: [CycleStatsRow] = [
        CycleStatsRow(label: "Previous cycle length", value: "31 days", statusType: .normal, statusLabel: "NORMAL", showInfoIcon: true),
        CycleStatsRow(label: "Previous period length", value: "5 days", statusType: .normal, statusLabel: "NORMAL", showInfoIcon: false),
        CycleStatsRow(label: "Cycle length variation", value: "26–37 days", statusType: .irregular, statusLabel: "IRREGULAR", showInfoIcon: true)
    ]

    static let healthAssistantRows: [HealthAssistantChatRow] = [
        HealthAssistantChatRow(
            iconName: "heart.fill",
            iconBackgroundColor: AppTheme.Colors.avatarPurple,
            title: "Cramps",
            time: "10:01 AM",
            descriptionText: "Let's discuss causes for cramps you might have.",
            showDotIndicator: true
        ),
        HealthAssistantChatRow(
            iconName: "bolt.fill",
            iconBackgroundColor: AppTheme.Colors.orangeAccent,
            title: "Headache",
            time: "9:15 AM",
            descriptionText: "Let's discuss causes and relief for any headaches you might have.",
            showDotIndicator: false
        ),
        HealthAssistantChatRow(
            iconName: "brain.head.profile",
            iconBackgroundColor: AppTheme.Colors.avatarPink,
            title: "Mood swings",
            time: "8:12 AM",
            descriptionText: "There are many reasons why you might be feeling this way. Let's work it out together.",
            showDotIndicator: false
        )
    ]

    // MARK: - Part 3 Static Data

    static let dietImpactOptions: [StatQuestionOption] = [
        StatQuestionOption(label: "Yes", expandedDescription: "Ever wondered why you're more hungry before your period? Or if there's anything to eat to ease PMS? Check out our articles and videos from dieticians to sync your diet with your cycle."),
        StatQuestionOption(label: "No", expandedDescription: ""),
        StatQuestionOption(label: "I'm not sure", expandedDescription: "")
    ]

    static let mentalHealthOptions: [MentalHealthOption] = [
        MentalHealthOption(label: "Mood swings", expandedDescription: "Mood swings are one of the most common PMS symptoms. Bloom can help you track and predict when they might occur so you can better prepare."),
        MentalHealthOption(label: "Anxiety", expandedDescription: "Thanks to brain chemistry and hormone fluctuations, women are more likely to experience anxiety than men. Check out Bloom's video course on how to cope."),
        MentalHealthOption(label: "Fatigue", expandedDescription: "Feeling drained at certain points in your cycle is completely normal. Track your energy levels in Bloom and discover your personal patterns."),
        MentalHealthOption(label: "Irritability", expandedDescription: "Fluctuating hormones have a lot to answer for — like how tolerant we are to irritations during PMS. Log your feelings in Bloom and see if a pattern emerges with your cycle."),
        MentalHealthOption(label: "Low mood", expandedDescription: "Low mood can be linked to hormonal changes in your cycle. Bloom helps you understand these connections and offers evidence-based coping strategies."),
        MentalHealthOption(label: "I have Premenstrual Dysphoric Disorder", expandedDescription: "PMDD is a severe form of PMS that affects 3-8% of women. Bloom can help you track symptoms to share with your healthcare provider.")
    ]

    static let sexualWellnessOptions: [SexualWellnessOption] = [
        SexualWellnessOption(label: "Better orgasms", expandedDescription: "Understanding your cycle can help you discover when arousal peaks. Bloom offers insights from sex therapists on enhancing pleasure."),
        SexualWellnessOption(label: "Improved sex drive", expandedDescription: "Fluctuating libido is perfectly normal but can feel like a mystery. Log it in Bloom to see if it changes during your cycle, plus get tips to boost your sex drive from Bloom's sex therapists."),
        SexualWellnessOption(label: "Increased intimacy", expandedDescription: "Strong communication is vital to great partnered sex but takes effort and practice! Bloom offers sexpert-approved tips on how to communicate your needs and find out theirs."),
        SexualWellnessOption(label: "Sex positions", expandedDescription: "Explore different positions that work better at different phases of your cycle. Bloom provides curated suggestions from certified sex educators."),
        SexualWellnessOption(label: "Make sex less painful", expandedDescription: "Pain during sex is common but not normal. Bloom can help you track when it occurs and offers resources from healthcare professionals.")
    ]

    static let enhanceSexLifeOptions: [EnhanceSexLifeOption] = [
        EnhanceSexLifeOption(label: "I want to feel more connected during sex"),
        EnhanceSexLifeOption(label: "I want to have more orgasms"),
        EnhanceSexLifeOption(label: "I want to make sex more fun"),
        EnhanceSexLifeOption(label: "I want to feel more confident sexually"),
        EnhanceSexLifeOption(label: "Prefer not to answer")
    ]

    static let articleCards: [ArticleCardItem] = [
        ArticleCardItem(title: "How to clean your vagina", backgroundColor: AppTheme.Colors.articleBlue, iconName: "hand.raised.fill", width: 140, height: 160),
        ArticleCardItem(title: "5 sex therapy secrets", backgroundColor: AppTheme.Colors.avatarPink, iconName: "heart.circle.fill", width: 140, height: 130),
        ArticleCardItem(title: "What to do after unprotected sex", backgroundColor: AppTheme.Colors.primaryPink, iconName: "exclamationmark.shield.fill", width: 160, height: 180),
        ArticleCardItem(title: "What Counts as a Late Period?", backgroundColor: AppTheme.Colors.articlePurple, iconName: "calendar.badge.clock", width: 140, height: 140),
        ArticleCardItem(title: "Discharge: What to Look Out For", backgroundColor: AppTheme.Colors.articlePeach, iconName: "drop.fill", width: 150, height: 150),
        ArticleCardItem(title: "7 Non-Penetrative Sex Ideas", backgroundColor: AppTheme.Colors.featurePink, iconName: "sparkles", width: 130, height: 120)
    ]

    // MARK: - Part 4 Static Data

    static let subscriptionPlans: [SubscriptionPlan] = [
        SubscriptionPlan(
            id: "yearly",
            title: "Yearly",
            price: "$49.99/year",
            perPeriod: "$0.96/week",
            savings: "Save 86%",
            trialText: "3-day free trial",
            isMostPopular: true
        ),
        SubscriptionPlan(
            id: "weekly",
            title: "Weekly",
            price: "$6.99/week",
            perPeriod: "$6.99/week",
            savings: nil,
            trialText: nil,
            isMostPopular: false
        )
    ]

    static let paywallReviews: [PaywallReview] = [
        PaywallReview(
            name: "Emma R.",
            initial: "E",
            rating: 5,
            text: "Bloom helped me finally understand my body. The predictions are incredibly accurate!",
            avatarColor: AppTheme.Colors.avatarPink
        ),
        PaywallReview(
            name: "Sophia L.",
            initial: "S",
            rating: 5,
            text: "The symptom tracking changed everything for me. I feel so much more in control of my health.",
            avatarColor: AppTheme.Colors.avatarTeal
        ),
        PaywallReview(
            name: "Mia K.",
            initial: "M",
            rating: 5,
            text: "Best period tracker I've ever used. The insights are spot on and the community is amazing.",
            avatarColor: AppTheme.Colors.avatarPurple
        ),
        PaywallReview(
            name: "Olivia T.",
            initial: "O",
            rating: 5,
            text: "I love how Bloom connects my cycle to my mood, energy, and skin. It's like having a personal health guide.",
            avatarColor: AppTheme.Colors.avatarCoral
        )
    ]

    static let comparisonItems: [ComparisonItem] = [
        ComparisonItem(feature: "Period predictions", withoutBloom: "Guessing when it starts", withBloom: "Know the exact day"),
        ComparisonItem(feature: "Symptoms", withoutBloom: "Suffering in confusion", withBloom: "Understand the why"),
        ComparisonItem(feature: "Mood changes", withoutBloom: "Feeling out of control", withBloom: "Predict & prepare"),
        ComparisonItem(feature: "Sex & intimacy", withoutBloom: "Disconnected from desire", withBloom: "Sync with your cycle"),
        ComparisonItem(feature: "Health insights", withoutBloom: "One-size-fits-all advice", withBloom: "Personalized to you")
    ]

    static let pledgeItems: [PledgeItem] = [
        PledgeItem(emoji: "🌸", text: "I will listen to my body and honor what it needs"),
        PledgeItem(emoji: "📝", text: "I will log my symptoms and moods consistently"),
        PledgeItem(emoji: "💪", text: "I will take charge of my reproductive health"),
        PledgeItem(emoji: "❤️", text: "I will treat myself with kindness every day of my cycle"),
        PledgeItem(emoji: "🌟", text: "I will embrace the power of understanding my body")
    ]
}
