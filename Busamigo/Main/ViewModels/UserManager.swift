//
//  UserManager.swift
//  Busamigo
//
//  Created by Nick Askari on 08/06/2022.
//

import Foundation
import FirebaseAuth
import Firebase
import SwiftUI

class UserManager: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published private var user: User?
    @AppStorage("userID") private var userID: String = ""
    
    func fetchUser() {
        db.collection("Users").whereField("id", isEqualTo: Auth.auth().currentUser?.uid ?? "").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            for document in documents {
                do {
                    let fethcedUser = try document.data(as: User.self)
                    self.user = fethcedUser
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func signIn() async {
        //try? Auth.auth().signOut()
        if Auth.auth().currentUser == nil {
            do {
                try await Auth.auth().signInAnonymously()
            } catch {
                print(error.localizedDescription)
            }
            await addUser()
        }
    }
    
    func getUserID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func getAuthorKarisma(id: String, completion: @escaping(_ karisma: Double?) -> Void) {
        let ref = db.collection("Users").whereField("id", isEqualTo: id)
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        let fetched: User = try document.data(as: User.self)
                        let karisma = calculateKarisma(posts: fetched.posts, votes: fetched.posts)
                        completion(karisma)
                    } catch {
                        print(error)
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func getUserKarisma() -> Double? {
        if let user = self.user {
            return calculateKarisma(posts: user.posts, votes: user.votes)
        }
        return nil
    }
    
    private func addUser() async {
        let ref = db.collection("Users")
        let uid = Auth.auth().currentUser?.uid
        
        do {
            if let uid = uid {
                DispatchQueue.main.async {
                    self.userID = uid
                }
                let newUser = User(id: uid, posts: 0, votes: 0)
                let addedUser = try ref.addDocument(from: newUser)
                print("User is added to Busamigo: \(addedUser.documentID)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
