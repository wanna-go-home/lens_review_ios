//
//  SelectLensView.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/08.
//

import SwiftUI
import URLImage

struct SelectLensView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var reviewWriteViewModel:ReviewWriteViewModel
    
    @State var selectedLensId: Int
    @State private var goReviewWriteView = false
    
    var body: some View {
        VStack(spacing: 3)
        {
            customTitleBar
            
            Spacer()
            
            Text("write_review_select_lens".localized())
            
            Picker(selection: $selectedLensId, label: Text("")) {
                ForEach(reviewWriteViewModel.lensList){ lens_ in
                    HStack {
                        URLImage(url: URL(string: lens_.productImage[0])!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        }
                        Text(lens_.name)
                            .font(.system(size: 11))
                    }
                }
            }
            
            Button(action: {
                reviewWrite()
            })
            {
                Text("write_review_next".localized())
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(Color("PrimaryColor"))
                    .foregroundColor(Color.white)
                
            }
            
            Spacer()
            
            NavigationLink(destination: ReviewWriteView(lensId: selectedLensId).environmentObject(reviewWriteViewModel), isActive: $goReviewWriteView){
                EmptyView()
            }.isDetailLink(false)
        }
        .padding([.leading, .trailing])
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {
            reviewWriteViewModel.getLensList()
        })
        // TODO 셀렉트뷰 닫는거 다른 방법 찾아봐야함
        .onReceive(reviewWriteViewModel.reviewPostSuccessForSelect, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    var customTitleBar : some View {
        HStack
        {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("cancel".localized())
                }
            
            Spacer()
        }
        .foregroundColor(Color("BoardContentColor"))
    }
    
    func reviewWrite()
    {
        self.goReviewWriteView = true
//        self.presentationMode.wrappedValue.dismiss()
    }
}
