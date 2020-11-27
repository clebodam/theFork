//
//  NetworkService.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidStatusCode
    case invalidResponse
    case noData
    case serialization
}

typealias GetResponse = (RawRestaurant?, NetworkError?) -> Void


protocol NetWorkManagerProtocol {
    func getData(completion: @escaping GetResponse)
    func doSomeLikeOrShareMockAction( completion: @escaping () ->())
}

class NetWorkManager: NetWorkManagerProtocol {

    var session: URLSession
    var sessionCfg: URLSessionConfiguration
    private let RESTAURANT_HOST = "ptitchevreuil.github.io"
    private let RESTAURANT_PATH = "/test.json"
    private var currentTask: URLSessionDataTask?

    init() {
        sessionCfg = URLSessionConfiguration.default
        sessionCfg.timeoutIntervalForRequest = 10.0
        session = URLSession(configuration: sessionCfg)
    }

    internal  func get<T>( _ type: T.Type ,route: String?, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {

        let completion: (Result<T, Error>) -> Void = {result in
            callback?(result)
            self.currentTask = nil
        }

        if let task = currentTask {
            task.cancel()
        }
        guard let url = URL(string: route ?? "") else {
            completion(Result.failure(NetworkError.badUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        currentTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse  else {
                completion(Result.failure(NetworkError.invalidResponse))
                return
            }
            if (200..<300) ~= response.statusCode {
                guard let data = data  else {
                    completion(Result.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseObject  = try decoder.decode(type, from: data)
                    completion(Result.success(responseObject))

                } catch {
                    print(error)
                    completion(Result.failure(NetworkError.serialization))
                    self.currentTask = nil
                }
            } else {
                completion(Result.failure(NetworkError.invalidStatusCode))

            }
        })
        currentTask?.resume()
    }

    public func getRestaurant(callback: ((Result<RawRestaurant, Error>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RESTAURANT_HOST
        urlComponents.path = RESTAURANT_PATH
        self.get(RawRestaurant.self, route: urlComponents.url?.absoluteString, callback: callback )
    }

    public  func getData(completion: @escaping GetResponse){

        var netWorkError: NetworkError? = nil
        var restaurant: RawRestaurant?
        getRestaurant { (result) in
            switch result {
            case .success(let response):
                restaurant = response
            case .failure(let error):
                netWorkError = error as? NetworkError
            }
            completion(restaurant, netWorkError)
        }
    }

    public func doSomeLikeOrShareMockAction( completion: @escaping () ->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion()
        }
    }
}



