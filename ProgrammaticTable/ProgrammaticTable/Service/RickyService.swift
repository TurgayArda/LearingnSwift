//
//  RickyService.swift
//  ProgrammaticTable
//
//  Created by ArdaSisli on 21.01.2022.
//

import Foundation
import Alamofire

enum url: String {
    case Base_url = "https://rickandmortyapi.com/api"
    case Path = "/character"
    
    static func pathUrl() -> String {
        return "\(Base_url.rawValue)\(Path.rawValue)"
    }
}

protocol IRickyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void)
}

class RickyService: IRickyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void) {
        AF.request(url.pathUrl(),method: .get).responseDecodable(of: PostModel.self) {
            (model) in
            guard let data = model.value else { return }
            response(data.results)
        }
    }
}
