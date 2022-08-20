//
//  NetworkManager.swift
//  P7
//
//  Created by Lucy Xu on 11/2/20.
//

import Foundation
import Alamofire

class NetworkManager {

    // TODO: Edit our server host endpoint
    /* Helpful Hint: What is the host endpoint for our server?
     * Ex. If endpoint is "https://google.com/blah", Google is the host
     */
    private static let host = "64.227.6.156"
    
    // TODO: Complete function to get all restaurants
    static func getRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        let endpoint = "\(host)/eateries/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let restaurantsData = try? jsonDecoder.decode(RestaurantsDataResponse.self, from: data) {
                        let restaurants = restaurantsData.data.restaurants
                        completion(restaurants)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // TODO: Complete function to get a single restaurant
    static func getRestaurant(id: Int, completion: @escaping (Restaurant) -> Void) {
        let parameters: [String: Any] = [
            "id": id
        ]
        let endpoint = "\(host)/eatery/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let restaurant = try? jsonDecoder.decode(Restaurant.self, from: data) {
                    completion(restaurant)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // EXTRA CREDIT TODO: Complete function to search for restaurants
    
}
