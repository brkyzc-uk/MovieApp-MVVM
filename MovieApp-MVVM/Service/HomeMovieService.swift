//
//  HomeMovieService.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import Foundation
import RxSwift

class HomeMovieService {
    
    static let shared = HomeMovieService()
    private var disposeBag = DisposeBag()
    
    private init() {
        
    }
    
    func getMovieList(completionHandler: @escaping ([MovieResults]) -> Void, errorHandler: @escaping (Error) -> Void) {
        BaseNetworkLayer
            .shared
            .request(requestUrl: "https://api.themoviedb.org/3/movie/popular?api_key=f506ec91a7f3deb9dcc4d3a6243eb20d",
                                 requestMethod: .get)
            .subscribe(onNext: { (data: HomeMovies) in
                completionHandler(data.results)
            }, onError: { (error: Error) in
                errorHandler(error)
            }).disposed(by: disposeBag)
    }
}
