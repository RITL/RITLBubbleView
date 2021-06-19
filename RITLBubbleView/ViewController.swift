//
//  ViewController.swift
//  RITLBubbleView
//
//  Created by YueWen on 2021/6/13.
//

import UIKit

class ViewController: UIViewController {

    private let max = 3 //每次最多是3个
    /// 数据
    private var items: [RITLBubbleItem] = [
        
        (id: "01", title: "50cal", subtitle: "知识问答", type: RITLBubbleContainerView.RITLBubbleType.large),
        (id: "02", title: "25g", subtitle: "坐地铁", type: RITLBubbleContainerView.RITLBubbleType.meduim),
        (id: "03", title: "20g", subtitle: "步行", type: RITLBubbleContainerView.RITLBubbleType.meduim),
        (id: "04", title: "5g", subtitle: "分享", type: RITLBubbleContainerView.RITLBubbleType.short),
        (id: "05", title: "5g", subtitle: "分享", type: RITLBubbleContainerView.RITLBubbleType.meduim),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bubbleView = RITLBubbleContainerView()
        
        view.addSubview(bubbleView)
        
        bubbleView.backgroundColor = #colorLiteral(red: 0.4867153168, green: 0.7604991198, blue: 1, alpha: 1)
        bubbleView.delegate = self
        bubbleView.frame = CGRect(x: 10, y: 50, width: UIScreen.main.bounds.width - 20, height: 300)
        bubbleView.contentRect = bubbleView.bounds
        
        bubbleView.retriesCount = 300 //完全不重叠的循环次数为300，如果300次随机仍不能完全重合，使用 offsetRatio 进行重合
        bubbleView.offsetRatio = 0.7 // 如果实在无法完全布遮盖，允许遮盖0.3，漏出0.7
        
        //设置属性
        bubbleView.setItems(items: items.prefix(max).map {$0} )
        //移除本地的数据
        items.removeFirst(min(max, items.count))
    }
}


extension ViewController: RITLBubbleDelegate {
    
    func bubbleContainerView(allClear view: RITLBubbleContainerView) {
        print("我已经不存在数据啦")
    }
    
    func bubbleContainerView(view: RITLBubbleContainerView, didSelectAt index: Int, item: RITLBubbleItem) {
        
        // view.items 将存储未removeAll之前的所有数据
        
        print("我是\(index), 我被点击啦!")
        view.remove(index: index)
        
        //如果本地还有数据，添加一个即可
        if !items.isEmpty {
            view.appendItem(item: items.removeFirst())
        }
        
    }
}


