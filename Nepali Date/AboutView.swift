//
//  AboutView.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 01/01/2026.
//


import SwiftUI


struct AboutView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var isAnimating = false

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
                            // App Icon & Title
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

                                    Image(systemName: "calendar.badge.clock")
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
                                    Text("Nepali Date")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [primaryRed, primaryOrange],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )

                                    Text("नेपाली मिति")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(primaryBlue.opacity(0.7))

                                    Text("Version 1.0")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                }
                                .opacity(isAnimating ? 1.0 : 0)
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)

                            // What is Nepali Date
                            AboutCard(
                                icon: "info.circle.fill",
                                iconColor: primaryBlue,
                                title: "What is Nepali Date?",
                                description: "Nepali Date is your companion for staying connected with the Bikram Sambat calendar. Never miss important dates, festivals, or cultural celebrations with accurate Nepali date conversion at your fingertips.",
                                colorScheme: colorScheme
                            )

                            // Features Section
                            VStack(spacing: 16) {
                                FeatureRow(
                                    icon: "calendar",
                                    iconColor: primaryRed,
                                    title: "Accurate Date Conversion",
                                    description: "Seamlessly convert between AD and BS calendars",
                                    colorScheme: colorScheme
                                )

                                FeatureRow(
                                    icon: "apps.iphone",
                                    iconColor: primaryOrange,
                                    title: "Beautiful Widgets",
                                    description: "Add Nepali dates to your home screen and lock screen",
                                    colorScheme: colorScheme
                                )

                                FeatureRow(
                                    icon: "moon.stars.fill",
                                    iconColor: primaryGold,
                                    title: "Dark Mode Support",
                                    description: "Comfortable viewing in any lighting condition",
                                    colorScheme: colorScheme
                                )

                                FeatureRow(
                                    icon: "bell.badge.fill",
                                    iconColor: primaryBlue,
                                    title: "Daily Updates",
                                    description: "Automatically updates at midnight every day",
                                    colorScheme: colorScheme
                                )
                            }

                            // Why Nepali Date?
                            AboutCard(
                                icon: "heart.fill",
                                iconColor: primaryRed,
                                title: "Why Nepali Date?",
                                description: "The Bikram Sambat calendar is an integral part of Nepali culture and identity. Whether you're planning festivals, or simply staying connected with your heritage, Nepali Date makes it effortless.",
                                colorScheme: colorScheme
                            )

                            // Developer Info
                            VStack(spacing: 12) {
                                Text("Made with")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 4) {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [primaryRed, primaryOrange],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                    Text("in Nepal")
                                        .foregroundColor(.secondary)
                                }
                                .font(.caption)

                                Text("© 2025 Bibek Bhujel")
                                    .font(.caption2)
                                    .foregroundColor(.secondary.opacity(0.7))
                            }
                            .padding(.vertical, 20)
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
}

// MARK: - About Card Component
struct AboutCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    let colorScheme: ColorScheme

    private var cardBackground: Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.18) : .white
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)

                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(iconColor)
            }

            Text(description)
                .font(.system(size: 16))
                .foregroundColor(.primary.opacity(0.8))
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(cardBackground)
                .shadow(color: iconColor.opacity(0.1), radius: 12, x: 0, y: 4)
        )
    }
}

// MARK: - Feature Row Component
struct FeatureRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    let colorScheme: ColorScheme

    private var cardBackground: Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.18) : .white
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(cardBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Preview
#Preview {
    AboutView()
}

#Preview("Dark Mode") {
    AboutView()
        .preferredColorScheme(.dark)
}
