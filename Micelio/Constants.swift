//
//  Constants.swift
//  Micelio
//
//  Created by Davide Aliti on 30/11/23.
//

import Foundation

enum Constants {
    
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
    
    enum MushroomCatalog {
        enum NavigationLink {
            public static let padding: CGFloat = 4
        }
        
        enum MushroomCatalogRow {
            public static let imageFrameSize: CGFloat = 80
            public static let clipShapeCornerSize: CGSize = CGSize(width: 20, height: 10)
            public static let vStackSpacing: CGFloat = 20
        }
        
        enum TitleAndDetails {
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
            public static let titleAndDetailOffsetCorrection: CGFloat = 70
            public static let internalVStackSpacing: CGFloat = 25
            public static let internalVStackHorizontalPadding: CGFloat = 20
            public static let internalVStackBottomPadding: CGFloat = 50
            public static let internalVStackFrameMaxWidth: CGFloat = 640
            public static let spacerMinLengthCorrection: CGFloat = 60
            
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
