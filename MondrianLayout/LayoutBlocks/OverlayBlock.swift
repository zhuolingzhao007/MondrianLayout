import UIKit

public struct OverlayBlock:
  _LayoutBlockType
{

  // MARK: - Properties

  public var name: String = "Overlay"

  public var _layoutBlockNode: _LayoutBlockNode {
    .overlay(self)
  }

  public let content: _LayoutBlockNode
  public let overlayContent: _LayoutBlockNode

  // MARK: - Initializers

  init(
    content: _LayoutBlockNode,
    overlayContent: _LayoutBlockNode
  ) {

    self.content = content
    self.overlayContent = overlayContent

  }

  // MARK: - Functions

  public func setupConstraints(parent: _LayoutElement, in context: LayoutBuilderContext) {

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

      case .view(let c):

        context.register(viewConstraint: c)

        let guide = _LayoutElement(layoutGuide: overlayLayoutGuide)

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
