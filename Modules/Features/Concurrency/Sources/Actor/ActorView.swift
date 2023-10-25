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
            HStack {
                Button {
                    Task {
                        truck.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        truck.fullLevel += fuel
                        truck.isCharging = false
                    }
                } label: {
                    VStack {
                        Image(systemName: "box.truck")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(truck.description)
                            .font(.subheadline)
                    }
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 150)
                }
                Spacer().frame(width: 30)
                Button {
                    Task {
                        car.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        car.fullLevel += fuel
                        car.isCharging = false
                    }
                } label: {
                    VStack {
                        Image(systemName: "car.rear")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(car.description)
                            .font(.subheadline)
                    }
                    .foregroundColor(.yellow)
                    .frame(width: 100, height: 150)
                }
                Spacer().frame(width: 30)
                Button {
                    Task {
                        bus.isCharging = true
                        let fuel = await viewModel.requestCharge()
                        bus.fullLevel += fuel
                        bus.isCharging = false
                    }
                } label: {
                    VStack {
                        Image(systemName: "bus.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(bus.description)
                            .font(.subheadline)
                    }
                    .foregroundColor(.green)
                    .frame(width: 100, height: 150)
                }
            }
        }
    }
}

#Preview {
    ActorView()
}
