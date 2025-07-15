//
//  ContentView.swift
//  HomeWork2
//
//  Created by Artur Bagautdinov on 15.07.2025.
//

import SwiftUI

struct ContentView: View {

    @State var userLogin: String = ""
    @State var userPassword: String = ""
    @State var showAuthError = false
    @State var isNextScreenShown: User?

    @StateObject var myViewModel: MyViewModel = MyViewModel()

    var body: some View {
        VStack {
            Image(systemName: "iphone")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Login form")

            TextField("Enter your login", text: $userLogin)
                .padding(.top, 60)
                .foregroundStyle(Color.blue)
                .padding(6)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(height: 1)
                }

            SecureField("Enter your password", text: $userPassword)
                .padding(.top, 60)
                .foregroundStyle(Color.blue)
                .padding(6)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(height: 1)
                }
            
            if showAuthError {
                Text("Wrong login or password")
                    .foregroundColor(.red)
                    .transition(.opacity)
            }

            Button {
                isNextScreenShown = myViewModel.authorize(login: userLogin, password: userPassword)
                showAuthError = false
                if isNextScreenShown == nil {
                    showAuthError = true
                }
            } label: {
                Text("Log in")
                    .foregroundStyle(Color.black)
                    .font(.title)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.opacity(0.3))
                    }
            }
            .padding(.top, 20)


        }
        .padding()
        .fullScreenCover(item: $isNextScreenShown) { user in
            MyNewView(user: user)
        }
    }

    @ViewBuilder
    private func getNewView() -> some View {
        Text("Hello, World!")
    }
}

struct MyNewView: View {
    @Environment(\.dismiss) var dismiss
    var user: User

    var body: some View {
        VStack {
            Text("Profile")
            if let avatr = user.avatar {
                Image(avatr)
                    .resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image(.default)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            VStack(spacing: 20) {
                Text(user.name)
                Text("Личная информация")
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Возраст: \(user.age)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Дата рождения: \(user.birthday)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Почта: \(user.email)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Номер телефона: \(user.phone)")
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(1))
                    .frame(width: 200, height: 1)
                
                Text("Биография")
                Text(user.biography)
                    .lineLimit(nil)
                    .fixedSize()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black)
                    .padding(.leading, 30)
            }
        }
        .background {
            Color.accentColor.opacity(0.2).ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}

#Preview("MyNewView") {
    MyNewView(user: User(login: "login", name: "Name", password: "123123", age: 19, birthday: "15.05.2006", email: "@gmail.com", phone: "+79123456789", biography: "Hello, I know Linked Lists very well!"))
}

