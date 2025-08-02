//
//  ContentView.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 19/11/24.
//

import SwiftUI
import Foundation
struct ContentView: View {

    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Image(.main).resizable().frame(width:240,height:235,alignment: .topLeading)
                } .frame(maxWidth: .infinity,maxHeight: 245,alignment: .topLeading)
                VStack(alignment: .trailing, spacing: 20){
                    NavigationLink {
                        CreateZipFile(files: [], folder: "", zipFile: "", isPresented: false)
                    } label: {
                        Text("Zip File").frame(width:150,height:60)
                    }.padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    Button {
                        exit(0)
                    } label: {
                        Text("Close Application").frame(width:150,height:60)
                    }.padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)

                  
                }.frame(width:450,height:205,alignment:.topTrailing)
                ZStack{
                    VStack{
                        Text("Copyright (c) 2024 Angelos Staboulis").frame(width:300,height:60,alignment: .bottom)

                    }.frame(maxWidth: .infinity,maxHeight: 285,alignment: .bottom)
                }
            }
          
        }
        
    }
}

#Preview {
    ContentView()
}
