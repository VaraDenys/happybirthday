//
//  ImagePickerCoordinator.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit
import PhotosUI

protocol ImagePickerCoordinatorDelegate: AnyObject {
    func imagePickerCoordinator(_ coordinator: ImagePickerCoordinator,
                                didPick result: (image: UIImage, name: String?)?,
                                error: AppErrorType?)
    func imagePickerDidCancel()
}

class ImagePickerCoordinator: NSObject {
    private weak var presentingVC: UIViewController?
    weak var delegate: ImagePickerCoordinatorDelegate?

    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }

    func presentPicker() {
        let alert = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                self.presentCamera()
            })
        }

        alert.addAction(UIAlertAction(title: "Choose from Gallery", style: .default) { _ in
            self.presentPhotoLibrary()
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.delegate?.imagePickerDidCancel()
        })

        presentingVC?.present(alert, animated: true)
    }

    private func presentCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        presentingVC?.present(picker, animated: true)
    }

    private func presentPhotoLibrary() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        presentingVC?.present(picker, animated: true)
    }
}

    // MARK: - UIImagePickerControllerDelegate (Camera)

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            delegate?.imagePickerCoordinator(self, didPick: nil, error: .imageLoadingError)
            return
        }

        var fileName: String?
        if let url = info[.imageURL] as? URL {
            fileName = url.lastPathComponent
        }

        delegate?.imagePickerCoordinator(self, didPick: (image, fileName), error: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        delegate?.imagePickerDidCancel()
    }
}

    // MARK: - PHPickerViewControllerDelegate (Photo Library)

extension ImagePickerCoordinator: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) else {
            delegate?.imagePickerCoordinator(self, didPick: nil, error: .imageLoadingError)
            return
        }

        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            DispatchQueue.main.async {
                guard let self else { return }

                if let error {
                    print("Image loading error: \(error.localizedDescription)")
                    self.delegate?.imagePickerCoordinator(self, didPick: nil, error: .imageLoadingError)
                    return
                }

                if let image = object as? UIImage {
                    let name = itemProvider.suggestedName
                    self.delegate?.imagePickerCoordinator(self, didPick: (image, name), error: nil)
                } else {
                    self.delegate?.imagePickerCoordinator(self, didPick: nil, error: .imageLoadingError)
                }
            }
        }
    }
}
