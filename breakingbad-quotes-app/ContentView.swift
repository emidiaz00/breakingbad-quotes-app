//
//  ContentView.swift
//  breakingbad-quotes-app
//
//  Created by Emiliano Diaz on 10/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var quotesData : [Quote] = []
    let darkGreen = Color(red: 0.0, green: 0.2, blue: 0.0)
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Image("bbad").resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 65, y: 0)
                    }
                ForEach(quotesData, id: \.quote.isEmpty) { quote in
                    Text(quote.quote)
                        .font(.title)
                        .foregroundColor(darkGreen)
                        .opacity(0.9)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text(quote.author)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .padding()
                    }
            }
            .onAppear(perform: getQuotes)
            .padding()
        }
    }
    
    private func getQuotes() {
        guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodeData = try? JSONDecoder().decode([Quote].self, from: data) {
                DispatchQueue.main.async {
                    self.quotesData = decodeData
                    print("Quotes count: \(self.quotesData.count)")
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
