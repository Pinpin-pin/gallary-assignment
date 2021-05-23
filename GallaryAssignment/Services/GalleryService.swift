import Foundation

class GalleryService : NSObject, GalleryServiceProtocol {
    private let host = "api.500px.com"
    internal enum Path {
      internal static let popular = "/v1/photos"
    }
    
    func getGalleryData(feature: String, page: Int,
                        onSuccess: @escaping (GalleryListResponse) -> Void,
                        onError: @escaping () -> Void){
        let queryItems: [URLQueryItem] = [.init(name: "feature", value: "popular"),
                                          .init(name: "page", value: String(page))]
        
        let request = getUrlRequest(path: Path.popular, queryItems: queryItems)
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let gallery = try! jsonDecoder.decode(GalleryListResponse.self, from: data)
                onSuccess(gallery)
            }
            if error != nil {
                onError()
            }
        }.resume()
    }
    
    private func getUrlRequest(path: String, queryItems: [URLQueryItem]) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        urlComponents.queryItems =  queryItems
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        return URLRequest(url: urlComponents.url!)
    }
}
