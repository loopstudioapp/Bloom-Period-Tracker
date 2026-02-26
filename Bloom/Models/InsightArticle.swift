import SwiftUI

struct ArticleKeyPoint: Identifiable {
    let id = UUID()
    let heading: String
    let body: String
}

struct InsightArticle: Identifiable {
    let id = UUID()
    let category: String
    let title: String
    let subtitle: String
    let iconName: String
    let readTime: String
    let cardColor: Color
    let keyPoints: [ArticleKeyPoint]
}

// MARK: - Article Data

struct InsightArticleData {
    static let featured = articles[0]

    static let articles: [InsightArticle] = [
        // 1. Understanding Your Cycle
        InsightArticle(
            category: "Cycle Basics",
            title: "Your Cycle in 4 Phases",
            subtitle: "Learn what's happening in your body each week.",
            iconName: "arrow.triangle.2.circlepath",
            readTime: "5 min read",
            cardColor: Color(hex: "#F9E0E8"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Menstrual Phase (Days 1–7)",
                    body: "Your uterine lining sheds during your period. Estrogen and progesterone are at their lowest, which is why energy and mood can dip. Bleeding typically lasts 3–7 days."
                ),
                ArticleKeyPoint(
                    heading: "Follicular Phase (Days 1–14)",
                    body: "Overlapping with menstruation, your body prepares an egg for release. Rising estrogen boosts energy and mood as you approach mid-cycle."
                ),
                ArticleKeyPoint(
                    heading: "Ovulation (Around Day 14)",
                    body: "A surge in luteinizing hormone triggers the release of a mature egg. This is your most fertile window — many people notice increased energy and libido."
                ),
                ArticleKeyPoint(
                    heading: "Luteal Phase (Days 15–28)",
                    body: "Progesterone rises to thicken the uterine lining. If the egg isn't fertilized, hormone levels drop, triggering PMS symptoms and eventually your next period."
                ),
                ArticleKeyPoint(
                    heading: "Normal Varies",
                    body: "A healthy cycle can range from 21 to 35 days. Not everyone has a textbook 28-day cycle, and some variation month to month is completely normal."
                )
            ]
        ),

