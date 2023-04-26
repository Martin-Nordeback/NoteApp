import CoreData
import SwiftUI

struct NoteView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                if coreDataViewModel.savedEntities.isEmpty {
                    NoNotesView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    let filteredNotes = coreDataViewModel.filteredNotes(searchText: searchText)
                    List {
                        ForEach(filteredNotes) { entity in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: EditNoteView(entity: entity)) {
                                    NoteRowView(entity: entity)
                                }
                                // NoteRowView(placeHolder: entity.name!)
                                Text(coreDataViewModel.formatDate(entity.date) ?? "N/A")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .onTapGesture {
                                withAnimation(.linear) {
                                    coreDataViewModel.updateNotes(entity: entity)
                                }
                            }
                        }
                        .onDelete(perform: coreDataViewModel.deleteNote)
                        .onMove(perform: coreDataViewModel.moveNotes)
                    }
                    .overlay(
                        VStack {
                            if coreDataViewModel.filteredNotes(searchText: searchText).isEmpty {
                                Text("No matching notes for \(searchText).")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    )
                }
            }
            .navigationTitle("My Notes")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                NavigationLink(destination: AddNote()) {
                    Label("Add note", systemImage: "plus")
                }
            )
        }
        .searchable(text: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoteView()
            }
            .environmentObject(CoreDataViewModel())
            .preferredColorScheme(.dark)

            NavigationView {
                NoteView()
            }
            .environmentObject(CoreDataViewModel())
            .preferredColorScheme(.light)
        }
    }
}
