//
//  DetailView.swift
//  Bookworm
//
//  Created by Macmaurice Osuji on 4/19/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.green.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Spacer()
           
            VStack {
                HStack {
                    Text("Written by:")
                        .font(.title3)
                        .italic()
                    Text(book.author ?? "Unknow Author")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.blue)
                }
                
                Text(book.review ?? "No review")
                    .padding()
                Text(book.date?.formatted(date: .complete, time: .standard) ?? "No date")
                    .foregroundColor(.secondary)
                    .padding()
            }
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("YES", role: .destructive, action: deleteBook)
            Button("No", role: .cancel) {}
        }message: {
            Text("Are you sure you want to delete this book?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}


