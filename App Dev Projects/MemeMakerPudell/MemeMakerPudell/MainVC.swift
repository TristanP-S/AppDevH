//
//  MainVC.swift
//  MemeMakerPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/30/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//TESTED w/ iPhone8, iPhone 11, and iPad Pro (12.9 in.) (3rd Gen)
//KNOWN BUGS/ISSUES: Saved memes have the little white part of the preview at the top (can be fixxed manually by cropping in photo album), keyboard can block what you're writing in the meme protion of the app. App won't work if you don't give it photo album permissions (which it asks you for), formatting changes based on device in weird ways, but all information is still available on screen. Mainly designed for iPhone 8.
//GLOBAL VARIABLES
var mainImg: UIImage = UIImage(named: "default")!
import Foundation
import UIKit
class MainVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //UI components on Main VC, typed button instead of btn, too late to fix it
    @IBOutlet weak var changeImgButton: UIButton!
    @IBOutlet weak var addTextButton: UIButton!
    @IBOutlet weak var memeMakerLbl: UILabel!
    @IBOutlet weak var imgPreviewLbl: UILabel!
    @IBOutlet weak var imgPreview: UIImageView!
    override func viewDidLoad(){
        super.viewDidLoad()
        imgPreview.image = mainImg
    }
    //Abstract image picker class
    func pickAnImage(from source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    //change img buttn pressed
    @IBAction func changeImgPressed(_ sender: Any) {
        //picks an image from the camera
        pickAnImage(from: .photoLibrary)
    }
    //actually sets photo once its picked from photo album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            mainImg = image
        }
        else{
            print("Invalid Photo Error")
        }
        imgPreview.image = mainImg
        self.dismiss(animated: true, completion: nil)
    }
}
