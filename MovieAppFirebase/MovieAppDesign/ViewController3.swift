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

        if let N = message?.film_ad , let Y = message?.film_yil , let D = message?.yonetmen_ad , let K = message?.kategori_ad , let asd = message?.film_resim {
            MovieName.text = N
            MovieTour.text = K
            MovieYear.text = "\(Y)"
            MovieDirector.text = D
            MovieImage.image = UIImage(named: asd)
            
            navigationItem.title = N
        }
       
    }
    

   

}
