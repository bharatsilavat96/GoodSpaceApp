//
//  CircularProgressView.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation
import UIKit

class CircularProgressBar: UIView {
    private var progressLayer: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: frame.size.width / 2,
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )

        progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor(hex: "#1E9915").cgColor
        progressLayer.lineWidth = 2.0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0.0

        layer.addSublayer(progressLayer)
    }

    func setProgress(_ progress: Float) {
        progressLayer.strokeEnd = CGFloat(progress)
    }
}
