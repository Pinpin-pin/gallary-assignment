import Foundation
@testable import GallaryAssignment

class MockGalleryViewModel: NSObject, GalleryViewModelProtocol {
    private var galleryService : GalleryServiceProtocol!
    
    required init(galleryService: GalleryServiceProtocol) {
        super.init()
        self.galleryService =  galleryService
        callGalleryService()
    }
    
    var galleryModel: Array<Gallery>? {
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
    
    private func callGalleryService() {
        galleryService.getGalleryData(feature: "", page: 1) { response in
            self.galleryModel = GalleryModel().toModel(galleryListResponse: response)?.photos
        } onError: {
            self.errorModel = ErrorModel(title: "Title", message: "Message")
        }
    }
}
