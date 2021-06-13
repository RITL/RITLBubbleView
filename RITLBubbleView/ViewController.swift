//
//  ViewController.swift
//  RITLBubbleView
//
//  Created by YueWen on 2021/6/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bubbleView = RITLBubbleContainerView()
        
        view.addSubview(bubbleView)
        
        bubbleView.backgroundColor = #colorLiteral(red: 0.4867153168, green: 0.7604991198, blue: 1, alpha: 1)
        bubbleView.delegate = self
        bubbleView.frame = CGRect(x: 10, y: 50, width: UIScreen.main.bounds.width - 20, height: 300)
        bubbleView.contentRect = bubbleView.bounds
        
        //设置属性
        bubbleView.setItems(items: [
            (title: "50cal", subtitle: "知识问答", type: RITLBubbleContainerView.RITLBubbleType.large),
            (title: "25g", subtitle: "坐地铁", type: RITLBubbleContainerView.RITLBubbleType.middle),
            (title: "20g", subtitle: "步行", type: RITLBubbleContainerView.RITLBubbleType.middle),
            (title: "5g", subtitle: "分享", type: RITLBubbleContainerView.RITLBubbleType.short),
            (title: "5g", subtitle: "分享", type: RITLBubbleContainerView.RITLBubbleType.middle),
        ])
    }
}


extension ViewController: THBubbleDelegate {
    
    func bubbleContainerView(allClear view: RITLBubbleContainerView) {
        print("我已经不存在数据啦")
    }
    
    func bubbleContainerView(view: RITLBubbleContainerView, didSelectAt index: Int) {
        print("我是\(index), 我被点击啦!")
        view.remove(index: index)
    }
}


