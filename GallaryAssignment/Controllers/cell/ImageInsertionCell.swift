import UIKit

class ImageInsertionCell: UITableViewCell {
    @IBOutlet weak var imageInsertionCell: UIImageView!
    
    static let identifier = "ImageInsertionCell"
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupImage(imageInsertion: ImageInsertion) {
        imageInsertionCell.image = imageInsertion.image
    }
}
