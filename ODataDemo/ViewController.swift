import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let employee = Employee(name: "David", position: "Senior iOS Developer", other: nil)
        do {
            let employeeDictionary: [String: Any] = try DictionaryEncoder().encode(employee)
            print(employeeDictionary)
        } catch let error {
            print(error)
        }
    }
}
