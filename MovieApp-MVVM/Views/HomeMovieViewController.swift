//
//  HomeMovieViewController.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import UIKit
import SDWebImage
import SwiftUI

class HomeMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeMovieViewModelDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        homeMovieViewModel.searchedMovieList.removeAll(keepingCapacity: false)
        
        if let searchTerm = searchController.searchBar.text {
            let searchedArray = homeMovieViewModel.movieList.filter { result in
                return (result.title?.lowercased().contains(searchTerm.lowercased()) ?? false)
            }
            homeMovieViewModel.searchedMovieList = searchedArray
            if searchController.isBeingDismissed == false {
                movieTableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearchController.searchBar.endEditing(true)
        movieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieSearchController.isActive = false
        movieSearchController.searchBar.endEditing(true)
        movieSearchController.searchBar.showsCancelButton = false
        movieTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        movieSearchController.isActive = false
        movieSearchController.searchBar.showsCancelButton = true
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        movieSearchController.isActive = true
        movieSearchController.searchBar.showsCancelButton = true
        movieTableView.reloadData()
    }
    

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
    
    lazy var movieSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        return searchController
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        navigationItem.title = "Movies App"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont(name: "Futura Bold", size: 24)!]
        navigationController?.navigationBar.backgroundColor = .clear
        view.addSubview(movieTableView)
        view.addSubview(loaderActivtyIndicatorView)
        loaderActivtyIndicatorView.startAnimating()
        //print("setup called")
        setupConstraints()
        setupSearchController()
        
        
    }
    
    func setupSearchController() {
           if #available(iOS 11.0, *) {
               navigationItem.hidesSearchBarWhenScrolling = false
               navigationItem.searchController = movieSearchController
           } else {
               movieSearchController.hidesNavigationBarDuringPresentation = false
               navigationItem.titleView = movieSearchController.searchBar
           }
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
        if movieSearchController.isActive {
            return homeMovieViewModel.searchedMovieList.count
                } else {
                    return homeMovieViewModel.movieList.count
                }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieTableViewCell") as? HomeMovieTableViewCell {
            
            if movieSearchController.isActive {
                           getCellData(with: homeMovieViewModel.searchedMovieList[indexPath.row], cell: cell)
                       } else {
                           getCellData(with: homeMovieViewModel.movieList[indexPath.row], cell: cell)
                       }
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
