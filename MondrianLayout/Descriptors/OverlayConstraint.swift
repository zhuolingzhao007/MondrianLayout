import UIKit

public protocol _OverlayContentConvertible {
  var _overlayContent: _OverlayContent { get }
}

public indirect enum _OverlayContent {

  case view(ViewConstraint)
  case vStack(VStackConstraint)
  case hStack(HStackConstraint)
  case zStack(ZStackConstraint)
  case relative(RelativeConstraint)
  case overlay(OverlayConstraint)
  case background(BackgroundConstraint)
}

public struct OverlayConstraint: LayoutDescriptorType, _RelativeContentConvertible {

  public var _relativeContent: _RelativeContent {
    return .overlay(self)
  }

  public let content: _OverlayContent
  public let overlayContent: _OverlayContent

  init(
    content: _OverlayContent,
    overlayContent: _OverlayContent
  ) {

    self.content = content
    self.overlayContent = overlayContent

  }

  public func setupConstraints(parent: _LayoutElement, in context: LayoutBuilderContext) {

    setupContent: do {

      switch content {
      case .view(let c):
        context.register(view: c)
        c.setupConstraints(parent: parent, in: context)
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

    setupOverlay: do {

      let overlayLayoutGuide = context.makeLayoutGuide(identifier: "Overlay")

      context.add(constraints: [
        overlayLayoutGuide.topAnchor.constraint(equalTo: parent.topAnchor),
        overlayLayoutGuide.leftAnchor.constraint(equalTo: parent.leftAnchor),
        overlayLayoutGuide.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        overlayLayoutGuide.rightAnchor.constraint(equalTo: parent.rightAnchor),
        overlayLayoutGuide.widthAnchor.constraint(
          lessThanOrEqualTo: parent.widthAnchor,
          multiplier: 1
        ),
        overlayLayoutGuide.heightAnchor.constraint(
          lessThanOrEqualTo: parent.heightAnchor,
          multiplier: 1
        ),
      ])

      switch overlayContent {

      case .view(let viewConstraint):

        context.register(view: viewConstraint)

        viewConstraint.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .relative(let relativeConstraint):

        relativeConstraint.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .vStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .hStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .zStack(let stackConstraint):

        stackConstraint.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .overlay(let c):

        c.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      case .background(let c):

        c.setupConstraints(
          parent: .init(layoutGuide: overlayLayoutGuide),
          in: context
        )

      }

    }

  }

}

extension _OverlayContentConvertible {

  public func overlay(_ view: UIView) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .view(view.viewConstraint))
  }

  public func overlay(_ constraint: ViewConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .view(constraint))
  }

  public func overlay(_ constraint: RelativeConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .relative(constraint))
  }

  public func overlay(_ constraint: VStackConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .vStack(constraint))
  }

  public func overlay(_ constraint: HStackConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .hStack(constraint))
  }

  public func overlay(_ constraint: ZStackConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .zStack(constraint))
  }

  public func overlay(_ constraint: OverlayConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .overlay(constraint))
  }

  public func overlay(_ constraint: BackgroundConstraint) -> OverlayConstraint {
    return .init(content: _overlayContent, overlayContent: .background(constraint))
  }
}