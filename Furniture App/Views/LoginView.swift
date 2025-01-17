//
//  LoginView.swift
//  LoginPage
//
//  Created by kuet on 16/11/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    var body: some View {
        Home()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct Home: View {

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View{
        VStack{
            if self.status{
                Login()

            } else {
                VStack{
                    Login()
                }
                 .onAppear{
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in

                        self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    }
                }
            }
        }
    }
}




struct HomeScreen: View{
    var body: some View{
        VStack{
            
            Image("currency").resizable().frame(width: 300.0, height: 225.0, alignment: .center)
            
            Text("Signed in successfully")
                .font(.title)
                .fontWeight(.bold)
            
            Button(action: {
                
               // try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                
                Text("Sign out")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Dominant"))
            .cornerRadius(4)
            .padding(.top, 25)
        }
    }
}





struct Login: View{
    
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State private var navigateToContentView = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    
    var body: some View{
        NavigationView{
            VStack(){
                Image("img4").resizable().frame(width: 300.0, height: 255.0, alignment: .top)
                
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                
                TextField("Username or Email",text:self.$email)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
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
                            .foregroundColor(self.color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(borderColor,lineWidth: 2))
                .padding(.top, 10)
                
                HStack{
                    Spacer()
                    Button(action: {
                        //  self.ResetPassword()
                        self.visible.toggle()
                    }) {
                        Text("Forget Password")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Dominant"))
                    }.padding(.top, 10.0)
                }
                
                // Sign in button
                NavigationLink(
                    destination: FurnitureContentView(),
                    isActive: $navigateToContentView
                ) {
                    EmptyView()
                }
                .navigationBarHidden(true)
                .hidden()
                Button(action: {
                    if self.email != "" && self.pass != ""{
                        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                            
                            if err != nil{
                                
                                self.error = err!.localizedDescription
                                self.title = "Login Error"
                                self.alert.toggle()
                                return
                            }
                            
                            print("Login success!")
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                            self.navigateToContentView = true
                        }
                    }else{
                        self.title = "Login Error"
                        self.error = "Please fill all the content property"
                        self.alert = true
                    }
                    
                }) {
                    
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color(.black))
                .cornerRadius(6)
                .padding(.top, 15)
                .alert(isPresented: $alert){()->Alert in
                    return Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                            .default(Text("OK").fontWeight(.semibold)))
                }
                
                HStack{
                    Text("Don't have an account ?")
                    NavigationLink(destination: SignUpView()){
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color(.blue))
                    }
                    Text("now")
                }
                
            }
            .padding(.horizontal, 25)
        }
        
    }
}
