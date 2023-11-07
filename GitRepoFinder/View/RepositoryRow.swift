//
//  RepositoryRow.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 06.11.2023.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.fullName).font(.headline)
                .font(.headline)
                .foregroundColor(.primary)
            if let description = repository.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                if let forksCount = repository.forksCount {
                    Label("\(forksCount)", systemImage: "tuningfork")
                        .font(.footnote)
                }
                
                if let starsCount = repository.starsCount {
                    Label("\(starsCount)", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.footnote)
                }
                
                Spacer()
                
                Text("\(repository.formattedUpdateDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
