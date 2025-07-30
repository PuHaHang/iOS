//
//  RecipePreviewView.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct RecipePreviewView: View {
    let recipePreviewViewData: RecipePreviewViewData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                RecipeImageContentView(imageURL: recipePreviewViewData.thumbnail)
                    .padding(.bottom, 20)
                
                RecipeOverviewView(
                    title: recipePreviewViewData.title,
                    serving: recipePreviewViewData.serving
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                RecipeStepView(steps: recipePreviewViewData.steps)
                .padding(.horizontal, 17)
            }
        }
        .scrollIndicators(.hidden)
        .frame(width: 300, height: 480)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        )
    }
}

private extension RecipePreviewView {
    struct RecipeImageContentView: View {
        let imageURL: URL?
        
        var body: some View {
            KFImage.url(imageURL)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
        }
    }
    
    struct RecipeOverviewView: View {
        let title: String
        let serving: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.system(size: 18))
                    .foregroundStyle(AppColor.Text.main)
                    .fontWeight(.bold)
                
                Spacer()
                
                ServingInfoView(servingText: serving)
            }
        }
    }
    
    struct RecipeStepView: View {
        let steps: [RecipeStepViewData]
        
        var body: some View {
            VStack(spacing: 15) {
                ForEach(steps) { step in
                    RecipeStepItemView(
                        step: step.stepTitle,
                        content: step.stepContent
                    )
                }
                
                Color.clear
                    .frame(height: 20)
            }
        }
    }
    
    struct RecipeStepItemView: View {
        let step: String
        let content: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(step)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.Text.highlight)
                
                Text(content)
                    .font(.system(size: 13))
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.15), radius: 4)
            )
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()

        self.init(cgImage: image.cgImage!)
    }
}
