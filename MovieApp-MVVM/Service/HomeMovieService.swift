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
            .request(requestUrl: APIUrl.shared.getHomeMovieListUrl(),
                                 requestMethod: .get)
            .subscribe(onNext: { (data: HomeMovies) in
                completionHandler(data.results)
            }, onError: { (error: Error) in
                errorHandler(error)
            }).disposed(by: disposeBag)
    }
}
