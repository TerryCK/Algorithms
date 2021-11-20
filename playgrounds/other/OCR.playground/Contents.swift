import Vision

enum DemoImage: String {
    case document = "demoDocument4"
    case licensePlate = "demoLicensePlate"
}


/*
 OCR detector test
 
 中文測試
 
 */


class OCRReader {
    func performOCR(on url: URL?, recognitionLevel: VNRequestTextRecognitionLevel)  {
        guard let url = url else { return }
        let requestHandler = VNImageRequestHandler(url: url, options: [:])
        
        let request = VNRecognizeTextRequest  { (request, error) in
            if let error = error {
                print(error)
                return
            }
            
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            for currentObservation in observations {
                let topCandidate = currentObservation.topCandidates(1)
                if let recognizedText = topCandidate.first {

                    print(recognizedText.string)
                }
            }
        }
        
        request.recognitionLanguages = ["zh-Hans"]
        request.recognitionLevel = recognitionLevel
        try? requestHandler.perform([request])
    }
}

func url(for image: DemoImage) -> URL? {
    return Bundle.main.url(forResource: "demoDocument5", withExtension: "png")
}

let ocrReader = OCRReader()
ocrReader.performOCR(on: url(for: .document), recognitionLevel: .accurate)
