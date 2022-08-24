//
//  FileManager.swift
//  MyReminder-S.M
//
//  Created by Mcbook Pro on 23.08.22.
//

import UIKit

class FileManagersActions {
    
    private let manager = FileManager.default
    
    func saveToFileManager(textFromTexfield: String){
        
        var allUrls = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        allUrls?.appendPathComponent(textFromTexfield)
        
        try? manager.createDirectory(at: allUrls!, withIntermediateDirectories: true)
        
        
    }
   
    func writeFile(titleOfTextFile: String, tapedDir: String){
        
        let file = titleOfTextFile //this is the file. we will write to and read from it

        let text = ""
       
        if let dir = manager.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent("\(tapedDir)/\(titleOfTextFile)")

            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}

            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    func fetchDataFromFM(complition:([String])->Void){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        guard let documentDirectory = paths.first else { return }
        
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            
            complition(allItems)
        }
    }
    
   
}
