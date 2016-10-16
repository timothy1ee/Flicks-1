//
//  DetailViewController.swift
//  Flicks
//
//  Created by James Zhou on 10/13/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var infoView: UIView!
    
    
    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.infoView.frame.origin.y + self.infoView.frame.size.height + tabBarHeight!)
        self.scrollView.bounces = true
        self.scrollView.showsVerticalScrollIndicator = false
        
        // Do any additional setup after loading the view.
        
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        let title = movie["title"] as? String
        self.titleLabel.text = title
        
        let overview = movie["overview"] as? String
        self.overviewLabel.text = overview
        self.overviewLabel.sizeToFit()
                
        let releaseDate = movie["release_date"] as! String
        let formattedDate = UIConstants.formatReleaseDate(releaseDate: releaseDate)
        self.releaseDateLabel.text = formattedDate
        self.releaseDateLabel.adjustsFontSizeToFitWidth = true
        
        if let posterPath = movie["poster_path"] as? String {
            let imageURL = URL(string: "\(NetworkUtil.poster_base_url)\(posterPath)")
            self.posterImageView.setImageWith(imageURL!)
        } else {
            self.posterImageView.image = nil
        }
        
        
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
