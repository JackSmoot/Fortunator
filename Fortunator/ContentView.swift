//
//  ContentView.swift
//  Fortunator
//
//  Created by Jack Smoot on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fortune: String = ""
    @State private var selectedGenre: String = "All Categories"
    let fortuneFiles = ["art.rtf", "computers.rtf", "cookie.rtf", "debian.rtf", "definitions.rtf", "disclaimer.rtf", "drugs.rtf", "education.rtf", "ethnic.rtf", "food.rtf", "fortunes.rtf", "goedel.rtf", "humorists.rtf", "kids.rtf", "kngtbrd.rtf", "law.rtf", "laws.rtf", "linux.rtf", "linuxcookie.rtf", "literature.rtf", "love.rtf", "magic.rtf", "medicine.rtf", "men-women.rtf", "miscellaneous.rtf", "news.rtf", "paradoxum.rtf", "people.rtf", "perl.rtf", "pets.rtf", "platitudes.rtf", "politics.rtf", "riddles.rtf", "science.rtf", "science2.rtf", "songs-poems.rtf", "sports.rtf", "startrek.rtf", "translate-me.rtf", "wisdom.rtf", "work.rtf", "zippy.rtf"] // List of files
    var body: some View {
        VStack {
            Text("Fortunator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding()
            
            Image("fortunecookie")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            Picker("Select a Genre", selection: $selectedGenre) {
                Text("All Categories").tag("All Categories") // Default option
                    .foregroundColor(Color.green)
                ForEach(fortuneFiles, id: \.self) { file in
                    Text(file.replacingOccurrences(of: ".rtf", with: "").capitalized)
                        .tag(file)
                        .foregroundColor(Color.green)
                }
            }
            .pickerStyle(MenuPickerStyle()) // Dropdown menu style
            .tint(.green)
            
            Text(fortune)
                .font(.title2) // Default size
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.green)
                    .padding()
                    .lineLimit(8) // Limits to 5 lines before truncation
                    .minimumScaleFactor(0.5) // Shrinks text if it's too long
            
            Button(action: {
                fortune = getRandomFortune(from: selectedGenre)
            }) {
                Text("Get Fortune")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(30)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    func getRandomFortune(from selection: String) -> String {
        let folderName = "FortunatorTXT" // Name of the folder inside the app bundle
        
        // Decide which file to use
        let selectedFile: String
        if selection == "All Categories" {
            selectedFile = fortuneFiles.randomElement() ?? "" // Pick random file
        } else {
            selectedFile = selection
        }

        // Get the full path
        guard let folderURL = Bundle.main.resourceURL?.appendingPathComponent(folderName) else {
            return "Fortunes folder not found!"
        }

        let fileURL = folderURL.appendingPathComponent(selectedFile)

        // Read the RTF file data
        guard let rtfData = try? Data(contentsOf: fileURL) else {
            return "Error reading fortune file!"
        }

        // Convert RTF data to plain text
        guard let attributedString = try? NSAttributedString(data: rtfData, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil) else {
            return "Error processing fortune!"
        }

        let plainText = attributedString.string

        // Split text by "%" to separate fortunes
        let fortunes = plainText.components(separatedBy: "%").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

                // Pick a random fortune
        return fortunes.randomElement() ?? "No fortune available!"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
