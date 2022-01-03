//
//  ViewController2.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var MovieCollection: UICollectionView!
    
    var movie = [Movies]()
    var message:Categories?

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieCollection.dataSource = self
        MovieCollection.delegate = self
        
        if let temp = message?.kategori_ad {
            navigationItem.title = temp
        }
        
       
        
        let design  = UICollectionViewFlowLayout()
        let width = self.MovieCollection.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 5
        design.minimumLineSpacing = 5
        let h = (width-25)/2
        design.itemSize = CGSize(width: h, height: h*1.80)
        MovieCollection.collectionViewLayout = design
        
        if let temp = message?.kategori_id {
            movie = Filmlerdao().GetAllTheMovies(kategori_id: temp)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController3
            goingVC.message = movie[temp]
        }
    }
    

    

}

extension ViewController2:UICollectionViewDelegate,UICollectionViewDataSource,ProtokolCell {
    func AddButton(indexPath: IndexPath) {
        print("added : \(movie[indexPath.row].film_ad!)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coming = movie[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! CollectionViewCell
        cell.MovieImage.image = UIImage(named: coming.film_resim!)
        cell.NameLabel.text = coming.film_ad
        cell.PriceLabel.text = "\(12.90)"
        cell.proto = self
        cell.index = indexPath
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "2To3", sender: indexPath.row)
    }
    
}
