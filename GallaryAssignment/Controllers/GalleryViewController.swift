import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<String, Gallery>!
    private var galleryViewModel : GalleryViewModel!
        
    private var list = [Gallery(id: 1, name: "aaaaaa", positiveVotesCount: 222, description: "aasdfdsfdasfdsafsadfadasfsadfdsfsad", imageUrl: "https://drscdn.500px.org/photo/1032448443/q%3D50_h%3D450/v2?sig=da6b45717cb13b59d69c8e65ed05640f82f9e544d91aadb7fe1f44e9050ac5eb"),
        Gallery(id: 2, name: "aaaaaa", positiveVotesCount: 222, description: "aasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsadaasdfdsfdasfdsafsadfadasfsadfdsfsad", imageUrl: "https://drscdn.500px.org/photo/1032448443/q%3D50_h%3D450/v2?sig=da6b45717cb13b59d69c8e65ed05640f82f9e544d91aadb7fe1f44e9050ac5eb"),
        Gallery(id: 3, name: "aaaaaa", positiveVotesCount: 222, description: "aasdfdsfdasfdsafsadfadasfsadfdsfsad", imageUrl: "https://drscdn.500px.org/photo/1032448443/q%3D50_h%3D450/v2?sig=da6b45717cb13b59d69c8e65ed05640f82f9e544d91aadb7fe1f44e9050ac5eb")]
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


