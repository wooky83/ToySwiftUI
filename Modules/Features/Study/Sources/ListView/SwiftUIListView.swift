import SwiftUI

struct ToDoItem: Identifiable {
    let id = UUID()
    let task: String
    let imageName: String
}

struct SwiftUIListView: View {
    @State var listData = [
        ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
        ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
        ToDoItem(task: "Wash the car", imageName: "car.fill"),
    ]

    @State private var toggleStatus = true

    var body: some View {
        List {
            Section(header: Text("Settings")) {
                Toggle(isOn: $toggleStatus) {
                    Text("Allow Notifications")
                }
            }

            Section(header: Text("To Do Tasks")) {
                ForEach(listData) { item in
                    HStack {
                        Image(systemName: item.imageName)
                        Text(item.task)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        listData.remove(at: index)
                    }
                })
            }
        }
        .refreshable {
            listData = [
                .init(task: "Order dinner", imageName: "dollarsign.circle.fill"),
                .init(task: "Call financial advisor", imageName: "phone.fill"),
                .init(task: "Sell the kids", imageName: "person.2.fill"),
            ]
        }
        .navigationTitle(Text("To Do List"))
    }
}

#Preview {
    SwiftUIListView()
}
