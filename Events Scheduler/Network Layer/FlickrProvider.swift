//
//  FlickrProvider.swift
//  Events Scheduler
//
//  Created by Gourav  Garg on 21/06/18.
//  Copyright © 2018 Gourav  Garg. All rights reserved.
//

import Foundation
class FlickrProvider {
    
    typealias FlickrResponse = (NSError?, PhotoCollection?) -> Void
    
    let searchTerm: String? = "sunday"
    
    class func fetchFlickerPhotos(onCompletion: @escaping FlickrResponse) {
        //let apiKey = "67a5e3716cf1d970d8bbc31c0ed438a3"  //enter your new api key
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=7c1690a42b8d81e1c69422cee75a5717&tags=india&per_page=1&page=1&format=json&nojsoncallback=1&api_sig=27ed5130ad2ff10f2584431c0acd4c46"
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, downloadError) in
            if let error = downloadError {
                print("Error: \(error)")
                onCompletion(error as NSError, nil)
            }
            else {
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let photoCollection = try decoder.decode(PhotoCollection.self, from: data)
                        if photoCollection.stat == "fail" {
                            print("Flickr: No Results")
                            onCompletion(nil, nil)
                        }
                        else {
                            onCompletion(nil, photoCollection)
                        }
                    }
                    else {
                        print("data is nil")
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
