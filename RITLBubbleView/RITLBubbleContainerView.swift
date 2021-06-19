//
//  RITLBubbleContainerView.swift
//  RITLBubbleView
//
//  Created by YueWen on 2021/6/13.
//

import UIKit

private extension RITLBubbleContainerView.RITLBubbleType {
    
    /// 大小
    func diameter() -> CGFloat {
        switch self {
        case .short: return 45
        case .regular: return 52
        case .meduim: return 60
        case .large: return 68
        case .custom(let diameter, _): return diameter
        }
    }
    
    /// 漂浮物中间的字体大小
    func font() -> UIFont {
        switch self {
        case .short: return UIFont.systemFont(ofSize: 10, weight: .medium)
        case .regular: return UIFont.systemFont(ofSize: 11, weight: .medium)
        case .meduim: return UIFont.systemFont(ofSize: 12, weight: .medium)
        case .large: return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .custom(_, let font): return font
        }
    }
}



/// RITLBubbleContainerView 中的漂浮物视图
public class RITLBubbleItemView: UIView {
    
    /// 显示的背景图片
    let imageView = UIImageView()
    /// 位于图片中的标签
    let middleLabel = UILabel()
    /// 位于图片下方的标签
    let bottomLabel = UILabel()
    /// 负责响应的control
    let control = UIControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(control)
        addSubview(imageView)
        addSubview(middleLabel)
        addSubview(bottomLabel)
        
        imageView.backgroundColor = #colorLiteral(red: 0.1025624946, green: 0.7712242603, blue: 0.6992376447, alpha: 1)
        
        middleLabel.textAlignment = .center
        middleLabel.text = "500cal"
        middleLabel.textColor = #colorLiteral(red: 0.2397080362, green: 0.5343199372, blue: 0.1250673234, alpha: 1)
        middleLabel.isUserInteractionEnabled = false
        
        bottomLabel.textAlignment = .center
        bottomLabel.text = "知识问答"
        bottomLabel.textColor = #colorLiteral(red: 0.2397080362, green: 0.5343199372, blue: 0.1250673234, alpha: 1)
        bottomLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        bottomLabel.isUserInteractionEnabled = false
        
        control.translatesAutoresizingMaskIntoConstraints = false
        control.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        control.topAnchor.constraint(equalTo: topAnchor).isActive = true
        control.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        control.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        control.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
//        imageView.snp.makeConstraints { make in
//            make.leading.top.trailing.equalToSuperview()
//            make.height.equalTo(imageView.snp.width)
//        }
        
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        middleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        middleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        middleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
//        middleLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.centerY.equalTo(imageView)
//            make.height.equalTo(17)
//        }
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
//        bottomLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(2)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(18)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
    }
}



public protocol RITLBubbleDelegate: AnyObject {
    
    /// bubbleItemView点击的回调
    /// 需要手动去remove
    /// - Parameters:
    ///   - index: 该索引调用view.remove
    ///   - item: 点击回调的数据源
    func bubbleContainerView(view: RITLBubbleContainerView, didSelectAt index: Int, item: RITLBubbleItem)
    /// 全部已经清楚的回调
    func bubbleContainerView(allClear view: RITLBubbleContainerView)
}

public extension RITLBubbleDelegate {
    
    func bubbleContainerView(view: RITLBubbleContainerView, didSelectAt index: Int, item: RITLBubbleItem) {}
    func bubbleContainerView(allClear view: RITLBubbleContainerView) {}
}

/// title为漂浮物中间的文本
/// subtitle为底部的文本
public typealias RITLBubbleItem = (id: String, title: String, subtitle: String, type: RITLBubbleContainerView.RITLBubbleType)

/// 青碳行的泡泡容器
public final class RITLBubbleContainerView: UIView {
    
    /// 基础的tag
    private static let RITLBubbleSubviewsBaseTag = 10000

    /// 泡泡的类型
    public enum RITLBubbleType {
        /// 默认的小
        case short
        /// 默认的正常
        case regular
        /// 默认的中
        case meduim
        /// 默认的大
        case large
        /// 自定义的直径(大小为漂浮物图片的直径，不包含底部的描述文本)
        /// 实际应用半径 > diameter / 2.0, 会在此基础增加底部的描述文本
        /// font为漂浮物中间的文字font
        case custom(diameter: CGFloat, font: UIFont)
    }
        
    // public
    
    public weak var delegate: RITLBubbleDelegate?
    
    /// 是否可以存在遮盖
    /// 默认为false 不能遮盖
    /// 如果实在无法完全独立，可能会存在循环问题，可以使用 retriesCount 和 offsetRatio 参数进行摇摆设置
    /// 如果该参数为true,则不会进行重试
    public var coverable = false
    
