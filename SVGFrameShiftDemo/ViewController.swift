//
//  ViewController.swift
//  SVGFrameShiftDemo
//
//  Created by Nathan Andersen on 4/20/16.
//
//

import UIKit
import SVGPlayButton

class ViewController: UIViewController {


    /** 
     This class builds 2 views:
     view one: at the top on the right, in yellow
     view two: in the middle, on the left, in orange.
     
     There are 2 buttons:
     button 1 removes the play button from its superview, then adds it to view one, in the center
     button 2 "".... adds it to view two, in the center.
     
     the button is always constrained to the height of its parent and an equal aspect ratio to itself
     so we would expect to see it blow up
     
     However, we don't.

     */

    var viewOne: UIView!
    var viewTwo: UIView!
    var playButton: SVGPlayButton!

    var addToViewOneButton: UIButton!
    var addToViewTwoButton: UIButton!

    var pbViewOneConstraints: [NSLayoutConstraint]!
    var pbViewTwoConstraints: [NSLayoutConstraint]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        renderViewOne()
        renderViewTwo()
        renderPlayButton()
        renderToggleButtons()
        addConstraintsToViewOne()
        addConstraintsToViewTwo()
        addConstraintsToPlayButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func renderViewOne() {
        viewOne = UIView()
        viewOne.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(viewOne)
    }

    func addConstraintsToViewOne() {
        viewOne.translatesAutoresizingMaskIntoConstraints = false

        // constrain to 50 from left, 0 from right, 40 from top, and height 100
        NSLayoutConstraint(item: viewOne, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 50).active = true
        NSLayoutConstraint(item: viewOne, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: viewOne, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 40).active = true
        NSLayoutConstraint(item: viewOne, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100).active = true
        viewOne.updateConstraints()
    }

    func renderViewTwo() {
        viewTwo = UIView()
        viewTwo.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(viewTwo)
    }

    func addConstraintsToViewTwo() {
        viewTwo.translatesAutoresizingMaskIntoConstraints = false

        // constrain to 0 from left, 80 from right, height 150, and 60 below view 1
        NSLayoutConstraint(item: viewTwo, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: viewTwo, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -80).active = true
        NSLayoutConstraint(item: viewTwo, attribute: .Top, relatedBy: .Equal, toItem: viewOne, attribute: .Bottom, multiplier: 1, constant: 60).active = true
        NSLayoutConstraint(item: viewTwo, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 150).active = true
        viewTwo.updateConstraints()
    }

    func renderPlayButton() {
        playButton = SVGPlayButton()
        self.viewOne.addSubview(playButton)

    }

    func addConstraintsToPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false

        // aspect ratio = square
        let pbAspect = NSLayoutConstraint(item: playButton, attribute: .Height, relatedBy: .Equal, toItem: playButton, attribute: .Width, multiplier: 1, constant: 0)

        // constrain to center X, center Y, height of view 1
        let pbViewOneCX = NSLayoutConstraint(item: playButton, attribute: .CenterX, relatedBy: .Equal, toItem: viewOne, attribute: .CenterX, multiplier: 1, constant: 0)
        let pbViewOneCY = NSLayoutConstraint(item: playButton, attribute: .CenterY, relatedBy: .Equal, toItem: viewOne, attribute: .CenterY, multiplier: 1, constant: 0)
        let pbViewOneHeight = NSLayoutConstraint(item: playButton, attribute: .Height, relatedBy: .Equal, toItem: viewOne, attribute: .Height, multiplier: 1, constant: 0)

        // constrain to center X, center Y, height of view 2
        let pbViewTwoCX = NSLayoutConstraint(item: playButton, attribute: .CenterX, relatedBy: .Equal, toItem: viewTwo, attribute: .CenterX, multiplier: 1, constant: 0)
        let pbViewTwoCY = NSLayoutConstraint(item: playButton, attribute: .CenterY, relatedBy: .Equal, toItem: viewTwo, attribute: .CenterY, multiplier: 1, constant: 0)
        let pbViewTwoHeight = NSLayoutConstraint(item: playButton, attribute: .Height, relatedBy: .Equal, toItem: viewTwo, attribute: .Height, multiplier: 1, constant: 0)

        pbViewOneConstraints = [pbAspect,pbViewOneCX,pbViewOneCY,pbViewOneHeight]
        pbViewTwoConstraints = [pbAspect,pbViewTwoCX,pbViewTwoCY,pbViewTwoHeight]
    }

    func renderToggleButtons() {
        addToViewOneButton = UIButton(type: .System)
        addToViewOneButton.setTitle("Add To View One", forState: .Normal)
        addToViewOneButton.addTarget(self, action: #selector(ViewController.addPlayButtonToViewOne), forControlEvents: .TouchUpInside)

        self.view.addSubview(addToViewOneButton)


        addToViewTwoButton = UIButton(type: .System)
        addToViewTwoButton.setTitle("Add To View Two", forState: .Normal)
        addToViewTwoButton.addTarget(self, action: #selector(ViewController.addPlayButtonToViewTwo), forControlEvents: .TouchUpInside)

        self.view.addSubview(addToViewTwoButton)

        addToViewOneButton.translatesAutoresizingMaskIntoConstraints = false
        addToViewTwoButton.translatesAutoresizingMaskIntoConstraints = false

        // constrain to center x of overall but below view two, in a vertical stack

        NSLayoutConstraint(item: addToViewOneButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: addToViewTwoButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: addToViewOneButton, attribute: .Top, relatedBy: .Equal, toItem: viewTwo, attribute: .Bottom, multiplier: 1, constant: 20).active = true
        NSLayoutConstraint(item: addToViewTwoButton, attribute: .Top, relatedBy: .Equal, toItem: addToViewOneButton, attribute: .Bottom, multiplier: 1, constant: 20).active = true

        // wide enough that the text is clear
        NSLayoutConstraint(item: addToViewOneButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 200).active = true
        NSLayoutConstraint(item: addToViewTwoButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 200).active = true


        addToViewOneButton.updateConstraints()
        addToViewTwoButton.updateConstraints()
    }

    func addPlayButtonToViewOne() {
        // remove it from its superview
        playButton.constraints.forEach({$0.active = false})
        playButton.removeFromSuperview()

        // add it to view 1
        viewOne.addSubview(playButton)
        // activate its view 1 constraints
        pbViewOneConstraints.forEach({$0.active = true})
        // update the constraints / rendering
        playButton.updateConstraints()
        // call layout if needed on the parent
        viewOne.layoutIfNeeded()
    }

    func addPlayButtonToViewTwo() {
        // see above function for documentation
        playButton.constraints.forEach({$0.active = false})
        playButton.removeFromSuperview()

        viewTwo.addSubview(playButton)
        pbViewTwoConstraints.forEach({$0.active = true})
        playButton.updateConstraints()
        viewTwo.layoutIfNeeded()
    }


}

