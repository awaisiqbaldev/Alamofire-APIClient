//
//  APIManager.swift
//  Alamofire_Rapper
//
//  Created by Awais Iqbal on 14/09/2021.
//

import Foundation
import Alamofire

class APIClient {
    
    static let sharedObj = APIClient.init()
    
    public let baseURL : String! = ""
    public let authToken : String? = ""
    
    private init() {}
    
    typealias genericReponse<T> = (Result<T, Error>) -> Void
    typealias genericReponseArray<T> = (Result<[T], Error>) -> Void
    
    func requestGETURL<T : Decodable>(withURL url : String, method : HTTPMethod, ReponseType _: T.Type, authToken : Bool, withParameters params : [String : AnyObject]?, completion:@escaping genericReponse<T>) {
        
        AF.request(baseURL + url, method: method, parameters: nil, encoding: JSONEncoding.default , headers: nil).validate().responseDecodable(of: T.self) { response in
            
            if let value = response.value {
                completion(.success(value))
            }
            if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
    func requestURLwithArrayResponse<T : Decodable>(withURL url : String, method : HTTPMethod, ReponseType _: [T].Type, authToken : Bool, withParameters params : [String : AnyObject]?, completion:@escaping genericReponseArray<T>) {

        AF.request(baseURL + url, method: method, parameters: nil, encoding: JSONEncoding.default , headers: nil).validate().responseDecodable(of: [T].self) { response in

            if let value = response.value {
                completion(.success(value))
            }
            if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
    //    func requestGETURL<T : Decodable>(withURL url : String, method : HTTPMethod, ReponseType _: T.Type, authToken : Bool, withParameters params : [String : AnyObject]?, completion:@escaping genericReponse<T>) {
    //
    //        AF.request(baseURL + url, method: method, parameters: nil, headers: nil).validate().responseJSON { (response) in
    //
    //            if let data = response.data {
    //                do {
    //                    let responseModel = try JSONDecoder().decode(T.self, from: data)
    //                    completion(.success(responseModel))
    //                }
    //                catch (let error) {
    //                    completion(.failure(error))
    //                }
    //            }
    //            if let error = response.error {
    //                completion(.failure(error))
    //            }
    //
    //        }
    //    }
    
}

