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
        // Change background color based on required exam grade
        let backgroundColor: Color = requiredExamGrade != nil && requiredExamGrade! > 100 ? .red : .green
        
        VStack {
            // Title
            Text("Grade Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            
            // Form for user inputs
            VStack(spacing: 15) {
                TextField("Enter current grade", text: $currentGrade)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                
                TextField("Enter desired final grade", text: $desiredGrade)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                
                TextField("Enter exam weight (ex., 0.4 for 40%)", text: $examWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }
            
            // Calculate Button
            Button(action: calculateRequiredGrade) {
                Text("Calculate Required Exam Grade")
                    .font(.headline)
                    .fontWeight(.bold)
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
                    .fontWeight(.semibold)
                    .foregroundColor(requiredExamGrade > 100 ? .white : .black)
                    .padding()
                    .background(requiredExamGrade > 100 ? Color.red : Color.green)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .background(backgroundColor)
        .ignoresSafeArea()
        .padding()
    }
}

