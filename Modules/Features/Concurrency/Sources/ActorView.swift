import SwiftUI

struct ActorView: View {

    struct StateValue {
        var isCharging = false
        var fullLevel = 0
        var description: String {
            if isCharging {
                "Charging..."
            } else {
                "Fuel:\(fullLevel)"
            }
        }
    }

    @StateObject private var viewModel = ActorViewModel()
    @State var truck = StateValue()
    @State var car = StateValue()
    @State var bus = StateValue()

    var body: some View {
        VStack {
            HStack {
                Text("Current Fuel is \(viewModel.fullLevel)")
                Image(systemName: viewModel.isCharging ? "fuelpump" : "fuelpump.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(viewModel.isCharging ? .red : .none)
            }
            Spacer().frame(height: 100)
            VStack {
                Button {
                    Task {
                        truck.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        truck.fullLevel += fuel
                        truck.isCharging = false
                    }
                } label: {
                    Label(truck.description, systemImage: "box.truck")
                        .frame(width: 300, height: 100)
                        .foregroundColor(.blue)
                }
                Button {
                    Task {
                        car.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        car.fullLevel += fuel
                        car.isCharging = false
                    }
                } label: {
                    Label(car.description, systemImage: "car.rear")
                        .frame(width: 300, height: 100)
                        .foregroundColor(.yellow)
                }
                Button {
                    Task {
                        bus.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        bus.fullLevel += fuel
                        bus.isCharging = false
                    }
                } label: {
                    Label(bus.description, systemImage: "bus.fill")
                        .frame(width: 300, height: 100)
                        .foregroundColor(.green)
                }
            }
        }
    }
}

#Preview {
    ActorView()
}
