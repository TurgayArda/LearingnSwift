//
//  RickyVC.swift
//  ProgrammaticTable
//
//  Created by ArdaSisli on 21.01.2022.
//

import UIKit
import SnapKit

class RickyVC: UIViewController {
    
    private let tableview: UITableView = UITableView()
    private let label: UILabel = UILabel()
    private var tableDelegate: TableViewDelegate = TableViewDelegate()
    private var rickyService: IRickyService = RickyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        initservice()
    }
    
    private func initDelegate() {
        tableview.register(RickyCell.self, forCellReuseIdentifier: RickyCell.Identifier.Path.rawValue)
        tableview.delegate = tableDelegate
        tableview.dataSource = tableDelegate
        configure()
        edit()
        tableDelegate.rProtocol = self
    }
    
    private func initservice() {
        rickyService.fetchAllData { (data) in
            guard let value = data else { return }
            self.tableDelegate.saveData(value: value)
            self.tableview.reloadData()
        }
    }
    
    private func configure() {
        view.addSubview(label)
        view.addSubview(tableview)
        makeLabel()
        makeTable()
    }
    
     private func edit() {
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        view.backgroundColor = .white
        label.text = Costant.RickyConstant.labelName
        tableview.rowHeight = 190
    }
}

extension RickyVC: IRickyDelegate {
    func select(item: Result) {
        print(item.name ?? "")
    }
}

extension RickyVC {
   private func makeLabel() {
        label.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(5)
            
            make
                .left
                .equalTo(view.safeAreaLayoutGuide)
                .offset(130)
        }
    }
    
   private func makeTable() {
        tableview.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(10)
            
            make
                .left
                .equalTo(view)
                .offset(0)
            
            make
                .right
                .equalTo(view)
                .offset(0)
            
            make
                .bottom
                .equalTo(view)
                .offset(0)
        }
    }
}
