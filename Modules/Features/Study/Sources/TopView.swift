import SwiftUI

public struct TopView: View {

    @State var path: [ViewType] = []
    @State var title = "SwiftUI"
    @AppStorage("myText") var editorText = "SampleText"

    private var listData = ViewType.allCases
    public init() { }
    public var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextEditor(text: $editorText)
                    .frame(width: 300, height: 100)
                    .font(.largeTitle)

                List(listData) { item in
                    Button(action: {
                        path.append(item)
                    }, label: {
                        Text(item.rawValue.capitalized)
                    })
                }
            }
            .navigationTitle(title)
            .navigationDestination(for: ViewType.self) { next in
                switch next {
                case .stackFrame:
                    StackFrameView()
                case .obsStateEnvironment:
                    ObsStateEnvironmentView()
                case .structuredConcurrency:
                    StructuredConcurrencyView()
                case .testActor:
                    TestActorView()
                case .obsTutorial:
                    ObservableTutorialView()
                case .list:
                    SwiftUIListView()
                case .navigationSplitView:
                    SplitView()
                }
            }
        }
        .onAppear(perform: {
            print("onAppear triggered")
        })
        .onDisappear(perform: {
            print("onDisappeared triggered")
        })
        .task(priority: .background) {
            print("task Start")
            title = await changeTitle()
        }
    }

    func changeTitle() async -> String {
        sleep(5)
        return "Async task complete"
    }
}

enum ViewType: String, Hashable, CaseIterable, Identifiable {
    var id: Self { self }

    case stackFrame
    case obsStateEnvironment
    case structuredConcurrency
    case testActor
    case obsTutorial
    case list
    case navigationSplitView
}

#Preview {
    TopView()
}
