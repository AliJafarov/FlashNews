//
//  NewsHeader.swift
//  FlashNews
//
//  Created by Ali Jafarov on 29.04.22.
//

import Foundation
import UIKit
import SDWebImage

class NewsHeader: UIView {
    
    private var headerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImage)
        addSubview(headerLabel)
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraint() {
        let headerImageConsTraints = [
            headerImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            headerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            headerImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            headerImage.heightAnchor.constraint(equalToConstant: 200)
            ]
        NSLayoutConstraint.activate(headerImageConsTraints)
        
        let headerLabelConstraint = [
            headerLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            headerLabel.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40)
        ]
        
        NSLayoutConstraint.activate(headerLabelConstraint)
    }
    
    func configure(data: Article?) {
        if let data = data {
            headerLabel.text = data.title
            headerImage.sd_setImage(with: URL(string: data.urlToImage ?? ""), completed: nil)
        }
    }
}
