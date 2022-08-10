//
//  MovieDetailViewModel.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
    func setMovieCast(_ castDetailList: [CastDetailModel])
    func getMovieDetailError(_ error: Error)
}

class MovieDetailViewModel {
    
    var movieResults: MovieResults?
    var castDetailList = [CastDetailModel]()
    var castList = [CastModel]()
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResults: MovieResults?) {
        self.movieResults = movieResults
        getData()
    }
    
    func getData() {
        MovieDetailService.shared.getMovieCast(movieId: movieResults?.id ?? 0, completionHandler: { [weak self] (cast) in
               guard let self = self else { return }
               self.delegate?.setMovieCast(cast)
           }, errorHandler: { [weak self] (error) in
               guard let self = self else { return }
               self.delegate?.getMovieDetailError(error)
           })
       }
}


