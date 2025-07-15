//
//  MyViewModel.swift
//  HomeWork2
//
//  Created by Artur Bagautdinov on 15.07.2025.
//
import SwiftUI

struct User: Identifiable {
    var id: UUID = UUID()
    var login: String
    var name: String
    var password: String
    var age: Int
    var birthday: String
    var email: String
    var phone: String
    var biography: String
    var avatar: String?
}

class MyViewModel: ObservableObject {
    @Published var text = "Hello, World!"
    var users: [User] = [User(login: "Arbuzzz3", name: "Artur", password: "123456", age: 19, birthday: "22.05.2006", email: "artur@gmail.com", phone: "+79123456789", biography: "Hello, Im Java Spring Developer!", avatar: "profile1Image"), .init(login: "Tom23", name: "Tom", password: "123123", age: 22, birthday: "19.07.2002", email: "tom@gmail.com", phone: "+79123456789", biography: "Hello, Im SwiftUI Developer!", avatar: "profileImage"), .init(login: "Abcd123", name: "John", password: "12312", age: 22, birthday: "19.07.2002", email: "john@gmail.com", phone: "+79123456789", biography: "Hello, I know C# not bad!")]


    func authorize(login: String, password: String) -> User? {
        for user in users {
            if user.login == login && user.password == password {
                return user
            }
        }
        return nil
    }
}

