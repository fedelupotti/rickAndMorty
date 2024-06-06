//
//  ConnectionFailsView.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 25/04/24.
//

import SwiftUI

struct ConnectionFailsView: View {
    var onRetry: () -> Void
    
    private func retryAction() {
        onRetry()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "wifi.slash")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.bottom)
            
            Text("No Internet Connection!")
                .font(.headline)
            
            Text("Please check your connection and try again")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Button(action: retryAction, label: {
                Label {
                    Text("Retry")
                } icon: {
                    Image(systemName: "arrow.clockwise")
                }
                .labelStyle(.titleAndIcon)
                
            })
            .buttonStyle(.borderedProminent)
            .padding(.top, 50)
            .padding(.bottom, 10)
        }
        .padding(10)
        .background(Color.secondary.opacity(0.3))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        
        
    }
}

#Preview {
    ConnectionFailsView() {
        
    }
}
