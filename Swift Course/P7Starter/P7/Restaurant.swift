//
//  Restaurant.swift
//  P7
//
//  Created by Lucy Xu on 10/31/20.
//


// TODO: Define model for our restaurant resposne
struct RestaurantsDataResponse: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your RestaurantsDataResponse object after the JSON response.
     */
    
    let restaurants: [Restaurant]
}


// TODO: Define model for our restaurant
struct Restaurant: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your Restaurant object after the JSON response, except using camel
     * case instead of snake case, as shown in our JSON response.
     * Helpful Hint: We have two different possible restaurant objects we might get
     * back from the backend, one with "reviews" and one without. How do we include
     * this in our model despite this being the case? Think about what we do when
     * a value is allowed to be nil...
     */
    
    let id: Int
    let name: String
    let category: [String]
    let openTime: String
    let closeTime: String
    let rating: Float
    let photo: String
    let address: String
    let phoneNumber: String
    let reviews: [String]?
}
