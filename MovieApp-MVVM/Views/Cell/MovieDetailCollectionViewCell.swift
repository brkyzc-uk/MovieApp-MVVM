//
//  MovieDetailCollectionViewCell.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {
    
    lazy var castImageView: BaseImageViewComponent = {
        
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        imageView.layer.cornerRadius = imageView.frame.size.width / 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var castLabel: BaseLabelComponent = {
        
        let label = BaseLabelComponent()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .cyan
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(castImageView)
        addSubview(castLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               castImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
               castImageView.widthAnchor.constraint(equalToConstant: 120),
               castImageView.heightAnchor.constraint(equalToConstant: 120),
               castImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
               
               castLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 10),
               castLabel.widthAnchor.constraint(equalToConstant: 75),
               castLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
           ])
       }
    
    
}
