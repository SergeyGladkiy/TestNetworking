//
//  MainRequestView.swift
//  TestNetworking
//
//  Created by Serg on 26.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainRequestView: UIView {
    
    private var controller: MainRequestController!
    
    private weak var collectionView: UICollectionView!
    private let reuseIdentifier = "requestCell"
    
    init() {
        super.init(frame: .zero)
//        backgroundColor = .yellow
        customLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func customLayout() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(RequestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        collectionView.backgroundColor = .white
        
        addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension MainRequestView: InterfaceMainRequestView {
    
    var output: MainRequestController {
        get {
            return controller
        }
        set {
            controller = newValue
        }
    }
    
}

extension MainRequestView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.numberOfItemInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RequestCollectionViewCell
        cell.viewModel = controller.viewModelForItemAt(indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller.performAction(by: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 40, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    
}
