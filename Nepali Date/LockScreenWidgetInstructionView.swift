//
//  LockScreenWidgetInstructionView.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 31/12/2025.
//

import SwiftUI

import SwiftUI

struct LockScreenWidgetInstructionView: View {
    @State private var selectedTab = 0
    @Namespace private var animation
    @Environment(\.dismiss) var dismiss

    private let instructionCards: [InstructionCard] = [
        InstructionCard(
            instruction: "Tap and hold on an empty area of your lock screen.",
            imageName: "lock_instruction_1"
        ),
        InstructionCard(
            instruction: "Tap the Customize button at the bottom of the screen.",
            imageName: "lock_instruction_2"
        ),
        InstructionCard(
            instruction: "Select Add Widgets from the menu.",
            imageName: "lock_instruction_3"
        ),
        InstructionCard(
            instruction: "Select Nepali Date from the widget menu.",
            imageName: "lock_instruction_4"
        ),
        InstructionCard(
            instruction: "Tap and drag the Nepali Date widget to position it on your lock screen.",
            imageName: "lock_instruction_5"
        ),
        InstructionCard(
            instruction: "Tap the Done button to save your changes and finish setup.",
            imageName: "lock_instruction_6"
        )
    ]

    var body: some View {
        ZStack(alignment: .top) {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.systemGray6).opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                headerView
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // Main content
                GeometryReader { geometry in
                    TabView(selection: $selectedTab) {
                        ForEach(instructionCards.indices, id: \.self) { index in
                            instructionCardView(
                                card: instructionCards[index],
                                index: index,
                                geometry: geometry
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: selectedTab)
                }

                // Custom page indicator and navigation
                bottomControlsView
                    .padding(.bottom, 30)
            }
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text("Lock Screen Widget")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.primary, .primary.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }

            Text("Step \(selectedTab + 1) of \(instructionCards.count)")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    // MARK: - Instruction Card View
    private func instructionCardView(card: InstructionCard, index: Int, geometry: GeometryProxy) -> some View {
        VStack(spacing: 24) {
            // Image container with shadow and glow
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: .primary.opacity(0.1), radius: 20, x: 0, y: 10)

                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding(8)
            }
            .frame(maxHeight: geometry.size.height * 0.5)
            .scaleEffect(selectedTab == index ? 1 : 0.95)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: selectedTab)

            // Instruction text
            VStack(spacing: 12) {
                HStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("\(index + 1)")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        )

                    Spacer()
                }

                Text(card.instruction)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Material.ultraThin)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        LinearGradient(
                            colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
    }

    // MARK: - Bottom Controls
    private var bottomControlsView: some View {
        VStack(spacing: 20) {
            // Custom page indicator
            HStack(spacing: 8) {
                ForEach(instructionCards.indices, id: \.self) { index in
                    Capsule()
                        .fill(selectedTab == index ?
                              LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                              ) :
                              LinearGradient(
                                colors: [Color.secondary.opacity(0.3), Color.secondary.opacity(0.3)],
                                startPoint: .leading,
                                endPoint: .trailing
                              )
                        )
                        .frame(width: selectedTab == index ? 24 : 8, height: 8)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                }
            }

            // Navigation buttons
            HStack(spacing: 16) {
                // Previous button
                Button(action: {
                    withAnimation {
                        if selectedTab > 0 {
                            selectedTab -= 1
                        }
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Previous")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(selectedTab == 0 ? .secondary : .primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.systemGray6))
                    )
                }
                .disabled(selectedTab == 0)
                .opacity(selectedTab == 0 ? 0.5 : 1)

                // Next/Done button
                Button(action: {
                    withAnimation {
                        if selectedTab < instructionCards.count - 1 {
                            selectedTab += 1
                        } else {
                            dismiss()
                        }
                    }
                }) {
                    HStack(spacing: 8) {
                        Text(selectedTab == instructionCards.count - 1 ? "Done" : "Next")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        if selectedTab < instructionCards.count - 1 {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .semibold))
                        } else {
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(14)
                    .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    LockScreenWidgetInstructionView()
}
