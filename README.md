# MondrianLayout - (alpha)

<img width="246" alt="CleanShot 2021-06-17 at 21 12 03@2x" src="https://user-images.githubusercontent.com/1888355/122394225-b1da4e80-cfb0-11eb-9e62-f5627c817b66.png">

This image laied out by MondrianLayout

<details><summary>Layout code</summary>
<p>

```swift
HStackBlock(spacing: 2, alignment: .fill) {
  VStackBlock(spacing: 2, alignment: .fill) {
    UIView.mock(
      backgroundColor: .mondrianRed,
      preferredSize: .init(width: 28, height: 28)
    )

    UIView.mock(
      backgroundColor: .layeringColor,
      preferredSize: .init(width: 28, height: 50)
    )

    UIView.mock(
      backgroundColor: .mondrianYellow,
      preferredSize: .init(width: 28, height: 28)
    )

    UIView.mock(
      backgroundColor: .layeringColor,
      preferredSize: .init(width: 28, height: 28)
    )

    HStackBlock(alignment: .fill) {
      UIView.mock(
        backgroundColor: .layeringColor,
        preferredSize: .init(width: 28, height: 28)
      )
      UIView.mock(
        backgroundColor: .layeringColor,
        preferredSize: .init(width: 28, height: 28)
      )
    }
  }

  VStackBlock(spacing: 2, alignment: .fill) {
    HStackBlock(spacing: 2, alignment: .fill) {
      UIView.mock(
        backgroundColor: .layeringColor,
        preferredSize: .init(width: 28, height: 28)
      )
      VStackBlock(spacing: 2, alignment: .fill) {
        HStackBlock(spacing: 2, alignment: .fill) {
          UIView.mock(
            backgroundColor: .mondrianYellow,
            preferredSize: .init(width: 28, height: 28)
          )
          UIView.mock(
            backgroundColor: .layeringColor,
            preferredSize: .init(width: 28, height: 28)
          )
        }
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
      }
    }

    HStackBlock(spacing: 2, alignment: .fill) {
      VStackBlock(spacing: 2, alignment: .fill) {
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
        UIView.mock(
          backgroundColor: .mondrianBlue,
          preferredSize: .init(width: 28, height: 28)
        )
      }

      UIView.mock(
        backgroundColor: .layeringColor,
        preferredSize: .init(width: 28, height: 28)
      )

      VStackBlock(spacing: 2, alignment: .fill) {
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
      }
    }

    HStackBlock(spacing: 2, alignment: .fill) {
      UIView.mock(
        backgroundColor: .mondrianRed,
        preferredSize: .init(width: 28, height: 28)
      )
      VStackBlock(spacing: 2, alignment: .fill) {
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
        UIView.mock(
          backgroundColor: .layeringColor,
          preferredSize: .init(width: 28, height: 28)
        )
      }
    }

  }

}
.overlay(
  UILabel.mockMultiline(text: "Mondrian Layout", textColor: .white)
    .viewBlock
    .padding(4)
    .background(
      UIView.mock(
        backgroundColor: .layeringColor
      )
      .viewBlock
    )
    .relative(bottom: 8, right: 8)
)
```

</p>
</details>

A DSL based layout builder with AutoLayout

> 🧦 Currently still in development
> And I'm not sure if my idea goes true.

## Future direction

- Brushing up the DSL - to be stable in describing.
- Adding more modifiers for fine tuning in layout.
- Tuning up the stack block's behavior.
- Adding a way to setting constraints independently besides DSL
  - AutoLayout is definitely powerful to describe the layout. We might need to set the constraints additionally since DSL can't describe every pattern of the layout.

## Introduction

AutoLayout is super powerful to describe the layout and how it changes according to the bounding box.  
What if we get a more ergonomic interface to declare the constraints.

like this (simplified from actual code)
```swift
VStackBlock {
  HStackBlock {
    profileImageView
    nicknameLabel
    
    SpacerBlock()
    
    optionButton
  }
  
  imageView
    .overlay(
      captionLabel.related(bottom: 10, right: 10)
    )
  
  HStackBlock {
    likeButton
    commentButton
    messageButton
    
    SpacerBlock()
    
    saveButton
  }
}
```

<img width="250" alt="CleanShot 2021-06-17 at 21 13 11@2x" src="https://user-images.githubusercontent.com/1888355/122394356-d9311b80-cfb0-11eb-8c8c-f5117593ffbe.png">

<img width="1280" alt="CleanShot 2021-06-17 at 21 14 10@2x" src="https://user-images.githubusercontent.com/1888355/122394462-f9f97100-cfb0-11eb-9838-91f22c148bd9.png">


## Demo app

