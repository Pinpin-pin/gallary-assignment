import Foundation

protocol GalleryViewModelProtocol {
    init(galleryService: GalleryServiceProtocol)
    var galleryModel : Array<Gallery>? { get }
    var bindGalleryDataViewModelToController : (() -> ()) { get }
    var errorModel: ErrorModel? { get }
    var bindErrorController: (() -> ()) { get }
}
