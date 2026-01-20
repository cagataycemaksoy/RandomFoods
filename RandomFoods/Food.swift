//
//  Food.swift
//  RandomFoods
//
//  Created by Cem Aksoy on 20.01.2026.
//

import Foundation

@Observable
class Food {
  struct Dish: Codable {
    var image: String
  }
  
  let urlString = "https://foodish-api.com/api"
  
  var imageURL = ""
  var dishName = ""
  
  func getData() async {
    guard let url = URL(string: urlString) else {
      print("Failed to create URL.")
      return
    }
    guard let (returned, _) = try? await URLSession.shared.data(from: url) else {
      print("Failed to get response.")
      return
    }
    
    guard let imageURL = try? JSONDecoder().decode(Dish.self, from: returned).image else {
      print("Failed to decode the response.")
      return
    }
    
    self.imageURL = imageURL
    self.dishName = getDishName(for: imageURL)
  }
  
  func getDishName(for dishURLString: String) -> String {
    let stringComponents = dishURLString.components(separatedBy: "/")
    return stringComponents[4]
  }
}
