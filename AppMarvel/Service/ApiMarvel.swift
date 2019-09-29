//
//  ApiMarvel.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelApi {
    
    static private let basePath = "https://gateway.marvel.com/v1/public/characters?"
    
    static private let privateKey = "4a2e57421b235dfd91fdd605f79f34d096d0349c"
    static private let publicKey = "23650f813ec0b9c6af6664f147a75cb2"
    static private let limit = 50
    
    private class func getCredentials() -> String {
        // Retorna um intervalo de tempo
        let timeStamp = String(Date().timeIntervalSince1970)
        // encriptar minha info para MD5 da Marvel
        let hash = MD5(timeStamp+privateKey+publicKey).lowercased()
        let url = "ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)"
        return url
    }
    
    class func loadHeros(page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + getCredentials()
        print(url)
        
        
        AF.request(url).responseJSON{ (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do{
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            }
            catch{
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
}
