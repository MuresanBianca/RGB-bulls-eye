//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Bianca Muresan on 05.08.2021.
//

import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ColorRectangle(red: rTarget, green: gTarget, blue: bTarget)
                ColorRectangle(red: rGuess , green: gGuess, blue: bGuess)
            }
            HStack {
                Text("Match this color")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                  .frame(minWidth: 10, maxWidth: .infinity, minHeight: 10, maxHeight: 30)
                Text("R:\(Int(rGuess * 255.0)) G:\(Int(gGuess * 255.0)) B:\(Int(bGuess * 255.0))")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 10, maxWidth: .infinity, minHeight: 10, maxHeight: 30)
            }
            Button(action: {
                self.showAlert = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 150, height: 50, alignment: .center)
                  Text("Hit Me!")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
            }
            
            ColorSlider(value: $rGuess, sliderColor: .red)
            ColorSlider(value: $gGuess, sliderColor: .green)
            ColorSlider(value: $bGuess, sliderColor: .blue)
        }
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
                .previewDevice("iPhone 12 Pro Max")
                
            ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
                .previewDevice("iPod touch (7th generation)")
        }
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var sliderColor: Color
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(.black)
            Slider(value: $value)
                .accentColor(sliderColor)
            Text("255")
                .foregroundColor(.black)
        }
        .padding(10)
    }
}

struct ColorRectangle: View {
    var red: Double
    var green: Double
    var blue: Double
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: red, green: green, blue: blue, opacity: 1.0))
            .frame(minWidth: 100,  maxWidth: .infinity , minHeight: 10, maxHeight: .infinity)
    }
}
