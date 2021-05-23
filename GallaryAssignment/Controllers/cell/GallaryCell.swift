import UIKit

class GallaryCell: UITableViewCell {

    @IBOutlet weak var gallaryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    static let identifier = "GallaryCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
