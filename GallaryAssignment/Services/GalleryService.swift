import Foundation

class GalleryService :  NSObject {
    
    private let sourcesURL = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=1")!
    
    func getGalleryData(completion : @escaping (GalleryListResponse) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let gallery = try! jsonDecoder.decode(GalleryListResponse.self, from: data)
                    completion(gallery)
            }
        }.resume()
    }
}
