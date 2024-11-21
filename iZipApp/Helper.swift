//
//  Helper.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 21/11/24.
//

import Foundation
class Helper{
    func getHomeDirectory()->String{
        return NSHomeDirectory()
    }
    func getTempDirectory()->String{
        return getHomeDirectory() + "/temp"
    }
    func createTempDirectory(){
        let urlTemp = URL(filePath: getHomeDirectory() + "/temp")
        do{
            try FileManager.default.createDirectory(at: urlTemp, withIntermediateDirectories: false)
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    func removeTempDirectory(){
        let urlTemp = URL(filePath: getHomeDirectory() + "/temp")
        do{
            try FileManager.default.removeItem(at: urlTemp)
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    func findFiles(path:String)->[String]{
            var files:[String] = []
            do{
                files =  try FileManager.default.contentsOfDirectory(atPath: path+"/")
                var attributes:[FileAttributeKey:Any] = [:]
                for file in files{
                     attributes =  try FileManager.default.attributesOfItem(atPath: path + "/" + file)
                    let getType = String(describing:attributes[.type] as! FileAttributeType)
                    if  getType.contains("NSFileTypeDirectory"){
                        files.append(contentsOf:findFiles(path: path + "/" + file))
                        break
                    }
                    
                }
                
            }catch{
                debugPrint("something went wrong!!!"+error.localizedDescription)
        }
        return files
    }
}
