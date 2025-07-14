//
//  ImageStore.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import Foundation
import UIKit

class ImageStore {
    static let shared = ImageStore()
    static let fallbackName = "fallback_name"
    private var currentFileName: String? {
        didSet {
            DefaultsManager.imageFileName = currentFileName
        }
    }

    private init() {
        currentFileName = DefaultsManager.imageFileName
    }

    func save(image: UIImage, named fileName: String?) {
        self.removeImage()
        
        guard let data = image.pngData() else {
            print("ImageStore: Failed to convert image to PNG data.")
            return
        }
        let url = self.fileURL(for: fileName ?? Self.fallbackName)

        do {
            try data.write(to: url)
            self.currentFileName = fileName
            return
        } catch {
            print("ImageStore: Failed to write image data: \(error)")
            return
        }
    }

    func getImageInfo() -> (image: UIImage?, name: String?) {
        let url = self.fileURL(for: currentFileName ?? Self.fallbackName)
        guard FileManager.default.fileExists(atPath: url.path) else { return (nil, nil) }
        
        return (image: UIImage(contentsOfFile: url.path), name: self.currentFileName)
    }

    func removeImage() {
        let url = self.fileURL(for: self.currentFileName ?? Self.fallbackName)
        
        guard FileManager.default.fileExists(atPath: url.path) else { return }

        do {
            try FileManager.default.removeItem(at: url)
            self.currentFileName = nil
            return
        } catch {
            print("ImageStore: Failed to delete image: \(error)")
            return
        }
    }

    private func fileURL(for fileName: String) -> URL {
        let fileManager = FileManager.default
        let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("\(fileName).png")
    }
}
