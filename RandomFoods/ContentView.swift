//
//  ContentView.swift
//  RandomFoods
//
//  Created by Cem Aksoy on 20.01.2026.
//

import SwiftUI

struct ContentView: View {
  @State private var food = Food()
  
    var body: some View {
        NavigationStack {
          VStack {
            Spacer()
            
            AsyncImage(url: URL(string: food.imageURL)) { image in
              image
                .resizable()
                .scaledToFit()
            } placeholder: {
              RoundedRectangle(cornerRadius: 20)
                .fill(.secondary.opacity(0.3))
            }
            .frame(width: 200, height: 200)

            Text(food.dishName.capitalized)
              .font(.title3.bold())
              .padding(9)
            
            Spacer()
            Spacer()
          }
          .navigationTitle("Food of the Day:")
        }
        .task {
          await food.getData()
        }
    }
}

#Preview {
    ContentView()
}
