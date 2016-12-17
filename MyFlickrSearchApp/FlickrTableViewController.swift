//
//  FlickrTableViewController.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import UIKit

class FlickrTableViewController: UITableViewController {

    // MARK: - Model
    
    // Our model: an array of an array of pictures - Why? To be able to fetch data per section.
    var photosModel = [Array<FlickrPhoto>]() {
        didSet {
            tableView.reloadData() // if model is set, we need to display it (i.e. fill the table view)
        }
    }

    var searchText: String? { // also part of the model
        didSet {
            //photos.removeAll()
            photosModel.removeAll()
            search(forText: searchText!, section: 1)
            title = searchText
        }
    }
    
    @IBOutlet var flickrTableView: UITableView!
    
    // MARK: - Storyboard
    
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
        static let FlickrCellIdentifier = "FlickrTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchText = "snowboarding"
        flickrTableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func search(forText textToSearch: String, section: Int) {
        print("searching for \(textToSearch)")
        FlickrProvider.fetchPhotosForSearchText(searchText: textToSearch, section: section, onCompletion: { (error: NSError?, flickrPhotos: [FlickrPhoto]?) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                self.photosModel.append(flickrPhotos!)
            } else {
                //self.photosModel[section] = []
                if (error!.code == FlickrProvider.Errors.invalidAccessErrorCode) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        //self.showErrorAlert()
                    })
                }
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = textToSearch//searchText
                self.tableView.reloadData()
            })
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return photosModel.count // Number of rows represents number of sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosModel[section].count // Number of pictures in a section
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResultCellIdentifier = "FlickrTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: searchResultCellIdentifier, for: indexPath as IndexPath) //as? FlickrTableViewCell //SearchResultCell
        
        //cell!.setupWithPhoto(flickrPhoto: photosModel[indexPath.section][indexPath.row])
     
        print("configure cell at [\(indexPath.section)][\(indexPath.row)]")
        cell.textLabel?.text = photosModel[indexPath.section][indexPath.row].title
     
        //currentPage = indexPath.section + 1
     
        return cell
     }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
