//
//  MainRequestController.swift
//  TestNetworking
//
//  Created by Serg on 26.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainRequestController: UICollectionViewController {
    
    weak var customView: UIView!
    
    init(view: UIView) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
        self.view = customView
        print(view.superview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
