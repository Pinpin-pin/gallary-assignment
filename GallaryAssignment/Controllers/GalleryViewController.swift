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
        galleryTableView.register(UINib(nibName: GalleryCell.identifier, bundle: nil), forCellReuseIdentifier: GalleryCell.identifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: galleryTableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GalleryCell.identifier) as? GalleryCell else {
                return UITableViewCell()
            }
            cell.setupContent(gallery: item)
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


