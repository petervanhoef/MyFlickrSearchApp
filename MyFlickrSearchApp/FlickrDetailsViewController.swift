//
//  FlickrDetailsViewController.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import UIKit

class FlickrDetailsViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL? {
        didSet {
            print("image url is set")
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    fileprivate func fetchImage() {
        print("fetching image")
        if let url = imageURL {
            print("fetching \(imageURL?.absoluteString)")
            spinner?.startAnimating()
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.image = UIImage(data: imageData)
                        } else {
                            self.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    // MARK: - Image handling
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
