import Foundation

struct GalleryModel {
    func toModel(galleryListResponse: GalleryListResponse) -> GalleryList? {
        guard let gallery = galleryListResponse.photos?.map({ item in
            Gallery(id: item.id,
                    name: item.name,
                    positiveVotesCount: item.positiveVotesCount,
                    description: item.description,
                    imageUrl: item.images?.first?.url)
        }) else { return nil }
        return GalleryList(currentPage: galleryListResponse.currentPage,
                           totalPage: galleryListResponse.totalPage,
                           photos: gallery)
    }
}

struct GalleryList {
    let currentPage: Int?
    let totalPage: Int?
    let photos: Array<Gallery>
    
    
}

struct Gallery: Hashable {
    let id: Int?
    let name: String?
    let positiveVotesCount: Int?
    let description: String?
    let imageUrl: String?
}
