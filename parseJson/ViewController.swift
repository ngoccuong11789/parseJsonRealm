//
//  ViewController.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/4/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import UIKit
import RealmSwift
import ReachabilitySwift
import MBProgressHUD
class ViewController: UIViewController {

    var listArtist = ListArtist()
    var list_Kiyaku_Artist = List_Kiyaku_Artist()
    var list_Kiyaku = List_Kiyaku()
    let textCellIdentifier = "textCell"
    let reachability = Reachability()!
    @IBOutlet weak var tableView: UITableView!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        //print(Realm.Configuration.defaultConfiguration.fileURL?.path)
//        reachability.whenReachable = { reachability in
//            if reachability.isReachableViaWiFi {
//                print("Connect to WiFi")
//                self.fetchListArtist()
//            }else {
//                print("Reachable via Cellular")
//                self.fetchListArtist()
//            }
//        }
//        
//        reachability.whenUnreachable = { reachability in
//            print("Not reachable")
//            DispatchQueue.main.async() {
//                let realm = try! Realm()
//                realm.refresh()
//                guard let result = realm.objects(ListArtist.self).filter({ (list: ListArtist) -> Bool in
//                    if list.id == "1" {
//                        return true
//                    }else {
//                        return false
//                    }
//                }).first else {
//                    return
//                }
//                self.listArtist = result
//                self.tableView.reloadData()
//            }
//            
//        }
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
//
//        fetchData()

        
//        let asyncQueue = DispatchQueue(label: "asyncQueue", attributes: .concurrent)
//        
//        // perform the task asynchronously
//        asyncQueue.async {
//            // perform some long-running task here
//            self.fetchList_Kiyaku()
//            
//        }
//        
//        asyncQueue.async {
//            self.fetchListArtist()
//            
//        }
//        
//        asyncQueue.async {
//            self.fetchList_Kiyaku_Artist()
//            
//        }
        self.fetchList_Kiyaku()
        self.fetchListArtist()
        self.fetchList_Kiyaku_Artist()
        self.showActivity()

    }
    
    fileprivate func checkCount() {
        if count == 3 {
            print("count : \(count)")
            hideActivity()
        }
    }
    
    fileprivate func showActivity() {
        print("Show Activity")
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity.label.text = "Loading"
        spinningActivity.detailsLabel.text = "Please wait"
        spinningActivity.isUserInteractionEnabled = false
    }
    
    fileprivate func hideActivity() {
        print("HideActivity")
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
//    fileprivate func fetchData() {
//        APIManager.sharedInstance.getArtist(success: { (artist) in
//            self.artistData = artist
//            print("ArtistData : \(self.artistData[1].text)")
//            //self.addTextToRealm()
//            self.tableView.reloadData()
//            
//        }) { (error) in
//            print("Error : \(error)")
//        }
//    }
    
    fileprivate func fetchListArtist() {
        APIManager.sharedInstance.getListArtist(success: { (listArtist) in
            //print("ListArtist : \(listArtist)")
            self.listArtist = listArtist
            //self.listArtistData = listArtist.artist
            print("List Artist Data")
            self.count = self.count + 1
            self.checkCount()
            //self.addListTextToRealm()
            //self.tableView.reloadData()
        }) { (error) in
            print(error)
            self.checkErrorAPI()
        }
        
    }

    fileprivate func fetchList_Kiyaku_Artist() {
        APIManager.sharedInstance.get_List_Kiyaku_Artist(success: { (list_Kiyaku_Artist) in
            self.list_Kiyaku_Artist = list_Kiyaku_Artist
            print("List Kiyaku Artist")
            self.count = self.count + 1
            self.checkCount()
            //self.tableView.reloadData()
        }) { (error) in
            print(error)
            self.checkErrorAPI()
        }
        
    }
    
    fileprivate func fetchList_Kiyaku() {
        APIManager.sharedInstance.get_List_Kiyaku(success: { (listKiyaku) in
            self.list_Kiyaku = listKiyaku
            print("List Kiyaku")
            self.count = self.count + 1
            self.checkCount()
            self.tableView.reloadData()
        }) { (error) in
            print(error)
            self.checkErrorAPI()
        }
        //checkCount()
    }
    
    func checkErrorAPI() {
        if count < 3 {
            print("Api error")
            self.hideActivity()
        }
    }
    
//    fileprivate func addTextToRealm() {
//        print("ArtistData : \(artistData)")
//        APIManager.sharedInstance.saveTextListToReal(artist: artistData, update: true) { (flat) in
//            print("Save successfull")
//        }
//    }
    
    fileprivate func addListTextToRealm() {
        print("ArtistData : \(listArtist)")
        APIManager.sharedInstance.saveTextListToReal(listArtist: listArtist, update: true) { (flat) in
            print("Save successfull")
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return listArtist.artist.count
        //return list_Kiyaku_Artist.artist.count
        return list_Kiyaku.artist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
//        cell.titleTxt.text = listArtist.artist[row].id
//        cell.textTxt.text = listArtist.artist[row].text
        cell.titleTxt.text = list_Kiyaku.artist[row].id
        cell.textTxt.text = list_Kiyaku.artist[row].text
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        //print(listArtist.artist[row].text)
    }
    
    
}

