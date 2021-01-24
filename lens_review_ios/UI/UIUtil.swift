//
//  UIUtil.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/11/29.
//

import SwiftUI
import Combine

struct ScrollDivider: View {
    let color: Color = Color("ScrollDividerColor")
    let width: CGFloat = 5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct BoardDetailDivider: View {
    let color: Color = Color("ScrollDividerColor")
    let width: CGFloat = 13
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct DeviceInfo {
    static let deviceHeight:CGFloat = UIScreen.main.bounds.size.height
    static let deviceWidth:CGFloat = UIScreen.main.bounds.size.width
}

// TODO 나중에 SwiftUI alert에 textfield 추가 가능해지면 이거 사용 안 해도 됨
// https://velog.io/@wimes/SwiftUI-Alert-TextField
struct CommentModifyAlert
{
    var postId: Int
    var commentId: Int
    var bundleId: Int? = nil
    var onModify: (Int, Int, String, Int?) -> Void = {_,_,_,_ in }
    
    func alert(comment: String) {
        let alert = UIAlertController(title: nil, message: "comment_modify".localized(), preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.text = comment
        }
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .destructive) { _ in })
        alert.addAction(UIAlertAction(title: "modify".localized(), style: .default) { _ in self.onModify(postId, commentId, alert.textFields?[0].text ?? "", bundleId) })
        showAlert(alert: alert)
    }

    private func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }

    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
}
