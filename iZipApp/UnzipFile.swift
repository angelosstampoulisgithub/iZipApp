//
//  UnzipFile.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 21/11/24.
//

import SwiftUI
import ZipArchive
struct UnzipFile: View {
    @State var files:[String]
    @State var folder:String
    @State var zipDestination:String
    @State var isPresented:Bool
    let helper = Helper()
    var body: some View {
        VStack{
            HStack {
                TextField("Enter path where is the Zip File", text: $folder).frame(width:300)
                Button {
                    zipDestination = helper.getTempDirectory()
                    SSZipArchive.unzipFile(atPath: folder, toDestination: zipDestination)
                    isPresented.toggle()
                } label: {
                    Text("UnZip File")
                }.alert(isPresented: $isPresented) {
                    Alert(title:Text("Information Message"),message:Text("UnZip file is completed"))
                }
            }
            VStack{
                Text("Files from Folder " + folder).onTapGesture {
                    files = helper.findFiles(path: helper.getTempDirectory())
                    
                }
                List(files,id:\.self){item in
                    Text(item)
                }
            }.onAppear {
                if helper.getTempDirectory().count <= 0 {
                    helper.createTempDirectory()
                }
            }
        }
    }
}

