import SwiftUI

@MainActor
class PartnerViewModel: ObservableObject {
    @Published var isPartnerLinked: Bool = false
    @Published var partnerCode: String = ""

    let benefits: [(String, String)] = [
        ("checkmark.circle.fill", "He'll know when your sex drive might be high"),
        ("checkmark.circle.fill", "You'll feel supported through your cycle lows"),
        ("checkmark.circle.fill", "We'll explain your cycle in a way he understands")
    ]

    func linkPartner() {
        isPartnerLinked = true
    }
}
