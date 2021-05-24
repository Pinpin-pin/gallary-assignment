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
    
    func callGalleryService() {
        guard loadMoreGallery.currentPage <= loadMoreGallery.totalPage else {
            return
        }
        galleryService.getGalleryData(feature: GalleryFeature.popular.rawValue, page: loadMoreGallery.currentPage + 1) { galleryList in
            let galleryList = GalleryModel().toModel(galleryListResponse: galleryList)
            let aaa  = self.manageAddOrAppendGalleryResponse(galleryPhotos: galleryList?.photos ?? [])
            self.setGalleryModel(galleryPhotos: aaa)
            self.loadMoreGallery = LoadMoreGallery(currentPage: galleryList?.currentPage ?? 0,
                                                   totalPage: galleryList?.totalPage ?? 0)
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
    private func manageAddOrAppendGalleryResponse(galleryPhotos: Array<GalleryItem>) -> Array<GalleryItem> {
        var newItems: Array<GalleryItem> = []
        var offset = 0
        if (galleryModel?.count ?? 0 > 0) {
            offset = ((galleryModel?.count ?? 0) - 1) - (galleryModel?.lastIndex(where: { $0 is ImageInsertion}) ?? 0)
        }
        
        for (index, item) in galleryPhotos.enumerated() {
            if ((index + offset) % 4 == 0 && index + offset != 0) {
                newItems.append(ImageInsertion())
            }
            newItems.append(item)
        }
        
        return newItems
    }
    
    private func insertAssignedItemBetweenModel(photos: Array<GalleryItem>) {
        photos.forEach { item in
            let imageInsertion = ImageInsertion()
            if (galleryModel?.count ?? 0 % 4 == 0 && galleryModel?.count != 0){
                galleryModel?.append(imageInsertion)
            }
            
            galleryModel?.append(item)
        }
    }
    
}
