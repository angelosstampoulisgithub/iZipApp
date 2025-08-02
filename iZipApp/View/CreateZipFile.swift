//
//  CreateZipFile.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 21/11/24.
//

import SwiftUI

struct CreateZipFile: View {
    @State var files:[String]
    @State var folder:String
    @State var zipFile:String
    @State var isPresented:Bool
    @State var helper = Helper()
    var body: some View {
        VStack{
            VStack {
                VStack{
                    HStack{
                        TextField("Enter path for a folder", text: $folder).frame(width:200)
                        Button {
                            do{
                                files = try FileManager.default.contentsOfDirectory(atPath:folder)
                                
                            }catch{
                                debugPrint("something went wrong!!!!"+error.localizedDescription)
                            }
                        } label: {
                            Text("List files from Folder").frame(width:200)
                        }
                    }.frame(width:400,alignment: .leading)
                    .padding(10)
                    HStack{
                        TextField("Enter path for a Zip File", text: $zipFile).frame(width:200)
                        Button {
                            helper.createZipFile(folder: folder, zipFile: zipFile)
                                isPresented = true
                        } label: {
                            Text("Create Zip File").frame(width:200)
                        }.alert(isPresented: $isPresented) {
                            Alert(title:Text("Information Message"),message:Text("Zip file is created"))
                        }.frame(width:400,alignment: .leading)
                    }.frame(width:400,alignment: .leading)
                }.frame(width:400)
            }.frame(width:400)
            VStack{
                Text("Files from Folder " + folder)
                List(files,id:\.self){item in
                    Text(item)
                }
            }
        }
    }
}

#Preview {
    CreateZipFile(files: [], folder: "", zipFile: "", isPresented: false)
}
