//
//  DashboardVC.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

class WorkVC: BaseVC {

    @IBOutlet weak private var searchView: UIView!
    @IBOutlet weak private var searchTF: UITextField!
    
    @IBOutlet weak private var premiumProductView: UIView! {
        didSet{
            UIView.animate(withDuration: 0.2) {
                self.premiumProductHeightConst.constant = (self.premiumProductView.isHidden) ? 0 : 182
            }
        }
    }
    
    @IBOutlet weak private var premiumProductHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var tableViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    private let viewModel = WorkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initilizeValue()
        dataObserver()
        
    }
}

extension WorkVC : UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIView.animate(withDuration: 0.2) {
            self.tableViewHeightConst.constant = CGFloat(190 * self.viewModel.data.count + 10)
        }
        
        return viewModel.data.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: JobsTvCell.identifier, for: indexPath) as! JobsTvCell
        
        let data = viewModel.data[indexPath.row]
        cell.data = data
        
        cell.shareUrl = { _ in
            self.shareURL(url: data.cardData?.url ?? "")
        }
        
        return cell
        
    }
    
}

extension WorkVC: UITextFieldDelegate {
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
    
        if viewModel.fetechJobSearch(data: textField.text ?? ""){
            tableView.reloadData()
        }
        
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
}

extension WorkVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.premiumProduct.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PremiumProductCell.identifier, for: indexPath) as! PremiumProductCell
        cell.data = viewModel.premiumProduct[indexPath.row]
        return cell
    }
    
    
}

extension WorkVC {
    
    private func setupUI(){
        
        premiumProductView.isHidden = true
        
        searchView.defaultTheme()

        searchTF.delegate = self
        searchTF.addDoneButtonOnKeyboard()
        
        tableView.register(UINib(nibName: JobsTvCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: JobsTvCell.identifier)
        tableView.dataSource = self
        
        collectionView.dataSource = self
        
    }

    private func initilizeValue(){
        tableViewHeightConst.constant = 0
    }
    
    private func dataObserver(){
        
        AppHelper.shared.showProgressIndicator(view: self.view)
        viewModel.fetchJobs {  [weak self] result in
            switch result{
            case .success(_):
                    DispatchQueue.main.async {
                        AppHelper.shared.hideProgressIndicator(view: self?.view)
                        self?.tableView.reloadData()
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    AppHelper.shared.showAlert(title: "Not Found", message: error.localizedDescription, vc: self)
                }
            }
        }
        
        viewModel.fetchPremiumProduct {  [weak self] result in
            switch result{
            case .success(let data):
                    DispatchQueue.main.async {
                        self?.premiumProductView.isHidden = !data
                        self?.collectionView.reloadData()
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    AppHelper.shared.showAlert(title: "Not Found", message: error.localizedDescription, vc: self)
                }
            }
        }
        
        
    }
    
    private func shareURL(url shareURLString : String) {
        
        if let shareURL = URL(string: shareURLString){
            let activity = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
            present(activity, animated: true)
        }
        
    }
    
}
