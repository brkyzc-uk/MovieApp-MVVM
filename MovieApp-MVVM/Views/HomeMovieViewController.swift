//
//  HomeMovieViewController.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import UIKit
import SDWebImage
import SwiftUI

class HomeMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeMovieViewModelDelegate {
   
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeMovieTableViewCell.self, forCellReuseIdentifier: "HomeMovieTableViewCell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var loaderActivtyIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    lazy var homeMovieViewModel: HomeMovieViewModel = {
        let viewModel = HomeMovieViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        navigationItem.title = "Movies App"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont(name: "Futura Bold", size: 30)!]
        navigationController?.navigationBar.backgroundColor = .clear
        view.addSubview(movieTableView)
        view.addSubview(loaderActivtyIndicatorView)
        loaderActivtyIndicatorView.startAnimating()
        //print("setup called")
        setupConstraints()
        
    }
    
    
    
    func getCellData(with movieList: MovieModel, cell: HomeMovieTableViewCell) {
        cell.movieNameLabel.text = movieList.title
        cell.movieImageView.sd_setImage(with: URL(string: movieList.imageUrl ??  "" ))
        cell.movieReleaseDateLabel.text = "Release Date: \(movieList.releaseDate ?? "")"
        cell.movieVoteAvarageLabel.text = "Rate: \(movieList.voteAverage ?? 0.0)"
    }
    
    func setMovieList(_ movieList: [MovieModel]) {
        homeMovieViewModel.movieList = movieList
        movieTableView.reloadData()
        loaderActivtyIndicatorView.stopAnimating()
    }
    
    func getHomeMovieListError(_ error: Error) {
        showError(title: "Error", message: error.localizedDescription)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(homeMovieViewModel.movieList.count)
        return homeMovieViewModel.movieList.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieTableViewCell") as? HomeMovieTableViewCell {
            
            getCellData(with: homeMovieViewModel.movieList[indexPath.row], cell: cell)
            return cell
        } else {
        
            return UITableViewCell()
            
            
        }
        
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        let movieDetailViewModel = MovieDetailViewModel(movieResults: homeMovieViewModel.movieResults[indexPath.row])
        movieDetailViewController.moviDetailViewModel = movieDetailViewModel
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
   
    

    
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let dismissButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okButton)
        alertController.addAction(dismissButton)
        present(alertController, animated: true)
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                
             
            ])
        } else {
            NSLayoutConstraint.activate([
                movieTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
    }
    
    

}
