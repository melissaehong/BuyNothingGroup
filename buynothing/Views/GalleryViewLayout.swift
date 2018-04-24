//
//  GalleryViewLayout.swift
//  buynothing
//
//  Created by Jake Romer on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class GalleryViewLayout: UICollectionViewFlowLayout {
  var columns: Int
  let spacing: CGFloat = 1.0

  var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }

  var itemWidth: CGFloat {
    let cols = CGFloat(columns)
    let fudgeFactorForBreathingRoom: CGFloat = 15
    let availableScreen = screenWidth - fudgeFactorForBreathingRoom - (cols * spacing)
    return availableScreen / cols
  }

  init(columns: Int = 2) {
    self.columns = columns

    super.init()
    let fudgeFactorForVerticalBreathingRoom: CGFloat = 5.0
    self.minimumLineSpacing = spacing + fudgeFactorForVerticalBreathingRoom
    self.minimumInteritemSpacing = spacing
    self.itemSize = CGSize(width: itemWidth, height: itemWidth)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
