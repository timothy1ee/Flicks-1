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
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let title = movie["title"] as? String
        self.titleLabel.text = title
        
        let overview = movie["overview"] as? String
        self.overviewLabel.text = overview
        
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
