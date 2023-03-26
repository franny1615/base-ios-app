//
//  EditPersonView.swift
//  LearningCoreData
//
//  Created by Francisco F on 3/26/23.
//

import SwiftUI

struct EditPersonView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("", text: $viewModel.name, prompt: Text("Name"))
                .textFieldStyle(.roundedBorder)
            
            TextField("", text: $viewModel.age, prompt: Text("Age"))
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            TextField("", text: $viewModel.gender, prompt: Text("Gender"))
                .textFieldStyle(.roundedBorder)
            
            Button {
                viewModel.editPerson { error in
                    // TODO: display error if needed
                    dismiss()
                }
            } label: {
                Text(viewModel.saveButtonText)
            }
        }
        .padding([.leading, .trailing], 8.0)
    }
}
