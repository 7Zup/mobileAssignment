//
//  APIController.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 26/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
import SendBirdSDK

class APIController {
    
    // Singleton
    static let shared = APIController()

    // Variables
    var access_token: String?
    private let apiURL = "https://api.sendbird.com/v3"
    private let apiToken = "cecb5acab58813c8b2d8bd5e6fac1b6273aa4c1c"

    
    
    
    
    // Private because APIController is a singleton
    private init() {}

    

    
    
    /*****************************************************************************/
    // MARK: - General request to use the API
    
    func request<T: Mappable>(requestType: HTTPMethod, route: String, params: [String: AnyObject]? = nil, keyPath: String? = nil, retry: Int? = 2, completionHandler: @escaping (_ object: T?) -> Void) {
    
        let header = ["Api-Token": apiToken]
        print("request route : \(apiURL)\(route)")
        print("params \(String(describing: params ?? nil))")
        
        Alamofire.request("\(apiURL)\(route)", method: requestType, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseObject(keyPath: keyPath) { (response: DataResponse<T>) in
                
                completionHandler(response.result.value)
        }
    }
    
    func requestArray<T: Mappable>(requestType: HTTPMethod, route: String, params: [String: AnyObject]? = nil, keyPath: String? = nil, retry: Int? = 5, completionHandler: @escaping (_ object: [T]?) -> Void) {
        
        let header = ["Api-Token": apiToken]
        
        print("request route : \(apiURL)\(route)")
        print("params \(String(describing: params ?? nil))")
        
        Alamofire.request("\(apiURL)\(route)", method: requestType, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseArray(keyPath: keyPath) { (response: DataResponse<[T]>) in
                
                completionHandler(response.result.value)
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Authentication
    
    // Create a user using a nickname
    func createUser<T: Mappable>(nickname: String, completionHandler: @escaping (_ user: T?) -> Void) {
        
        /// Parameters to create a user
        var params = [String: AnyObject]()
        params["nickname"] = nickname as AnyObject
        params["user_id"] = nickname + "_id" as AnyObject
        params["profile_url"] = NSNull() as AnyObject
        
        print("Request: Create User")
        self.request(requestType: .post, route: "/users", params: params, completionHandler: completionHandler)
    }
    
    // Get a user using its nickname
    func getUser<T: Mappable>(nickname: String, completionHandler: @escaping (_ user: T?) -> Void) {
        
        print("Request: Get User")
        self.request(requestType: .get, route: "/users/\(nickname)_id", completionHandler: completionHandler)
    }
    
    // Delete a user using its nickname
    func deleteUser<T: Mappable>(nickname: String, completionHandler: @escaping (_ user: T?) -> Void) {
        
        print("Request: Get User")
        self.request(requestType: .delete, route: "/users/\(nickname)_id", completionHandler: completionHandler)
    }
}
