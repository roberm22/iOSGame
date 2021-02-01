

import SwiftUI

struct QuizRow: View {
	
	var quiz: QuizItem
	
	@EnvironmentObject var imageStore: ImageStore
	
	var body: some View {
		HStack{
			Image(uiImage: imageStore.image(url: quiz.attachment?.url))
				.resizable()
				.frame(width: 50, height: 50)
				.clipped()
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.shadow(radius: 20 )
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
			Text(quiz.question)
			Spacer()
			
			Image(uiImage: imageStore.image(url: quiz.author?.photo?.url))
				.resizable()
				.frame(width: 30, height: 30)
				.clipped()
				.clipShape(Circle())
				.shadow(radius: 20 )
				.transition(.slide)
		}
	}
}

struct QuizRow_Previews: PreviewProvider {
	static var previews: some View {
		QuizRow(quiz: QuizModel.shared.quizzes[0])
	}
}
