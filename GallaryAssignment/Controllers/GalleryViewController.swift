import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<String, Gallery>!
    private var galleryViewModel : GalleryViewModel!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindingGalleryViewModel()
        setupPullToRefresh()
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
    
    private func bindingGalleryViewModel() {
        galleryViewModel = GalleryViewModel(galleryService: GalleryService())
        galleryViewModel.bindGalleryDataViewModelToController = {
            self.updateDataSource()
            self.setupEndPullToRefresh()
        }
    }
    
    private func updateDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<String, Gallery>()
        snapShot.appendSections([""])
        guard let gallery = galleryViewModel.galleryModel else {
            return
        }
        snapShot.appendItems(gallery)
        dataSource.apply(snapShot)
    }
    
    private func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        galleryTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        bindingGalleryViewModel()
    }
    
    private func setupEndPullToRefresh() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}


