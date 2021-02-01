
import SwiftUI

struct ContentView: View {
	
	var model: QuizModel
	@EnvironmentObject var scoreModel: ScoreModel
	@State var showScore: Bool=false
	@State var showScore2: Bool=false
	
	var body: some View {
		
		if showScore{
			Puntuacion(showScore: $showScore,showScore2: $showScore2)
			
		}else{
			NavigationView{
				List{
					ForEach(model.quizzes, id: \.id){quiz in
						NavigationLink(destination: QuizDetail(quiz: quiz, showScore: $showScore, showScore2: $showScore2)) {
							QuizRow(quiz: quiz)
							
						}
						
					}
				}
				.navigationTitle("P1 Quiz")
				.toolbar{
					Button("Puntuacion: \(scoreModel.acertadas.count)"){
						showScore = true
					}
					
				}
				
				VStack{
					Text("Elige el quiz deslizando hacia la derecha")
					Image("swipe")
						.resizable()
						.scaledToFit()
					
					
				}
				
			}
		}
		
	}
}


