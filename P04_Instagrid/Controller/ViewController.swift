//
//  ViewController.swift
//  P04_Instagrid
//
//  Created by Dems on 11/05/2021.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var viewPhoto: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!


    @IBOutlet var buttonsDown: [UIButton]!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for family : String in UIFont.familyNames
        {
            print(family)
            for names : String in UIFont.fontNames(forFamilyName: family)
            {
                print("==\(names)")
            }
        }
        
    }


    @IBAction func buttonLayout(_ sender: UIButton)
    {

        for button in buttonsDown
        {
            button.isSelected = false
        }

        sender.isSelected = true


        switch sender.tag
        {
            case 1:
                button1.isHidden = true
                button3.isHidden = false
            case 2:
                button3.isHidden = true
                button1.isHidden = false
            case 3:
                button3.isHidden = false
                button1.isHidden = false

            default :
                break

        }

    }

    func addImage()
    {
        let pickImage = UIImagePickerController()
        pickImage.sourceType = .photoLibrary
        pickImage.delegate = self
        pickImage.allowsEditing = true
        present(pickImage, animated: true)
    }

    var recover = 1 // reception the position of image

    @IBAction func tapButton1(_ sender: UIButton)
    {
        recover = 1
        addImage()
    }

    @IBAction func tapButton2(_ sender: UIButton)
    {
        recover = 2
        addImage()
    }

    @IBAction func tapButton3(_ sender: UIButton)
    {
        recover = 3
        addImage()
    }

    @IBAction func tapButton4(_ sender: UIButton)
    {
        recover = 4
        addImage()
    }


    /*@IBAction func tapButton(_ sender: UIButton)
    {
        switch sender.tag
        {
            case 1:
                recover = 1
                addImage()
            case 2:
                recover = 2
                addImage()
            case 3:
                recover = 3
                addImage()
            case 4:
                recover = 4
                addImage()
            default :
                break
        }
    }*/
    

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
       {
            switch recover
            {
            case 1:
                button1.setImage(image, for: .normal)
            case 2:
                button2.setImage(image, for: .normal)
            case 3:
                button3.setImage(image, for: .normal)
            case 4:
                button4.setImage(image, for: .normal)
            default:
                break
            }

       }

        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

