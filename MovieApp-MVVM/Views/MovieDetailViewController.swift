//
//  MovieDetailViewController.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MovieDetailViewModelDelegate {
    
    
    lazy var mainScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var titleLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.font = UIFont.boldSystemFont(ofSize: 26)
        baseLabelComponent.textColor = UIColor.white
        return baseLabelComponent
    }()
    
    lazy var coverImageView: BaseImageViewComponent = {
        
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 500))
        return imageView
    }()
    
    
    lazy var ratingLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.font = UIFont.boldSystemFont(ofSize: 20)
        baseLabelComponent.textColor = UIColor.yellow
        return baseLabelComponent
    }()
    
    lazy var releaseDateLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.textColor = UIColor.lightGray
        return baseLabelComponent
    }()
    
    lazy var summaryLabel: BaseLabelComponent = {
        
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 18)
        baseLabelComponent.textAlignment = .justified
        baseLabelComponent.textColor = UIColor.white
        return baseLabelComponent
    }()
    
    lazy var castCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 200)
        flowLayout.estimatedItemSize = CGSize(width: 150, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: "MovieDetailCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = UIView.init(frame: .zero)
        return collectionView
        
    }()
    
    var moviDetailViewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getDataFrom(moviDetailViewModel?.movieResults)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        resizeScroll()
    }
    
   
    
    func resizeScroll() {
        let height = coverImageView.frame.size.height + titleLabel.frame.size.height + ratingLabel.frame.size.height + releaseDateLabel.frame.size.height + summaryLabel.frame.size.height + castCollectionView.frame.size.height + 100
        mainScrollView.contentSize = CGSize(width: view.frame.size.width, height: height)
    }
    
    func setUp() {
        navigationItem.title = moviDetailViewModel?.movieResults?.title
        moviDetailViewModel?.delegate = self
        mainScrollView.addSubview(coverImageView)
        mainScrollView.addSubview(titleLabel)
        mainScrollView.addSubview(ratingLabel)
        mainScrollView.addSubview(releaseDateLabel)
        mainScrollView.addSubview(summaryLabel)
        mainScrollView.addSubview(castCollectionView)
        view.addSubview(mainScrollView)
        setupConstraints()
        
    }
    
    func getDataFrom(_ movieResult: MovieResults?) {
        if let title = movieResult?.title, let imageUrl = URL(string: API.movieImageUrl.rawValue + (movieResult?.backdropPath ?? "")), let releaseDate = movieResult?.releaseDate, let summary = movieResult?.overview {
            titleLabel.text = title
            coverImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            coverImageView.sd_setImage(with: imageUrl, completed: nil)
            releaseDateLabel.text = "Release Date: \(releaseDate)"
            ratingLabel.text = "Rate: \(movieResult?.voteAverage ?? 0.0)"
            summaryLabel.text = summary


        } else {
            titleLabel.text = "Undefined"
            coverImageView.image = UIImage(named: "placeholder")
            releaseDateLabel.text = "Undefined"
            summaryLabel.text = "Undefined"
            
        }
    }
    
    // check cast have profile photo
    func checkImageUrl(path: CastDetailModel) {
        if path.profilePath != nil {
            let model = CastModel(name: path.name, imagePath: API.movieImageUrl.rawValue + (path.profilePath ?? ""), character: path.character)
            moviDetailViewModel?.castList.append(model)
        } else {
            let model = CastModel(name: path.name ?? "", imagePath: nil, character: path.character ?? "")
            moviDetailViewModel?.castList.append(model)
        }
    }
    
    func setImageUrl(_ movieCastList: [CastDetailModel]) {
        for path in movieCastList {
            checkImageUrl(path: path)
        }
    }
    
    
    
    func setMovieCast(_ castDetailList: [CastDetailModel]) {
        moviDetailViewModel?.castDetailList = castDetailList
        setImageUrl(castDetailList)
        castCollectionView.reloadData()
    }
    
    func getMovieDetailError(_ error: Error) {
        showError(title: "Error", message: error.localizedDescription)
    }
    
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let dismissButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okButton)
        alertController.addAction(dismissButton)
        present(alertController, animated: true)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviDetailViewModel?.castList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionViewCell", for: indexPath) as? MovieDetailCollectionViewCell {
            if let imageUrl = URL(string: moviDetailViewModel?.castList[indexPath.item].imagePath ?? "") {
                cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.castImageView.sd_setImage(with: imageUrl)
            } else {
                cell.castImageView.image = UIImage(named: "placeholder")
            }
            cell.castLabel.text = moviDetailViewModel?.castList[indexPath.item].name
            cell.castCharacterLabel.text = moviDetailViewModel?.castList[indexPath.item].character
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height:  200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = CastDetailViewController()
        if let model = moviDetailViewModel?.castDetailList[indexPath.row] {
            let viewModel = CastDetailViewModel(castDetailModel: model)
            viewController.castDetailViewModel = viewModel
        }
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func setupConstraints() {
         NSLayoutConstraint.activate([
             
             coverImageView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 5),
             coverImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 1.4),
             coverImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
             coverImageView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 5),
             titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9),
             titleLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             
             releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
             releaseDateLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
             ratingLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             summaryLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 15),
             summaryLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9),
             summaryLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             castCollectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5),
             castCollectionView.heightAnchor.constraint(equalToConstant: 300),
             castCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
             castCollectionView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
             
             mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
             mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
             mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
             mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
         ])
     }

  

}

