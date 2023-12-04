//
//  ContentView.swift
//  AITextRecognition
//
//  Created by John goodstadt on 04/12/2023.
//

import SwiftUI
import MLKitTextRecognition
import MLKitVision
import MLKit

struct ContentView: View {
	@State var selectedRow: String = ""
	@State private var showMessageToast = false
	@State private var imageDescription = "Description will go here"
	@State private var script   = "Latin"
	@State private var mainImage = UIImage(named: "Sonnet18")
	@State private var overlayImage = UIImage(systemName: "clock")
	
	private var imageNames = ["imagesSP","imagesSP2","imagesSP3","imagesSPChinese","imagesSPItaly","imagesSPJapan","japanese","korean","sanskrit"]
	@State private var index = 0
	
	@State var scriptPicked = "Latin"
	private let photoURL = URL(string: "https://picsum.photos/512.jpg")
	
	/// An overlay view that displays detection annotations.
	@State private var annotationOverlayView: UIView = {
	  //precondition(isViewLoaded)
	  let annotationOverlayView = UIView(frame: .zero)
	  annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
	  return annotationOverlayView
	}()
	
	@Namespace private var hero
	
	var body: some View {
		VStack {

			Button(action: {
				analyseImage(mainImage)
			}) {
				Text("Find Text")
			}
			.padding()
			
			Image(uiImage:mainImage!)
				.resizable()
				.scaledToFit()
				.padding()
			
		}
		
		Text(imageDescription)
			.padding()
			.font(.footnote)
		
		Spacer()
		Button(action: {
			changeImage()
		}) {
			Text("Change Image")
		}
		.padding()
	}
	
	
	
	func analyseImage(_ imageToAnalyse:UIImage?){
		
		if let image = imageToAnalyse {
			
			//following this doc https://developers.google.com/ml-kit/vision/text-recognition/v2/ios
			let visionImage = VisionImage(image: image)
			visionImage.orientation = image.imageOrientation
			
	
				// When using Latin script recognition SDK
				let latinOptions = TextRecognizerOptions()
				let latinTextRecognizer = TextRecognizer.textRecognizer(options:latinOptions)
				
				latinTextRecognizer.process(visionImage) { result, error in
					guard error == nil, let result = result else {
						print(error ?? "Error")
						return
					}
					// Recognized text
					var textList = [String]()

					imageDescription = textList.joined(separator: "\n")
					
					
					for block in result.blocks {
						let blockText = block.text
						let blockLanguages = block.recognizedLanguages
						let blockCornerPoints = block.cornerPoints
						let blockFrame = block.frame
						print("Text:\n\(blockText)")
						print("Languages:\n\(String(describing: blockLanguages.count > 0 ? blockLanguages.first?.languageCode : "undefined") )")
						print("CornerPoints:\n\(blockCornerPoints)")
						print("Frame:\n\(blockFrame)")
						
						print("\nlines:\n")
						for line in block.lines {
							let lineText = line.text
							print(lineText)
							
							textList.append("\(lineText)")
							
							let _ = line.recognizedLanguages
							let _ = line.cornerPoints
							let _ = line.frame
							for element in line.elements {
								let _ = element.text
								let _ = element.cornerPoints
								let _ = element.frame
								
								
								
							}
						}
					}
					 
					imageDescription = textList.joined(separator: "\n")

				}
		}
		
	}
	func changeImage(){
		
		print("\(index) \(imageNames.count)")
		
		self.index = self.index + 1
		if index >= imageNames.count {
			self.index = 0
		}
		
		let name = imageNames[index]
		self.mainImage = UIImage(named: name)
		self.imageDescription = ""
		analyseImage(mainImage)
		
	}
}

#Preview {
    ContentView()
}
