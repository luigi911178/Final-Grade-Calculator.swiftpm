import SwiftUI

struct ContentView: View {
    // State properties for user input
    @State private var currentGrade = ""
    @State private var desiredGrade = ""
    @State private var examWeight = ""
    
    // State for the calculated result
    @State private var requiredExamGrade: Double?
    
    // Function to calculate the required exam grade
    func calculateRequiredGrade() {
        guard let current = Double(currentGrade),
              let desired = Double(desiredGrade),
              let weight = Double(examWeight),
              weight > 0 && weight <= 1 else {
            // Invalid input handling
            requiredExamGrade = nil
            return
        }
        
        let requiredGrade = (desired - current * (1 - weight)) / weight
        requiredExamGrade = requiredGrade
    }
    
    var body: some View {
        VStack {
            // Title
            Text("Grade Calculator")
                .font(.largeTitle)
                .padding()
            
            // Form for user inputs
            VStack(spacing: 15) {
                TextField("Enter current grade", text: $currentGrade)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter desired final grade", text: $desiredGrade)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter exam weight (e.g., 0.4 for 40%)", text: $examWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // Calculate Button
            Button(action: calculateRequiredGrade) {
                Text("Calculate Required Exam Grade")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Display result
            if let requiredExamGrade = requiredExamGrade {
                Text("You need to score: \(requiredExamGrade, specifier: "%.2f") on your exam")
                    .font(.title2)
                    .foregroundColor(requiredExamGrade > 100 ? .red : .green)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}


