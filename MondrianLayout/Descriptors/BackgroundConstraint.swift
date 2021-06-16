import UIKit

public protocol _BackgroundContentConvertible {
  var _backgroundContent: _BackgroundContent { get }
}

public indirect enum _BackgroundContent {

  case view(ViewConstraint)
  case vStack(VStackConstraint)
  case hStack(HStackConstraint)
  case zStack(ZStackConstraint)
  case relative(RelativeConstraint)
  case overlay(OverlayConstraint)
  case background(BackgroundConstraint)
}

public struct BackgroundConstraint:
  LayoutDescriptorType,
  _RelativeContentConvertible
{

  // MARK: - Properties

  public var name: String = "Background"

  public var _relativeContent: _RelativeContent {
    return .background(self)
  }

  let content: _BackgroundContent
  let backgroundContent: _BackgroundContent

  // MARK: - Initializers

  init(
    content: _BackgroundContent,
    backgroundContent: _BackgroundContent
  ) {

    self.content = content
    self.backgroundContent = backgroundContent
  }

  // MARK: - Functions

  public func setupConstraints(parent: _LayoutElement, in context: LayoutBuilderContext) {

    setupBackground: do {

      let backgroundLayoutGuide = context.makeLayoutGuide(identifier: "Background")

      context.add(constraints: [
        backgroundLayoutGuide.topAnchor.constraint(equalTo: parent.topAnchor),
        backgroundLayoutGuide.leftAnchor.constraint(equalTo: parent.leftAnchor),
        backgroundLayoutGuide.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        backgroundLayoutGuide.rightAnchor.constraint(equalTo: parent.rightAnchor),
        backgroundLayoutGuide.widthAnchor.constraint(
          lessThanOrEqualTo: parent.widthAnchor,
          multiplier: 1
        ),
        backgroundLayoutGuide.heightAnchor.constraint(
          lessThanOrEqualTo: parent.heightAnchor,
          multiplier: 1
        ),
      ])

      switch backgroundContent {

      case .view(let c):

        context.register(viewConstraint: c)

        let guide = _LayoutElement(layoutGuide: backgroundLayoutGuide)

        context.add(
          constraints: [
            c.view.topAnchor.constraint(equalTo: guide.topAnchor),
            c.view.rightAnchor.constraint(equalTo: guide.rightAnchor),
            c.view.leftAnchor.constraint(equalTo: guide.leftAnchor),
            c.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
          ]
        )

      case .relative(let relativeConstraint):

        relativeConstraint.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )

      case .vStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )

      case .hStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )

      case .zStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )

      case .overlay(let c):

        c.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )

      case .background(let c):

        c.setupConstraints(
          parent: .init(layoutGuide: backgroundLayoutGuide),
          in: context
        )
      }

    }

    setupContent: do {

      switch content {
      case .view(let c):
        context.register(viewConstraint: c)
        context.add(
          constraints: [
            c.view.topAnchor.constraint(equalTo: parent.topAnchor),
            c.view.rightAnchor.constraint(equalTo: parent.rightAnchor),
            c.view.leftAnchor.constraint(equalTo: parent.leftAnchor),
            c.view.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
          ]
        )
      case .relative(let c):
        c.setupConstraints(parent: parent, in: context)
      case .vStack(let c):
        c.setupConstraints(parent: parent, in: context)
      case .hStack(let c):
        c.setupConstraints(parent: parent, in: context)
      case .zStack(let c):
        c.setupConstraints(parent: parent, in: context)
      case .overlay(let c):
        c.setupConstraints(parent: parent, in: context)
      case .background(let c):
        c.setupConstraints(parent: parent, in: context)
      }
    }
  }
}

extension _BackgroundContentConvertible {

  public func background(_ view: UIView) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .view(view.viewConstraint))
  }

  public func background(_ constraint: ViewConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .view(constraint))
  }

  public func background(_ constraint: RelativeConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .relative(constraint))
  }

  public func background(_ constraint: VStackConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .vStack(constraint))
  }

  public func background(_ constraint: HStackConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .hStack(constraint))
  }

  public func background(_ constraint: ZStackConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .zStack(constraint))
  }

  public func background(_ constraint: BackgroundConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .background(constraint))
  }


  public func background(_ constraint: OverlayConstraint) -> BackgroundConstraint {
    return .init(content: _backgroundContent, backgroundContent: .overlay(constraint))
  }

}

