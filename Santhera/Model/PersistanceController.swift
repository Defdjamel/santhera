//
//  PersistanceManager.swift
//  Santhera
//
//  Created by Santhera on 09/05/2018.
//  Copyright © 2018 Santhera. All rights reserved.
//

import Foundation
import CoreData

public class PersistanceController {
    
    static public let shared = PersistanceController()
    
    let layer = CoreDataLayer()
    let entityName = "Image"
    
    public init() {}
    
    // MARK: - Core Data
    
    public func createImage(picture: UIImage) -> Image? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.layer.managedObjectContext) else {
            return nil
        }
        
        let date = Date()
        let imageTitle = DateFormatter.localizedString(from: date, dateStyle: .full, timeStyle: .medium)
        let imageKey = DateFormatter.localizedString(from: date, dateStyle: .full, timeStyle: .full)
        
        let image = Image(entity: entityDescription, insertInto: self.layer.managedObjectContext)
        image.title = imageTitle
        image.path = imageKey
        image.date = date
        self.saveContext()
        self.savePicture(picture: picture, key: imageKey)
        return image
    }

    public func fetchImages() -> [Image]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sort = NSSortDescriptor(key: #keyPath(Image.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]

        do {
            let images = try self.layer.managedObjectContext.fetch(fetchRequest) as! [Image]
            return images
        } catch {
            print("Fetching images failed")
        }
        return nil
    }

    public func deleteImage(_ image: Image) {
        self.layer.managedObjectContext.perform({
            self.layer.managedObjectContext.delete(image)
            self.saveContext()
        })
    }

    public func deleteAllImages() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try layer.managedObjectContext.execute(request)
            try layer.managedObjectContext.save()
        } catch {
            print("can't delete all entity instances")
        }
    }
    
    public func saveContext() {
        self.layer.saveContext()
    }
    
    // MARK: - Pictures
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePicture(picture: UIImage, key: String) {
        if let data = UIImageJPEGRepresentation(picture, 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(key).jpg")
            print(filename)
            do {
                try data.write(to: filename)
            } catch {
                print("can't save picture")
            }
        }
    }
    
    func getPicture(Key: String) -> UIImage? {
        let fileManager = FileManager.default
        let filename = getDocumentsDirectory().appendingPathComponent("\(Key).jpg")
        if fileManager.fileExists(atPath: filename.path) {
            return UIImage(contentsOfFile: filename.path)
        }
        return nil
    }
}
