//
//  DataCollectionViewCell.swift
//  Purushoth_Coding
//
//  Created by vassathy on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "DataCollectionViewCell"
    let aboutCanadaImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 4.0
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imgView
    }()

    let aboutTitleLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.0
        return label
    }()
    
    let aboutDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.0
        label.textColor = .darkGray
        return label
    }()

    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.aboutCanadaImageView, self.aboutTitleLabel,self.aboutDescriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5.0
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        handleConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func handleConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verticalStackView)
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    override func awakeFromNib() {
    
    }
}
