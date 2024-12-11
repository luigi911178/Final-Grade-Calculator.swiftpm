import SwiftUI

struct ContentView: View {
    @State var textFieldOutPut = ""
    var body: some View {
        VStack {
            TextField("Hello", text: $textFieldOutPut)
        }
    }
}
