import Foundation

class GalleryViewModel: NSObject, GalleryViewModelProtocol {
    
    private(set) var galleryService: GalleryServiceProtocol!

    private(set) var loadMoreGallery: LoadMoreGallery = LoadMoreGallery()
    
    private(set) var galleryModel : Array<Gallery>? {
        didSet {
            self.bindGalleryDataViewModelToController()
        }
    }
    
    private(set) var errorModel: ErrorModel? {
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
    
    func callGalleryService() {
        guard loadMoreGallery.currentPage <= loadMoreGallery.totalPage else {
            return
        }
        galleryService.getGalleryData(feature: GalleryFeature.popular.rawValue, page: loadMoreGallery.currentPage + 1) { galleryList in
            let galleryList = GalleryModel().toModel(galleryListResponse: galleryList)
            self.manageAddOrAppendGalleryResponse(galleryPhotos: galleryList?.photos ?? [])
            self.loadMoreGallery = LoadMoreGallery(currentPage: galleryList?.currentPage ?? 0,
                                                   totalPage: galleryList?.totalPage ?? 0)
        } onError: {
            let errMsg = ErrorModel(title: "Sorry", message: "Internal server error, please try again later")
            self.errorModel = errMsg
        }
    }
    
    private func manageAddOrAppendGalleryResponse(galleryPhotos: Array<Gallery>) {
        if (self.galleryModel?.count ?? 0 > 0) {
            self.galleryModel?.append(contentsOf: galleryPhotos)
        } else {
            self.galleryModel = galleryPhotos
        }
    }
    
}
