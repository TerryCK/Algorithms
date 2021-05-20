//import Foundation
////import Combine
////
////let publisher = PassthroughSubject<Int, Never>()
////publisher.send(1)
////publisher.send(2)
////publisher.send(completion: .finished)
////
////print("開始訂閱")
////publisher.sink(receiveCompletion:  { print($0) },
////               receiveValue: {print($0)}
////)
////
////publisher.send(3)
////publisher.send(completion: .finished)
////
////
////
////let publisherB = CurrentValueSubject<Int, Never>(0)
////publisherB.value = 1
////publisherB.value = 2
////publisherB.send(completion: .finished)
////
////print("開始訂閱 B")
////publisherB.sink(receiveCompletion:  { print($0) },
////               receiveValue: {print($0)}
////)
////
//////publisherB.send(3)
//////publisherB.send(completion: .finished)
////
////
////let publisherC = CurrentValueSubject<Int, Never>(0)
////
////print("開始訂閱 C")
////publisherC.sink(receiveCompletion:  { print($0) },
////               receiveValue: {print($0)}
////)
////
////publisherC.value = 1
////publisherC.value = 2
////publisherC.send(3)
////publisherC.send(completion: .finished)
////print("--- \(publisherC.value) ---")
//
//
//
//// serial A -> targets concurrent B
//
//// concurrent queue A
//let a = DispatchQueue(label: "A")
//
//// serial queue B targeting concurrent queue A
//let b = DispatchQueue(label: "B", target: a)
//
//// next two blocks will be executed concurrently on A
//a.async {
//
//    print("1")
//}
//a.async {
//
//    print("2")
//}
//
//// next two blocks will be executed serially on A
//b.async {
//
//    print("3")
//}
//b.async {
//
//    print("4")
//}
//
//
//
//
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    init(navigationController: UINavigationController)
    func start()
    func navigate<DataSource: CoordinatorDataSource>(to page: DataSource)
    func navigate<DataSource: CoordinatorDataSource>(to anotherCoordinate: DataSource.Type)
    
}

class ViewController: UIViewController {
    weak var coordinator: Coordinator?
    
    
    func navigationTo() {
        
    }
}

protocol CoordinatorDataSource: CaseIterable {
    var viewController: ViewController.Type { get }
}

enum ChildCoordinatorDataSource: CoordinatorDataSource {
    case root
    var viewController: ViewController.Type {
        ViewController.self
    }
}


class CoordinatorTemplate<T: CoordinatorDataSource>: NSObject, Coordinator {
    unowned let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = T.allCases.first?.viewController.init() else { return }
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    func navigate<DataSource: CoordinatorDataSource>(to page: DataSource) {
        guard DataSource.self is T else {
            print("DataSource inconsistent")
            return
        }
        let viewController = page.viewController.init()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigate<DataSource: CoordinatorDataSource>(to anotherCoordinate: DataSource.Type) {
        let childCoordinator = CoordinatorTemplate<DataSource>(navigationController: navigationController)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
}

enum MainCoordinatorSource: CoordinatorDataSource {
    case main
    var viewController: ViewController.Type {
        ViewController.self
    }
}


final class MainCoordinator: CoordinatorTemplate<MainCoordinatorSource> {
}

let navigationViewController =  UINavigationController()
let mainCoordinator = MainCoordinator(navigationController: navigationViewController)
mainCoordinator.navigate(to: ChildCoordinatorDataSource.root)


