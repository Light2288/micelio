//
//  Constants.swift
//  Micelio
//
//  Created by Davide Aliti on 30/11/23.
//

import Foundation
import SwiftUI

enum Constants {
    enum MushroomClassifier {
        public static let minConfidence: Float = 0.05
        
        // Maps all MobileNetV2 classifications related to mushrooms
        public static let mobileNetMushroomClassifications: [String] = [
            "agaric",
            "mushroom",
            "polyporus",
            "earthstar",
            "bolete",
            "fungus",
            "gyromitra"
        ]
    }
    
    enum Styles {
        enum DisclosureGroupCustomStyle {
            public static let imageDimension: CGFloat = 30
        }
        
        enum ResizableImageWithShapeBackground {
            public static let padding: CGFloat = 6
        }
        
        enum ViewWithShapeBackground {
            public static let shadowRadius: CGFloat = 8
        }
        
        enum RecogniseImageStyle {
            public static let cornerRadius: CGSize = CGSize(width: 20, height: 10)
        }
    }
    
    enum CommonViews {
        enum LegendItemImage {
            public static let defaultPadding: CGFloat = 8
            public static let defaultCornerSize: CGSize = CGSize(width: 20, height: 10)
            public static let defaultLineWidth: CGFloat = 2
        }
    }
    
    enum Legend {
        enum LegendListSection {
            public static let headerPaddingTop: CGFloat = 10
        }
        
        enum LegendListRow {
            public static let imageSize: CGFloat = 60
        }
    }
    
    enum SplashScreen {
        public static let showMainIconTaskDelay: UInt64 = 2500000000
        public static let showMainTextAnimationDuration: TimeInterval = 0.6
        public static let showMainTextAnimationDelay: TimeInterval = 0.35
        public static let mainTextFontSize: CGFloat = 60
        public static let hideSplashScreenDelay: UInt64 = 4300000000
        
        enum MushroomIcons {
            public static let showMushroomIconsTaskDelay: UInt64 = 400000000
        }
    }
    
    enum MushroomMap {
        public static let sheetFraction: CGFloat = 0.75
        
        enum Map {
            public static let longPressMinimumDuration: Double = 0.25
            public static let dragGestureMinimumDistance: Double = 10
        }
        
        enum MushroomPin {
            public static let shadowRadius: CGFloat = 3
            public static let frameHeight: CGFloat = 60
        }
        
        enum CenterMapButton {
            public static let frameSize: CGFloat = 50
        }
        
        enum AddPinButton {
            public static let frameSize: CGFloat = 50
            public static let padding: CGFloat = -5
        }
        
        enum AddMushroomLocationText {
            public static let maxWidthCorrectionRatio: Double = 1.3
            public static let maxWidth: CGFloat = 400
        }
        
        enum AnnotationSheet {
            public static let vStackSpacing: CGFloat = 15
            
            enum ButtonHStack {
                public static let spacing: CGFloat = 15
                public static let bottomPadding: CGFloat = 3
            }
            
            enum DisplayView {
                public static let vStackSpacing: CGFloat = 10
            }
            
            enum EditView {
                public static let vStackSpacing: CGFloat = 15
                
                enum NotesText {
                    public static let vStackSpacing: CGFloat = 3
                }
                
                enum PinColorChoiceButton {
                    public static let cornerRadius: CGSize = CGSize(width: 3, height: 3)
                    public static let lineWidth: CGFloat = 3
                    public static let maxHeight: CGFloat = 30
                }
                
                enum SaveAnnotationButton {
                    public static let labelPadding: CGFloat = 5
                }
            }
        }
    }
    
    enum Recognise {
        public static let maxWidth: CGFloat = 600
        
        enum AddPhotoButtons {
            public static let roundButtonSize: CGFloat = 80
            public static let horizontalBottomPadding: CGFloat = 20
        }
        
        enum RecogniseButton {
            public static let roundButtonSize: CGFloat = 80
            public static let capsuleButtonWidth: CGFloat = 200
        }
        
