//
//  FlickrTableViewController.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import UIKit

class FlickrTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Model
    
    // Our model: an array of an array of pictures - Why? To be able to fetch data per section.
    var photosModel = [Array<FlickrPhoto>]() {
        didSet {
            tableView.reloadData() // if model is set, we need to display it (i.e. fill the table view)
        }
    }

    var searchText: String? { // also part of the model
        didSet {
            photosModel.removeAll()
            search(forText: searchText!, section: 1)
            title = searchText
        }
    }
    
    @IBOutlet var flickrTableView: UITableView!
    
    // MARK: - Search
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.text = searchText
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text
    }
    
    fileprivate var activeRequest = false
    
    /*public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = nil
    }*/
    
    // MARK: - Storyboard
    
    private struct Storyboard {
        static let ShowDetailsSegue = "Show Details"
        static let FlickrTableViewCellIdentifier = "FlickrTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        photosModel.removeAll()
        title = "Search again"
    }

    fileprivate func search(forText textToSearch: String, section: Int) {
        if !activeRequest {
            print("searching for \(textToSearch)")
            activeRequest = true
            FlickrDataProvider.fetchPhotos(searchText: textToSearch, section: section, onCompletion: { (error: NSError?, flickrPhotos: [FlickrPhoto]?) -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if error == nil {
                    print("appending pictures for section \(section)")
                    self.photosModel.append(flickrPhotos!)
                    self.activeRequest = false
                } else {
                    //self.photosModel[section] = []
                    if (error!.code == FlickrDataProvider.FlickrErrors.invalidAPIKey) {
                        DispatchQueue.main.async(execute: { () -> Void in
                            //self.showErrorAlert()
                        })
                    }
                    self.activeRequest = false
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.title = textToSearch//searchText
                    self.tableView.reloadData()
                })
            })
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return photosModel.count // Number of rows represents number of sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosModel[section].count // Number of pictures in a section
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Storyboard.FlickrTableViewCellIdentifier, for: indexPath as IndexPath)
        
        let flickrPhoto = photosModel[indexPath.section][indexPath.row]

        if let flickrCell = cell as? FlickrTableViewCell {
            flickrCell.flickrPhoto = flickrPhoto
        }
        
        //print("configure cell at [\(indexPath.section)][\(indexPath.row)]")
     
        currentPage = indexPath.section + 1
     
        return cell
    }

    fileprivate var currentPage = 0
    fileprivate var lastPage: Int {
        return photosModel.count
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height
        
        if currentOffset > maximumOffset - scrollView.frame.size.height {
            if currentPage == lastPage {
                if searchText != nil {
                    search(forText: searchText!, section: currentPage + 1)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Storyboard.ShowDetailsSegue { // check identifier first
            if let fdvc = segue.destination as? FlickrDetailsViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Possible improvement: pass one FlickrPhoto object to the FlickrDetailsViewController
                    fdvc.imageURL = photosModel[selectedIndexPath.section][selectedIndexPath.row].photoLargeUrl
                    fdvc.title = photosModel[selectedIndexPath.section][selectedIndexPath.row].title
                }
            }
        }
    }
}
