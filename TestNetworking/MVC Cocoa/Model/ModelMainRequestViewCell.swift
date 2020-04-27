//
//  ModelMainRequestViewCell.swift
//  TestNetworking
//
//  Created by Serg on 26.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelMainRequestViewCell: ViewModelMainRequest {
    let actionName: String
    
    var description: String {
        return actionName
    }
    
    init(item: DataRequests) {
        self.actionName = item.rawValue
    }
}
