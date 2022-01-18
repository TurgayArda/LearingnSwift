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
    
        let design  = UICollectionViewFlowLayout()
        let width = self.MovieCollection.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 5
        design.minimumLineSpacing = 5
        let h = (width-25)/2
        design.itemSize = CGSize(width: h, height: h*1.80)
        MovieCollection.collectionViewLayout = design
        
        if let T = message?.kategori_ad {
            navigationItem.title = "\(T)"
        }
        if let K = message?.kategori_id {
            if let OK = Int(K) {
                AllTheMovies(kategori_id:OK)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController3
                goingVC.message = movie[temp]
        }
    }
    
    func AllTheMovies(kategori_id:Int) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php")!)
        request.httpMethod = "POST"
        let postString = "kategori_id=\(kategori_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                let answer = try JSONDecoder().decode(Cod.self, from: data!)
                if let coming = answer.filmler {
                    self.movie = coming
                }
                DispatchQueue.main.async {
                    self.MovieCollection.reloadData()
                }
            
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
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
       
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(coming.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)

                DispatchQueue.main.async {
                    cell.MovieImage.image = UIImage(data: data!)
                }
            }
        }
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
