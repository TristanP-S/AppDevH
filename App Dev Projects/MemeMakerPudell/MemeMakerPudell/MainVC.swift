//
//  MainVC.swift
//  MemeMakerPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/30/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//GLOBAL VARIABLES
var mainImg: UIImage = UIImage(named: "default")!
import Foundation
import UIKit
class MainVC: UIViewController{
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
    @IBAction func changeImgPressed(_ sender: Any) {
        //checks if device used has a camera, uses album if not
        if(UIImagePickerController.availableCaptureModes(for: .rear) != nil){
        pickAnImage(from: .photoLibrary)
        } else{
        pickAnImage(from: .camera)
        }
    }
    @IBAction func addTextPressed(_ sender: Any) {
        
        present(ImgVC(), animated: true, completion: nil)
    }
}
