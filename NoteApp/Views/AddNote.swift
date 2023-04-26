import SwiftUI

struct AddNote: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var coreDataViewModel: CoreDataViewModel

    @State private var noteTextField: String = ""

    @State private var showAlert: Bool = false
    @State private var alertText: String = ""


    var body: some View {
        VStack {
            TextEditor(text: $noteTextField)
            Button(action: saveNote, label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            })
        }
        .padding(12)
        .navigationTitle("Add Note")
        .alert(isPresented: $showAlert, content: getAlert)
    }

    func saveNote() {
        if textIsEmpty() == true {
            coreDataViewModel.addNote(text: noteTextField)
            presentationMode.wrappedValue.dismiss()
        }
    }

    func textIsEmpty() -> Bool {
        if noteTextField.count < 1 {
            alertText = "It looks like your note is empty"
            showAlert.toggle()
            return false
        }
        return true
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alertText))
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddNote()
            }
            .preferredColorScheme(.dark)
            .environmentObject(CoreDataViewModel())

            NavigationView {
                AddNote()
            }
            .preferredColorScheme(.light)
            .environmentObject(CoreDataViewModel())
        }
    }
}
