import SwiftUI

struct DisSettingsView: View {
    @State private var hybridState = false
    @State private var electricState = false
    @State private var fuelCellState = false
    @State private var inversionState = false

    @State private var filtersExpanded = true

    var body: some View {
//        Form {
//            ToggleControl(title: " Hybrid Cars", state: hybridState)
//            ToggleControl(title: " Electric Cars", state: electricState)
//            ToggleControl(title: " Fuel Cell Cars", state: fuelCellState)
//            ColorControl(color: .red, label: "Background Color")
//            ColorControl(color: .blue, label: "ForegroundColor")
//            ToggleControl(title: "Color Inversion", state: inversionState)
//        }
        DisclosureGroup(isExpanded: $filtersExpanded) {
            ToggleControl(title: " Hybrid Cars", state: hybridState)
            ToggleControl(title: " Electric Cars", state: electricState)
            ToggleControl(title: " Fuel Cell Cars", state: fuelCellState)
        } label: {
            Label("Categories Filters", systemImage: "car.2.fill")
        }

        DisclosureGroup {
            ColorControl(color: .red, label: "Background Color")
            ColorControl(color: .blue, label: "ForegroundColor")
            ToggleControl(title: "Color Inversion", state: inversionState)
        } label: {
            Label("Color Settings", systemImage: "scribble.variable")
        }
    }
}

struct ColorControl: View {
    var color: Color
    var label: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Rectangle()
                .fill(color)
                .frame(width: 30, height: 30)
        }
        .padding(.leading)
        .scaledToFill()
    }
}

struct ToggleControl: View {
    var title: String
    @State var state: Bool

    var body: some View {
        Toggle(title, isOn: $state)
            .padding(.leading)
    }
}

#Preview {
    DisSettingsView()
}
