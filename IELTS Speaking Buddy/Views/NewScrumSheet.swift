/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = IeltsTestQuestion.emptyScrum
    @Binding var scrums: [IeltsTestQuestion]
    @Binding var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationStack {
            QuestionEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(scrums: .constant(IeltsTestQuestion.sampleData), isPresentingNewScrumView: .constant(true))
    }
}
