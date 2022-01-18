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
        
        if let N = message?.film_ad , let Y = message?.film_yil , let I = message?.film_resim , let T = message?.kategori?.kategori_ad
            , let D = message?.yonetmen?.yonetmen_ad {
            MovieImage.image = UIImage(named: I)
            MovieName.text = N
            MovieYear.text = Y
            MovieDirector.text = D
            MovieTour.text = T
            
            navigationItem.title = N
        }

       
    }
    

   

}
