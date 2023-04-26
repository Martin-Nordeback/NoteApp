import SwiftUI

@main
struct NoteAppApp: App {
    
    //let persistenceController = PersistenceController.shared
    @StateObject private var coreDataViewModel =  CoreDataViewModel()

   
    var body: some Scene {
        WindowGroup {
            NoteView()
                .environmentObject(coreDataViewModel)
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
