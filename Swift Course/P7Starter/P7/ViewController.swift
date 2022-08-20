//
//  ViewController.swift
//  P7
//
//  Created by Lucy Xu on 10/31/20.
//

import UIKit

class ViewController: UIViewController {
    
    private let restaurantsTableView = UITableView()
    private let restaurantReuseIdentifier = "RestaurantReuseIdentifier"
    private var restaurants: [Restaurant] = []
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        title = "Collegetown Eateries"
        navigationController?.navigationBar.barTintColor = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Enter restaurant"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        view.addSubview(searchBar)
        
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
        restaurantsTableView.separatorStyle = .none
        restaurantsTableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        restaurantsTableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: restaurantReuseIdentifier)
        view.addSubview(restaurantsTableView)
        
        getRestaurants()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            restaurantsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            restaurantsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restaurantsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // TODO: Complete function to get all restaurants
    private func getRestaurants() {
        /* Instructions: Make a call to getRestaurants function inside of NetworkManager
         * If function is written correctly, the function should return an array of retaurants.
         * Inside completion handler block, set restaurants array in this class to the
         * returned restaurants array and then reload restaurants table view.
         */
        
        NetworkManager.getRestaurants { restaurants in
            self.restaurants = restaurants
            
            DispatchQueue.main.async {
                self.restaurantsTableView.reloadData()
            }
            
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurants[indexPath.row]
        let restaurantViewController = RestaurantViewController(restaurant: restaurant)
        navigationController?.pushViewController(restaurantViewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: restaurantReuseIdentifier) as? RestaurantTableViewCell else { return UITableViewCell() }
        let restaurant = restaurants[indexPath.row]
        cell.configure(for: restaurant)
        return cell
    }
}

extension ViewController:  UISearchBarDelegate {
    // EXTRA CREDIT TODO: Complete functions to search restaurants
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /* Instructions: Make a call to searchRestaurants function inside of NetworkManager,
         * passing searchText as an argument. If function is written correctly, the function
         * should return an array of retaurants. Inside completion handler block, set
         * restaurants array in this class to the returned restaurants array and then reload
         * restaurants table view.
         */
    }
}
