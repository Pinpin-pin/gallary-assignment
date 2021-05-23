import UIKit

class GalleryCell: UITableViewCell {

    @IBOutlet weak var gallaryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    static let identifier = "GalleryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupImageLayer() {
        gallaryImageView.layer.cornerRadius = 4
    }
    
    func setupContent(gallery: Gallery) {
        titleLabel.text = gallery.name
        descriptionLabel.attributedText = gallery.description?.htmlToAttributedString()
        likeCountLabel.text = String(gallery.positiveVotesCount ?? 0).toCurrencyFormat()
        gallaryImageView.imageFromURL(urlString: gallery.imageUrl ?? "")
        gallaryImageView.contentMode = .scaleAspectFill
    }
}
