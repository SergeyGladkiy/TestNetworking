//
//  RequestController.swift
//  TestNetworking
//
//  Created by Serg on 25.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class RequestController: UICollectionViewController {
    
    private var viewInput: InterfaceRequestView
    
    init(view: InterfaceRequestView) {
        self.viewInput = view
        super.init(nibName: nil, bundle: nil)
        
        collectionView = viewInput
        viewInput.dataSourceView = self
        viewInput.delegateView = self
    }
    
    //OK
//    override func loadView() {
//        collectionView = viewInput
//        viewInput.dataSourceView = self
//        viewInput.delegateView = self
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewInput.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

protocol InterfaceRequestController: class {
    
}

extension RequestController: InterfaceRequestController {
    
}
