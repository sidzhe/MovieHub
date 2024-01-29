//
//  EditProfileViewController+ImagePickerController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 28.01.2024.
//

import UIKit
// MARK: - Protocols for load Image from gallery
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 60
        dismiss(animated: true, completion: nil)
    }
    
    private func chooseImage(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setAlertAction(alert: UIAlertController, imageLoad: ImageLoad) {
        let action: UIAlertAction
        
        switch imageLoad {
        case .camera:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .camera)
            }
            action.setValue(UIColor.darkGray, forKey: "titleTextColor")
        case .photoLibrary:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .photoLibrary)
            }
            action.setValue(UIColor.darkGray, forKey: "titleTextColor")
        case .cancel:
            action = UIAlertAction(title: imageLoad.rawValue, style: .destructive, handler: nil)
        }
        alert.addAction(action)
    }
    
    func alertImageView() {
        let alert = UIAlertController(title: nil, message: "Выберите способ загрузки фотографии", preferredStyle: .alert)
        
        setAlertAction(alert: alert, imageLoad: .camera)
        setAlertAction(alert: alert, imageLoad: .photoLibrary)
        setAlertAction(alert: alert, imageLoad: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
