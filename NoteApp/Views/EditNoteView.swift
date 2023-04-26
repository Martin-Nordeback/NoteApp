//
//  EditNoteView.swift
//  NoteApp
//
//  Created by Martin Nordebäck on 2023-03-31.
//

import SwiftUI

struct EditNoteView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode

    let entity: NoteEntity

    @State private var noteTextField: String = ""
    @State private var showAlert: Bool = false
    @State private var alertText: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $noteTextField)
            Button(action: updateNote, label: {
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
        
        //add name on the note as title
        .navigationTitle("Edit Note")
        .alert(isPresented: $showAlert, content: getAlert)
        .onAppear {
                    noteTextField = entity.name ?? ""
                }
    }

    func updateNote() {
        if textIsEmpty() {
            coreDataViewModel.updateNotes(entity: entity, newText: noteTextField)
            presentationMode.wrappedValue.dismiss()
        }
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

 struct EditNoteView_Previews: PreviewProvider {
    static let noteEntity = NoteEntity(context: CoreDataViewModel().container.viewContext)

    static var previews: some View {
        Group {
            NavigationView {
                EditNoteView(entity: noteEntity)
            }
            .preferredColorScheme(.dark)
            .environmentObject(CoreDataViewModel())

            NavigationView {
                EditNoteView(entity: noteEntity)
            }
            .preferredColorScheme(.light)
            .environmentObject(CoreDataViewModel())
        }
    }
 }
