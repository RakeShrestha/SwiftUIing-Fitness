//
//  HomeModel.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct WorkoutList: Identifiable {
    var id = UUID()
    var thumbnail: String
    var duration: String
    var calories: String
    var type: String
    var description: String
    var videoURL: String
}

struct DietList: Identifiable {
    var id = UUID()
    var image: String
    var proteinAmount: String
    var name: String
    var calories: String
}
