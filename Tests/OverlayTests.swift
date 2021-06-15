//
//  OverlayTests.swift
//  Tests
//
//  Created by Muukii on 2021/06/16.
//

import Foundation

import XCTest
import BoxLayout2
import SnapshotTesting

final class OverlayTests: XCTestCase {

  func test_1() {

    let view = ExampleView(width: nil, height: nil) { (view: UIView) in
      view.buildSublayersLayout {
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 100, height: 100)
        )
        .viewConstraint
        .overlay(
          UIView.mock(backgroundColor: .layeringColor)
            .viewConstraint
            .overlay(
              UIView.mock(backgroundColor: .layeringColor)
                .viewConstraint
                .padding(10)
            )
            .padding(10)
        )
      }
    }

    assertSnapshot(matching: view, as: .image, record: _record)

  }

}
