//
//  StarAnimationView.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 22/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import SwiftUI

struct StarAnimationView: View {
    
    @State private var size: CGFloat = 20
    
    @ObservedObject var cell: ProdutoCollectionViewCell
    
    var onDidChange: ((Bool) -> Void)?
    
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .foregroundColor(cell.favorited ? .yellow : .clear)
                .font(.system(size: size))
                .scaleEffect(cell.favorited ? 1 : 0.8)
            
            Image(systemName: "star")
                .foregroundColor(cell.favorited ? .clear : .yellow )
                .font(.system(size: size))
                .scaleEffect(cell.favorited ? 0.8 : 1)
            
        }.animation(.easeInOut)
        .onTapGesture {
            self.cell.favorited.toggle()
            self.onDidChange?(self.cell.favorited)
            pressFeedback()
        }
        
    }
    
    func pressFeedback() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
    }
    
}

//struct StarAnimationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StarAnimationView()
//    }
//}
