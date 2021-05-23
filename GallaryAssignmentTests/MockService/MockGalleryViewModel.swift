import Foundation
@testable import GallaryAssignment


class MockGalleryViewModel: NSObject, GalleryViewModelProtocol {
    
    
    var loadMoreGallery: LoadMoreGallery = LoadMoreGallery()
    
    var countCallGallery = 0
    required init(galleryService: GalleryServiceProtocol) {
    }
    
    var galleryModel: Array<Gallery>?
    
    var bindGalleryDataViewModelToController: (() -> ()) = {}
    
    var errorModel: ErrorModel?
    
    var bindErrorController: (() -> ()) = {}
    
    func callGalleryService() {
        countCallGallery += 1
    }
    
    
}
