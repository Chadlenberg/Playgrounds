//: Playground - noun: a place where people can play

//: Made while Working through a tutorial on Enums, Structs, and classes - https://www.raywenderlich.com/119881/enums-structs-and-classes-in-swift

import UIKit

var str = "Hello, playground"

extension CSSColor {
    enum ColorName: String {
        case black, silver, gray, white, maroon, red, purple, fuchsia, green, lime, olive, yellow, navy, blue, teal, aqua
    }
}
enum CSSColor {
    case named(ColorName)
    case rgb(UInt8, UInt8, UInt8)
}

extension CSSColor: CustomStringConvertible {
    var description: String {
        switch self {
        case .named(let ColorName):
            return ColorName.rawValue
        case .rgb(let red, let green, let blue):
            return String(format: "#%02X%02X%02X", red,green,blue)
        }
    }
}


let color1 = CSSColor.named(.red)
let color2 = CSSColor.rgb(0xAA, 0xAA, 0xAA)
print ("color1 = \(color1), color 2 = \(color2)") // prints color1 = red, color 2 = #AAAAAA

extension CSSColor {
    init(gray: UInt8) {
        self = .rgb(gray, gray, gray)
    }
}

let color3 = CSSColor(gray: 0xaa)
print(color3) // prints #AAAAAA

// Learned: new enum cases cannot be added later in an extension.

protocol Drawable {
    func draw(with context: DrawingContext)
}

protocol DrawingContext {
    func draw(_ circle: Circle)
    func draw(_ rectangle: Rectangle)
    // more primitives will go here ...
}

struct Circle: Drawable {
    var strokeWidth = 5
    var strokeColor = CSSColor.named(.red)
    var fillColor = CSSColor.named(.yellow)
    var center = (x: 80.0, y: 160.0)
    var radius = 60.00
    
    
    
    func draw(with context: DrawingContext) {
        context.draw(self)
    }
}

struct Rectangle : Drawable {
    var strokeWidth = 5
    var strokeColor = CSSColor.named(.teal)
    var fillColor = CSSColor.named(.aqua)
    var origin = (x: 110.0, y: 10.0)
    var size = (width: 100.0, height: 130.0)
    
    func draw(with context: DrawingContext) {
        context.draw(self)
    }
}

final class SVGContext: DrawingContext {
    private var commands: [String] = []
    
    var width = 250
    var height = 250
    
    
    // 1 
    func draw(_ circle: Circle) {
        commands.append("<circle cx='\(circle.center.x)' cy='\(circle.center.y)\' r='\(circle.radius)' stroke='\(circle.strokeColor)' fill='\(circle.fillColor)' stroke-width='\(circle.strokeWidth)' />")
    }
    
    // 2
    func draw(_ rectangle: Rectangle) {
        commands.append("<rect x='\(rectangle.origin.x)' y='\(rectangle.origin.y)' width='\(rectangle.size.width)' height='\(rectangle.size.height)' stroke='\(rectangle.strokeColor)' fill='\(rectangle.fillColor)' stroke-width='\(rectangle.strokeWidth)' />")
    }
    
    var svgString: String {
        var output = "<svg width='\(width)' height='\(height)'>"
        for command in commands {
            output += command
        }
        output += "</svg>"
        return output
    }
    
    var htmlString: String {
        return "<!DOCTYPE html><html><body>" + svgString + "</body></html>"
    }
}

struct SVGDocument {
    var drawables: [Drawable]=[]
    var htmlString: String {
        let context = SVGContext()
        for Drawable in drawables {
            Drawable.draw(with: context)
        }
        return context.htmlString
    }
    
    mutating func append(_ drawable: Drawable) {
        drawables.append(drawable)
    }
}


var document = SVGDocument()

let rectangle = Rectangle()
document.append(rectangle)

let circle = Circle()
document.append(circle)

let htmlString = document.htmlString
print(htmlString)


import WebKit
import PlaygroundSupport
let view = WKWebView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.loadHTMLString(htmlString, baseURL: nil)
PlaygroundPage.current.liveView = view


extension Circle {
    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    // Example of getter-only computed properties
    var area: Double {
        return radius * radius * Double.pi
    }
    var perimeter: Double {
        return 2 * radius * Double.pi
    }
    
    mutating func shift(x: Double, y: Double) {
        center.x += x
        center.y += y
    }
    
}
extension Rectangle {
    var area: Double {
        return size.width * size.height
    }
    
    var perimeter: Double {
        return 2 * (size.width + size.height)
    }
}


protocol ClosedShape {
    var area: Double { get }
    var perimeter: Double { get }
}

extension Circle : ClosedShape {}
extension Rectangle : ClosedShape {}

func totalPerimiter(shapes: [ClosedShape]) -> Double {
    return shapes.reduce(0) { $0 + $1.perimeter}
}

totalPerimiter(shapes: [circle, rectangle])

