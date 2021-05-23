import Foundation
@testable import GallaryAssignment

class MockGalleryViewModelFail: NSObject, GalleryViewModelProtocol {
    private var galleryService : MockGalleryService!
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
    override init() {
        super.init()
        self.galleryService =  MockGalleryService()
        callGalleryService()
    }
    
    private func callGalleryService() {
        galleryService.getGalleryServiceError(feature: "", page: 1, onSuccess: { resposne in
            self.galleryModel = GalleryModel().toModel(galleryListResponse: resposne)?.photos
        }, onError: {
            self.errorModel = ErrorModel(title: "Title", message: "Message")
        })
    }
}
