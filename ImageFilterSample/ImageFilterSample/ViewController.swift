//
//  ViewController.swift
//  ImageFilterSample
//
//  Created by RyutaMiyamoto on 2019/09/16.
//  Copyright © 2019 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        }
    }
    
    private let dataSource: [String] = ["CIBoxBlur","CIDiscBlur","CIGaussianBlur","CIMaskedVariableBlur","CIMedianFilter","CIMotionBlur","CINoiseReduction","CIZoomBlur","CIColorClamp","CIColorControls","CIColorMatrix","CIColorPolynomial","CIExposureAdjust","CIGammaAdjust","CIHueAdjust","CILinearToSRGBToneCurve","CISRGBToneCurveToLinear","CITemperatureAndTint","CIToneCurve","CIVibrance","CIWhitePointAdjust","CIColorCrossPolynomial","CIColorCube","CIColorCubeWithColorSpace","CIColorInvert","CIColorMonochrome","CIColorPosterize","CIFalseColor","CIMaskToAlpha","CIMaximumComponent","CIMinimumComponent","CIPhotoEffectChrome","CIPhotoEffectFade","CIPhotoEffectInstant","CIPhotoEffectMono","CIPhotoEffectNoir","CIPhotoEffectProcess","CIPhotoEffectTonal","CIPhotoEffectTransfer","CISepiaTone","CIVignette","CIVignetteEffect","CIBumpDistortion","CIBumpDistortionLinear","CICircularWrap","CIDisplacementDistortion","CIGlassDistortion","CIGlassLozenge","CIHoleDistortion","CIPinchDistortion","CIStretchCrop","CITorusLensDistortion","CITwirlDistortion","CIVortexDistortion","CIAffineTransform","CICrop","CILanczosScaleTransform","CIPerspectiveCorrection","CIPerspectiveTransform","CIPerspectiveTransformWithExtent","CIStraightenFilter","CICircularScreen","CICMYKHalftone","CIDotScreen","CIHatchedScreen","CILineScreen","CIAreaAverage","CIAreaHistogram","CIRowAverage","CIColumnAverage","CIHistogramDisplayFilter","CIAreaMaximum","CIAreaMinimum","CIAreaMaximumAlpha","CIAreaMinimumAlpha","CISharpenLuminance","CIUnsharpMask","CIBloom","CIComicEffect","CIConvolution3X3","CIConvolution5X5","CIConvolution7X7","CIConvolution9Horizontal","CIConvolution9Vertical","CICrystallize","CIDepthOfField","CIEdges","CIEdgeWork","CIGloom","CIHeightFieldFromMask","CIHexagonalPixellate","CIHighlightShadowAdjust","CILineOverlay","CIPixellate","CIPointillize","CISpotColor","CISpotLight","CIKaleidoscope"]
    
    private func filter(name: String) -> UIImage {
        guard let image = UIImage(named: "Image"), let ciImage = CIImage(image: image),
            let filter = CIFilter(name: name) else { return UIImage() }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let ciContext:CIContext = CIContext(options: nil)
        guard let filteredImage = filter.outputImage,
            let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent) else { return UIImage() }
        return UIImage(cgImage:imageRef, scale:1.0, orientation:.up)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.label.text = dataSource[indexPath.row]
        cell.filterImageView?.image = filter(name: dataSource[indexPath.row])
        return cell
    }
}
