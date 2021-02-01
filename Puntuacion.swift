

import SwiftUI

struct Puntuacion: View {
	
	@EnvironmentObject var scoreModel: ScoreModel
	@Binding var showScore: Bool
	@Binding var showScore2: Bool
	
	var body: some View {
		VStack{
			Text("Preguntas contestadas correctamente:")
				.bold()
				.padding()
			Spacer()
			List{
				if scoreModel.respondidos().count==0{
					Text("No has acertado aun a ninguna pregunta")
						.font(.subheadline)
						.foregroundColor(Color.gray)
				}
				ForEach(0..<scoreModel.respondidos().count){quiz in
					QuizRow(quiz: scoreModel.respondidos()[quiz])
					}
				}
			}
		Button("Volver"){
			if(showScore){showScore = false}
			if(showScore2){showScore2 = false}
		}
			.padding()
			
		}
	}



