//
//  AlamofireNetworkingRequest.swift
//  TestNetworking
//
//  Created by Serg on 30.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    static func getRequestWithAlamofire(url string: String) {
        AF.request(string).responseDecodable(of: [UserProfile].self) { (response) in
            switch response.result {
            case .success(let profiles):
                print(profiles)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
