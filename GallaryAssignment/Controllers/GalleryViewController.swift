import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
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
        galleryTableView.register(UINib(nibName: ImageInsertionCell.identifier, bundle: nil), forCellReuseIdentifier: ImageInsertionCell.identifier)
        galleryTableView.delegate = self
        galleryTableView.dataSource = self
    }
    
    private func bindingGalleryViewModel() {
        galleryViewModel = GalleryViewModel(galleryService: GalleryService())
        galleryViewModel.bindGalleryDataViewModelToController = {
            self.setupGalleryData()
        }
        galleryViewModel.bindErrorController = {
            self.setupAlertError(error: self.galleryViewModel.errorModel)
        }
    }
    
    private func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        galleryTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        bindingGalleryViewModel()
    }
    
    private func setupGalleryData() {
        DispatchQueue.main.async {
            self.galleryTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupAlertError(error: ErrorModel?) {
        let alert = UIAlertController(title: error?.title ?? "", message: error?.message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension GalleryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryViewModel.galleryModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = galleryViewModel.galleryModel?[indexPath.row] else { return UITableViewCell() }
        
        guard let galleryCell = tableView.dequeueReusableCell(withIdentifier: GalleryCell.identifier) as? GalleryCell else {
            return UITableViewCell()
        }
        
        guard let imageInsertionCell = tableView.dequeueReusableCell(withIdentifier: ImageInsertionCell.identifier) as? ImageInsertionCell else {
            return UITableViewCell()
        }
        
        if item is Gallery {
            galleryCell.setupContent(gallery: item as! Gallery)
            return galleryCell
        }
        if item is ImageInsertion {
            imageInsertionCell.setupImage(imageInsertion: item as! ImageInsertion)
            return imageInsertionCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isLastPage = indexPath.row == galleryViewModel.loadMoreGallery.totalPage
        
        if (indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex) && !isLastPage {
            self.galleryTableView.tableFooterView = createBottomIndicator(tableView: tableView)
            self.galleryTableView.tableFooterView?.isHidden = false
            self.galleryViewModel.callGalleryService()
        }
    }
    
    private func createBottomIndicator(tableView: UITableView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        return spinner
    }
}
