//
//  FlickrTableViewCell.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 18/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import UIKit

class FlickrTableViewCell: UITableViewCell {

    @IBOutlet weak var flickrMiniatureImageView: UIImageView!
    @IBOutlet weak var flickrTitleLabel: UILabel!
    @IBOutlet weak var flickrMiniatureSpinner: UIActivityIndicatorView!
    
    var flickrPhoto: FlickrPhoto? {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        // reset any existing information
        flickrMiniatureImageView?.image = nil
        flickrTitleLabel?.text = nil
        
        // load new information if any
        if let flickrPhoto = self.flickrPhoto {
            flickrTitleLabel?.text = flickrPhoto.title
            
            flickrMiniatureSpinner?.startAnimating()
            fetchImage()
        }
    }
   
    fileprivate func fetchImage() {
        print("fetching image")
        if let url = flickrPhoto?.photoUrl {
            print("fetching \(url.absoluteString)")
            flickrMiniatureSpinner?.startAnimating()
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.flickrPhoto?.photoUrl {
                        if let imageData = contentsOfURL {
                            self.flickrMiniatureImageView?.image = UIImage(data: imageData)
                            self.flickrMiniatureSpinner?.stopAnimating()
                        } else {
                            self.flickrMiniatureSpinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
