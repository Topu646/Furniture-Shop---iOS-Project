//
//  SignUpView.swift
//  LoginPage
//
//  Created by kuet on 16/11/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
      @State private var pass = ""
      @State private var repass = ""
      @State private var color = Color.black.opacity(0.7)
      @State private var visible = false
      @State private var revisible = false
      @State private var alert = false
      @State private var error = ""
        
//        @State var email = ""
//        @State var pass = ""
//        @State var repass = ""
//
//        @State var color = Color.black.opacity(0.7)
//
//        @State var visible = false
//        @State var revisible = false
//
//        @State var alert = false
//        @State var error = ""
    @State private var navigateToContentView = false
        let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
        
        var body: some View{
            
            
            VStack(alignment: .leading){
                
                GeometryReader{_ in
                    
                    VStack{
                        Image("img4").resizable().frame(width: 300.0, height: 255.0, alignment: .center)
                        
                        Text("Sign up a new account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 15)
                        
                        TextField("Username or Email",text:self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                            .padding(.top, 0)
                        
                        HStack(spacing: 15){
                            VStack{
                                
                                
                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .opacity(0.8)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6)
                            .stroke(self.borderColor,lineWidth: 2))
                        .padding(.top, 10)
                        
                        
                        // Confirm password
                        HStack(spacing: 15){
                            VStack{
                                if self.revisible {
                                    TextField("Confirm Password", text: self.$repass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Confirm Password", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.revisible.toggle()
                            }) {
                                //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .opacity(0.8)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6)
                            .stroke(self.borderColor,lineWidth: 2))
                        .padding(.top, 10)
                        
                        NavigationLink(
                            destination: LoginView(),
                            isActive: $navigateToContentView
                        ) {
                            EmptyView()
                        }
                        
                        .hidden()
                        // Sign up button
                        Button(action: {
                            if self.email != ""{
                                        if self.pass == self.repass{
                            
                                            Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                                                if let error = err {
                                                        print("Error creating user:", error.localizedDescription)
                                                        self.error = error.localizedDescription
                                                        self.alert.toggle()
                                                        return
                                                    }
                            
                                                if err != nil{
                            
                                                    self.error = err!.localizedDescription
                                                    self.alert.toggle()
                                                    return
                                                }
                            
                                                print("success")
                            
                                                UserDefaults.standard.set(true, forKey: "status")
                                                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                                                self.navigateToContentView = true
                                            }
                                        }
                                        else{
                            
                                            self.error = "Password mismatch"
                                            self.alert.toggle()
                                        }
                                    }
                                    else{
                            
                                        self.error = "Please fill all the contents properly"
                                        self.alert.toggle()
                                    }
                        }) {
                            Text("Sign up")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color(.black))
                        .cornerRadius(6)
                        .padding(.top, 15)
                        .alert(isPresented: self.$alert){()->Alert in
                            return Alert(title: Text("Sign up error"), message: Text("\(self.error)"), dismissButton:
                                    .default(Text("OK").fontWeight(.semibold)))
                        }
                        
                    }
                    .padding(.horizontal, 25)
                }
            }
        }
    }
    
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }

