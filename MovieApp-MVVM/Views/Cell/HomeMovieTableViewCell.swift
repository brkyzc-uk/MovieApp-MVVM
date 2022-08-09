//
//  HomeMovieTableViewCell.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 09/08/2022.
//

import UIKit
import SDWebImage

class HomeMovieTableViewCell: UITableViewCell {
    
    lazy var movieImageView: BaseImageViewComponent = {
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    
 
    
    lazy var movieNameLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 26)
        baseLabelComponent.textColor = UIColor.red
        return baseLabelComponent
    }()
    
    lazy var movieReleaseDateLabel: BaseLabelComponent = {
        let baseLabelComponent  = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 14)
        return baseLabelComponent
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieReleaseDateLabel])
        stackView.spacing = 26
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        configureCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(movieImageView)
        addSubview(labelStackView)
    }
    
    func configureCell() {
        backgroundColor = .cyan
        selectionStyle = .none
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            movieNameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            labelStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
