import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    @FocusState private var amountIsFocused: Bool
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    HStack{
                        Text("Bill Amount: ")
                        Spacer()
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<30) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                Section {
                    Text("Tip Percentage")
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    Text("Amount Per Person")
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
               
            } 
            Text("Each Person Needs to pay $" + String(totalPerPerson))
            .navigationTitle("🧾   i⚡️Split") 
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
