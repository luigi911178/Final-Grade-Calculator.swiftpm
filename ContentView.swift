import SwiftUI

struct ContentView: View {
    // State properties for user input
    @State private var currentGrade = ""
    @State private var desiredGrade = "A" // Default to "A"
    @State private var examWeight = ""
    
    // State for the calculated result
    @State private var requiredExamGrade: Double?
    
    // Function to calculate the required exam grade
    func calculateRequiredGrade() {
        guard let current = Double(currentGrade),
              let weight = Double(examWeight),
              weight > 0 && weight <= 1 else {
            // Invalid input handling
            requiredExamGrade = nil
            return
        }
        
        // Map desired grade (letter) to numeric value
        let gradeMapping: [String: Double] = ["A": 90, "B": 80, "C": 70, "D": 60]
        guard let desired = gradeMapping[desiredGrade] else {
            requiredExamGrade = nil
            return
        }
        
        let requiredGrade = (desired - current * (1 - weight)) / weight
        requiredExamGrade = requiredGrade
    }
    
    // Dismissing the keyboard when tapping outside the text fields
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            // Form for user inputs
            VStack(spacing: 20) {
                TextField("Enter current grade", text: $currentGrade)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismissKeyboard() // Dismiss keyboard when tapped
                    }
                
                // Picker for desired final grade
                Picker("Select desired final grade", selection: $desiredGrade) {
                    Text("A").tag("A")
                    Text("B").tag("B")
                    Text("C").tag("C")
                    Text("D").tag("D")
                }
                .pickerStyle(WheelPickerStyle()) // Wheel style for better visibility
                .padding()
                
                TextField("Enter exam weight (ex., 0.4 for 40%)", text: $examWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismissKeyboard() // Dismiss keyboard when tapped
                    }
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
            .padding(.top, 20)
            
            // Display result
            if let requiredExamGrade = requiredExamGrade {
                Text("You need to score: \(requiredExamGrade, specifier: "%.2f") on your exam")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(requiredExamGrade > 100 ? .white : .black)
                    .padding()
                    .background(requiredExamGrade > 100 ? Color.red : Color.green)
                    .cornerRadius(8)
                    .padding(.top, 20)
                
                // Display extra credit suggestion if grade is above 100%
                if requiredExamGrade > 100 {
                    Text("Your cooked my boy, ask your teacher for extra credit.")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                        .padding(.top, 10)
                }
            }
            
            Spacer()
        }
        .background(backgroundColor)
        .ignoresSafeArea()
        .padding()
        .onTapGesture {
            dismissKeyboard() // Dismiss keyboard when tapping outside
        }
    }
}
