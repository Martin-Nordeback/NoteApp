import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [NoteEntity] = []

    init() {
        container = NSPersistentContainer(name: "NoteApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchNotes()
    }

    func fetchNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }

    func addNote(text: String) {
        let newNote = NoteEntity(context: container.viewContext)
        newNote.name = text
        newNote.date = Date()
        saveData()
    }

    func updateNotes(entity: NoteEntity) {
        let currentName = entity.name ?? ""
        entity.name = currentName
        entity.date = Date()
        saveData()
    }

    func updateNotes(entity: NoteEntity, newText: String) {
        // let currentName = entity.name ?? ""
        entity.name = newText
        entity.date = Date()
        saveData()
    }

    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchNotes()
        } catch let error {
            print("Error saving. \(error)")
        }
    }

    func moveNotes(from: IndexSet, to: Int) {
        savedEntities.move(fromOffsets: from, toOffset: to)
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    func formatDate(_ date: Date?) -> String? {
        guard let date = date else { return nil }
        return itemFormatter.string(from: date)
    }

    func filteredNotes(searchText: String) -> [NoteEntity] {
        if searchText.isEmpty {
            return savedEntities
        } else {
            return savedEntities.filter { entity in
                entity.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
}


