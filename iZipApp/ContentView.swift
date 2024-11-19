//
//  ContentView.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var files:[String]
    @State var folder:String
    @State var zipFile:String
    @State var isPresented:Bool
    var body: some View {
        VStack{
            HStack {
                
                TextField("Enter path for a folder", text: $folder).frame(width:300)
                Button {
                    do{
                        files = try FileManager.default.contentsOfDirectory(atPath:folder)
                    }catch{
                        debugPrint("something went wrong!!!!"+error.localizedDescription)
                    }
                } label: {
                    Text("List files from Folder")
                }
                TextField("Enter path for a Zip File", text: $zipFile).frame(width:300)
                Button {
                            let directoryURL = URL(fileURLWithPath: folder)
                            let zipURL = URL(fileURLWithPath: zipFile)
                            var coordinatorError: NSError?
                            let coordinator = NSFileCoordinator()
                            coordinator.coordinate(
                                readingItemAt: directoryURL,
                                options: .forUploading,
                                error: &coordinatorError
                            ) { zipCreatedURL in
                                do {
                               
                                    try FileManager.default.moveItem(at: zipCreatedURL, to: zipURL)
                                    isPresented = true
                                } catch {
                                    debugPrint("error=",error.localizedDescription)
                                }
                            }
                           

                } label: {
                    Text("Create Zip File")
                }.alert(isPresented: $isPresented) {
                    Alert(title:Text("Information Message"),message:Text("Zip file is created"))
                }
            }
            VStack{
                Text("Files from Folder " + folder)
                List(files,id:\.self){item in
                    Text(item).onTapGesture {
                        debugPrint("item=",item)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView(files: [], folder: "", zipFile: "", isPresented: false)
}
