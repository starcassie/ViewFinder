//
//  AddPhotoViewController.swift
//  ViewFinder
//
//  Created by Apple on 6/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newScreen = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        newScreen.delegate = self
        newImage.image = UIImage(named: "img-placeholder.3")
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var newImage: UIImageView!
    @IBAction func openCamera(_ sender: UIButton) {
        newScreen.sourceType = .camera
        present(newScreen, animated: true, completion:  nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage.image = selectedImage
        }
        newScreen.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func accessLibrary(_ sender: UIButton) {
        newScreen.sourceType = .photoLibrary
        present(newScreen, animated: true, completion: nil)
    }
    @IBAction func savePhoto(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = comment.text
            if let userImage = newImage.image {
                if let userImageData = userImage.pngData() {
                    photoToSave.imageData =  userImageData
                }
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
