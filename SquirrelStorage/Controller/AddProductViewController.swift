//
//  AddProductViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: nil)
        view.backgroundColor = .background
        title = "Adicionar Produto"
        navigationItem.largeTitleDisplayMode = .never
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.separatorStyle = .none
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "AddProductImage")
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "AddProductName")
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "AddProductCategory")
        tableView.register(PriceTableViewCell.self, forCellReuseIdentifier: "AddProductPrice")
        tableView.register(QuantityTableViewCell.self, forCellReuseIdentifier: "AddProductQuantity")
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "AddProductDescription")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductImage", for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductName", for: indexPath)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductCategory", for: indexPath)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductPrice", for: indexPath)
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductQuantity", for: indexPath)
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddProductDescription", for: indexPath)

            
            
        default:
            print("error, cabo")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : 40
    }
}
