//
//  EstoqueViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class EstoqueViewController: UIViewController {
    
    var num = 0
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.register(EstoqueTableViewCell.self, forCellReuseIdentifier: "Estoque")
        tableView.register(ProdutosTableViewCell.self, forCellReuseIdentifier: "Produtos")
        tableView.allowsSelection = false
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
        setupTableView()
        
    }
    
    func setupNavController() {
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Estoque"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.largeTitle
        ]
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
extension EstoqueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Estoque", for: indexPath) as! EstoqueTableViewCell
            return cell
        }
        
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Produtos", for: indexPath) as! ProdutosTableViewCell
            cell2.contentView.isUserInteractionEnabled = false
            
            num = cell2.collectionView.numberOfItems(inSection: 0)
            return cell2
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfColums = 2
        let cellHeight = 222
        
        if num % numberOfColums == 0 {
            let result = (num/2) * cellHeight
            return CGFloat(indexPath.section == 0 ? 100 : result)
            
        } else {
            let result: Float = Float((Double(num/2)*222)+111)
            return CGFloat(indexPath.section == 0 ? 100 : result)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 71
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomSectionView()
        view.delegate = self
        return view
    }
}

extension EstoqueViewController: delegateFilter {
    func filterAction() {
        navigationController?.pushViewController(FiltroViewController(), animated: true )
    }
    
    
}
