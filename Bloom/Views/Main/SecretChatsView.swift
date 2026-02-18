import SwiftUI

struct SecretChatsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Secret Chats")
                    .font(AppTheme.Fonts.title2)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Text("Coming soon")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.Colors.background)
            .navigationTitle("Secret Chats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SecretChatsView()
}
