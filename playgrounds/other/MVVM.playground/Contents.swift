
import Foundation
import UIKit


class NetworkService {
    func fetch(_ handler: (Int) -> Void) {
        
    }
}

class ViewController: UITableViewController {
    let viewModel = ViewModel()
    
    override func loadView() {
        super.loadView()
        tableView.dataSource = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.update(with: .viewDidLoad)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.update(with: .viewWillAppear)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.update(with: .viewWillDisappear)
    }
}

/*
 View Model responsible for
 1. Communication with network service
 2. Converting data formatter to display properly
 3.
 
*/
final class ViewModel: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    }
   
    
    enum State {
        case initial, viewDidLoad, viewWillAppear, viewWillDisappear
    }
    
    func update(with state: State) {
    
        switch state {
        
        case .initial:
            break
        case .viewDidLoad:
            fetchData()
        case .viewWillAppear:
            break
        case .viewWillDisappear:
            break
        }
        current = state
    }
    
    private var dataSource = [Int]()
    
    private var current: State = .initial
    
    private var service: NetworkService?
    
    private lazy var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    var totalAmount: String {
        let total = dataSource.reduce(0, +)
        return formatter.string(for: total) ?? ""
    }
    
    func fetchData() {
        service?.fetch { value in
            dataSource.append(value)
        }
    }
}
