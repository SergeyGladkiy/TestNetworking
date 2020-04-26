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
    
    var controller: MainRequestController!
    
    private weak var collectionView: UICollectionView!
    private let reuseIdentifier = "requestCell"
    
    init() {
        super.init(frame: .zero)
        customLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func customLayout() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(RequestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView = collectionView
        addSubview(self.collectionView)
        
    }
    
}

extension MainRequestView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RequestCollectionViewCell
        
        return cell
    }
}
