//
//  OtpViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation


final class OtpViewModel{
    
    var data: AuthModel = AuthModel(mobile: "", countryCode: "")
    var isInvalidOTP: Bool = false
    
    var user: OtpResponse?{
        didSet{
            if let ds = user{
                AppSettings.setValue(token: ds.token ?? "", countryCode: ds.country_code ?? "", mobileNo: ds.mobile_number ?? "", imageUrl: ds.image_id ?? "")
            }
        }
    }
    
    private var timer: Timer?
    var counter = 0
    
    func scheduleTimer(comp: @escaping (Int) -> Void) {
        
        timer?.invalidate()
        counter = 60

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.counter -= 1
            
            comp(self.counter)

            if self.counter == 0 {
                timer.invalidate()
            }
        }
    }

    func resndOTP(comp: @escaping (Result<String,HandleError>) -> Void){
        
        //APP STORE CONNECT
        if data.mobile == APP_STORE.user.mobile && data.countryCode == APP_STORE.user.countryCode{
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
                comp(.success("Test Account Login"))
            }
            
            return
        }
        
        APIManager.request(endpoint: GoodSpaceAPI.Login(country: data.countryCode, mobile: data.mobile)) {
            (result: Result<LoginModel, HandleError>) in
            switch result{
            case .success(let data):
                comp(.success(data.message ?? ""))
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
    
    func VerifyOTP(otp: String, comp: @escaping (Result<OtpResponse?,HandleError>) -> Void){
        
        data.otp = otp
        
        //APP STORE CONNECT
        if data.mobile == APP_STORE.user.mobile && data.countryCode == APP_STORE.user.countryCode && data.otp == APP_STORE.user.otp{
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
                APP_STORE.isTestUser = true
                AppSettings.setValue(token: APP_STORE.token, countryCode: APP_STORE.user.countryCode , mobileNo: APP_STORE.user.mobile, imageUrl: "")
                comp(.success(nil))
            }
            
            return
        }
        
        APIManager.request(endpoint: GoodSpaceAPI.VerifyOTP(mobile: data.mobile, otp: otp)) {
            (result: Result<OtpModel, HandleError>) in
            switch result{
            case .success(let data):
                self.user = data.data
                comp(.success(data.data))
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
}
