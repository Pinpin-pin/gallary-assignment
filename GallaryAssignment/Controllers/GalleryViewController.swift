import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<String, Gallery>!
    private var galleryViewModel : GalleryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindingGalleryUI()
    }
    
    private func setupTableView() {
        galleryTableView.register(UINib(nibName: GallaryCell.identifier, bundle: nil), forCellReuseIdentifier: GallaryCell.identifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: galleryTableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GallaryCell.identifier) as? GallaryCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = item.name
            cell.descriptionLabel.text = item.description
            cell.likeCountLabel.text = String(item.positiveVotesCount ?? 0)
            return cell
        })
    }
    
    private func bindingGalleryUI() {
        galleryViewModel = GalleryViewModel()
        galleryViewModel.bindGalleryDataViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<String, Gallery>()
        snapShot.appendSections([""])
        snapShot.appendItems(galleryViewModel.galleryModel)
        dataSource.apply(snapShot)
    }
    
    
}


