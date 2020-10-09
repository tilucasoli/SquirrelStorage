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
    var productQuantity = 0
    
    var categories = [Category]()
    var categoryPicker = UIPickerView()
    var categoryPickerText = UILabel()
    var categoryPicked: String = "Categoria"
    var responder: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(didSaveButtonTapped))
        
        view.backgroundColor = .background
        navigationController?.navigationBar.backgroundColor = .background
        title = "Adicionar Produto"
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        configureTableView()
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            guard let frame = responder?.frame else {return}
            let point = tableView.convert(frame, to: responder?.superview).origin.y * -1
            if self.view.frame.origin.y == 0 && point > keyboardSize.height {
                self.tableView.contentOffset = CGPoint(x: self.tableView.frame.origin.x, y: keyboardSize.height + 80)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.tableView.contentOffset = .zero
        }
    }
    
    @objc func didSaveButtonTapped() {
        let product = getProduct()
        EstoqueViewController.productList.append(product)
        EstoqueViewController.showedProductList = EstoqueViewController.productList
        navigationController?.popViewController(animated: true)
    }
    
    func getProduct() -> Product {
        let product = Product(name: "", imageFilename: "", quantity: 0, favorited: false, costPrice: 0, sellPrice: 0, description: "", category: "")
        if let image = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageTableViewCell).productImageButton.imageView?.image {
            let filename = ImageFetcher().saveImage(image: image)
            product.imageFilename = filename
        }
        if let name = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! NameTableViewCell).productNameTextField.text {
            // If it is empty, I put one space in order to not modify the interface
            if name == "" {
                product.name = "Desconhecido"
            } else {
                product.name = name
            }
        }
        let categoryName = categories[(tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! CategoryTableViewCell).categoryPicker.selectedRow(inComponent: 0)].name
        if categoryName == "" {
            product.category = " "
        } else {
            product.category = categoryName
        }
        if let price = (tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! PriceTableViewCell).productPriceTextField.text {
            product.costPrice = Decimal(string: price) ?? 0
        }
        if let sellPrice = (tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! SellPriceTableViewCell).productSellPriceTextField.text {
            product.sellPrice = Decimal(string: sellPrice) ?? 0
        }
        if let quantity = (tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! QuantityTableViewCell).productQuantityTextField.text {
            product.quantity = Int(quantity) ?? 0
        }
        if let description = (tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! DescriptionTableViewCell).productDescriptionTextField.text {
            product.description = description
        }
        return product
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.separatorStyle = .none
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "AddProductImage")
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "AddProductName")
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "AddProductCategory")
        tableView.register(PriceTableViewCell.self, forCellReuseIdentifier: "AddProductPrice")
        tableView.register(SellPriceTableViewCell.self, forCellReuseIdentifier: "AddProductSellPrice")
        tableView.register(QuantityTableViewCell.self, forCellReuseIdentifier: "AddProductQuantity")
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "AddProductDescription")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.allowsSelection = false
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureCategory() {
        categories.append(Category(name: "Eletrônicos"))
        categories.append(Category(name: "Acessórios"))
        categories.append(Category(name: "Roupas"))
        categories.append(Category(name: "Papelaria"))
        categories.append(Category(name: "Outros"))
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductImage", for: indexPath) as! ImageTableViewCell
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            cell.delegate = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductName", for: indexPath) as! NameTableViewCell
            cell.productNameTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductCategory", for: indexPath) as! CategoryTableViewCell
            cell.productCategoryTextField.delegate = self
            cell.backgroundColor = .background
            cell.categoryPicker.delegate = self
            cell.categoryPicker.dataSource = self
            configureCategory()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductPrice", for: indexPath) as! PriceTableViewCell
            cell.productPriceTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductSellPrice", for: indexPath) as! SellPriceTableViewCell
            cell.productSellPriceTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductQuantity", for: indexPath) as! QuantityTableViewCell
            cell.productQuantityTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductDescription", for: indexPath) as! DescriptionTableViewCell
            cell.productDescriptionTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        default:
            print("Deu erro ao carregar célula")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 2:
            return 250
        default:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.canBecomeFirstResponder != nil {
                cell?.becomeFirstResponder()
        }
    }
}

extension AddProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        responder = textField
    }
}

extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var titleData = ""
        titleData = "\(categories[row].name)"
        pickerLabel.text = titleData
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        24
    }
}

extension AddProductViewController: QuantityAddProductDelegate {
    
    func increaseQuantity(label: UILabel) {
        productQuantity += 1
        label.text = "\(productQuantity)"
    }
    
    func decreaseQuantity(label: UILabel) {
        if productQuantity > 0 {
            productQuantity -= 1
        }
        label.text = "\(productQuantity)"
    }
}

extension AddProductViewController: imagePickerDelegate {
    func presentImagePicker(imgPickerController: UIImagePickerController) {
        present(imgPickerController, animated: true, completion: nil)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
