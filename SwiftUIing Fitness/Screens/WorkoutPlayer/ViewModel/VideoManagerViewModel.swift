//
//  VideoManagerViewModel.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import Foundation

class VideoManagerViewModel: ObservableObject {
    @Published private(set) var videos: [Video] = []
    
    // On initialize of the class, fetch the videos
    init() {
        // Need to Task.init and await keyword because findVideos is an asynchronous function
        Task.init {
            await findVideos()
        }
    }
    
    // Fetching the videos asynchronously
    func findVideos() async {
        do {
        // Make sure we have a URL before continuing
        guard let url = URL(string: "https://api.pexels.com/videos/search?query=workout&per_page=10&orientation=portrait") else { fatalError("Missing URL") }
        
        // Create a URLRequest
        var urlRequest = URLRequest(url: url)
        
        // Setting the Authorization header of the HTTP request - replace YOUR_API_KEY by your own API key
        urlRequest.setValue("eTvSFyKHhlltykEOyOE3AcAK61hNVJybB1PCOCLlBJjkwAjOTex6ZFQu", forHTTPHeaderField: "Authorization")
        
            // Fetching the data
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // Making sure the response is 200 OK before continuing
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            // Creating a JSONDecoder instance
            let decoder = JSONDecoder()
            
            // Allows us to convert the data from the API from snake_case to cameCase
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Decode into the ResponseBody struct below
            let decodedData = try decoder.decode(WorkoutResponseBody.self, from: data)
            
            // Setting the videos variable
            DispatchQueue.main.async {
                // Reset the videos (for when we're calling the API again)
                self.videos = []
                
                // Assigning the videos we fetched from the API
                self.videos = decodedData.videos
            }

        } catch {
            // If we run into an error, print the error in the console
            print("Error fetching data from Pexels: \(error)")
        }
    }
}