    /// 重试次数
    /// 当随机生成后，存在遮盖时的重试次数
    /// 默认为 -1 表示会一直重试，可能会在 contentRect 设置不合理时出现无限循环
    public var retriesCount = -1
    
    /// 位置的摇摆误差（不遮盖的比例）
    /// 只有当达到 retriesCount 时才会进行比例摇摆
    /// 两个泡泡允许存在的误差比例，可选范围: [0.0, 1.0]
    /// 0.0 表示可以完全重合；1.0 表示完全不重合
    /// 默认为 1.0
    public var offsetRatio: CGFloat = 1.0 {
        didSet {
            if offsetRatio < 0 || offsetRatio > 1 {
                fatalError("retriesProgress 设置错误!")
            }
        }
    }
    
    /// 四周的间距
    public var margin: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            if margin.left < 0 || margin.top < 0 || margin.right < 0 || margin.bottom < 0  {
                fatalError("margin 设置非法!")
            }
        }
    }
    /// 每个漂浮物的间距
    public var bubbleMargin: CGFloat = 5 {
        didSet {
            if bubbleMargin < 0 {
                fatalError("margin 设置非法!")
            }
        }
    }
    /// 设置区域，用于计算
    /// 如果使用frame布局，将bounds设置即可
    /// 如果使用约束布局，将计算后的bounds设置完毕，在进行设置
    public var contentRect: CGRect = .zero {
        didSet {
            if contentRect.width < 0 || contentRect.height < 0 {
                fatalError("contentRect 设置非法!")
            }
        }
    }
    
    /// 设置初始化数据
    public func setItems(items: [RITLBubbleItem]) {
        //移除所有的漂浮物
        removeAll()
        //赋值并创建
        self.items = items
        for item in items {
            create(item: item)
        }
    }
    
    
    /// 添加数据
    public func appendItem(item: RITLBubbleItem) {
        items.append(item)
        create(item: item)
    }
    
    /// 创建一个漂浮物
    /// - Parameters:
    ///   - item: 存放的数据item
    ///   - title: 泡泡中间显示的文本
    ///   - subtitle: 泡泡底部展示的文本
    private func create(item: RITLBubbleItem) {
        let diameter = item.type.diameter() + diameterExternSpace/*底部的文本高度*/
        //获得垂直随机位置
        let minY = margin.top + diameter * 0.5 + bubbleMargin
        let maxY = contentRect.height - diameter * 0.5 - bubbleMargin - margin.bottom
        //获得水平的随机位置
        let minX = margin.left + bubbleMargin + diameter * 0.5
        let maxX = contentRect.width - diameter * 0.5 - margin.right - bubbleMargin
        
        //获得随机的x,y
        let x = CGFloat(random(from: minX, to: maxX))
        let y = CGFloat(random(from: minY, to: maxY))
        //开始追加验证
        // 如果不允许覆盖，进行验证
        if !coverable {
            for center in centers {
                // 两个点之间的距离
                let currentDistance = CGFloat(sqrtf(pow(Float(center.x - x), 2) + pow(Float((center.y) - y), 2)))
                // 如果小于等于 diameter + bubbleMargin, 目前存在重叠
                if (currentDistance <= diameter + bubbleMargin) {
                    // 如果重试次数小于0，则无限重试
                    if retriesCount <= 0 {
                        create(item: item); return
                    }
                    // 如果重试次数没有达到最大的数量，则进行计数增加，重试
                    if (cacheCount[item.id] ?? -1) <= retriesCount {
                        let value = cacheCount[item.id] ?? 0
                        cacheCount[item.id] = value + 1
                        create(item: item); return
                    }
                    // 如果允许重试并且重试的次数已经大于了规范化的重试，则进行误差比例的权衡
                    // 再次进行比对,符合存在误差的偏移，直接使用即可
                    if currentDistance >= ((diameter + bubbleMargin) * offsetRatio) {
                        break
                    }
                    //重置
                    create(item: item); return
                }
            }
        }

        //存储中心点
        let center = CGPoint(x: x, y: y)
        centers.append(center)
        
        //创建view
        let view = RITLBubbleItemView()
        view.bounds = CGRect(x: 0, y: 0, width: diameter - diameterExternSpace, height: diameter)
        view.center = center
        addSubview(view)
        //记录视图
        allItemViews.append(view)
        //设置tag
        view.tag = RITLBubbleContainerView.RITLBubbleSubviewsBaseTag + (items.firstIndex { $0.id == item.id } ?? 1)
        //设置数据
        view.middleLabel.font = item.type.font()
        view.middleLabel.text = item.title
        view.bottomLabel.text = item.subtitle
        //追加响应按钮
        view.control.addTarget(self, action: #selector(bubbleViewDidTap(view:)), for: .touchUpInside)
        //
        animaion(scaleOnce: view)
        animation(upDown: view)
    }
    
    
    /// 移除当前索引的漂浮物
    /// - Parameter index: 索引
    public func remove(index: Int) {
        //获得tag
        let tag = RITLBubbleContainerView.RITLBubbleSubviewsBaseTag + index
        //选取view
        guard let view = allItemViews.first(where: { subview in
            return subview.tag == tag
        }) else { return }
        //启用动画
        UIView.animate(withDuration: 0.1) {
            //缩小
            view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
            
        } completion: { _ in
            //移除即可
            view.removeFromSuperview()
            self.allItemViews.removeAll { subview in
                return subview.tag == view.tag
            }
            //移除中心点
            self.centers.removeAll { center in
                return center == view.center
            }
            //如果所有的不在了，执行回调即可
            if self.allItemViews.isEmpty {
                self.delegate?.bubbleContainerView(allClear: self)
            }
        }
    }
    
    
    /// 移除所有的漂浮物
    public func removeAll() {
        for view in allItemViews {
            view.removeFromSuperview()
        }
        //重置所有的数据
        allItemViews.removeAll()
        centers.removeAll()
        items.removeAll()
        cacheCount.removeAll()
    }
    
    
    @objc func bubbleViewDidTap(view: UIView) {
        //获得superView并进行类型判断
        guard let bubbleItemView = view.superview as? RITLBubbleItemView else { return }
        //启用动画
        UIView.animate(withDuration: 0.1) {
            //缩放
            bubbleItemView.transform = bubbleItemView.transform.scaledBy(x: 1.15, y: 1.15)
        
        } completion: { _ in
            //进行点击回调
            guard bubbleItemView.tag >= RITLBubbleContainerView.RITLBubbleSubviewsBaseTag else { return }
            let index = bubbleItemView.tag - RITLBubbleContainerView.RITLBubbleSubviewsBaseTag
            self.delegate?.bubbleContainerView(view: self, didSelectAt: index, item: self.items[index])
        }
    }
    
    
    // private
    
    /// 进行计算的直径拓宽距离
    private let diameterExternSpace: CGFloat = 20
    
    /// 存储所有的中心点
    private var centers = [CGPoint]()
    /// 存储所有的按钮
    private var allItemViews = [UIView]()
    /// 存储所有的数据源
    private(set) var items = [RITLBubbleItem]()
    /// 用于缓存生成次数
    private var cacheCount = [String: Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 获得一个随机的中间值
    private func random(from: CGFloat, to: CGFloat) -> Int {
        //进行大小的交换
        let from = min(from, to)
        let to = max(from, to)
        return Int(from + CGFloat(Int(arc4random()) % Int(to - from + 1)))
    }
    
    //MARK: Animation
    
    /// 缩放一次的动画
    private func animaion(scaleOnce view: UIView) {
        UIView.animate(withDuration: 0.2) {
            view.transform = view.transform.scaledBy(x: 1.05, y: 1.05)
        } completion: { _ in
            //缩小即可
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
            }
        }
    }
    
    /// 上下活动的动画
    private func animation(upDown view: UIView) {
        
        let layer = view.layer
        let position = layer.position
        let from = CGPoint(x: position.x, y: position.y)
        var to = CGPoint(x: position.x, y: 0)
        
        //开始计算
        //随机的类型，用于随机上下
        let typeInt = arc4random() % 100
        var distanceFloat: CGFloat = 0
        //进行重新计算
        while distanceFloat == 0 {
            //随机
            distanceFloat = CGFloat((6 + Int(arc4random() % (9 - 7 + 1)))) * 100.0 / 101.0
        }
        let toPointY = position.y + distanceFloat * CGFloat(typeInt % 2 == 0 ? -1 : 1)
        to.y = toPointY
        
        //设置animation
        let animation = CABasicAnimation(keyPath: "position")
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fromValue = NSValue(cgPoint: from)
        animation.toValue = NSValue(cgPoint: to)
        animation.autoreverses = true
        var durationFloat: CGFloat = 0.0
        while durationFloat == 0 {
            durationFloat = 0.9 + CGFloat(Int(arc4random() % (100 - 70 + 1))) / 31.0
        }
        animation.duration = CFTimeInterval(durationFloat)
        animation.repeatCount = .greatestFiniteMagnitude
        
        layer.add(animation, forKey: nil)
    }
}
