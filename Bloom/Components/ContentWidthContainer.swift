import SwiftUI

struct ContentWidthContainer: ViewModifier {
    var maxWidth: CGFloat = AppTheme.ResponsiveLayout.maxContentWidth

    func body(content: Content) -> some View {
        if AppTheme.ResponsiveLayout.isIPad {
            content
                .frame(maxWidth: maxWidth)
                .frame(maxWidth: .infinity)
        } else {
            content
        }
    }
}

extension View {
    func constrainedWidth(_ maxWidth: CGFloat = AppTheme.ResponsiveLayout.maxContentWidth) -> some View {
        modifier(ContentWidthContainer(maxWidth: maxWidth))
    }
}
