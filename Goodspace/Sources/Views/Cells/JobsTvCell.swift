//
//  JobsTvCell.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import UIKit

class JobsTvCell: UITableViewCell {

    @IBOutlet weak private var userName: UILabel!
    @IBOutlet weak private var userCompany: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    
    @IBOutlet weak private var mainView: UIView!
    
    @IBOutlet weak private var lpaView: UIView!
    @IBOutlet weak private var experianceView: UIView!
    
    @IBOutlet weak private var jobtypeView: UIView!
    
    @IBOutlet weak private var jobTitle: UILabel!
    @IBOutlet weak private var companyName: UILabel!
    @IBOutlet weak private var postTime: UILabel!
    @IBOutlet weak private var location: UILabel!
    
    @IBOutlet weak private var salaryRange: UILabel!
    @IBOutlet weak private var experiance: UILabel!
    @IBOutlet weak private var jobType: UILabel!
    
    @IBOutlet weak private var applyBtn: UIButton!
    
    var shareUrl: ((Bool)->Void)?
    
    var data: JobDataResponse?{
        didSet{
            setupUI()
            initilizeValue()
        }
    }
    
    private func setupUI(){
        
        mainView.defaultTheme(backgroundColor: .clear)
        lpaView.defaultTheme2(borderColor: .greenColor)
        experianceView.defaultTheme2(borderColor: .darkBlueColor)
        jobtypeView.defaultTheme2(borderColor: .lightPinkColor)
        applyBtn.makeCircular(radius: 4)
        
    }

    private func initilizeValue(){
        
        guard let data else { return }
        
        jobTitle.text = data.cardData?.title ?? ""
        companyName.text = data.cardData?.companyName ?? ""
        postTime.text = data.cardData?.relativeTime ?? ""
        location.text = data.cardData?.location_city ?? ""
        
        salaryRange.text = data.cardData?.displayCompensation ?? ""
        experiance.text = data.cardData?.experiance ?? ""
        jobType.text = data.cardData?.jobType ?? ""
        
        
        userName.text = data.cardData?.userInfo.name ?? ""
        userCompany.text = data.cardData?.companyName ?? ""
        userImage.setImage(urlString: data.cardData?.userInfo.image_id ?? "", isRoundImg: true, placeholder: UIImage(systemName: "person.circle.fill"))
        
        applyBtn.setTitle(data.cardData?.hasApplied ?? false ? "Applied" : "Apply", for: .normal)
        
    }
    
    @IBAction private func shareBtnTap(_ sender: UIButton) {
        shareUrl?(true)
    }
    
    static var identifier: String {
        return "JobsTvCell"
    }
    
}
