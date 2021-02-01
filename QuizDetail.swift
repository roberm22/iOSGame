

import SwiftUI

struct QuizDetail: View {
	
	var quiz: QuizItem
	
	@EnvironmentObject var imageStore: ImageStore
	@EnvironmentObject var scoreModel: ScoreModel
	@Environment(\.verticalSizeClass) var verticalSizeClass
	@Binding var showScore: Bool
	@Binding var showScore2: Bool
	
	@State var answer: String = ""
	@State var showButtonAns: String = "Enseñar respuesta"
	@State var showModal = false
	@State var showAlerta = false
	
	var body: some View {
		if showScore2{
			Puntuacion(showScore: $showScore,showScore2: $showScore2)
			
		}else{
			if verticalSizeClass != .compact{
				VStack{
					Text(quiz.question)
						.font(.largeTitle)
					Button(action: {
						// Sentencias a ejecutar al pulsar el boton
						showButtonAns=quiz.answer
					}){
						// Contenido del boton
						Text("\(showButtonAns)")
							.foregroundColor(Color.red)
					}
					
					Image(uiImage: imageStore.image(url: quiz.attachment?.url))
						.resizable()
						.aspectRatio(contentMode: .fit)
						.clipped()
						.clipShape(RoundedRectangle(cornerRadius: 20))
						.shadow(radius: 20 )
						.animation(.easeInOut)
					
					HStack{
						Text("Respuesta:")
						TextField("Escriba aqui", text: $answer, onCommit: {self.showAlerta = true})
							.textFieldStyle(RoundedBorderTextFieldStyle())
					}
					
					Button(action: {
						// Sentencias a ejecutar al pulsar el boton
						self.showAlerta = true
					}){
						// Contenido del boton
						Text("Comprobar")
					}
					Spacer()
					HStack {
						Button(action: {
							// Sentencias a ejecutar al pulsar el boton
							showModal = true
						}){
							// Contenido del boton
							VStack{
								Image(systemName: "chevron.up.circle")
									.padding()
								Text("Informacion del autor")
									.font(.subheadline)
							}
						}
					}
					.sheet(isPresented: $showModal) {
						Editor(showModal: $showModal, quiz: quiz)
					}
					
				}
				.alert(isPresented: $showAlerta) {
					if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)==quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
						scoreModel.check(respuesta: answer,quiz: quiz)
						return Alert(title: Text("Has acertado"),
									 message: Text("Continua respondiendo otras preguntas"),
									 dismissButton: .default(Text("Cerrar")))
						
					}else{
						return Alert(title: Text("Has fallado"),
									 message: Text("Sigue intentandolo"),
									 dismissButton: .default(Text("Cerrar")))
					}
				}
				.toolbar{
					Button("Puntuacion: \(scoreModel.acertadas.count)"){
						showScore2 = true
					}
					
				}
				.padding()
			}else{
				VStack{
					HStack{
						Image(uiImage: imageStore.image(url: quiz.attachment?.url))
							.resizable()
							.aspectRatio(contentMode: .fit)
							.clipped()
							.clipShape(RoundedRectangle(cornerRadius: 20))
							.shadow(radius: 20 )
							.animation(.easeInOut)
							.padding()
						VStack{
							Text(quiz.question)
								.font(.largeTitle)
							Button(action: {
								// Sentencias a ejecutar al pulsar el boton
								showButtonAns=quiz.answer
							}){
								// Contenido del boton
								Text("\(showButtonAns)")
									.foregroundColor(Color.red)
							}
							HStack{
								Text("Respuesta:")
								TextField("Escriba aqui", text: $answer, onCommit: {self.showAlerta = true})
									.textFieldStyle(RoundedBorderTextFieldStyle())
							}
							Button(action: {
								// Sentencias a ejecutar al pulsar el boton
								self.showAlerta = true
							}){
								// Contenido del boton
								Text("Comprobar")
							}
							
							
						}
						.alert(isPresented: $showAlerta) {
							if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)==quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
								scoreModel.check(respuesta: answer,quiz: quiz)
								return Alert(title: Text("Has acertado"),
											 message: Text("Continua respondiendo otras preguntas"),
											 dismissButton: .default(Text("Cerrar")))
								
							}else{
								return Alert(title: Text("Has fallado"),
											 message: Text("Sigue intentandolo"),
											 dismissButton: .default(Text("Cerrar")))
							}
						}
						.toolbar{
							Button("Puntuacion: \(scoreModel.acertadas.count)"){
								showScore2 = !showScore2
							}
							
						}
						
					}
					HStack {
						Button(action: {
							// Sentencias a ejecutar al pulsar el boton
							showModal = true
						}){
							Image(systemName: "chevron.up.circle")
						}
					}
					.padding()
					.sheet(isPresented: $showModal) {
						Editor(showModal: $showModal, quiz: quiz)
					}
				}
				.padding()
			}
		}
		
		
	}
}


