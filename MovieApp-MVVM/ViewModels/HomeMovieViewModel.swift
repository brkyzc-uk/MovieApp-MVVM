//
//  HomeMovieViewModel.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import Foundation

protocol HomeMovieViewModelDelegate: AnyObject {
    func setMovieList(_ movieList: [MovieModel])
    func getHomeMovieListError(_ error: Error)
}

class HomeMovieViewModel {
    
    var movieResults: [MovieResults] = []
    var movieModel: MovieModel?
    var movieList: [MovieModel] = []
    weak var delegate: HomeMovieViewModelDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        HomeMovieService.shared.getMovieList(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.movieResults = results
            self.setMovieList(results)
        }, errorHandler: { [weak self] (error) in
            guard let self = self else { return }
            self.delegate?.getHomeMovieListError(error)
        })
    }
    
    func setMovieList(_ results: [MovieResults]) {
        for movie in results {
            if let imagePath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate {
                movieModel = MovieModel(title: title, imageUrl: API.movieImageUrl.rawValue + imagePath, releaseDate: releaseDate, voteAverage: movie.voteAverage)
                if let model = movieModel {
                    movieList.append(model)
                }
            }
        }
        delegate?.setMovieList(movieList)
    }
}



