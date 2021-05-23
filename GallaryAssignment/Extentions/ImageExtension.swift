import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String) {
        let indicator = setupIndicatorView()
        
        if self.image == nil{
            self.addSubview(indicator)
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                indicator.removeFromSuperview()
                self.image = image
            })

        }).resume()
    }
    
    private func setupIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        return activityIndicator
    }
}
