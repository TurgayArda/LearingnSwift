//
//  ViewController2.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit
import Firebase

class ViewController2: UIViewController {
    
    @IBOutlet weak var MovieCollection: UICollectionView!
    
    var movie = [Movies]()
    var message:Categories?
    var ref:DatabaseReference!
    private let movieCellId = "MovieCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieCollection.dataSource = self
        MovieCollection.delegate = self
        
        ref = Database.database().reference()
        
        let design  = UICollectionViewFlowLayout()
        let width = self.MovieCollection.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 5
        design.minimumLineSpacing = 5
        let h = (width-25)/2
        design.itemSize = CGSize(width: h, height: h*1.90)
        MovieCollection.collectionViewLayout = design
        
        if let N = message?.kategori_ad {
            
            navigationItem.title = "\(N)"
            
            AllTheMovies(kategori_ad: N)
        }
        
    
    }
    
    func setUpMovieDict(temp: NSDictionary, key: String) -> Movies {
        let key = key
        let name = temp[Constant.MovieConstant.filmAd] as? String ?? ""
        let year = temp[Constant.MovieConstant.filmyil] as? Int ?? 0
        let kategori = temp[Constant.MovieConstant.KategoriAd] as? String ?? ""
        let yonetmen = temp[Constant.MovieConstant.yonetmenAd] as? String ?? ""
        let film_resim = temp[Constant.MovieConstant.filmResim] as? String ?? ""
        let m1 = Movies(
            yonetmen_ad: yonetmen,
            kategori_ad: kategori,
            film_id: key,
            film_ad: name,
            film_yil: year,
            film_resim: film_resim
        )
        return m1
    }
    
    func AllTheMovies(kategori_ad:String) {
        let query = ref.child("filmler").queryOrdered(byChild: "kategori_ad").queryEqual(toValue: kategori_ad)
            query.observe(.value, with: {
            (snapshot) in
            if let comingData = snapshot.value as? [String:AnyObject] {
                self.movie.removeAll()
                for comingLine in comingData {
                    if let temp = comingLine.value as? NSDictionary {
                        self.movie.append(
                            self.setUpMovieDict(
                                temp: temp,
                                key: comingLine.key
                            )
                        )
                    }
                }
            }
                DispatchQueue.main.async {
                    self.MovieCollection.reloadData()
                }
        })
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! CollectionViewCell
        
        if let i = coming.film_resim {
            
            if let url = URL(
                string: Constant.NetworkConstant.createMovieImage(id: i)
            ) {
               
            DispatchQueue.global().async {
                
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.MovieImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
        //cell.MovieImage.image = UIImage(named: coming.film_resim!)
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
