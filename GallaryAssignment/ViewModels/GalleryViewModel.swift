import Foundation

class GalleryViewModel: NSObject, GalleryViewModelProtocol {
    
    private(set) var galleryService: GalleryServiceProtocol!
    private(set) var loadMoreGallery: LoadMoreGallery = LoadMoreGallery()
    private(set) var galleryModel : Array<GalleryItem>? {
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
    
    private func getLastOffetImageInsertion() -> Int {
        var offset = 0
        let galleryModelCount = galleryModel?.count ?? 0
        if galleryModelCount > 0 {
            offset = (galleryModelCount - 1) - (galleryModel?.lastIndex(where: { $0 is ImageInsertion}) ?? 0)
        }
        return offset
    }
    
    func callGalleryService() {
        guard loadMoreGallery.currentPage <= loadMoreGallery.totalPage else {
            return
        }
        galleryService.getGalleryData(feature: GalleryFeature.popular.rawValue, page: loadMoreGallery.currentPage + 1) { galleryList in
            
            let offset = self.getLastOffetImageInsertion()
            let galleryPhotos = galleryList.photos ?? []
            
            let photos: Array<GalleryItem> = GalleryModel().toModel(galleryPhotos: galleryPhotos, offset: offset)
            
            self.setGalleryModel(galleryPhotos: photos)
            self.loadMoreGallery = LoadMoreGallery(currentPage: galleryList.currentPage ?? 0,
                                                   totalPage: galleryList.totalPage ?? 0)
        } onError: {
            let errMsg = ErrorModel(title: "Sorry", message: "Internal server error, please try again later")
            self.errorModel = errMsg
        }
    }
    
    private func setGalleryModel(galleryPhotos: Array<GalleryItem>) {
        if galleryModel == nil {
            galleryModel = galleryPhotos
        } else {
            galleryModel?.append(contentsOf: galleryPhotos)
        }
    }
}
