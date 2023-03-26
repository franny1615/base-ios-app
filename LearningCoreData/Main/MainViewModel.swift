//
//  MainViewModel.swift
//  LearningCoreData
//
//  Created by Francisco F on 3/26/23.
//
// CodeWithChris tutorial followed: https://www.youtube.com/watch?v=O7u9nYWjvKk

import CoreData
import SwiftUI

class MainViewModel: ObservableObject {
    let context: NSManagedObjectContext
    
    @Published var people: [Person] = []
    @Published var showAddPersonView = false
    
    @Published var selectedPerson: Person?
    
    @Published var name = ""
    @Published var age = ""
    @Published var gender = ""
    @Published var saveButtonText = ""
    
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    func showEditScreen(forPerson person: Person?) {
        self.selectedPerson = person
        self.name = person?.name ?? ""
        self.age = person?.age == nil ? "": "\(person?.age ?? 0)"
        self.gender = person?.gender ?? ""
        self.saveButtonText = person == nil ? "Add": "Save"
        self.showAddPersonView = true
    }
    
    func fetchPeople(completion: @escaping (NSError?) -> Void) {
        do {
            let fetchRequest = Person.fetchRequest() as NSFetchRequest<Person>
            // filtering
//            let predicate = NSPredicate(format: "name CONTAINS %@", "Dog")
//            fetchRequest.predicate = predicate
            // sorting
//            let sortByName = NSSortDescriptor(key: "name", ascending: true)
            let sortByAge = NSSortDescriptor(key: "age", ascending: true)
            fetchRequest.sortDescriptors = [sortByAge]
            
            people = try context.fetch(fetchRequest)
            completion(nil)
        } catch {
            completion(error as NSError)
        }
    }
    
    func editPerson(completion: @escaping (NSError?) -> Void) {
        if let selectedPerson = selectedPerson {
            selectedPerson.name = name
            selectedPerson.age = Int64(age) ?? 0
            selectedPerson.gender = gender
        } else {
            let newPerson = Person(context: context)
            newPerson.name = name
            newPerson.gender = gender
            newPerson.age = Int64(age) ?? 0
        }
        
        do {
            try context.save()
            self.fetchPeople(completion: completion)
        } catch {
            completion(error as NSError)
        }
    }
    
    func removePerson(_ person: Person, completion: @escaping (NSError?) -> Void) {
        self.context.delete(person)
        do {
            try self.context.save()
            self.fetchPeople(completion: completion)
        } catch {
            completion(error as NSError)
        }
    }
    
    // MARK: - Relationship demonstration, no associated UI
    func relationshipDemo() {
        let family = Family(context: context)
        family.name = "abc family"
        
        let person = Person(context: context)
        person.name = "Joe Smith"
        person.family = family // this is the key
        
        let secondPerson = Person(context: context)
        secondPerson.name = "Will Smith"
        
        family.addToPeople(secondPerson) // another way to build relationship
        
        do {
            try context.save()
        } catch { }
    }
}
