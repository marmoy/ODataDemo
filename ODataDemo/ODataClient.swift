import Foundation
import Alamofire

let api = "http://services.odata.org/V4/Northwind/Northwind.svc/"

struct ODataClient {
    let servicePath: String
    let sessionManager: SessionManager

    func get<T: Decodable>(resourcePath: String? = nil, parameters: [QueryParameter], completion: @escaping ((Result<T>) -> Void)) {
        sessionManager.request(servicePath + (resourcePath ?? ""), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        _ = sessionManager.request(servicePath + (resourcePath ?? "")).responseDecodable { (response: DataResponse<T>) in
            completion(response.result)
        }
    }

    func post<T: Codable>(resourcePath: String? = nil, object: T, completion: @escaping ((Result<T>) -> Void)) {
        let dictionary: [String: Any] = (try? DictionaryEncoder().encode(object)) ?? [:]
        sessionManager.request(servicePath + (resourcePath ?? ""), method: .post, parameters: dictionary, encoding: JSONEncoding.default, headers: nil)
        _ = sessionManager.request(servicePath + (resourcePath ?? "")).responseDecodable { (response: DataResponse<T>) in
            completion(response.result)
        }
    }
}

extension ODataClient {
    enum QueryParameter {
        case filter(options: [(key: String, operator: String, value: String)])
        case select(keys: [String])
        case top(limit: Int)
        case count
        case orderBy(key: String, order: String)
        case skip(number: Int)
        case skipToken(token: String)
        case expand(keys: [String])
    }
}

extension ODataClient.QueryParameter {
    func query(from queryParameters: [ODataClient.QueryParameter]) -> String {
        return ""
    }
}
