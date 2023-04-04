//
//  PostCell.swift
//  BeReal
//
//  Created by Kelly Bonilla Guzmán on 4/3/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    private var imageDataRequest: DataRequest?
    
    func configure(with post: Post) {
        // Username
        if let user = post.user {
            usernameLabel.text = user.username
        }

        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        captionLabel.text = post.caption
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset image view image.
        postImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
