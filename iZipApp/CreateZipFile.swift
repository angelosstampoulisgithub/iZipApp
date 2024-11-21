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
    @State var isSelected:Bool
    let helper = Helper()
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
                            if isSelected{
                                let directoryURL = URL(fileURLWithPath:helper.getTempDirectory())
                                let zipURL = URL(fileURLWithPath: zipFile)
                                var coordinatorError: NSError?
                                let coordinator = NSFileCoordinator()
                                coordinator.coordinate(
                                    readingItemAt:directoryURL,
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
                                
                            }else{
                                let directoryURL = URL(fileURLWithPath:folder)
                                let zipURL = URL(fileURLWithPath: zipFile)
                                var coordinatorError: NSError?
                                let coordinator = NSFileCoordinator()
                                coordinator.coordinate(
                                    readingItemAt:directoryURL,
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
                                
                            }
                            
                            
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
                    Text(item).onTapGesture {
                        do{
                            try FileManager.default.copyItem(at: URL(filePath:folder+"/"+item), to:  URL(filePath:helper.getTempDirectory()+"/"+item))
                            isSelected.toggle()
                        }catch{
                            debugPrint("something went wrong"+error.localizedDescription)
                        }
                    }
                }
            }.onAppear {
                helper.createTempDirectory()
            }.onDisappear {
                helper.removeTempDirectory()
            }
        }
    }
}

#Preview {
    CreateZipFile(files: [], folder: "", zipFile: "", isPresented: false, isSelected: false)
}
