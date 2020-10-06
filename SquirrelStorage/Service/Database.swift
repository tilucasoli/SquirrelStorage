//
//  Database.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 23/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

class Database {
    
    let fileURL: URL
    
    init(filename: String) {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = url.appendingPathComponent(filename).appendingPathExtension("json")
        self.fileURL = fileURL
        print(fileURL)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // This saves an empty array. Since the function is generic, I need to specify the empty array's type, but it will work for every type.
            saveItems([Product]())
        }
    }
        
    func saveItems<EncodableType: Encodable>(_ itemsToBeSaved: [EncodableType]) {
        do {
            let jsonData = try JSONEncoder().encode(itemsToBeSaved)
            try jsonData.write(to: fileURL)
        } catch {
            print("It was not possible to save the items.")
        }
    }
    
    func loadItems<DecodableType: Decodable>() -> [DecodableType] {
        var loadedItems: [DecodableType] = []
        do {
            let jsonData = try Data(contentsOf: fileURL)
            loadedItems = try JSONDecoder().decode([DecodableType].self, from: jsonData)
            return loadedItems
        } catch {
            print("It was not possible to load the items.")
            return loadedItems
        }
    }
    
    func addItem<CodableType: Codable>(_ itemToBeSaved: CodableType) {
        var items: [CodableType] = loadItems()
        items.append(itemToBeSaved)
        saveItems(items)
    }
    
    @discardableResult func removeItem<CodableType: Codable>(_ type: CodableType.Type, at index: Int) -> CodableType? {
        var items: [CodableType] = loadItems()
        guard index < items.count && index >= 0 else {
            return nil
        }
        let removedItem = items.remove(at: index)
        saveItems(items)
        return removedItem
    }
    
    func updateItem<CodableType: Codable>(_ itemToBeUpdated: CodableType, at index: Int) {
        var items: [CodableType] = loadItems()
        guard index < items.count && index >= 0 else {
            return
        }
        items[index] = itemToBeUpdated
        saveItems(items)
    }
    
}
