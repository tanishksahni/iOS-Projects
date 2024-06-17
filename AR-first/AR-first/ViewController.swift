//
//  ViewController.swift
//  AR-first
//
//  Created by Anupinder Singh on 06/02/24.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    //outlet for the AR view
    @IBOutlet var arView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.scene = SCNScene()
        
        let sun = createSphere()
        arView.scene.rootNode.addChildNode(sun)
        let earth = createEarth()
        sun.addChildNode(earth)
        let moon = createMoon()
        earth.addChildNode(moon)
        
//        arView.scene.rootNode.addChildNode(createBox())
    }

    override func viewWillAppear(_ animated: Bool) {
        let myConfiguration = ARWorldTrackingConfiguration()
        arView.session.run(myConfiguration)
    }
    
    func createBox() -> SCNNode
    {
        let box = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1)
        
        
        let material  = SCNMaterial()
        material.diffuse.contents = UIColor.red
        box.materials = [material]
        
        let node = SCNNode(geometry: box)
        node.position = SCNVector3(x: 0.0, y: 0.0, z: -10.0)
        
        let action = SCNAction.rotate(by: Double.pi, around: SCNVector3(x: 0, y: 1, z: 0), duration: 2)
        
        node.runAction(SCNAction.repeatForever(action))
        
            
        return node
    }
    
    
    func createSphere() -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.5)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "sun")
        let node = SCNNode(geometry: sphere)
        
        let rotation = SCNAction.rotate(by: Double.pi, around: SCNVector3(0, 1, 0), duration: 50)
        node.runAction(SCNAction.repeatForever(rotation))
        return node
    }
    
    
    func createEarth() -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "earth_daymap")
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3(2, 0, 0)
        let rotation = SCNAction.rotate(by: Double.pi, around: SCNVector3(0, 1, 0), duration: 10)
        node.runAction(SCNAction.repeatForever(rotation))
        return node
    }
    
    func createMoon() -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "moon")
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3(-1, 0, 0)
        let rotation = SCNAction.rotate(by: Double.pi, around: SCNVector3(0, 1, 0), duration: 10)
        node.runAction(SCNAction.repeatForever(rotation))
        return node
    }
    

}

