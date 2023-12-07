//
//  WorkViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import Foundation


final class WorkViewModel{
    
    var backUpData: [JobDataResponse] = []
    var data: [JobDataResponse] = []
    
    var premiumProduct: [PremiumProductResponse] = []
    
    
    func fetechJobSearch(data text: String) -> Bool{
        
        if !text.isEmpty{
            
            data = backUpData.filter({ ($0.cardData?.title ?? "").contains(text) || ($0.cardData?.companyName ?? "").contains(text) })
        }
        
        if data.isEmpty || text.isEmpty{
            data = backUpData
        }
        
        return true
    }
    
    func fetchJobs(comp: @escaping (Result<Bool,HandleError>) -> Void){
        APIManager.request(endpoint: GoodSpaceAPI.jobsListOnDashBoard) {
            (result: Result<JobDataModel, HandleError>) in
            switch result{
            case .success(let data):
                if data.status == 200{
                    self.data = data.data.filter({ $0.type.lowercased() == "job" })
                    self.backUpData = self.data
                    data.data.isEmpty ? comp(.failure(.custom("No New Jobs List Avaiable"))) : comp(.success(true))
                }else {
                    comp(.failure(.custom("Something Went Wrong")))
                }
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
    
    
    func fetchPremiumProduct(comp: @escaping (Result<Bool,HandleError>) -> Void){
        APIManager.request(endpoint: GoodSpaceAPI.premiumProducts) {
            (result: Result<PremiumProductModel, HandleError>) in
            switch result{
            case .success(let data):
                if data.status == 200{
                    self.premiumProduct = data.data
                    comp(.success(!data.data.isEmpty))
                }else {
                    comp(.failure(.custom("Something Went Wrong")))
                }
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
}
