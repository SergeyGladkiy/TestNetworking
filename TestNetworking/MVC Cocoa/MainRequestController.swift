//
//  MainRequestController.swift
//  TestNetworking
//
//  Created by Serg on 26.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class MainRequestController: UICollectionViewController {
    
    private var urlsDictionary = [String: String]()
    private let urlsFileName = "urls"
    private var alert: UIAlertController!
    private var downloadFilePath = ""
    private var backgroundDataProvider: BackgroundDataProvider
    weak var customView: InterfaceMainRequestView!
    private var dataModel = TypeRequest.allCases
    
    init(view: InterfaceMainRequestView, dataProvider: BackgroundDataProvider) {
        self.backgroundDataProvider = dataProvider
        self.customView = view
        super.init(nibName: nil, bundle: nil)
        customView.output = self
        self.view = customView as? UIView
        parseDataFromFile()
        
        settingNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingNotification() {
        registerForNotification()
        
        //MARK: процесс загрузки завершен
        backgroundDataProvider.locationDownloadingFile = { [weak self] location in
            
            //Сохранить файл для дальнейшего использования
            print("Download finished: \(location.absoluteString)")
            self?.downloadFilePath = location.absoluteString
            self?.alert.dismiss(animated: false, completion: nil)
            //вызываем нотификацию
            self?.postNotification()
        }
    }
    
    func parseDataFromFile() {
        guard let path = Bundle.main.path(forResource: urlsFileName, ofType: "text", inDirectory: nil) else {
            return
        }
        //print(path) !!!
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
            urlsDictionary = json
//            if let jsonResult = jsonResult as? Dictionary<String, String> {
//                return  jsonResult
//            }
        } catch {
            print("Error get urls file: \(error)")
        }
    }
    
    private func showAlert() {
        alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        alert.view.addConstraint(height)
        
        //MARK: не работает
        //        alert.view.translatesAutoresizingMaskIntoConstraints = false
        //        alert.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] action in
            self?.backgroundDataProvider.stopDownload()
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true) { [weak self] in
            guard let self = self else { return }
            
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2, y: self.alert.view.frame.height / 2)
            
            let aiv = UIActivityIndicatorView(style: .gray)
            aiv.frame.size = size
            aiv.center = point
            
            aiv.startAnimating()
            
            let progressView = UIProgressView(frame:
                CGRect(x: 0,
                       y: self.alert.view.frame.height - 44,
                       width: self.alert.view.frame.width,
                       height: 2))
            progressView.tintColor = .blue
            
            self.backgroundDataProvider.onProgress = { [weak self] progress in
                progressView.progress = Float(progress)
                self?.alert.message = String(Int(progress * 100)) + "%"
            }
            
            self.alert.view.addSubview(aiv)
            self.alert.view.addSubview(progressView)
        }
    }
}

extension MainRequestController {
    
    //You may use the shared user notification center object simultaneously from any of your app's threads. The object processes requests serially in the order they were initiated.
    
    private func registerForNotification() {
        //MARK: запрос у пользователя на отправку уведомлений
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, _) in
            
        }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Download complete!"
        content.body = "Your background transfer has completed. File path: \(downloadFilePath)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}


extension MainRequestController {
    func numberOfItemInSection() -> Int {
        return dataModel.count
    }
    
    func viewModelForItemAt(_ indexPath: IndexPath) -> ViewModelMainRequest {
        let modelItem = dataModel[indexPath.row]
        return ModelMainRequestViewCell(item: modelItem)
    }
    
    func performAction(by indexPath: IndexPath) {
        let type = dataModel[indexPath.item]
        
        guard let string = urlsDictionary[type.rawValue] else {
            print("Do not have url")
            return }
        switch type {
        case .get:
            AlamofireNetworkRequest.getRequestWithAlamofire(url: string)
            //APIManager.shared.getRequest(with: string)
        case .post:
            APIManager.shared.postRequest(with: string)
        case .uploadImage:
            APIManager.shared.uploadImageRequest(with: string)
        case .backgroundDownload:
            showAlert()
            backgroundDataProvider.startDownloadFrom(string)
        }
        
    }
}
