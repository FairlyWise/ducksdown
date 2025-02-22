//
//  AddDataView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI

struct AddDataView: View {
    var blind: Blind
    @State private var selectedTime = "Morning"
    @State private var selectedWeather = "41º-50º"
    @State private var birdCount = 1
    @State private var selectedSpecies = "Mallard"

    let times = ["Morning", "Afternoon", "Evening"]
    let weatherOptions = ["Lower than -30º", "-29º- -20º", "-19º- -10º", "-9º - 0º", "1º - 10º", "11º-20º", "21º-30º", "31º-40º", "41º-50º", "51º-60º", "61º-70º", "71º-80º", "81º-90º", "91º-99º", "100º and higher"]
    let speciesOptions = ["Mallard", "Teal", "Pintail", "Wood Duck", "Canvasback"]

    var body: some View {
        Form {
            Picker("Time of Hunt", selection: $selectedTime) {
                ForEach(times, id: \.self) { Text($0) }
            }
            
            Picker("Weather", selection: $selectedWeather) {
                ForEach(weatherOptions, id: \.self) { Text($0) }
            }
            
            Stepper("Bird Count: \(birdCount)", value: $birdCount, in: 1...30)
            
            Picker("Species", selection: $selectedSpecies) {
                ForEach(speciesOptions, id: \.self) { Text($0) }
            }
            
            Button("Save Data") {
                saveData()
            }
        }
        .navigationTitle("Add Data")
    }
    
    private func saveData() {
        // Firebase save logic
    }
}
