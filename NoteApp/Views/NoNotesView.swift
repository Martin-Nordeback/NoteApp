//
//  NoNotesView.swift
//  NoteApp
//
//  Created by Martin Nordebäck on 2023-03-30.
//

import SwiftUI

struct NoNotesView: View {
    @State private var animate: Bool = false

    let secondaryAccentColor = Color("SecondaryAccentColor")

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Spacer()
                Text("Looks empty")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\"the best way to get started is to start\"")
                    .padding(.bottom, 20)

                NavigationLink {
                    AddNote()
                } label: {
                    Text("Add something")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(20)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.7) :
                        Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0.0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoNotesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoNotesView()
                    .navigationTitle("Title")
            }
            .preferredColorScheme(.dark)

            NavigationView {
                NoNotesView()
                    .navigationTitle("Title")
            }
            .preferredColorScheme(.light)
        }
    }
}
