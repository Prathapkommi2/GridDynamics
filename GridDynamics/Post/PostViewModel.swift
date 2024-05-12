//
//  PostViewModel.swift
//  GridDynamics
//
//  Created by Prathap Kommi on 12/05/24.
//

import Foundation

protocol PostViewModelDelegate: AnyObject {
    func displayError(_ msg: String)
    func reloadUI()
}

class PostViewModel {
    var postList = [PostModel]()
    var filterList = [PostModel]()
    weak var delegate: PostViewModelDelegate?
    var isSearchActive = false
    
    /// Filter the post based on the search input with title
    func searchPost(searchString: String) {
        print(searchString)
        filterList = filterList.filter({$0.title?.contains(searchString) ?? false})
        print(searchString)
        isSearchActive = true
        delegate?.reloadUI()
    }
    
    /// Get the list of post from the server
    func fetchPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            delegate?.displayError("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            do {
                guard error == nil else {
                    return
                }
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode( [PostModel].self, from: data!)
                if !response.isEmpty {
                    self.postList = response
                    self.filterList = response
                    self.delegate?.reloadUI()
                }
                
            } catch let error {
                self.delegate?.displayError(error.localizedDescription)
            }
        }
        task.resume()
    }
}
