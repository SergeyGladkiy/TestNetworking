//
//  BackgroundDataProvider.swift
//  TestNetworking
//
//  Created by Serg on 29.04.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class BackgroundDataProvider: NSObject {
    private var downloadTask: URLSessionDownloadTask!
    var locationDownloadingFile: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    private weak var urlSession: URLSession!
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: "SessionConfigurationBackground")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        config.timeoutIntervalForRequest = 300 
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        self.urlSession = session
    }
    
    func startDownloadFrom(_ stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        self.downloadTask = urlSession.downloadTask(with: url)
        downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
        downloadTask.countOfBytesClientExpectsToSend = 512
        downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
        downloadTask.resume()
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
}

extension BackgroundDataProvider: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let completionHandler = appDelegate.backgroundCompletionHandler else { return }
            appDelegate.backgroundCompletionHandler = nil
            completionHandler()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        //guard downloadTask == self.downloadTask else { return }
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}

extension BackgroundDataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("Did finish downloading: \(location.absoluteString)")
        DispatchQueue.main.async {
            self.locationDownloadingFile?(location)
        }
    }
}
