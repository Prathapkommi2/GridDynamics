//
//  DetailsViewController.swift
//  GridDynamics
//
//  Created by Prathap Kommi on 12/05/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedPost: PostModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - Tableview protocols
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosttDetailsTableViewCell") as! PosttDetailsTableViewCell
        cell.data = self.selectedPost
        
        return cell
    }
}


class PosttDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var selectedTitle: UILabel!
    @IBOutlet weak var selectedAlbumId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: PostModel? {
        didSet {
            if let url = URL(string: data?.url ?? "") {
                self.postImage.loadImageWithUrl(url)
            } else {
                self.postImage.image = UIImage(named: "Default")
            }
            selectedTitle.text = "Title: \(data?.title ?? "N.A")"
            selectedAlbumId.text = "AlbumId: \(data?.albumId ?? 0)"
        }
    }
}
