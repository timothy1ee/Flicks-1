//
//  NowPlayingViewController.swift
//  Flicks
//
//  Created by James Zhou on 10/11/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    
    var errorMsgLabel = UILabel()
    
    var movies: [NSDictionary]?
    
    var endpoint: String?
    
    var movieSearchBar: UISearchBar?
    
    var filteredMovies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIConstants.primaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: .valueChanged)
        self.movieTableView.insertSubview(refreshControl, at: 0)
        
        self.movieTableView.addSubview(self.errorMsgLabel)
        self.errorMsgLabel.backgroundColor = UIConstants.errorRed
        self.errorMsgLabel.textColor = UIColor.white
        
        self.errorMsgLabel.textAlignment = .center
        self.errorMsgLabel.frame = CGRect(x: 0, y: -40, width: 414, height: 40)
        self.errorMsgLabel.text = "Network Error"
        self.errorMsgLabel.isHidden = true
        
        // Do any additional setup after loading the view.
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        self.movieSearchBar = UISearchBar()
        self.movieSearchBar?.sizeToFit()
        self.navigationItem.titleView = self.movieSearchBar
        self.movieSearchBar?.delegate = self
        self.movieSearchBar?.tintColor = UIConstants.primaryColor
                
        refresh { (result) in
            if (result) {
                self.filteredMovies = self.movies
                self.movieTableView.reloadData()
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        refresh { (result) in
            refreshControl.endRefreshing()
            if (result) {
                self.movieTableView.reloadData()
            }
        }
    }
    
    func refresh(handler: @escaping (Bool) -> ()) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkUtil.getMovies(endpoint: endpoint!, successHandler: { (task, responseObject) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            let responseDict = responseObject as! NSDictionary
            self.movies = responseDict["results"] as? [NSDictionary]
            handler(true)
            
        }) { (task, error) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            UIView.animate(withDuration: 1.0, animations: {
                self.errorMsgLabel.isHidden = false
                self.errorMsgLabel.frame = CGRect(x: 0, y: 0, width: 414, height: 40)
                }, completion: { (finished) in
                    UIView.animate(withDuration: 0.5, delay: 2, options: [], animations: {
                        self.errorMsgLabel.frame = CGRect(x: 0, y: -40, width: 414, height: 40)
                        }, completion: {(finished) in
                            self.errorMsgLabel.isHidden = true
                            handler(false)
                    })
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredMovies = self.filteredMovies {
            return filteredMovies.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.backgroundColor = UIConstants.primaryColor
        
        let movie = self.filteredMovies![indexPath.row]
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        if let posterPath = movie["poster_path"] as? String {
            let imageURL_low = URL(string: "\(NetworkUtil.poster_base_url_low_res)\(posterPath)")
            let imageURLRequest_low = URLRequest(url: imageURL_low!)
            let imageURL_high = URL(string: "\(NetworkUtil.poster_base_url_high_res)\(posterPath)")
            let imageURLRequest_high = URLRequest(url: imageURL_high!)

            
            cell.posterImage.setImageWith(imageURLRequest_low, placeholderImage: nil, success: { (lowResImageRequest, lowResImageResponse, lowResImage) in
                
                cell.posterImage.alpha = 0.0
                cell.posterImage.image = lowResImage
                print("setting low res image")
                
                UIView.animate(withDuration: 1.0, animations: { 
                    cell.posterImage.alpha = 1.0
                    }, completion: { (success) in
                        
                        cell.posterImage.setImageWith(imageURLRequest_high, placeholderImage: nil, success: { (highResImageRequest, highResImageResponse, highResImage) in
                            
                            cell.posterImage.image = highResImage
                            print("setting high res image")
                            
                            }, failure: { (request, response, error) in
                                // error handling
                        })
                })
                
                }, failure: { (request, response, error) in
                    // error handling
            })
            
            
            
            
            
            
            
        } else {
            cell.posterImage.image = nil
        }

        cell.titleLabel.text = title
        cell.titleLabel.textColor = UIConstants.secondaryColor
        cell.overviewLabel.text = overview
        cell.overviewLabel.textColor = UIConstants.secondaryColor
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            self.filteredMovies = self.movies
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            
            self.filteredMovies = self.movies?.filter({ (movie: NSDictionary) -> Bool in
                
                let movieTitle = movie["title"] as! String
                if movieTitle.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        self.movieTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        self.movieSearchBar?.resignFirstResponder()
        
        let cell = sender as! UITableViewCell
        let indexPath = self.movieTableView.indexPath(for: cell)
        let movie = self.movies![indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
    }
    

}
