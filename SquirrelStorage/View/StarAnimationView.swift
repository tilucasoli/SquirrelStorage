//
//  StarAnimationView.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 22/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import SwiftUI

struct StarAnimationView: View {
    
    @State private var favorited = false
    
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .foregroundColor(favorited ? .yellow : .white )
                .font(.system(size: 20))
                .scaleEffect(favorited ? 1 : 0.8)
            
            Image(systemName: "star")
                .foregroundColor(favorited ? .clear : .yellow )
                .font(.system(size: 20))
                .scaleEffect(favorited ? 0.8 : 1)
            
        }.animation(.easeInOut)
        .onTapGesture {
            pressFeedback()
            self.favorited.toggle()
        }
        
    }
    
    func pressFeedback() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
    }
    
}

struct StarAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        StarAnimationView().scaledToFit()
    }
}
