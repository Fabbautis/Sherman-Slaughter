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
    @EnvironmentObject var data:Data
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
            .environmentObject(data)
            .onDisappear(){
                print("Please get rid of the Box anchor and reload it")
            }
    }
}

struct ARViewContainer: UIViewRepresentable { //Create the entire AR view with the box and all that. This does not create the code, that is done later
    @EnvironmentObject var data:Data
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
        context.coordinator.handleAccelerometer()
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator:NSObject
{
    //ContentView().environmentObject(yourEnvironmentObject) https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-fatal-error-no-observableobject-of-type-sometype-found
    @EnvironmentObject var data:Data
    weak var arView:ARView?
    weak var boxScene: Experience.Box?
    var canReel:Bool = false;
    var xRot:Double = 0;
    var yRot:Double = 0;
    var zRot:Double = 0
    let waitTimerStart: Double = 0;//Use of constants in variable construction
    var startedRotation: Double = 0;
    var randomChange = Double.random(in: -0.3...0.3)
    var parent:ARViewContainer
    
    init(_ parent:ARViewContainer){
        //super.init()
        self.parent = parent
    }

    func handleAccelerometer () { //create the accelerometer and get the x y and z rotations
        var motionManager: CMMotionManager
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            if let data = motionManager.accelerometerData
            {
                self.xRot = data.acceleration.x
                self.yRot = data.acceleration.y
                self.zRot = data.acceleration.z
                if (self.canReel){
                    self.reeling()
                }
            }
        }
    }
    
    func checkRotations() -> (zRot: String, yRot: String, xRot:String) {
        return (zRot: String(zRot), yRot: String(yRot), xRot: String(xRot))//Return of Multiple Values from a Function
    }
    
    func endStartAnim (_ entity: Entity?) { //this also starts the game by establishing predetermined values to shoot for
        guard let entity = entity else {return}
        
        
        if ((zRot >= 0.7 && randomChange > 0) || (zRot <= -0.7 && randomChange < 0)){
            randomChange = randomChange * -1 //ensure that you can actually rotate your phone to that angle
        }
        startedRotation = zRot; //What rotation does the game go based off to calculate the goal
        canReel = true; //start the game
    }
    
    func reeling(using rotation:checkRotations()) {
        let currentRotation = (Double(checkRotations().zRot) ?? zRot)
        
        if currentRotation <= (startedRotation + randomChange) - 0.1 {
            self.boxScene?.notifications.tooHigh.post()
        } else if currentRotation >= (startedRotation + randomChange) + 0.1{
            self.boxScene?.notifications.tooLow.post()
        } else if currentRotation <= (startedRotation + randomChange) + 0.1 && currentRotation >= (startedRotation + randomChange) - 0.1 {
            self.boxScene?.notifications.justRight.post()
            endGame(gameState: true)
            return
        }
        endGame(gameState: false)
    }
    func endGame (gameState: Bool){//Customized Parameter Labels
        if (!gameState){
            return
        } else{
            self.boxScene?.notifications.rotate360.post()
            canReel = false;
            let randomColor = Int.random(in:1...3)
            let randomWeight = Int.random(in:5...40)
            switch (randomColor){ //use of switch statements
                case 1:
                parent.data.fishCaughtColor.append("red")
                case 2:
                parent.data.fishCaughtColor.append("blue")
                case 3:
                parent.data.fishCaughtColor.append("green")
                default:
                parent.data.fishCaughtColor.append("red")
            }
            parent.data.fishCaughtWeight.append(String(randomWeight))
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
