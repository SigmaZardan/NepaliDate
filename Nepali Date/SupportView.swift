//
//  SupportView.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 01/01/2026.
//

//
//  SupportView.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 24/12/2025.
//

import SwiftUI
import StoreKit


struct SupportView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Environment(\.requestReview) var requestReview
    @State private var isAnimating = false
    @State private var showThankYou = false
    @State private var selectedStar = 0
    @Environment(\.openURL) private var openUrl

    private var primaryRed: Color {
        colorScheme == .dark ? .nepaliRedDark : .nepaliRed
    }

    private var primaryBlue: Color {
        colorScheme == .dark ? .nepaliBlueDark : .nepaliBlue
    }

    private var primaryOrange: Color {
        colorScheme == .dark ? .nepaliOrangeDark : .nepaliOrange
    }

    private var primaryGold: Color {
        colorScheme == .dark ? .templeGoldDark : .templeGold
    }

    private var cardBackground: Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.18) : .white
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    // Background gradient
                    LinearGradient(
                        colors: colorScheme == .dark ? [
                            Color(red: 0.08, green: 0.08, blue: 0.12),
                            Color(red: 0.12, green: 0.10, blue: 0.15),
                            Color(red: 0.10, green: 0.08, blue: 0.13)
                        ] : [
                            Color(red: 0.98, green: 0.95, blue: 0.93),
                            Color(red: 0.95, green: 0.97, blue: 0.99),
                            Color(red: 0.96, green: 0.94, blue: 0.95)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 24) {
                            // Header
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [primaryRed.opacity(0.2), primaryOrange.opacity(0.1)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 100, height: 100)

                                    Image(systemName: "heart.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [primaryRed, primaryOrange],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                }
                                .scaleEffect(isAnimating ? 1.0 : 0.8)
                                .opacity(isAnimating ? 1.0 : 0)

                                VStack(spacing: 8) {
                                    Text("Support Us")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [primaryRed, primaryOrange],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )

                                    Text("हाम्रो सहयोग गर्नुहोस्")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(primaryBlue.opacity(0.7))

                                    Text("Your support helps us improve")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .opacity(isAnimating ? 1.0 : 0)
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)

                            // Rate Us Section
                            VStack(spacing: 20) {
                                VStack(spacing: 12) {
                                    Text("Enjoying Nepali Date?")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(primaryRed)

                                    Text("Tap the stars to rate us on the App Store")
                                        .font(.system(size: 15))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)

                                    Button {
                                        requestReview()
                                    } label: {
                                        HStack(spacing: 8) {
                                            Image(systemName: "hand.thumbsup.fill")
                                                .font(.system(size: 16, weight: .semibold))

                                            Text("Rate on App Store")
                                                .font(.system(size: 17, weight: .semibold))
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(
                                            LinearGradient(
                                                colors: [primaryRed, primaryGold],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .shadow(color: primaryRed.opacity(0.3), radius: 8, x: 0, y: 4)
                                    }
                                    .buttonStyle(.plain)


                                    Text("Takes less than a minute")
                                               .font(.system(size: 13))
                                               .foregroundColor(.secondary)
                                               .padding(.bottom, 4)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(cardBackground)
                                        .shadow(color: primaryGold.opacity(0.15), radius: 15, x: 0, y: 5)
                                )
                            }

                            // Support Options
                            VStack(spacing: 16) {
                                SupportCard(
                                    icon: "envelope.fill",
                                    iconColor: primaryBlue,
                                    title: "Send Feedback",
                                    subtitle: "Share your ideas and suggestions",
                                    colorScheme: colorScheme
                                ) {
                                    sendFeedback()
                                }

                                SupportCard(
                                    icon: "ladybug.fill",
                                    iconColor: primaryOrange,
                                    title: "Report a Bug",
                                    subtitle: "Help us fix issues",
                                    colorScheme: colorScheme
                                ) {
                                    reportBug()
                                }

                                SupportCard(
                                    icon: "arrow.up.forward.app.fill",
                                    iconColor: primaryRed,
                                    title: "Share the App",
                                    subtitle: "Tell your friends and family",
                                    colorScheme: colorScheme
                                ) {
                                    shareApp()
                                }
                            }

                            // Social Media Section
                            VStack(spacing: 16) {
                                Text("Follow Us")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(primaryBlue)

                                HStack(spacing: 20) {
                                    SocialButton(icon: "link", color: primaryBlue) {
                                        openWebsite()
                                    }


                                    SocialButton(icon: "envelope.fill", color: primaryOrange) {
                                        openEmail()
                                    }
                                }
                            }
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(cardBackground)
                                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
                            )

                            // Thank You Message
                            VStack(spacing: 12) {
                                Image(systemName: "hands.sparkles.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [primaryRed, primaryOrange],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )

                                Text("Your support means the world to us!")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.primary.opacity(0.8))
                                    .multilineTextAlignment(.center)

                                Text("Every rating, feedback, and share helps us reach more people and keep improving.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: colorScheme == .dark ? [
                                                primaryRed.opacity(0.15),
                                                primaryOrange.opacity(0.1)
                                            ] : [
                                                primaryRed.opacity(0.05),
                                                primaryOrange.opacity(0.03)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.secondary.opacity(0.6))
                    }
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8).delay(0.1)) {
                    isAnimating = true
                }
            }
        }
    }



    private func sendFeedback() {
        let email = "bibekbhujel077@gmail.com"
        let subject = "Send Feedback- Nepali Date App"
        let body = "Hi there,\n\n I would like to write a feedback."

        if let url = URL(string: "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }

    private func reportBug() {
        let email = "bibekbhujel077@gmail.com"
        let subject = "Bug Report - Nepali Date App"
        let body = "Hi there,\n\nI found a bug:\n\nDevice: \(UIDevice.current.model)\niOS Version: \(UIDevice.current.systemVersion)\n\nDescription:\n\n"

        if let url = URL(string: "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }

    private func shareApp() {
        let text = "Check out Nepali Date - the best app for Bikram Sambat calendar! 📅"
        // this is actually important
        let url = URL(string: "https://apps.apple.com/app/nepali-date")! // Replace with your actual App Store URL

        let activityVC = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }

    private func openWebsite() {
        if let url = URL(string: "https://nepalidate.com") {
            UIApplication.shared.open(url)
        }
    }

    private func openEmail() {
        let email = "bibekbhujel077@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Support Card Component
struct SupportCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let colorScheme: ColorScheme
    let action: () -> Void

    private var cardBackground: Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.18) : .white
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 54, height: 54)

                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(iconColor)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)

                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary.opacity(0.5))
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(cardBackground)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Social Button Component
struct SocialButton: View {
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 60, height: 60)

                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Custom Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Preview
#Preview {
    SupportView()
}

#Preview("Dark Mode") {
    SupportView()
        .preferredColorScheme(.dark)
}
