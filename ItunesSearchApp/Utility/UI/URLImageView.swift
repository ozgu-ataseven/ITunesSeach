//
//  URLImageView.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 8.05.2022.
//

import UIKit

public final class URLImageView: UIImageView {
    
    // MARK: - Variables
    private var imageTask: URLSessionTask?
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - public methods
    public func imageWithURL(_ url: String?, placeHolder: UIImage?) {
        guard let url = url,
              let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                  image = placeHolder
                  return
              }
        
        imageTask?.cancel()
        imageTask = nil
        image = placeHolder
        
        imageTask = ImageManager.shared.get(with: urlString, completion: { result in
            switch result {
            case .value(let data):
                guard let downloadedImage = UIImage(data: data) else {
                    return
                }
                
                self.image = downloadedImage
            default:
                print("Image URL: \(url) can not load")
            }
        })
        
        imageTask?.resume()
    }
}
