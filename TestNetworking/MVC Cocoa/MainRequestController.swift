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
    
    weak var customView: InterfaceMainRequestView!
    private var dataModel = DataRequests.allCases
    
    init(view: InterfaceMainRequestView) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
        customView.output = self
        self.view = customView as? UIView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainRequestController {
    func numberOfItemInSection() -> Int {
        return dataModel.count
    }
    
    func viewModelForItemAt(_ indexPath: IndexPath) -> ViewModelMainRequest {
        let modelItem = dataModel[indexPath.row]
        return ModelMainRequestViewCell(item: modelItem)
    }
}
