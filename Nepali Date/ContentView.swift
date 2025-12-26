//
//  ContentView.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 21/12/2025.
//

import SwiftUI
import WidgetKit

// Nepali-inspired color palette
extension Color {
    // Light mode colors (unchanged)
    static let nepaliRed = Color(red: 0.863, green: 0.078, blue: 0.235)
    static let nepaliBlue = Color(red: 0.0, green: 0.2, blue: 0.4)
    static let nepaliOrange = Color(red: 0.957, green: 0.435, blue: 0.196)
    static let himalayanBlue = Color(red: 0.4, green: 0.6, blue: 0.8)
    static let templeGold = Color(red: 0.847, green: 0.686, blue: 0.259)

    // Dark mode colors
    static let nepaliRedDark = Color(red: 0.95, green: 0.3, blue: 0.4)
    static let nepaliBlueDark = Color(red: 0.4, green: 0.6, blue: 0.85)
    static let nepaliOrangeDark = Color(red: 1.0, green: 0.6, blue: 0.35)
    static let himalayanBlueDark = Color(red: 0.5, green: 0.7, blue: 0.9)
    static let templeGoldDark = Color(red: 0.95, green: 0.8, blue: 0.4)
}

struct ContentView: View {
    @State private var isAnimating = false
    @State private var isActiveOnHomeScreen = false
    @State private var isActiveOnLockScreen = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.scenePhase) private var scenePhase

    // Computed properties for adaptive colors
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

    private var secondaryCardBackground: Color {
        colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.15) : .white
    }

    private let nepaliDateConverter = NepaliDateConverter()


    private func detectWidgetPresence() {
        // Widget presence detection
        WidgetCenter.shared.getCurrentConfigurations { result in
            switch result {
            case .success(let widgets):
                let kind = "NepaliDateWidget"
                isActiveOnHomeScreen = widgets.contains { $0.kind == kind && ($0.family == .systemSmall || $0.family == .systemMedium) }
                isActiveOnLockScreen = widgets.contains { $0.kind == kind && ($0.family == .accessoryRectangular) }
            case .failure:
                isActiveOnHomeScreen = false
                isActiveOnLockScreen = false
            }
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height

                ZStack {
                    // Adaptive gradient background
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

                    if isLandscape {
                        // Landscape layout
                        ScrollView {
                            HStack(alignment: .top, spacing: 20) {
                                // Left side - Date display
                                VStack(spacing: 16) {
                                    mainDateCard(isLandscape: isLandscape)

                                    ctaButton()
                                }
                                .frame(width: screenWidth * 0.45)

                                // Right side - Widget status and footer
                                VStack(spacing: 20) {
                                    widgetStatusCard(isLandscape: isLandscape)

                                    footerButtons()
                                }
                                .frame(width: screenWidth * 0.45)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .frame(minHeight: screenHeight)
                        }
                    } else {
                        // Portrait layout (original)
                        VStack(spacing: 0) {
                            mainDateCard(isLandscape: isLandscape)
                                .padding(.bottom, 32)

                            widgetStatusCard(isLandscape: isLandscape)
                                .padding(.horizontal, 20)

                            Spacer()

                            ctaButton()
                                .padding(.horizontal, 20)
                                .padding(.top, 32)

                            Spacer()
                            Spacer()

                            footerButtons()
                                .padding(.bottom, 32)
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.6)) {
                    isAnimating = true
                }

                detectWidgetPresence()
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                detectWidgetPresence()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(alignment: .center, spacing: 2) {
                        Text("Nepali Date")
                            .font(.system(size: 30, weight: .bold))
                            .kerning(2)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [primaryRed, primaryOrange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .multilineTextAlignment(.center)
                            .scaleEffect(isAnimating ? 1.0 : 0.95)
                            .opacity(isAnimating ? 1.0 : 0.8)
                        Text("नेपाली मिति")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(primaryBlue.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }

    // MARK: - Component Views


    @ViewBuilder
    private func mainDateCard(isLandscape: Bool) -> some View {
        var date: String {
            "\(nepaliDateConverter.currentNepaliYear) \(nepaliDateConverter.currentNepaliMonth)" +
            " \(nepaliDateConverter.currentNepaliDay)"
        }
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(date)
                    .font(.system(size: isLandscape ? 36 : 48, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [primaryRed, primaryRed.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .multilineTextAlignment(.center)
                    .scaleEffect(isAnimating ? 1.0 : 0.95)
                    .opacity(isAnimating ? 1.0 : 0.8)

                Text(nepaliDateConverter.currentWeekDay)
                    .font(.system(size: isLandscape ? 20 : 24, weight: .medium))
                    .foregroundColor(primaryBlue.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, isLandscape ? 24 : 32)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(cardBackground)
                        .shadow(color: primaryRed.opacity(0.12), radius: 20, x: 0, y: 8)

                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    primaryRed.opacity(0.3),
                                    primaryOrange.opacity(0.2),
                                    primaryGold.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
            .padding(.horizontal, isLandscape ? 0 : 20)
        }
    }

    @State private var showWidgetInstructionForHomeScreen = false
    @State private var showWidgetInstructionForLockScreen = false

    @ViewBuilder
    private func widgetStatusCard(isLandscape: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text("Widget Status")
                    .font(.headline)
                    .foregroundColor(primaryBlue)
                Spacer()
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [primaryRed, primaryOrange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 8, height: 8)
            }
            .padding(.bottom, 16)

            VStack(spacing: 12) {
                // Home Screen widget row
                WidgetCellView(
                    screenName:"Home Screen",
                    iconLabel: "apps.iphone",
                    primaryRed: primaryRed,
                    primaryOrange: primaryOrange,
                    primaryBlue: primaryBlue,
                    isActive: isActiveOnHomeScreen,
                    secondaryCardBackground: secondaryCardBackground,
                    colorScheme: colorScheme,
                    showWidgetInstruction: $showWidgetInstructionForHomeScreen
                )

                // Lock Screen widget row
                WidgetCellView(
                    screenName: "Lock Screen",
                    iconLabel: "lock.iphone",
                    primaryRed: primaryRed,
                    primaryOrange: primaryOrange,
                    primaryBlue: primaryBlue,
                    isActive: isActiveOnLockScreen,
                    secondaryCardBackground: secondaryCardBackground,
                    colorScheme: colorScheme,
                    showWidgetInstruction: $showWidgetInstructionForLockScreen
                )
            }
        }
        .padding(20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(cardBackground)
                    .shadow(color: primaryOrange.opacity(0.1), radius: 12, x: 0, y: 4)

                VStack {
                    HStack {
                        Spacer()
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        primaryGold.opacity(0.2),
                                        .clear
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 50
                                )
                            )
                            .frame(width: 100, height: 100)
                            .offset(x: 30, y: -30)
                    }
                    Spacer()
                }
            }
        )
    }

    @ViewBuilder
    private func ctaButton() -> some View {
        Button {

        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 18))
                Text("Add to Lock Screen")
                    .font(.system(size: 17, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundColor(.white)
        }
        .background(
            LinearGradient(
                colors: [primaryRed, primaryRed.opacity(0.8)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(14)
        .shadow(color: primaryRed.opacity(0.4), radius: 12, x: 0, y: 6)
    }

    @ViewBuilder
    private func footerButtons() -> some View {
        HStack(spacing: 40) {
            FooterButton(icon: "gearshape.fill", title: "Settings", color: primaryBlue) {

            }

            FooterButton(icon: "info.circle.fill", title: "About", color: primaryOrange) {

            }

            FooterButton(icon: "heart.fill", title: "Support", color: primaryRed) {

            }
        }
    }
}

struct FooterButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}


struct WidgetCellView: View {
    let screenName:String
    let iconLabel:String
    let primaryRed: Color
    let primaryOrange: Color
    let primaryBlue: Color
    let isActive:Bool
    let secondaryCardBackground: Color
    let colorScheme: ColorScheme
    @Binding var showWidgetInstruction: Bool

    var widgetStatusText: String {
        isActive ? "Widget is active": "Add widget to lock screen"
    }


    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconLabel)
                .font(.system(size: 20))
                .foregroundStyle(
                    LinearGradient(
                        colors: [primaryRed, primaryOrange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(screenName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(primaryBlue)
                Text(widgetStatusText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
            if isActive {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 18))
            }else {
                Button {
                    showWidgetInstruction = true
                }label: {
                    Image(systemName: "chevron.right")
                    .foregroundColor(primaryOrange)
                    .font(.system(size: 14, weight: .semibold))
                }
            }

        }
        .padding(16)
        .background(
            isActive ?
                AnyView(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: colorScheme == .dark ? [
                                    primaryRed.opacity(0.15),
                                    primaryOrange.opacity(0.1)
                                ] : [
                                    Color.nepaliRed.opacity(0.05),
                                    Color.nepaliOrange.opacity(0.03)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                ) :
                AnyView(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorScheme == .dark ? secondaryCardBackground : .white.opacity(0.7))
                )
        )
    }
}



#Preview {
    ContentView()
}

