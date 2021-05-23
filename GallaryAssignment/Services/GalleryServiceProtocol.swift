import Foundation

protocol GalleryServiceProtocol {
    func getGalleryData(feature: String, page: Int,
                        onSuccess: @escaping (GalleryListResponse) -> Void,
                        onError: @escaping () -> Void)
}
