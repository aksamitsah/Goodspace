//
//  JobsTvCell.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import UIKit

class JobsTvCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lpaView: UIView!
    @IBOutlet weak var experianceView: UIView!
    
    @IBOutlet weak var jobtypeView: UIView!
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var salaryRange: UILabel!
    @IBOutlet weak var experiance: UILabel!
    @IBOutlet weak var jobType: UILabel!
    
    var shareUrl: ((Bool)->Void)?
    
    @IBOutlet weak var applyBtn: UIButton!
    
    var data: JobDataResponse?{
        didSet{
            
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.defaultTheme(backgroundColor: .clear)
        lpaView.defaultTheme2(borderColor: .greenColor)
        experianceView.defaultTheme2(borderColor: .darkBlueColor)
        jobtypeView.defaultTheme2(borderColor: .lightPinkColor)
        applyBtn.makeCircular(radius: 4)
        
    }
    
    @IBAction func shareBtnTap(_ sender: UIButton) {
        shareUrl?(true)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifier: String {
        return "JobsTvCell"
    }
    
    
}
