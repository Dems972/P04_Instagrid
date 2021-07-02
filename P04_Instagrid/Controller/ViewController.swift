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

    @IBOutlet weak var viewSwipe: UIStackView!

    var recover = 1

    enum direction {
        case left, up
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout(button2)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))

        if view.bounds.size.height > view.bounds.size.width {
            swipeGesture.direction = .up
        }
        else {
            swipeGesture.direction = .left
        }
        self.viewSwipe.addGestureRecognizer(swipeGesture)


    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        swipe()
    }

    @IBAction func buttonLayout(_ sender: UIButton) {
        for button in buttonsDown {
            button.isSelected = false
        }

        sender.isSelected = true

        switch sender.tag {
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

    private func addImage() {
        let pickImage = UIImagePickerController()
        pickImage.sourceType = .photoLibrary
        pickImage.delegate = self
        pickImage.allowsEditing = true
        present(pickImage, animated: true)
    }

    private func swipe() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))

        for recognizer in viewSwipe.gestureRecognizers ?? [] {
                        viewSwipe.removeGestureRecognizer(recognizer)
                    }
        if view.bounds.size.height > view.bounds.size.width {
            swipeGesture.direction = .left
        }
        else {
            swipeGesture.direction = .up
        }
        self.viewSwipe.addGestureRecognizer(swipeGesture)
    }




    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer) {
//        let activity = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
//        activity.popoverPresentationController?.sourceView = self.view
//        self.present(activity, animated: true, completion: nil)

        if UIDevice.current.orientation.isLandscape {
            print("left")
            self.animationY(value: -UIScreen.main.bounds.height)
        } else {
            print("up")
            self.animationX(with: -UIScreen.main.bounds.width)
        }

    }

    @IBAction func tapButton(_ sender: UIButton) {
        switch sender.tag {
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

    private func animationX(with value: CGFloat) {
        UIView.animate(withDuration: 1.5, delay: 0.3, options: [.curveEaseOut]) {
            self.viewPhoto.transform = CGAffineTransform(translationX: 0, y: -700)
        } completion: { (success) in
            self.shareActivity()
        }
    }
    private func animationY(value: CGFloat) {
        UIView.animate(withDuration: 1.5, delay: 0.3, options: [.curveEaseOut]) {
            self.viewPhoto.transform = CGAffineTransform(translationX: -700, y: 0)
        } completion: { (success) in
            self.shareActivity()
        }
    }

    private func shareActivity() {
        let renderer = UIGraphicsImageRenderer(size: viewPhoto.bounds.size)
        let capturedImage = renderer.image {
            (ctx) in
            viewPhoto.drawHierarchy(in: viewPhoto.bounds, afterScreenUpdates: true)
        }
        let activityController = UIActivityViewController (activityItems: [capturedImage], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { _ , _ , _, _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.viewPhoto.transform = .identity
            })
        }
    }
    
//
//    @objc func panOnGridView(_ sender: UIPanGestureRecognizer) {
//
//        switch sender.state {
//        case .began, .changed:
//        transformGridViewWith(gesture: sender)
//        case .cancelled, .ended:
//        let size = view.bounds
//
//        if size.width > size.height { // Si on est en mode paysage
//        if sender.location(in: self.view).x < view.center.x - 50 {
//            userLetGoOfGridView(direction: .left)
//                    } else {
//                        UIView.animate(withDuration: 0.3) {
//                            self.viewPhoto.transform = .identity
//                        }
//                    }
//                } else {
//                    if sender.location(in: self.view).y < view.center.y - 50 {
//                        userLetGoOfGridView(direction: .up)
//                    } else {
//                        UIView.animate(withDuration: 0.3) {
//                            self.viewPhoto.transform = .identity
//                        }
//                    }
//                }
//            default:
//                break
//            }
//        }
//
//        func transformGridViewWith(gesture: UIPanGestureRecognizer) {
//            let translation = gesture.translation(in: viewPhoto)
//            let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
//            viewPhoto.transform = translationTransform
//        }
//
//    func userLetGoOfGridView(direction: direction) {
//
//            let screenWidth = UIScreen.main.bounds.width
//            var translationTransform: CGAffineTransform
//
//            if direction == .up {
//                translationTransform = CGAffineTransform(translationX: 0, y: -screenWidth - viewPhoto.bounds.height)
//            } else {
//                translationTransform = CGAffineTransform(translationX: -screenWidth - viewPhoto.bounds.width, y: 0)
//            }
//
//            UIView.animate(withDuration: 0.3) {
//                self.viewPhoto.transform = translationTransform
//            } completion: { (success) in
//                if success {
//                    self.swipe()
//                }
//            }
//        }
//
//        func gridViewReturnToInitialPos() {
//
//            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
//                self.viewPhoto.transform = .identity
//            }, completion: nil)
//        }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            switch recover {
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

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
