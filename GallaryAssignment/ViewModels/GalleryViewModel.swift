import Foundation

class GalleryViewModel : NSObject {
    
    private var galleryService : GalleryService!
    private(set) var galleryModel : Array<Gallery>! {
        didSet {
            self.bindGalleryDataViewModelToController()
        }
    }
    
    var bindGalleryDataViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.galleryService =  GalleryService()
        callGalleryService()
    }
    
    private func callGalleryService() {
        self.galleryService.getGalleryData { (response) in
            let galleryList = GalleryModel().toModel(galleryListResponse: response)
            self.galleryModel = galleryList?.photos
        }
    }
    
}
