//
//  CountryPickerView.swift
//  Coinstar
//
//  Created by Akshay Matre on 04/10/26.
//

import SwiftUI

struct CountryDropdownPayload {
    let anchor: Anchor<CGRect>
    let width: CGFloat
    let height: CGFloat
    let spacing: CGFloat
    let content: AnyView
}

// MARK: - Collapsed field button style (pressed state)
private struct FieldPressedStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

private struct CountryRowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.black.opacity(0.04) : Color.clear)
    }
}

struct CountryDropdownPreferenceKey: PreferenceKey {
    static var defaultValue: CountryDropdownPayload? = nil
    static func reduce(value: inout CountryDropdownPayload?, nextValue: () -> CountryDropdownPayload?) {
        // At most one CountryPickerField is expanded at a time in normal
        // use; if more than one somehow publishes, the latest wins.
        if let next = nextValue() { value = next }
    }
}

struct CountryPickerView: View {
    @Binding var selectedCountry: Country
    @Binding var isExpanded: Bool
    
    var dropdownMaxHeight: CGFloat = 300
    var countries: [Country] = Country.all
    var onSelect: ((Country) -> Void)? = nil

    var body: some View {
        fieldButton
            .anchorPreference(
                key: CountryDropdownPreferenceKey.self,
                value: .bounds
            ){ anchor in
                guard isExpanded else { return nil }
                return CountryDropdownPayload(
                    anchor: anchor,
                    width: 280,
                    height: dropDownHeight,
                    spacing: 8,
                    content: AnyView(dropDownList)
                )
            }
    }
    
    private var dropDownHeight: CGFloat {
        let rowHeight: CGFloat = 53 // 52pt row + 1pt divider
        let contentHeight = CGFloat(countries.count) * rowHeight
        return min(contentHeight, dropdownMaxHeight)
    }
    
    private var fieldButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.18)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: 6.0) {
                Text(selectedCountry.flag)
                    .font(.system(size: 26.0))
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.black.opacity(0.7))
                Text(selectedCountry.dialCode)
                    .font(.system(size: 26.0, weight: .semibold))
                    .foregroundStyle(Color.black)
            }
            .frame(height: 56.0, alignment: .leading)
            .contentShape(Rectangle())
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Country code, \(selectedCountry.name), \(selectedCountry.dialCode)")
            .accessibilityAddTraits(.isButton)
        }
        .buttonStyle(FieldPressedStyle())
    }
    
    private var dropDownList: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 0) {
                ForEach(Array(countries.enumerated()), id: \.element.id){ index, country in
                    countryRow(country)
                    
                    if index < countries.count - 1 {
                        Divider()
                            .padding(.leading, 32)
                    }
                }
            }
        }
        .frame(height: dropDownHeight)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 10)
    }
    
    private func countryRow(_ country: Country) -> some View {
        let isSelected = country == selectedCountry

        return Button {
            select(country)
        } label: {
            HStack(spacing: 12) {
                Text(country.flag)
                    .font(.system(size: 22.0))
                    .frame(width: 28)

                Text(country.name)
                    .font(.system(size: 17.0))
                    .foregroundStyle(Color.black)
                    .lineLimit(1)

                Spacer(minLength: 8)

                Text(country.dialCode)
                    .font(.system(size: 15.0))
                    .foregroundStyle(Color.black.opacity(0.45))

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.black)
                        .frame(width: 18)
                } else {
                    Color.clear.frame(width: 18)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(CountryRowButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(country.name), \(country.dialCode)")
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
    
    private func select(_ country: Country) {
        selectedCountry = country
        withAnimation(.easeInOut(duration: 0.18)){
            isExpanded = false
        }
        onSelect?(country)
    }
}

private struct CountryPickerDropdownHost: ViewModifier {
    func body(content: Content) -> some View {
        content.overlayPreferenceValue(CountryDropdownPreferenceKey.self) { payload in
            GeometryReader { proxy in
                if let payload {
                    let fieldFrame = proxy[payload.anchor]
                    payload.content
                        .frame(width: payload.width, height: payload.height)
                        .position(
                            x: fieldFrame.minX + payload.width / 2,
                            y: fieldFrame.maxY + payload.spacing + payload.height / 2
                        )
                        .transition(
                            .scale(scale: 0.95, anchor: .top)
                                .combined(with: .opacity)
                        )
                }
            }
            .allowsHitTesting(payload != nil)
        }
    }
}

extension View {
    func countryPickerDropdownHost() -> some View {
        modifier(CountryPickerDropdownHost())
    }
}


#Preview("Collapsed / Expanded") {
    VStack(alignment: .leading, spacing: 40) {
        StatefulPreviewWrapper(Country.default) { countryBinding in
            StatefulPreviewWrapper(false) { expandedBinding in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tap the field to open the dropdown")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    CountryPickerView(
                        selectedCountry: countryBinding,
                        isExpanded: expandedBinding,
                    )
                    .frame(width: 200, alignment: .leading)
                }
            }
        }
        Spacer()
    }
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(Color("F7F8FC"))
    // Required once at the root of any screen using CountryPickerField.
    .countryPickerDropdownHost()
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    let content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
