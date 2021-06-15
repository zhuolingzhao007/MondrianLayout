import BoxLayout2
import StorybookKit
import UIKit

let book = Book(title: "BoxLayout2") {

  BookSection(title: "Sample") {

    if #available(iOS 13, *) {
      BookPreview {
        ExampleView(width: nil, height: nil) { (view: UIView) in
          view.buildSublayersLayout {
            VStackConstraint {
              UIImageView.mock(image: UIImage(systemName: "square.and.pencil")!)
              UIImageView.mock(image: UIImage(systemName: "square.and.pencil")!)
              UIImageView.mock(image: UIImage(systemName: "square.and.pencil")!)
              UIImageView.mock(image: UIImage(systemName: "square.and.pencil")!)
            }
          }
        }
      }
    }

    _book_background

    _book_overlay

    _book_VStackConstraint

    _book_HStackConstraint

    _book_ZStackConstraint

    BookPreview(viewBlock: {
      DemoView()
    })
  }
}

final class DemoView: UIView {

  private let profileImageView = UIView.mock(
    backgroundColor: .mondrianYellow,
    preferredSize: .init(width: 32, height: 32)
  )

  private let nicknameLabel = UILabel.make(text: "Muukii")

  private let imageView = UIView.mock(backgroundColor: .mondrianYellow)

  private let likeButton = UIView.mock(
    backgroundColor: .mondrianRed,
    preferredSize: .init(width: 32, height: 32)
  )
  private let commentButton = UIView.mock(
    backgroundColor: .mondrianRed,
    preferredSize: .init(width: 32, height: 32)
  )
  private let messageButton = UIView.mock(
    backgroundColor: .mondrianRed,
    preferredSize: .init(width: 32, height: 32)
  )

  private let box = UIView.mock(backgroundColor: .mondrianYellow)
  private let box2 = UIView.mock(backgroundColor: .mondrianRed)

  init() {

    super.init(frame: .zero)

    self.buildSublayersLayout {
      VStackConstraint {
        StackSpacer(minLength: 10)
        StackSpacer(minLength: 10)
        HStackConstraint {
          ViewConstraint(profileImageView)
            .huggingPriority(.horizontal, .required)
          StackSpacer(minLength: 4)

          nicknameLabel
        }
        StackSpacer(minLength: 10)
        StackSpacer(minLength: 10)
        ViewConstraint(imageView)
          .aspectRatio(1)
        StackSpacer(minLength: 10)
        HStackConstraint {
          likeButton
          StackSpacer(minLength: 2)
          commentButton
          StackSpacer(minLength: 2)
          messageButton
        }
        ZStackConstraint {
          ViewConstraint(box).width(100).aspectRatio(CGSize(width: 3, height: 4))
          ViewConstraint(box2).width(50).aspectRatio(CGSize(width: 1, height: 2))
        }
      }
    }

  }

  required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

}
