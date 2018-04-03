import Foundation
import Alamofire

extension DataRequest {
    func responseDecodable<T: Decodable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(NSError()) }

            guard let data = data else {
                return .failure(NSError())
            }

            do{
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                return .success(responseObject)
            } catch let error {
                return .failure(error)
            }
        }

        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
