import SwiftUI

struct CarInfo: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var children: [CarInfo]?
}

let carItems: [CarInfo] = [

    CarInfo(name: "Hybrid Cars", image: "leaf.fill", children: [
        CarInfo(name: "Toyota", image: "car.circle", children: [
            CarInfo(name: "Prius", image: "leaf.fill"),
            CarInfo(name: "Highlander Hybrid", image: "leaf.fill"),
            CarInfo(name: "Lexus", image: "car.circle", children: [
                CarInfo(name: "Lexus RX", image: "leaf.fill"),
                CarInfo(name: "Lexus NX", image: "leaf.fill")])
        ]),
        CarInfo(name: "Ford", image: "car.circle", children: [
            CarInfo(name: "Fusion Energi", image: "leaf.fill"),
            CarInfo(name: "Escape", image: "leaf.fill"),
            CarInfo(name: "Volvo", image: "car.circle", children: [
                CarInfo(name: "S90 Hybrid", image: "leaf.fill"),
                CarInfo(name: "XC90 Hybrid", image: "leaf.fill")])
        ])
    ]),

    CarInfo(name: "Electric Cars", image: "bolt.car.fill", children: [
        CarInfo(name: "Tesla", image: "car.circle", children: [
            CarInfo(name: "Model 3", image: "bolt.car.fill")
        ]),
        CarInfo(name: "Karma", image: "car.circle", children: [
            CarInfo(name: "Revero GT", image: "bolt.car.fill")
        ])
    ])
]



struct ListDisclosureView: View {
    var body: some View {
//        List(carItems, children: \.children) { item in
//            CellView(item: item)
//        }
//        .listStyle(.grouped)
        VStack {
            List {
                ForEach(carItems) { item in
                    Section(header: Text(item.name)) {
                        OutlineGroup(item.children ?? [CarInfo](), children: \.children) { child in
                            CellView(item: child)
                        }
                    }
                }
            }
            .listStyle(InsetListStyle())
            NavigationLink {
                DisSettingsView()
            } label: {
                Text("SettingsView")
            }
        }
    }
}

struct CellView: View {
    var item: CarInfo

    var body: some View {
        HStack {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.green)
            Text(item.name)
        }
    }
}

#Preview {
    ListDisclosureView()
}
