////
////protocol CanMakeSoftDrink {
////    func make(with order: Order) -> Drink
////
////}
////
////
////struct Order {
////    let ice: Quantity
////    let suger: Quantity
////    let drink: Drink
////    let price: Float
////}
////
////enum Quantity {
////    case less, medium, none, full
////}
////
////enum Drink {
////    case bubbleTea, blackTea, greenTea
////}
////
////class Person {
////    let name: String
////    init(name: String) {
////        self.name = name
////    }
////}
////
////
////class Waiter: Person, CanMakeSoftDrink {
////    func make(with order: Order) -> Drink {
////        return order.drink
////    }
////}
////
////class CustomerSevice: Person, CanMakeSoftDrink {
////    func make(with order: Order) -> Drink {
////        return .blackTea
////    }
////
////}
////
////class Customer: Person {
////    var delegate: CanMakeSoftDrink?
////    var order : Order?
////    func getSomeDrink() -> Drink? {
////        switch order {
////        case .none: return nil
////        case .some(let order):
////            if let delegate = delegate {
////               let drink = delegate.make(with: order)
//////                print("the waiter \(delegate.name) help me \(name) to get drink \(drink), price: \(order.price)")
////                return drink
////            }
////            return nil
////        }
////
////
////    }
//////    func getSomeDrink() -> Drink? {
//////        if let order = order {
//////            return delegate.make(with: order)
//////        } else {
//////            return nil
//////        }
//////    }
////}
////
////let ulala = CustomerSevice(name: "Ulala")
////
////
////let waiter = Waiter(name: "Amy")
////let customer = Customer(name: "Sheldon")
////customer.delegate = ulala
////customer.order = Order(ice: .full, suger: .less, drink: .blackTea, price: 10)
////customer.getSomeDrink()
////
////
////
////protocol CanCook {
////    func cook(with menu: Menu) -> Food
////}
////
////struct Menu {
////    let food: Food
////    let price1: Float
////}
////
////enum Food {
////    case soup, noodle
////}
////
////class Chef: Person, CanCook {
////    func cook(with menu: Menu) -> Food {
////        return menu.food
////    }
////}
////
////class Man: Person {
////    var delegate: CanCook?
////    var menu: Menu?
////    func getSomeFood() -> Food? {
////        switch menu {
////        case .none: return nil
////        case .some(let menu):
////            if let delegate = delegate {
////                let food = delegate.cook(with: menu)
////                return food
////            }
////            return nil
////        }
////    }
////}
//// let bob = Man(name: "Bob")
//// let tim = Chef(name: "Tim")
////
////bob.delegate = tim
////bob.menu = Menu(food: .noodle, price1: 0)
////bob.getSomeFood()
////
////let terry = Man(name: "terry")
////terry.delegate = tim
////terry.menu = Menu(food: .soup, price1: 10)
////terry.getSomeFood()
////
////
////
////let apples = 3
////let bananas = 10
////let applesu = "I have \(apples) apples"
////let friuts = "I have \(apples + bananas) friuts"
//
////func sumOf(numbers: Int...) -> Int {
////    var sum = 0
////    for number in numbers {
////        sum += number
////    }
////    return sum
////}
////sumOf()
////sumOf(numbers: 42,55,88)
////
//
////func makeIn() -> ((Int) -> Int) {
////    func addOne(number: Int) -> Int {
////        return 1 + number
////    }
////    return addOne
////}
////var inc = makeIn()
////inc(7)
//
//
////struct Tutorial {
////    var difficulty: Int = 1
////}
////
////var tutorial1 = Tutorial()
////var tutorial2 = tutorial1
////tutorial2.difficulty = 2
////
////
////
////import UIKit
////
////var view1 = UIView()
////view1.alpha = 0.5
////
////let view2 = UIView()
////view2.alpha = 0.5 // Will this line compile?
////
////view1 = view2
////
////
////var animals = ["fish", "cat", "chicken", "dog"]
////animals.sort { (one: String, two: String) -> Bool in
////    return one < two
////}
////animals.sort(by: <)
////print(animals)
////
////
////
////class Address {
////    var fullAddress: String
////    var city: String
////
////    init(fullAddress: String, city: String) {
////        self.fullAddress = fullAddress
////        self.city = city
////    }
////}
////
////class Person {
////    var name: String
////    var address: Address
////
////    init(name: String, address: Address) {
////        self.name = name
////        self.address = address
////    }
////}
////
////var headquarters = Address(fullAddress: "123 Tutorial Street", city: "Appletown")
////var ray = Person(name: "Ray", address: headquarters)
////var brian = Person(name: "Brian", address: headquarters)
////
////brian.address.fullAddress = "148 Tutorial Street"
////
////print (ray.address.fullAddress)
//
//class Animal {
//    func canMove() {
////     print("animal can move")
//    }
//}
//
//
//
//
//
//
////person.canMove()
//
//class Cat: Animal {
//    func trowsCatHairball() {
//
//
//    }
//
//    private var heart: String = ""
//}
//
//
//
//
//class Dog: Animal {}
//
//let cat = Cat()
//cat.canMove()
//
//
//let dog = Dog()
//
//let cats: [Cat] = [cat]
//
//let dogs: [Dog] = [dog]
//
//
//let animals: [Animal] = [cat, dog]
//
//
//class DataManager {
//    static let shared = DataManager()
//
//    private init() { }
//    var data: String = ""
//}
//
//DataManager.shared.data
//DataManager.shared.data = "terry"
//DataManager.shared.data
//
//DataManager.shared.data = "shiung"
//
//DataManager.shared.data
//
//
////let x = DataManager()
////
////// reference sematics
////class Person {
////    var age : Int = 0
////}
////
////class Doctor: Person { }
////
////let doctor = Doctor()
////doctor.age = 10
////
////
////
////let doctorCopy = doctor
////
////doctorCopy.age
////
////
////doctorCopy.age = 20
////
////doctorCopy.age
////doctor.age
////
////// value sematics
////
////
////
////struct People {
////    var age: Int
////}
////
////let people = People(age: 10)
////var peopleCopy = people
////
////peopleCopy.age = 20
////
////peopleCopy.age
////people.age
//
//
//
//
//
//
//
//
// import UIKit
//class ViewContoller: UIViewController{
//
//    override func viewDidLoad() {
//        view.backgroundColor = .gray
//    }
//}
//
//
//class View: UIView {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        backgroundColor = .gray
//    }
//}
//
//var myInfo = (name: "Shiung", age: 25)
//print(myInfo.age)
//
//let anOptionalString = Optional<String>.some
//print(anOptionalString)
//let anOptionaStringNil = Optional<String>.none
//print(anOptionaStringNil)



enum Weather : Int {
    case sun, rain, cloudy, wind
}


var set = Set<Weather>()

set.insert(.sun)
let x = set.insert(.sun)

print(x)

import Foundation

struct NewsStory: Hashable {
    var id: Int
    var title: String
    var date = Date()

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: NewsStory, rhs: NewsStory) -> Bool {
        return lhs.id == rhs.id
    }
}

var sets: Set<NewsStory> = [NewsStory(id: 10, title: "test")]
sets.insert(NewsStory(id: 10, title: "test"))
NewsStory(id: 10, title: "test") == NewsStory(id: 10, title: "test")
sets
