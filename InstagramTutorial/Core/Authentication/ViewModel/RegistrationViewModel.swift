//
//  RegistrationViewModel.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/21/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
