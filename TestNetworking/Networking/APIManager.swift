//
//  APIManager.swift
//  TestNetworking
//
//  Created by Serg on 27.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit
final class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    private func fetchData(with urlRequest: URLRequest, completion: (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                 print ("error: \(error)")
                 return
             }
             print(response)
             guard let response = response as? HTTPURLResponse,
                 (200...299).contains(response.statusCode) else {
                 print ("server error")
                 return
             }
            
             if let data = data {
                 do {
                     let json = try JSONSerialization.jsonObject(with: data, options: []) //as! [String: Any]
                     print(json)
                 } catch {
                     print(error)
                 }
             }
        }.resume()
    }
    
    func getRequest(with string: String) {
        guard let url = URL(string: string) else { return }
        let urlRequest = URLRequest(url: url)
        
        fetchData(with: urlRequest) { (data, respnose, error) in
            
        }
    }
    
    func postRequest(with string: String) {
        
        guard let url = URL(string: string) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let urlFile = URL(fileURLWithPath: "/Users/sergejgladkij/beet lab/homeworks/RevolutWithOQ MVVM/currencies.json")
        
        guard let httpBody = try? Data(contentsOf: urlFile, options: []) else { return }
        request.httpBody = httpBody
        fetchData(with: request) { (_, _, _) in
            
        }
    }
    
    func uploadImageRequest(with string: String) {
        
        guard let url = URL(string: string) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Client-ID 9f0bdb4b5294cc1", forHTTPHeaderField: "Authorization")
        
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: "/Users/sergejgladkij/Desktop/IMG_0946.jpg"), options: []) else {
            print("Wrong urlPath")
            return }
        //let im = UIImage(data: imageData)?.jpegData(compressionQuality: <#T##CGFloat#>)
        
        request.httpBody = imageData
        fetchData(with: request) { (_, _, _) in
            
        }
    }
}


//        URLSession.shared.uploadTask(with: request, fromFile: urlFile, completionHandler: { data, response, error in
//
//            if let error = error {
//                print ("error: \(error)")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                (200...299).contains(response.statusCode) else {
//                    print ("server error")
//                    return
//            }
//            print(response)
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) //as! [String: Any]
//                    print(json)
//                } catch {
//                    print(error)
//                }
//            }
//        }).resume()
