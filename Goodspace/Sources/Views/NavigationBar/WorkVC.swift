//
//  DashboardVC.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

class WorkVC: BaseVC {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConst: NSLayoutConstraint!
    
    private let viewModel = WorkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.defaultTheme()
        searchTF.delegate = self
        searchTF.addDoneButtonOnKeyboard()
        
        
        tableView.register(UINib(nibName: JobsTvCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: JobsTvCell.identifier)
        tableView.dataSource = self
        tableViewHeightConst.constant = 0
        //tableView.reloadData()

        dataObserver()
        
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
                    AppHelper.shared.showAlert(title: "Not Found...!!!", message: error.localizedDescription, vc: self)
                }
            }
        }
    }
    
}

extension WorkVC : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIView.animate(withDuration: 0.2) {
            self.tableViewHeightConst.constant = CGFloat(190 * self.viewModel.data.count + 10)
        }
        
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func shareURL(url shareURLString : String) {
        
            if let shareURL = URL(string: shareURLString) {
                let activityViewController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
                
                // On iPad, set a source view to prevent a crash
                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceView = self.view
                }
                
                // Present the activity view controller
                present(activityViewController, animated: true, completion: nil)
            }
        }
}
