//
//  UIViewExtension.swift
//  HealthyFood
//
//  Created by Sorrapong W on 14/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit

extension UIView {
    class func viewFromNibName(_ name: String) -> UIView? {
      let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
      return views?.first as? UIView
    }
}
