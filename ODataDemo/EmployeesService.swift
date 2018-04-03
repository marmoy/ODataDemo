import Foundation
import Alamofire

protocol Service {
    var servicePath: String { get }
    var sessionManager: SessionManager { get }
}

struct EmployeeService: Service {

    let servicePath: String
    let sessionManager: SessionManager

    func loadAllEmployees(completion: @escaping (Result<[Employee]>) -> Void) {
        _ = sessionManager.request(servicePath).responseDecodable { (response: DataResponse<[Employee]>) in
            completion(response.result)
        }
    }
}

struct Employee: Codable {
    let name: String
    let position: String
    let other: String?
}

