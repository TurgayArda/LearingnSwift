//
//  ViewController3.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var MovieYear: UILabel!
    @IBOutlet weak var MovieTour: UILabel!
    @IBOutlet weak var MovieDirector: UILabel!
    
    var message:Movies?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let name = message?.film_ad , let year = message?.film_yil , let  type = message?.kategori?.kategori_ad , let director = message?.yonetmen?.yonetmen_ad , let image = message?.film_resim {
            MovieImage.image = UIImage(named: image)
            MovieName.text = name
            MovieYear.text = "\(year)"
            MovieTour.text = type
            MovieDirector.text = director
            navigationItem.title = name
        }

       
    }
    

   

}
