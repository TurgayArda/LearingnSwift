//
//  ViewController.swift
//  EditingCollecionView
//
//  Created by ArdaSisli on 26.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    var MovieView = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tasarim  = UICollectionViewFlowLayout()
        let genislik = self.CollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing  = 5
        let olcu = (genislik-25)/2
        tasarim.itemSize = CGSize(width: olcu, height: olcu*1.50)
        CollectionView.collectionViewLayout = tasarim
        
        let m1 = Movies(MovieName: "Birzamanlaranadoluda", MoviePrice: "18.90", MovieImageName: "birzamanlaranadoluda" )
        let m2 = Movies(MovieName: "Django", MoviePrice: "21.60", MovieImageName: "django")
        let m3 = Movies(MovieName: "Inception", MoviePrice: "14.50", MovieImageName: "inception")
        let m4 = Movies(MovieName: "Interstaller", MoviePrice: "32.00", MovieImageName: "interstellar")
        let m5 = Movies(MovieName: "Thepianist", MoviePrice: "11.20", MovieImageName: "thepianist")
        
        MovieView.append(m1)
        MovieView.append(m2)
        MovieView.append(m3)
        MovieView.append(m4)
        MovieView.append(m5)
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
    }
    
    
    


}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,CollectionCell {
    
    func ClickCell(indexPath: IndexPath) {
        let coming = MovieView[indexPath.row]
        print("\(coming.MovieName!)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coming = MovieView[indexPath.row]
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Collection
        cell.proto = self
        cell.index = indexPath
        if let temp = coming.MovieName {
            if let temp2 = coming.MoviePrice {
                if let temp3 = coming.MovieImageName {
        cell.Name.text = temp
        cell.Price.text = "\(temp2) TL"
        cell.Image.image = UIImage(named: temp3)
       
                }
            }
        }
        return cell
    }
}

