//
//  ViewController.swift
//  SolarSystem
//
//  Created by Anupinder Singh on 05/02/24.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet var mySceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mySceneView.allowsCameraControl = true
        mySceneView.showsStatistics = true
        
        
        mySceneView.scene = SCNScene()
        mySceneView.scene?.background.contents = UIImage(named: "stars")
        let sun = createSphere()
        mySceneView.scene?.rootNode.addChildNode(sun)
        let earth = createEarth()
        sun.addChildNode(earth)
        let moon = createMoon()
        earth.addChildNode(moon)
        //mySceneView.scene?.rootNode.addChildNode(createEarth())
        mySceneView.scene?.rootNode.addChildNode(createCamera())
        mySceneView.scene?.rootNode.addChildNode(createAmbientLight())
        mySceneView.scene?.rootNode.addChildNode(createDirectionalLight())
        
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
    
    func createCamera() -> SCNNode
    {
        let cam = SCNCamera()
        cam.zFar = 100.0
        cam.fieldOfView = 60
        
        let node = SCNNode()
        node.camera = cam;
        node.position = SCNVector3(0,0,7)
        let action = SCNAction.move(to: SCNVector3(0,0,1.0), duration: 100)
//        let delay = SCNAction.wait(duration: 3)
        //node.runAction(action)
        return node
    }
    
    func createAmbientLight() ->SCNNode
    {
        let light = SCNLight()
        light.type = .ambient
        light.color = UIColor.gray
        let node = SCNNode()
        node.light = light
        
        return node
    }
    
    func createDirectionalLight() ->SCNNode
    {
        let light = SCNLight()
        light.type = .omni
        
        let node = SCNNode()
        node.position = SCNVector3(5, 5, 5)

        node.light = light
        
        return node
    }


}

