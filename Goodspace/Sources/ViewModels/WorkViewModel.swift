//
//  WorkViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import Foundation


final class WorkViewModel{
    
    var data: [JobDataResponse] = []
    
    func fetchJobs(comp: @escaping (Result<Bool,HandleError>) -> Void){
        APIManager.request(endpoint: GoodSpaceAPI.jobsListOnDashBoard) {
            (result: Result<JobDataModel, HandleError>) in
            switch result{
            case .success(let data):
                if data.status == 200{
                    self.data = data.data.filter({ $0.type.lowercased() == "job" })
                    data.data.isEmpty ? comp(.failure(.custom("No Job List Found"))) : comp(.success(true))
                }else {
                    comp(.failure(.custom("Something Went Wrong")))
                }
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
}
