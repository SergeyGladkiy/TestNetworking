//
//  RequestCollectionViewCell.swift
//  TestNetworking
//
//  Created by Serg on 26.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class RequestCollectionViewCell: UICollectionViewCell {
    
    weak var viewModel: ViewModelMainRequest! {
        didSet {
            self.actionLabel.text = viewModel.description
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            //backgroundColor = isHighlighted ? .white : .lightGray
            var alpha: CGFloat = 1
            
            if isHighlighted {
                alpha = 0.7
            }
                
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.alpha = alpha
                
            }, completion: nil)
        }
    }
    
    private weak var actionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        self.actionLabel = label
        let stackView = UIStackView(arrangedSubviews: [actionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
