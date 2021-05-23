import Foundation

protocol GalleryViewModelProtocol {
    init(galleryService: GalleryServiceProtocol)
    
    var galleryModel : Array<Gallery>? { get }
    var loadMoreGallery: LoadMoreGallery  { get }
    
    var bindGalleryDataViewModelToController : (() -> ()) { get }
    var errorModel: ErrorModel? { get }
    var bindErrorController: (() -> ()) { get }
    
    func callGalleryService()
    
}
