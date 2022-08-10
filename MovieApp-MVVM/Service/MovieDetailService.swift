//
//  MovieDetailService.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import Foundation
import RxSwift

class MovieDetailService{
    
    static let shared = MovieDetailService()
    private var disposeBag = DisposeBag()
    
    private init() {}
    
    func getMovieCast(movieId: Int, completionHandler: @escaping ([CastDetailModel]) -> Void, errorHandler: @escaping (Error) -> Void) {
        BaseNetworkLayer
            .shared
            .request(requestUrl: APIUrl.shared.getMovieDetailUrl(with: movieId),
                     requestMethod: .get)
            .subscribe(onNext: { (data: MovieCredits) in
                completionHandler(data.cast)
            }, onError: { (error: Error) in
                errorHandler(error)
            }).disposed(by: disposeBag)
    }
}
