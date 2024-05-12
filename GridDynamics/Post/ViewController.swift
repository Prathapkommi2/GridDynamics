//
//  ViewController.swift
//  GridDynamics
//
//  Created by Prathap Kommi on 12/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    /// Setup the delegates and datasources
    func setup() {
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        viewModel.fetchPost()
    }
}

// MARK: - ViewModel Delegates
extension ViewController: PostViewModelDelegate {
    func displayError(_ msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Tableview Delegates and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearchActive {
            return viewModel.filterList.count
        }
        return viewModel.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell") as! PostsTableViewCell
        let post = viewModel.isSearchActive ? viewModel.filterList : viewModel.postList
        cell.model = post[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.isSearchActive ? viewModel.filterList : viewModel.postList
        let selectedPost = post[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.selectedPost = selectedPost
        self.present(vc, animated: true)
    }
}

// MARK: - Textfield delegate
extension ViewController: UITextFieldDelegate {
    /// Filter the post based on the search input with title
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchedText = textField.text ?? ""
        if searchedText.isEmpty {
            self.viewModel.isSearchActive = false
            self.tableView.reloadData()
        } else {
            viewModel.searchPost(searchString: searchedText)
        }
        textField.endEditing(true)
        return true
    }
}

