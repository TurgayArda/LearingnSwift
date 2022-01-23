//
//  RickyCell.swift
//  ProgrammaticTable
//
//  Created by ArdaSisli on 21.01.2022.
//

import UIKit
import SnapKit
import AlamofireImage

class RickyCell: UITableViewCell {

    private let Name: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    private let image: UIImageView = UIImageView()
    
    enum Identifier: String {
        case Path = "Cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        detail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(image)
        addSubview(Name)
        addSubview(customDescription)
        makeImage()
        makeName()
        makeCustomDescription()
    }
    
    func detail() {
        Name.textColor = .purple
        Name.font = .boldSystemFont(ofSize: 18)
        customDescription.textColor = .black
        customDescription.font = .boldSystemFont(ofSize: 16)
    }
}

extension RickyCell {
    func saveModel(value: Result) {
        Name.text = value.name
        customDescription.text = value.status
        if let temp = value.image {
            image.af.setImage(withURL: URL(string: temp)!)
        }
    }
}

extension RickyCell {
    func makeImage() {
        image.snp.makeConstraints { make in
                make
                .top
                .equalTo(contentView)
                .offset(5)
            
                make
                .height
                .equalTo(120)
            
                make
                .width
                .equalTo(170)
            
            make
                .left
                .equalTo(contentView.snp.left)
                .offset(5)
        }
    }
    
    func makeName() {
        Name.snp.makeConstraints { (make) in
            make
                .left
                .equalTo(contentView)
                .offset(20)
            
            make
                .top
                .equalTo(image.snp.bottom)
                .offset(10)
        }
    }
    
    func makeCustomDescription() {
        customDescription.snp.makeConstraints { make in
            make
                .left
                .equalTo(contentView)
                .offset(20)
            
            make
                .top
                .equalTo(Name.snp.bottom)
                .offset(10)
        }
    }
}


 
