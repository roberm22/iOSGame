
import SwiftUI

@main
struct iOSGameApp: App {
	
	let model = QuizModel.shared //creado a nivel de aplicacion se podria crear en la vista
	let imageStore = ImageStore()
	var scoreModel: ScoreModel = ScoreModel()
	let showScore: Bool = false
	let showScore2: Bool = false
	
    var body: some Scene {
        WindowGroup {
			ContentView(model: model,showScore: showScore, showScore2:showScore2)
				.environmentObject(imageStore)
				.environmentObject(scoreModel)
        }
    }
}


