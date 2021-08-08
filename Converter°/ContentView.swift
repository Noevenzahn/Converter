
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var someNumberProxy: Binding<String> {
        Binding<String>(
            get: { String(Int(self.viewModel.input)) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.viewModel.input = Int(truncating: value)
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 200)
            
            Text("\(viewModel.temperature, specifier: "%.2f") \(viewModel.unitSymbol)")
                .font(.system(size: 70))
            
            VStack {
                TextField("Degrees", text: someNumberProxy)
                    .onChange(of: viewModel.input, perform: { value in
                        viewModel.calculate()
                    })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)

                Spacer()
                Button("calculate", action: {viewModel.calculate()})
                Menu {
                    Button("Celsius", action: {viewModel.unit = "Celsius"; viewModel.unitSymbol = "°F"; viewModel.calculate()})
                    Button("Fahrenheit", action: {viewModel.unit = "Fahrenheit"; viewModel.unitSymbol = "°C"; viewModel.calculate()})
                } label: {
                    Text("Unit: \(viewModel.unit)")
                }
            }
            .padding()
            .padding(.horizontal, 25)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

