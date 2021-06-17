import MondrianLayout
import StorybookKit
import UIKit

var _book_HStackBlock: BookView {
  BookNavigationLink(title: "HStackBlock") {

    BookSection(title: "Justify (Distribution)") {

      BookParagraph("Wrapping with VStack")

      BookForEach(data: [VStackBlock.HorizontalAlignment]([.leading, .center, .trailing])) {
        alignment in
        BookPreview {
          ExampleView(width: 180, height: nil) { (view: UIView) in
            view.buildSublayersLayout {
              VStackBlock(alignment: alignment) {

                HStackBlock(spacing: 4) {

                  UIView.mock(
                    backgroundColor: .mondrianYellow,
                    preferredSize: .init(width: 28, height: 28)
                  )

                  UIView.mock(
                    backgroundColor: .mondrianRed,
                    preferredSize: .init(width: 28, height: 28)
                  )

                  UIView.mock(
                    backgroundColor: .mondrianBlue,
                    preferredSize: .init(width: 28, height: 28)
                  )

                }
                .background(UIView.mock(backgroundColor: .layeringColor))

              }
              .background(UIView.mock(backgroundColor: .layeringColor))
            }
          }
        }
        .title("\(alignment)")
      }
    }

    BookSection(title: "1 element") {
      BookForEach(data: [VStackBlock.HorizontalAlignment]([.leading, .center, .trailing])) {
        alignment in
        BookPreview {
          ExampleView(width: 60, height: nil) { (view: UIView) in
            view.buildSublayersLayout {
              VStackBlock(alignment: alignment) {

                UIView.mock(
                  backgroundColor: .mondrianYellow,
                  preferredSize: .init(width: 28, height: 28)
                )

              }
              .background(UIView.mock(backgroundColor: .layeringColor))
            }
          }
        }
      }

//      BookForEach(data: [VStackBlock.HorizontalAlignment]([.leading, .center, .trailing])) {
//        alignment in
//        BookPreview {
//          ExampleView(width: 60, height: nil) { (view: UIView) in
//            view.buildSublayersLayout {
//              VStackBlock(alignment: alignment) {
//
//                SpacerBlock(minLength: 10)
//
//              }
//              .background(UIView.mock(backgroundColor: .layeringColor))
//            }
//          }
//        }
//      }

    }

    BookSection(title: "Examples") {

      BookPreview {
        ExampleView(width: 180, height: nil) { (view: UIView) in
          view.buildSublayersLayout {
            HStackBlock(spacing: 4) {
              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              SpacerBlock(minLength: 20)

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              SpacerBlock(minLength: 20, expands: false)
            }
            .background(UIView.mock(backgroundColor: .layeringColor))
          }
        }
      }
      .title("Spacing")

      BookForEach(data: [.center, .top, .bottom, .fill] as [HStackBlock.VerticalAlignment]) {
        alignment in
        BookPreview {
          ExampleView(width: nil, height: nil) { (view: UIView) in
            view.buildSublayersLayout {
              HStackBlock(spacing: 4, alignment: alignment) {
                UILabel.mockMultiline(text: "Hello\nHello", textColor: .white)
                  .viewBlock
                  .padding(8)
                  .background(UIView.mock(backgroundColor: .mondrianYellow))
                UILabel.mockMultiline(text: "Mondrian Mondrian Mondrian", textColor: .white)
                  .viewBlock
                  .padding(8)
                  .background(UIView.mock(backgroundColor: .mondrianRed))
                UILabel.mockMultiline(text: "Layout!", textColor: .white)
                  .viewBlock
                  .padding(8)
                  .background(UIView.mock(backgroundColor: .mondrianBlue))
              }
            }
          }
        }
        .title("Labels - align: \(alignment)")
      }

      BookPreview {
        ExampleView(width: nil, height: nil) { (view: UIView) in
          view.buildSublayersLayout {
            HStackBlock(spacing: 4) {
              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )
            }
          }
        }
      }
      .title("Spacing")

      BookPreview {
        ExampleView(width: nil, height: nil) { (view: UIView) in
          view.buildSublayersLayout {
            HStackBlock(spacing: 4) {
              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )
              .viewBlock
              .alignSelf(.fill)

              SpacerBlock(minLength: 4)

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )

              UIView.mock(
                backgroundColor: .mondrianYellow,
                preferredSize: .init(width: 28, height: 28)
              )
            }
          }
        }
      }
      .title("Spacing with additional spacer")
    }

  }
}
