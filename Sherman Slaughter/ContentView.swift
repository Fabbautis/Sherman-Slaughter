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

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        @State var boxAnchor: Experience.Box;
        
        let arView = ARView(frame: .zero)
        context.coordinator.arView = arView
        
        // Load the "Box" scene from the "Experience" Reality File
        boxAnchor = try! Experience.loadBox()
        
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
    weak var arView:ARView?
    weak var boxScene: Experience.Box?
    
    override init(){
        super.init()
        self.handleAccelerometer()
    }
    func handleAccelerometer () {
        var motionManager: CMMotionManager
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            if let data = motionManager.accelerometerData
            {
                print("Y value: " + String(data.acceleration.y))
                if(data.acceleration.y <= -0.5){ //y is what you want to cast the fishing rod
                    print("under -0.5")
                    self.boxScene?.notifications.ajasaiaasdjasdadas
                }
            }
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