You can see many layout examples from the demo application.

<img width="375" alt="CleanShot 2021-06-17 at 00 23 00@2x" src="https://user-images.githubusercontent.com/1888355/122247248-2e622400-cf02-11eb-9746-cae1d475142d.png">

## Overview

MondrianLayout enables us to describe layouts of subviews by DSL (powered by `resultBuilders`)  
It's like describing in SwiftUI, but this behavior differs a bit since laying out by AutoLayout system.

To describe layout, use `buildSublayersLayout` as entrypoint.  
This method creates a set of NSLayoutConstraint, UILayoutGuide, and modifiers of UIView.  
Finally, those apply. You don't need to call `addSubview`. that goes automatically according to hierarchy from layout descriptions.

```swift
class MyView: UIView {

  let nameLabel: UILabel
  let detailLabel: UILabel

  init() {
    super.init(frame: .zero)
    
    // Seting up constraints constraints, layoutGuides and adding subviews
    buildSublayersLayout {
      VStackBlock {
        nameLabel
        detailLabel
      }
    }
    
    // Seting up constraints for the view itself.
    buildSelfSizing {
      $0.width(200).maxHeight(...)... // can be method cain.
    }
    
  }
}
```

## Detail

### Vertically and Horizontally Stack layout

**VStackBlock**

Alignment 
| center(default) | leading | trailing | fill |
|---|---|---|---|
|<img width="155" alt="CleanShot 2021-06-17 at 00 06 10@2x" src="https://user-images.githubusercontent.com/1888355/122244438-d75b4f80-ceff-11eb-90ea-8982758ed0b0.png">|<img width="151" alt="CleanShot 2021-06-17 at 00 05 19@2x" src="https://user-images.githubusercontent.com/1888355/122244276-b7c42700-ceff-11eb-90d0-492c3fbc5076.png">|<img width="159" alt="CleanShot 2021-06-17 at 00 05 33@2x" src="https://user-images.githubusercontent.com/1888355/122244312-c01c6200-ceff-11eb-888d-0a37b63f666a.png">|<img width="159" alt="CleanShot 2021-06-17 at 00 05 42@2x" src="https://user-images.githubusercontent.com/1888355/122244341-c6124300-ceff-11eb-9da8-dcbb4425909a.png">|

**HStackBlock**

| center(default) | top | bottom | fill |
|---|---|---|---|
|<img width="358" alt="CleanShot 2021-06-17 at 00 09 43@2x" src="https://user-images.githubusercontent.com/1888355/122245037-5486c480-cf00-11eb-872a-e98cfce7262e.png">|<img width="359" alt="CleanShot 2021-06-17 at 00 09 51@2x" src="https://user-images.githubusercontent.com/1888355/122245054-58b2e200-cf00-11eb-9691-607a75060f75.png">|<img width="362" alt="CleanShot 2021-06-17 at 00 09 59@2x" src="https://user-images.githubusercontent.com/1888355/122245073-5d779600-cf00-11eb-856d-0e48712377d7.png">|<img width="355" alt="CleanShot 2021-06-17 at 00 10 06@2x" src="https://user-images.githubusercontent.com/1888355/122245096-62d4e080-cf00-11eb-99f2-2969a3ccc350.png">|

```swift
buildSublayersLayout {
  VStackBlock(spacing: 4, alignment: alignment) {
    UILabel.mockMultiline(text: "Hello", textColor: .white)
      .viewBlock
      .padding(8)
      .background(UIView.mock(backgroundColor: .mondrianYellow))
    UILabel.mockMultiline(text: "Mondrian", textColor: .white)
      .viewBlock
      .padding(8)
      .background(UIView.mock(backgroundColor: .mondrianRed))
    UILabel.mockMultiline(text: "Layout!", textColor: .white)
      .viewBlock
      .padding(8)
      .background(UIView.mock(backgroundColor: .mondrianBlue))
  }
}
```

**Background modifier**

```swift
label
  .viewBlock // To enable view describes layout
  .padding(8)
  .background(backgroundView)
```

<img width="74" alt="CleanShot 2021-06-17 at 00 14 52@2x" src="https://user-images.githubusercontent.com/1888355/122245871-0f16c700-cf01-11eb-91bc-019693736801.png">

**Overlay modifier**

// TODO:

**Related modifier**

// TODO:

**ZStackBlock**

// TODO:

## Installation

**CocoaPods**

```ruby
pod "MondrianLayout"
```

**SwiftPM**

```swift
dependencies: [
    .package(url: "https://github.com/muukii/MondrianLayout.git", exact: "<VERSION>")
]
```

## LICENSE

MondrianLayout is released under the MIT license.
