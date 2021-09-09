//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        
        label.textColor = .black
        
        view.addSubview(label)
        label.layer.addSublayer(replicator())
//        view.layer.insertSublayer(replicator(), at: 1)
        self.view = view
    }
    
    
    func replicator() -> CALayer {
        let shape = CAShapeLayer()
        shape.frame.size = CGSize(width: 10, height: 50)
        shape.anchorPoint = CGPoint(x: 0.5, y: 1)
        shape.path = CGPath(ellipseIn: shape.frame, transform: nil)
        shape.fillColor = UIColor.black.cgColor
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = 20
        let fullCicle = CGFloat.pi * 2
        let angle = fullCicle / CGFloat(replicator.instanceCount)
        replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicator.bounds.size = CGSize(width: shape.frame.height * .pi, height: shape.frame.height)
        replicator.addSublayer(shape)
        replicator.instanceAlphaOffset = -0.05
        return replicator
    }
    
    func documation() -> CAShapeLayer {
        let document = CAShapeLayer()
        document.strokeColor = UIColor.white.cgColor
        let size = CGSize(width: 100, height: 120)
        let foldInset: CGFloat = 30
        
        let path = CGMutablePath()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: size.width - foldInset, y: 0))
        path.addLine(to: .zero)
        
        
        
        path.move(to: CGPoint(x: size.width - foldInset, y: 0))
        path.addLine(to: CGPoint(x: size.width - foldInset, y: foldInset))
        path.addLine(to: CGPoint(x: size.width, y: foldInset))
        document.path = path
        return document
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
