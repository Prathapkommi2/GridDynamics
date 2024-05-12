//
//  PostsTableViewCell.swift
//  GridDynamics
//
//  Created by Prathap Kommi on 12/05/24.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model: PostModel? {
        didSet {
            if let urlStr = model?.url, let url = URL(string: urlStr)  {
                self.postImage.loadImageWithUrl(url)
            }
            postTitle.text = model?.title ?? "N.A"
        }
    }

}
