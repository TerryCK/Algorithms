
func x(param: Any? = nil) {
    switch param {
    case let s as String: print(s)
    default: break
    }
}


x(param: "test")

func y(param: Int?) {
    switch param {
    case let g?: print(g)
    default: break
    }
}

y(param: 10)
