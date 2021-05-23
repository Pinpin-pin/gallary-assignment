import Foundation

class GalleryViewModel: NSObject, GalleryViewModelProtocol {
    private var galleryService: GalleryServiceProtocol!
    
    var galleryModel : Array<Gallery>? {
        didSet {
            self.bindGalleryDataViewModelToController()
        }
    }
    
    var errorModel: ErrorModel? {
        didSet {
            self.bindErrorController()
        }
    }
    
    var bindGalleryDataViewModelToController: (() -> ()) = {}
    var bindErrorController: (() -> ()) = {}
    
    required init(galleryService: GalleryServiceProtocol) {
        super.init()
        self.galleryService =  galleryService
        callGalleryService()
    }
    
    private func callGalleryService() {
        galleryService.getGalleryData(feature: GalleryFeature.popular.rawValue, page: 1) { galleryList in
            let galleryList = GalleryModel().toModel(galleryListResponse: galleryList)
            self.galleryModel = galleryList?.photos ?? nil
        } onError: {
            let errMsg = ErrorModel(title: "Sorry", message: "Internal server error, please try again later")
            self.errorModel = errMsg
        }
    }
    
}
