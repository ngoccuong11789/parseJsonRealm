//
//  APIManager.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/5/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import ReachabilitySwift
//private let getArtistUrl = "/kiyaku_artist.php"
private let getArtistUrl = "/api/privacy.php"
private let getKiyakuArtistUrl = "/api/kiyaku_artist.php"
private let getKiyaku = "/api/kiyaku.php"
class APIManager {
    static let sharedInstance = APIManager()
    let uiRealm: Realm?
    private init() {
    uiRealm = try? Realm()
    }
    func getBaseUrl() -> String {
        //return "http://103.18.6.158:1029/api"
        return "http://103.18.6.158:1029"
    }
    
    // Get Artist
    func getArtist(
        
        success:@escaping (_ artist: [Artist]) -> Void,
        failure:@escaping (_ error: Error) -> Void) {
        
        let url = self.getBaseUrl() + getArtistUrl

        Alamofire.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
            )
            .validate()
            .responseData { response in
            }
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    var artist = [Artist]()
                    if let datas = response.value(forKey: "data") as? [NSDictionary] {
                        //print("data: \(datas)")
                        for data in datas {
                            
                            let text = (data["text"] as? String) ?? "empty"
                            let id = (data["id"] as? String) ?? "empty"
                            
//                            var text2 = ""
//                            if let text = (data["text"] as? String) {
//                                text2 = text
//                            } else {
//                                text2 = ""
//                            }
                            let newArtist = Artist(id: id, text: text)
                            
                            artist.append(newArtist)
                        }
                        success(artist)

                    }
                case .failure(let error):
                    print("error : \(error)" )
                    failure(error)
                }
        }
    }
    // End Get Artist
    
    //
    
    // Get ListArtist
    func getListArtist(
        
        success:@escaping (_ listArtist: ListArtist) -> Void,
        failure:@escaping (_ error: Error) -> Void) {
        
        let url = self.getBaseUrl() + getArtistUrl
        
        Alamofire.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
            )
            .validate()
            .responseData { response in
            }
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    var code = Int()
                    var message = String()
                    if let header = response.value(forKey: "header") as? NSDictionary {
                        //print("header : \(header)")
                        code = (header.value(forKey: "code") as? Int)!
                        message = (header.value(forKey: "message") as? String)!
                    }
//                    if let time_update = response.value(forKey: "time_update") as? String {
//                        print("time_update : \(time_update)")
//                    }
                    let time_update = (response.value(forKey: "time_update") as? String) ?? "Time Emply"
                     var artist = List<Artist>()
                    if let datas = response.value(forKey: "data") as? [NSDictionary] {
                        //print("data: \(datas)")
                        for data in datas {
                            let text = (data["text"] as? String) ?? "empty"
                            let id = (data["id"] as? String) ?? "empty"
                            let newArtist = Artist(id: id, text: text)
                            artist.append(newArtist)
                        }
                    }
                    let newListArtist = ListArtist(code: code, message: message, time_update: time_update, artist: artist)
                    success(newListArtist)
                case .failure(let error):
                    print("error : \(error)" )
                    failure(error)
                }
        }
    }
    // End Get ListArtist
    
    //
    // Add Text To Realm
    
    func saveTextListToReal(listArtist: ListArtist, update: Bool, completion: (Bool) -> ()) {
        guard let realm = uiRealm else {
            completion(false)
            return
        }
        
        do {
            
            try realm.write({
                //for item in artist
                //{
                    realm.add(listArtist, update: update)

                //}
            })
            
            completion(true)
            
        } catch {
            completion(false)
        }
        
    }

    // End Adding Text to Realm
    
    // Add ListArtist To Realm
    
    func saveListArtistToReal(listArtist: ListArtist, update: Bool, completion: (Bool) -> ()) {
        guard let realm = uiRealm else {
            completion(false)
            return
        }
        
        do {
            
            try realm.write({
                realm.add(listArtist, update: update)
            })
            
            completion(true)
            
        } catch {
            completion(false)
        }
        
    }
    
    // End Adding ListArtist to Realm
    
    // Get List_Kiyaku_Artist
    func get_List_Kiyaku_Artist(
        
        success:@escaping (_ listKiyakuArtist: List_Kiyaku_Artist) -> Void,
        failure:@escaping (_ error: Error) -> Void) {
        
        let url = self.getBaseUrl() + getKiyakuArtistUrl
        
        Alamofire.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
            )
            .validate()
            .responseData { response in
            }
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    var code = Int()
                    var message = String()
                    if let header = response.value(forKey: "header") as? NSDictionary {
                       // print("header : \(header)")
                        code = (header.value(forKey: "code") as? Int)!
                        message = (header.value(forKey: "message") as? String)!
                    }

                    let Kiyaku_Artist_ = List<Kiyaku_Artist>()
                    if let datas = response.value(forKey: "data") as? [NSDictionary] {
                        //print("data: \(datas)")
                        for data in datas {
                            let text = (data["text"] as? String) ?? "empty"
                            let id = (data["id"] as? String) ?? "empty"
                            let title = (data["title"] as? String) ?? "emply"
                            let newKiyakuArtist = Kiyaku_Artist(id: id, text: text, title: title)
                            Kiyaku_Artist_.append(newKiyakuArtist)
                        }
                    }
                    let newListArtist = List_Kiyaku_Artist(code: code, message: message, artist: Kiyaku_Artist_)
                    success(newListArtist)
                case .failure(let error):
                    print("error : \(error)" )
                    failure(error)
                }
        }
    }
    // End Get List_Kiyaku_Artist
    
    // Get List_Kiyaku
    func get_List_Kiyaku(
        
        success:@escaping (_ listKiyaku: List_Kiyaku) -> Void,
        failure:@escaping (_ error: Error) -> Void) {
        
        let url = self.getBaseUrl() + getKiyaku
        
        Alamofire.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
            )
            .validate()
            .responseData { response in
            }
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    var code = Int()
                    var message = String()
                    if let header = response.value(forKey: "header") as? NSDictionary {
                        //print("header : \(header)")
                        code = (header.value(forKey: "code") as? Int)!
                        message = (header.value(forKey: "message") as? String)!
                    }
                    
                    let Kiyaku_ = List<Kiyaku>()
                    if let datas = response.value(forKey: "data") as? [NSDictionary] {
                        //print("data: \(datas)")
                        for data in datas {
                            let text = (data["text"] as? String) ?? "empty"
                            let id = (data["id"] as? String) ?? "empty"
                            let title = (data["title"] as? String) ?? "emply"
                            let newKiyakuArtist = Kiyaku(id: id, text: text, title: title)
                            Kiyaku_.append(newKiyakuArtist)
                        }
                    }
                    let newListArtist = List_Kiyaku(code: code, message: message, artist: Kiyaku_)

                    success(newListArtist)
                case .failure(let error):
                    print("error : \(error)" )
                    failure(error)
                }
        }
    }
    // End Get List_Kiyaku
    
    
}
