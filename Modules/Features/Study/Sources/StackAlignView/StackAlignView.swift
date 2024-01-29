import SwiftUI

extension VerticalAlignment {
    private enum CrossAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.bottom]
        }
    }
    static let crossAlignment = VerticalAlignment(CrossAlignment.self)
}

struct StackAlignView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text("This is some text")
            Text("This is some longer text")
            Text("This is short")
        }
        VStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.green)
                .frame(width: 120, height: 50)
            Rectangle()
                .foregroundColor(.red)
                .alignmentGuide(.leading, computeValue: { d in
                    d.width / 3
                })
                .frame(width: 200, height: 50)
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 180, height: 50)
        }
        HStack(alignment: .crossAlignment, spacing: 20) {
            Circle()
                .foregroundColor(.purple)
                .alignmentGuide(.crossAlignment, computeValue: { d in
                    d[VerticalAlignment.center]
                })
                .frame(width: 100, height: 100)
            VStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.blue)
                    .alignmentGuide(.crossAlignment, computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

#Preview {
    StackAlignView()
}
