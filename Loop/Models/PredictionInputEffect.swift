//
//  PredictionInputEffect.swift
//  Loop
//
//  Created by Nate Racklyeft on 9/4/16.
//  Copyright © 2016 Nathan Racklyeft. All rights reserved.
//

import Foundation
import HealthKit


struct PredictionInputEffect: OptionSet {
    let rawValue: Int

    static let carbs            = PredictionInputEffect(rawValue: 1 << 0)
    static let insulin          = PredictionInputEffect(rawValue: 1 << 1)
    static let momentum         = PredictionInputEffect(rawValue: 1 << 2)
    static let retrospection    = PredictionInputEffect(rawValue: 1 << 3)
    static let suspend          = PredictionInputEffect(rawValue: 1 << 4)
    static let damper           = PredictionInputEffect(rawValue: 1 << 5)

    static let all: PredictionInputEffect = [.carbs, .insulin, .damper, .momentum, .retrospection]

    var localizedTitle: String? {
        switch self {
        case [.carbs]:
            return NSLocalizedString("Carbohydrates", comment: "Title of the prediction input effect for carbohydrates")
        case [.insulin]:
            return NSLocalizedString("Insulin", comment: "Title of the prediction input effect for insulin")
        case [.damper]:
            return NSLocalizedString("Negative Insulin Damper", comment: "Title of the prediction input effect for negative insulin damper")
        case [.momentum]:
            return NSLocalizedString("Glucose Momentum", comment: "Title of the prediction input effect for glucose momentum")
        case [.retrospection]:
            return NSLocalizedString("Retrospective Correction", comment: "Title of the prediction input effect for retrospective correction")
        case [.suspend]:
            return NSLocalizedString("Suspension of Insulin Delivery", comment: "Title of the prediction input effect for suspension of insulin delivery")
        default:
            return nil
        }
    }

    func localizedDescription(forGlucoseUnit unit: HKUnit) -> String? {
        switch self {
        case [.carbs]:
            return String(format: NSLocalizedString("Carbs Absorbed (g) ÷ Carb Ratio (g/U) × Insulin Sensitivity (%1$@/U)", comment: "Description of the prediction input effect for carbohydrates. (1: The glucose unit string)"), unit.localizedShortUnitString)
        case [.insulin]:
            return String(format: NSLocalizedString("Insulin Absorbed (U) × Insulin Sensitivity (%1$@/U)", comment: "Description of the prediction input effect for insulin"), unit.localizedShortUnitString)
        case [.damper]:
            return String(format: NSLocalizedString("Glucose effect of applying a damper to reduce increases in glucose due to negative insulin", comment: "Description of the prediction input effect for negative insulin damper"), unit.localizedShortUnitString)
        case [.momentum]:
            return NSLocalizedString("15 min glucose regression coefficient (b₁), continued with decay over 30 min", comment: "Description of the prediction input effect for glucose momentum")
        case [.retrospection]:
            return NSLocalizedString("30 min comparison of glucose prediction vs actual, continued with decay over 60 min", comment: "Description of the prediction input effect for retrospective correction")
        case [.suspend]:
             return NSLocalizedString("Glucose effect of suspending insulin delivery", comment: "Description of the prediction input effect for suspension of insulin delivery")
        default:
            return nil
        }
    }
}
