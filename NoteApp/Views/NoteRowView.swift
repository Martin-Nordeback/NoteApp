import SwiftUI

struct NoteRowView: View {
    
    var placeHolder: String = ""
    var isHeader: Bool = false

    var body: some View {
        HStack {
            Text(placeHolder)
                .font(isHeader ? .title: .body)
                .fontWeight(isHeader ? .bold: .regular)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
           
        }
        //.font(.title3)
        .padding(.vertical, 6)
    }
}

extension NoteRowView {
    init(entity: NoteEntity) {
        self.init(placeHolder: entity.name ?? "")
    }
}

struct NoteRowView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            NoteRowView(placeHolder: "Text")
        }
        .previewLayout(.sizeThatFits)
    }
}
