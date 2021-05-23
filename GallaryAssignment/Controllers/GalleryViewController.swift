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
        galleryTableView.delegate = self
        galleryTableView.dataSource = self
    }
    
    private func bindingGalleryViewModel() {
        galleryViewModel = GalleryViewModel(galleryService: GalleryService())
        galleryViewModel.bindGalleryDataViewModelToController = {
            self.setupGalleryData()
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
}

extension GalleryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryViewModel.galleryModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GalleryCell.identifier) as? GalleryCell else {
            return UITableViewCell()
        }
        guard let item = galleryViewModel.galleryModel?[indexPath.row] else { return UITableViewCell() }
        cell.setupContent(gallery: item)
        return cell
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