        // 2. Period Pain & Relief
        InsightArticle(
            category: "Pain Relief",
            title: "Taming Period Cramps",
            subtitle: "Proven ways to ease menstrual pain.",
            iconName: "heart.text.square",
            readTime: "4 min read",
            cardColor: Color(hex: "#FDDCD5"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Why It Hurts",
                    body: "Cramps are caused by prostaglandins — chemicals that make your uterus contract to shed its lining. Higher levels mean more severe pain."
                ),
                ArticleKeyPoint(
                    heading: "Pain Relief Timing Matters",
                    body: "Ibuprofen or naproxen taken at the first sign of pain work best because they reduce prostaglandin production before cramps peak."
                ),
                ArticleKeyPoint(
                    heading: "Heat Therapy Works",
                    body: "Applying a heating pad to your lower abdomen is clinically supported. Research shows topical heat can be as effective as ibuprofen for mild-to-moderate cramps."
                ),
                ArticleKeyPoint(
                    heading: "Exercise Helps Too",
                    body: "Regular exercise (8–12 weeks) has been shown to reduce cramp intensity and shorten the duration of pain episodes."
                ),
                ArticleKeyPoint(
                    heading: "When to See a Doctor",
                    body: "If pain interferes with daily life, gets progressively worse, or started suddenly after age 25, it could signal endometriosis or fibroids."
                )
            ]
        ),

        // 3. Fertility & Ovulation
        InsightArticle(
            category: "Fertility",
            title: "Your Fertile Window",
            subtitle: "When conception is most likely and how to tell.",
            iconName: "leaf.fill",
            readTime: "5 min read",
            cardColor: Color(hex: "#D5F0E3"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "The 6-Day Window",
                    body: "You are most likely to conceive during the 5 days before ovulation and on ovulation day itself. Sperm can survive in the body for up to 5 days."
                ),
                ArticleKeyPoint(
                    heading: "When You Actually Ovulate",
                    body: "Ovulation typically occurs about 14 days before your next period — not necessarily on day 14. If your cycle is 32 days, you likely ovulate around day 18."
                ),
                ArticleKeyPoint(
                    heading: "Cervical Mucus Is a Key Sign",
                    body: "Before ovulation, mucus becomes clear, stretchy, and slippery. After ovulation, it returns to thick and dry. Tracking this pattern helps predict fertility."
                ),
                ArticleKeyPoint(
                    heading: "LH Test Strips",
                    body: "Over-the-counter ovulation predictor kits detect the LH surge 24–48 hours before ovulation and are up to 99% effective at identifying your most fertile days."
                ),
                ArticleKeyPoint(
                    heading: "Combine Multiple Signs",
                    body: "Tracking basal body temperature, cervical mucus changes, and cycle length together gives the most complete picture of your fertility pattern."
                )
            ]
        ),

        // 4. Nutrition & Your Cycle
        InsightArticle(
            category: "Nutrition",
            title: "Eat for Your Cycle",
            subtitle: "Foods that support each phase of your period.",
            iconName: "fork.knife",
            readTime: "5 min read",
            cardColor: Color(hex: "#FDE8D0"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Menstrual Phase: Replenish Iron",
                    body: "Blood loss depletes iron stores. Focus on iron-rich foods like leafy greens, red meat, lentils, and beans. Pair with vitamin C for better absorption."
                ),
                ArticleKeyPoint(
                    heading: "Follicular Phase: Fuel Up",
                    body: "As energy and estrogen rise, support your body with lean proteins, fermented foods, and whole grains that help metabolize increasing estrogen."
                ),
                ArticleKeyPoint(
                    heading: "Luteal Phase: Manage Cravings",
                    body: "PMS cravings are driven by hormonal shifts. Complex carbs and high-fiber foods like sweet potatoes and whole grains help stabilize blood sugar."
                ),
                ArticleKeyPoint(
                    heading: "Anti-Inflammatory Foods Help",
                    body: "Omega-3 fatty acids from salmon, walnuts, and flaxseed reduce inflammation and may ease cramps. Staying well-hydrated helps reduce bloating."
                ),
                ArticleKeyPoint(
                    heading: "Balance Over Perfection",
                    body: "Focus on overall balanced nutrition rather than rigid phase-specific protocols. Small, consistent improvements matter more than extreme changes."
                )
            ]
        ),

        // 5. Exercise & Periods
        InsightArticle(
            category: "Fitness",
            title: "Move With Your Cycle",
            subtitle: "The best workouts for every phase.",
            iconName: "figure.run",
            readTime: "4 min read",
            cardColor: Color(hex: "#D4EDE8"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Menstrual Phase: Go Gentle",
                    body: "Hormones are at their lowest. Light walking, yoga, and stretching can ease cramps and improve mood without overtaxing your body."
                ),
                ArticleKeyPoint(
                    heading: "Follicular Phase: Push Harder",
                    body: "Rising estrogen boosts energy and recovery. This is ideal for strength training, HIIT, and higher-intensity cardio."
                ),
                ArticleKeyPoint(
                    heading: "Ovulation: Peak Performance",
                    body: "A testosterone surge supports muscle growth and repair. You may feel your strongest, but take care — elevated estrogen can make ligaments more lax."
                ),
                ArticleKeyPoint(
                    heading: "Luteal Phase: Dial It Back",
                    body: "Rising progesterone causes fatigue and increased body temperature. Moderate cardio, Pilates, and lower-weight strength training work well."
                ),
                ArticleKeyPoint(
                    heading: "Consistency Is Key",
                    body: "Everyone's cycle is different. The best exercise is whatever you enjoy and can do regularly. Track how you feel to find your personal rhythm."
                )
            ]
        ),

        // 6. Mental Health & Hormones
        InsightArticle(
            category: "Mental Health",
            title: "Your Mood & Your Cycle",
            subtitle: "Why hormones affect how you feel.",
            iconName: "brain.head.profile",
            readTime: "5 min read",
            cardColor: Color(hex: "#E4DAF1"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "The Hormone-Mood Connection",
                    body: "Fluctuating estrogen during the luteal phase affects serotonin, a brain chemical key to mood regulation. This is why irritability and mood swings are common PMS symptoms."
                ),
                ArticleKeyPoint(
                    heading: "PMS Affects Most People",
                    body: "Up to 90% of menstruating people experience PMS to some degree. Common emotional symptoms include irritability, anxiety, difficulty concentrating, and sadness."
                ),
                ArticleKeyPoint(
                    heading: "PMDD Is More Severe",
                    body: "Premenstrual Dysphoric Disorder affects about 3–8% of menstruating people with severe mood symptoms. It is a recognized medical condition that deserves care."
                ),
                ArticleKeyPoint(
                    heading: "What Helps",
                    body: "Regular exercise, adequate sleep, stress management, and limiting caffeine and alcohol during the luteal phase can all meaningfully reduce symptoms."
                ),
                ArticleKeyPoint(
                    heading: "When to Seek Help",
                    body: "If mood symptoms disrupt your relationships, work, or daily functioning, or you feel hopeless, talk to a healthcare provider. Treatment is available."
                )
            ]
        ),

        // 7. Sexual Health
        InsightArticle(
            category: "Sexual Health",
            title: "Sex & Your Cycle",
            subtitle: "How your cycle influences intimacy.",
            iconName: "heart.circle",
            readTime: "4 min read",
            cardColor: Color(hex: "#F5D5DD"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Libido Fluctuates Naturally",
                    body: "Many people experience increased desire around ovulation when estrogen and testosterone peak. Some also notice heightened arousal during menstruation."
                ),
                ArticleKeyPoint(
                    heading: "Period Sex Is Safe",
                    body: "There is no medical reason to avoid sex during your period. It may even help relieve cramps through endorphin release."
                ),
                ArticleKeyPoint(
                    heading: "Pregnancy Is Possible on Your Period",
                    body: "While less likely, sperm can survive up to 5 days. If you ovulate shortly after your period ends, conception can occur."
                ),
                ArticleKeyPoint(
                    heading: "Infection Awareness",
                    body: "The cervix opens slightly during menstruation, which may increase susceptibility to certain infections. Barrier protection reduces this risk."
                ),
                ArticleKeyPoint(
                    heading: "Communication Matters",
                    body: "Changes in desire throughout your cycle are completely normal. Talking openly with your partner strengthens intimacy and reduces pressure."
                )
            ]
        ),

        // 8. Discharge & Cervical Mucus
        InsightArticle(
            category: "Body Literacy",
            title: "What Your Discharge Means",
            subtitle: "A guide to what's normal down there.",
            iconName: "drop.fill",
            readTime: "4 min read",
            cardColor: Color(hex: "#D4E8F5"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "It Changes Throughout Your Cycle",
                    body: "After your period you may have dry days. Discharge then becomes sticky, gradually turning creamy. Near ovulation it becomes clear, wet, and stretchy."
                ),
                ArticleKeyPoint(
                    heading: "Normal Discharge",
                    body: "Clear or white discharge without a strong odor is normal. The amount varies from person to person — some naturally produce more than others."
                ),
                ArticleKeyPoint(
                    heading: "Warning Signs by Color",
                    body: "Yellow, green, or gray discharge may indicate infection. Cottage cheese-like texture could signal a yeast infection. A fishy odor may point to bacterial vaginosis."
                ),
                ArticleKeyPoint(
                    heading: "Tracking Mucus Is Useful",
                    body: "Paying attention to cervical mucus patterns helps you understand your fertility, confirm ovulation, and notice changes that need attention."
                ),
                ArticleKeyPoint(
                    heading: "Don't Self-Diagnose",
                    body: "If discharge changes notably in smell, color, or consistency, see a healthcare provider. Many conditions have overlapping symptoms that require proper evaluation."
                )
            ]
        ),

        // 9. Sleep & Your Cycle
        InsightArticle(
            category: "Wellness",
            title: "Better Sleep, Better Periods",
            subtitle: "Why your cycle disrupts sleep and what helps.",
            iconName: "moon.zzz.fill",
            readTime: "4 min read",
            cardColor: Color(hex: "#D8D4E8"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Sleep Changes Are Common",
                    body: "Up to 7 in 10 people notice sleep changes before their period. The sharp drop in progesterone — which promotes relaxation — is a major contributor."
                ),
                ArticleKeyPoint(
                    heading: "Melatonin Dips Too",
                    body: "During the late luteal and menstrual phases, reduced melatonin affects your deepest sleep stages, leading to lighter, less restorative sleep."
                ),
                ArticleKeyPoint(
                    heading: "Body Temperature Plays a Role",
                    body: "Progesterone slightly raises core body temperature after ovulation. Since your body needs to cool down to fall asleep, this can make it harder to drift off."
                ),
                ArticleKeyPoint(
                    heading: "Practical Sleep Tips",
                    body: "Keep your bedroom cool and dark, maintain a consistent schedule, limit caffeine in the luteal phase, and manage pain proactively before bed."
                ),
                ArticleKeyPoint(
                    heading: "Supplements to Consider",
                    body: "Magnesium, vitamin B6, and calcium have shown potential for improving PMS-related sleep disruption. Always check with your doctor before starting supplements."
                )
            ]
        ),

        // 10. When to See a Doctor
        InsightArticle(
            category: "Health Check",
            title: "Signs to Talk to Your Doctor",
            subtitle: "Don't ignore these period red flags.",
            iconName: "stethoscope",
            readTime: "4 min read",
            cardColor: Color(hex: "#F5D5D5"),
            keyPoints: [
                ArticleKeyPoint(
                    heading: "Irregular Timing",
                    body: "See a doctor if regular periods become irregular, come more often than every 21 days, less often than every 35 days, or go more than 90 days apart."
                ),
                ArticleKeyPoint(
                    heading: "Heavy Bleeding",
                    body: "Soaking through a pad or tampon every 1–2 hours, passing clots larger than a quarter, or bleeding longer than 8 days are signs of abnormally heavy bleeding."
                ),
                ArticleKeyPoint(
                    heading: "Severe Worsening Pain",
                    body: "Cramps that don't respond to pain relief, pain that gets worse cycle after cycle, or new severe pain after age 25 may indicate endometriosis or fibroids."
                ),
                ArticleKeyPoint(
                    heading: "Missed Periods",
                    body: "Missing three or more consecutive periods when not pregnant, breastfeeding, or in menopause warrants attention. Causes range from stress to thyroid disorders and PCOS."
                ),
                ArticleKeyPoint(
                    heading: "Urgent Warning Signs",
                    body: "Seek immediate care if you experience fainting, confusion, shortness of breath, or feel lightheaded during heavy bleeding — these could indicate dangerous blood loss."
                )
            ]
        )
    ]
}
