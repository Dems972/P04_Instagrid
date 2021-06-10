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


    @IBOutlet weak var viewSwipe: UIView!
    
    var recover = 1

    override func viewDidLoad()
    {
        super.viewDidLoad()
        swipe()

    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
    {
        swipe()
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

    private func addImage()
    {
        let pickImage = UIImagePickerController()
        pickImage.sourceType = .photoLibrary
        pickImage.delegate = self
        pickImage.allowsEditing = true
        present(pickImage, animated: true)
    }

    private func swipe()
    {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))

        if view.bounds.size.height > view.bounds.size.width
        {
            print ("landscape")
            swipeGesture.direction = .up
        }
        else 
        {
            print ("portrait")
            swipeGesture.direction = .left
        }
        self.viewSwipe.addGestureRecognizer(swipeGesture)
    }

    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer)
    {
        print("gesture ok")
        let activity = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view

        self.present(activity, animated: true, completion: nil)
    }

    @IBAction func tapButton(_ sender: UIButton)
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
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
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
