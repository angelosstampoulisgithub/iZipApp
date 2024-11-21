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
}
