//
//  CastDetailViewController.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 11/08/2022.
//

import UIKit
import SDWebImage

class CastDetailViewController: UIViewController {
    
    lazy var castImageView: BaseImageViewComponent = {
        
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        return imageView
    }()
    
    
    lazy var castNameLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.boldSystemFont(ofSize: 26)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    lazy var castCharacterLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    lazy var castKnownForDepartmentLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    lazy var castGenderLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    lazy var castPopularityLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    lazy var labelStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [castNameLabel,
                                                       castCharacterLabel,
                                                       castKnownForDepartmentLabel,
                                                       castGenderLabel,
                                                       castPopularityLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var castDetailViewModel: CastDetailViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        navigationItem.title = "Cast Detail"
        view.addSubview(castImageView)
        view.addSubview(labelStackView)
        getData(castDetailViewModel?.castDetailModel)
        setupConstraints()
    }
    
    func getData(_ movieCastModel: CastDetailModel?) {
        
        if movieCastModel?.profilePath == nil {
            castImageView.image = UIImage(named: "placeholder")
        } else {
            let imageUrl =  URL(string: API.movieImageUrl.rawValue + (movieCastModel?.profilePath ?? ""))
            castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            castImageView.sd_setImage(with: imageUrl, completed: nil)
        }
        
        castNameLabel.text = "Name:  \(movieCastModel?.name ?? "Unknown")"
        castCharacterLabel.text = "Character: \(movieCastModel?.character ?? "Unknown")"
        castKnownForDepartmentLabel.text = "Known for department: \(movieCastModel?.knownForDepartment ?? "Unknown")"
        castPopularityLabel.text = "Popularity: \(movieCastModel?.popularity ?? 0.0)"
        
        if let castGender = movieCastModel?.gender {
            if castGender == 1 {
                castGenderLabel.text = "Gender: Woman"
            } else if castGender == 2 {
                castGenderLabel.text = "Gender: Man"
            } else {
                castGenderLabel.text = "Gender: Unknown"
            }
        }
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                castImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                castImageView.widthAnchor.constraint(equalToConstant: 200),
                castImageView.heightAnchor.constraint(equalToConstant: 200),
                castImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                
                castNameLabel.widthAnchor.constraint(equalToConstant: 300),
                
                labelStackView.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 20),
                labelStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                castImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
                castImageView.widthAnchor.constraint(equalToConstant: 200),
                castImageView.heightAnchor.constraint(equalToConstant: 200),
                castImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                castNameLabel.widthAnchor.constraint(equalToConstant: 300),
                
                labelStackView.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 20),
                labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    
    

  

}
