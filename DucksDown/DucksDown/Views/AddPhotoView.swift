//
//  AddPhotoView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

struct AddPhotoView: View {
    @State private var selectedImage: UIImage?
    @State private var pickerItem: PhotosPickerItem?
    @State private var isUploading = false
    @State private var uploadMessage = ""
    
    var blindID: String
    var huntDate: String

    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItem, matching: .images) {
                Text("Select a Photo")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()

            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(10)
            }

            if isUploading {
                ProgressView()
            } else {
                Button("Upload Photo") {
                    uploadPhoto()
                }
                .disabled(selectedImage == nil)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Text(uploadMessage)
                .foregroundColor(.gray)
                .padding()
        }
        .padding()
        .onChange(of: pickerItem) { newItem in
            loadImage(from: newItem)
        }
    }
    
    private func loadImage(from pickerItem: PhotosPickerItem?) {
        guard let pickerItem = pickerItem else { return }
        
        Task {
            if let data = try? await pickerItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                selectedImage = image
            }
        }
    }
    
    private func uploadPhoto() {
        guard let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        isUploading = true
        let storageRef = Storage.storage().reference().child("blinds/\(blindID)/\(huntDate)/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            isUploading = false
            if let error = error {
                uploadMessage = "Upload failed: \(error.localizedDescription)"
            } else {
                uploadMessage = "Photo uploaded successfully!"
            }
        }
    }
}
