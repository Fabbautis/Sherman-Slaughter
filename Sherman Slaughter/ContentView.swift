//
//  ContentView.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 1/27/23.
//

import SwiftUI
import RealityKit
import CoreMotion


struct ContentView : View {
    
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable { //Create the entire AR view with the box and all that. This does not create the code, that is done later
    func makeUIView(context: Context) -> ARView {
        @State var boxAnchor: Experience.Box;
        
        let arView = ARView(frame: .zero)
        context.coordinator.arView = arView
        
        // Load the "Box" scene from the "Experience" Reality File
        boxAnchor = try! Experience.loadBox()
        context.coordinator.boxScene = boxAnchor
        boxAnchor.actions.fishSpawned.onAction = context.coordinator.endStartAnim(_:)
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
}

class Coordinator:NSObject
{
    var canReel: Bool
    weak var arView:ARView?
    weak var boxScene: Experience.Box?
    var zRot:Double = 0
    var totalTime: Double = 0
    let howLongToWait:Double = 5
    var waitTimerStart: Double = 0;
    
    override init(){
        self.canReel = false;
        super.init()
        self.handleAccelerometer()
    }

    func handleAccelerometer () { //create the accelerometer and get the x y and z rotations
        var motionManager: CMMotionManager
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            if let data = motionManager.accelerometerData
            {
                self.zRot = data.acceleration.z
                self.checkRotations()
            }
        }
    }
    
    func checkRotations() {
        print("Z value: " + String(zRot))
        if zRot <= -0.5 && canReel { //z is what you want to cast the fishing rod
            self.boxScene?.notifications.rotate360.post()
        }
    }
    
    func endStartAnim (_ entity: Entity?) {
        guard let entity = entity else {return}
        
        canReel = true;
    }
    
    func reeling() {
        var currentZRot:Double = zRot;
        //some kind of 5 second timer
        if zRot >= currentZRot - 5 && zRot <= currentZRot + 5 {
            
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
