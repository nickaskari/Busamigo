//
//  FlaggingReasonView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/07/2022.
//

import SwiftUI

struct FlaggingReasonView: View {
    let observation: Observation
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var feed: AtbFeed
    
    @State private var placeholder: String = "Skriv en begrunnelse ..."
    @State private var description: String = ""
    @State private var showConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ZStack(alignment: .leading) {
                    if self.description.isEmpty {
                        TextEditor(text: $placeholder)
                            .font(.body)
                            .foregroundColor(.gray)
                            .disabled(true)
                    }
                    ZStack {
                        TextEditor(text: $description)
                            .opacity(self.description.isEmpty ? 0.25 : 1)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItem(placement: .principal) {
                    header
                }
                ToolbarItem(placement: .confirmationAction) {
                    confirmButton
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)
    }
    
    private var cancelButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
    }
    
    private var confirmButton: some View {
        Button {
            if isValidDescription() {
                hideKeyboard()
                feed.flagObservation(docID: self.observation.id!, self.description) { success in
                    if success {
                        self.showConfirmationAlert.toggle()
                    } else {
                        dismiss()
                    }
                }
            }
        } label: {
            Text("Send")
                .font(.subheadline)
                .foregroundColor(.black)
                .opacity(isValidDescription() ? 1 : 0.5)
        }
        .disabled(isValidDescription() ? false : true)
        .alert("Merknaden er notert", isPresented: $showConfirmationAlert) {
            Button("Skjønner!", role: .cancel) {
                dismiss()
            }
        }
    }
    
    private var header: some View {
        Text("Begrunnelse")
            .bold()
    }
    
    private func isValidDescription() -> Bool {
        !description.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private func dismiss() {
        hideKeyboard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}






/*struct FlaggingReasonView_Previews: PreviewProvider {
    static var previews: some View {
        FlaggingReasonView()
    }
}*/
