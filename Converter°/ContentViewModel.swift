
import Foundation

class ContentViewModel: ObservableObject {
    @Published var input = 0
    @Published var unitSymbol = "°F"
    @Published var unit = "Celsius"
    @Published var temperature: Double = 0
    
    func calculate() {
        if unit == "Celsius" {
            temperature = (Double(input) * 1.8) + 32 // celsius to fahrenheit
            unitSymbol = "°F"
        } else {
            temperature = Double((input - 32)) / 1.8
            unitSymbol = "°C"
        }
    }
}
