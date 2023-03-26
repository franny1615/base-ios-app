//
//  MainView.swift
//  LearningCoreData
//
//  Created by Francisco F on 3/12/23.
//

import CoreData
import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people, id: \.self) { person in
                    Text("\(person.name ?? "Unknown"), age \(person.age), of gender \(person.gender ?? "Unknown")")
                        .swipeActions {
                            Button("Delete") {
                                viewModel.removePerson(person) { error in
                                    // TODO: display error
                                }
                            }.tint(.red)
                        }
                        .onTapGesture {
                            viewModel.showEditScreen(forPerson: person)
                        }
                }
            }
            .navigationTitle("People")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showEditScreen(forPerson: nil)
                    } label: {
                        Label("", systemImage: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchPeople { error in
                    // TODO: display error
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $viewModel.showAddPersonView) {
            EditPersonView(viewModel: viewModel)
        }
    }
}
