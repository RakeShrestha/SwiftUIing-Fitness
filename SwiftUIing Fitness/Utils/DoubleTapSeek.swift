//
//  DoubleTapSeek.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct DoubleTapSeek: View {
    var isForward: Bool = false
    var onTap: () -> ()
    
    @State private var isTapped: Bool = false
    @State private var showArrow: [Bool] = [false, false, false]
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .overlay {
                Circle()
                    .fill(.black.opacity(0.4))
                    .scaleEffect(4, anchor: isForward ? .leading : .trailing)
            }
            .opacity(isTapped ? 1 : 0)
            .overlay {
                VStack(spacing: 10) {
                    HStack(spacing: 0){
                        ForEach((0...2).reversed(), id: \.self) { index in
                            
                            Image(systemName: isForward ? "arrowtriangle.forward.fill" : "arrowtriangle.backward.fill")
                                .foregroundStyle(.white)
                                .opacity(showArrow[index] ? 1 : 0.2)
                        }
                    }
                    .font(.title)
                    Text("5 sec")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .opacity(isTapped ? 1 : 0)
            .contentShape(Rectangle())
            .onTapGesture(count: 2) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isTapped = true
                    showArrow[0] = true
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.2)){
                    showArrow[0] = false
                    showArrow[1] = true
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.35)){
                    showArrow[1] = false
                    showArrow[2] = true
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.5)){
                    showArrow[2] = false
                    isTapped = false
                }
                onTap()
            }
    }
}
