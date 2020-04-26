//
//  RequestView.swift
//  TestNetworking
//
//  Created by Serg on 25.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class RequestView: UICollectionView {
    
    private weak var controllerOutput: InterfaceRequestController!
    
    private let cellId = "requestCell"
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .green
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension RequestView: InterfaceRequestView {
    var controller: InterfaceRequestController {
        get {
            return controllerOutput
        }
        set {
            controllerOutput = newValue
        }
    }
    
    @objc var reuseIdentifier: String {
        return cellId
    }
    
    var delegateView: UICollectionViewDelegate? {
        get {
            return delegate
        }
        set {
            delegate = newValue
        }
    }
    
    var dataSourceView: UICollectionViewDataSource? {
        get {
            return dataSource
        }
        set {
            dataSource = newValue
        }
    }
}

protocol InterfaceRequestView: UICollectionView {
    var controller: InterfaceRequestController { get set }
    var reuseIdentifier: String { get }
    var delegateView: UICollectionViewDelegate? { get set }
    var dataSourceView: UICollectionViewDataSource? { get set }
    
}

class Child: RequestView {
    
    let cellId = "cellId"
    
    override init() {
        super.init()
        backgroundColor = .blue
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String {
        return cellId
    }
}

extension UITableViewCell {
    @objc func a() {
        print("UITableViewCell")
    }
}

class B: UITableViewCell {
    override func a() {
        print(self)
    }
}