        enum RecogniseDisclaimer {
            public static let backgroundRectangleCornerSize: CGSize = CGSize(width: 20, height: 20)
            public static let backgroundRectangleStrokeLineWidth: CGFloat = 1.5
            
            enum Title {
                public static let bottomPadding: CGFloat = 3
            }
        }
        
        enum Results {
            public static let imageFrameMaxHeight: CGFloat = 200
            public static let vStackFrameMaxHeight: CGFloat = 600
            
            enum ResultList {
                enum MainResult {
                    public static let vStackBottomPadding: CGFloat = 30
                    public static let titleBottomPadding: CGFloat = 6
                }
                
                enum OtherResults {
                    public static let titleBottomPadding: CGFloat = 3
                    public static let resultTextMaxHeight: CGFloat = 80
                }
                
                enum ResultItem {
                    public static let defaultMaxHeight: CGFloat = 100
                    public static let overlayCornerRadius: CGFloat = 20
                    public static let overlayLineWidth: CGFloat = 2
                    
                    enum MushroomNameText {
                        public static let padding: CGFloat = 3
                    }
                    
                    enum MushroomConfidenceText {
                        public static let lowConfidenceUpperLimit: Float = 0.2
                        public static let midConfidenceUpperLimit: Float = 0.7
                    }
                }
            }
        }
    }
    
    enum MushroomCatalog {
        enum NavigationLink {
            public static let padding: CGFloat = 4
        }
        
        enum NoFilteredResults {
            public static let imageFrameDimension: CGFloat = 200
        }
        
        enum CatalogFilter {
            public static let vStackSpacing: CGFloat = 5
            public static let hStackBottomPadding: CGFloat = 8
            public static let vStackVerticalPadding: CGFloat = 10
            public static let vStackShadowRadius: CGFloat = 1
            
            enum CatalogFilterMenuLabel {
                public static let appliedFiltersCountTextPadding: CGFloat = 5
            }
        }
        
        enum MushroomCatalogRow {
            public static let imageFrameSize: CGFloat = 80
            public static let clipShapeCornerSize: CGSize = CGSize(width: 20, height: 10)
            public static let vStackSpacing: CGFloat = 10
            public static let vStackPadding: CGFloat = 10
            public static let rowEdgeInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        }
        
        enum TitleAndDetails {
            public static let maxWidthCorrection: CGFloat = 80
            public static let backgroundCornerSize: CGSize = CGSize(width: 20, height: 10)
            public static let shadowRadius: CGFloat = 5
            public static let shadowY: CGFloat = 3
            
            enum Details {
                public static let bottomPadding: CGFloat = 8
            }
            
            enum DetailGrid {
                public static let oneColumnMaxWidth: CGFloat = 60
                public static let twoColumnsMaxWidth: CGFloat = 120
                public static let gridItemWidth: CGFloat = 50
                public static let imageSize: CGFloat = 40
                public static let imagePadding: CGFloat = 4
                public static let imageCornerSize: CGSize = CGSize(width: 5, height: 5)
                public static let imageLineWidth: CGFloat = 1
            }
        }
        
        enum MushroomDetail {
            public static let externalVStackSpacing: CGFloat = 20
            public static let internalVStackSpacing: CGFloat = 25
            public static let internalVStackHorizontalPadding: CGFloat = 20
            public static let internalVStackBottomPadding: CGFloat = 50
            public static let internalVStackFrameMaxWidth: CGFloat = 640
            public static let titleAndDetailsOffsetCorrectionRatio: CGFloat = 1.5
            public static let spacerMinLengthCorrectionRatio: CGFloat = 2.2
            
            enum MainAndAdditionalImage {
                enum AllImagesContainer {
                    public static let smallImageSizeCorrectionFactor: Int = 5
                    public static let backgroundRectangleHeightCorrection: CGFloat = 20
                    public static let backgroundRectangleWidthCorrectionFactor: Int = 2
                    public static let backgroundRectangleShadowRadius: CGFloat = 20
                    public static let backgroundRectangleShadowX: CGFloat = -10
                }
                
                enum AllImages {
                    public static let rowSpacing: CGFloat = 1
                }
            }
        }
    }
    
    
}
