//
//  ChangeTicket.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
//  Modified by Cuahuctemoc Osorio on 3/2/16


import Foundation

class ChangeTicket
{
    var number: String = ""
    var approver: String = ""
    var plannedStart: NSDate
    var plannedEnd: NSDate
    var actualStart: NSDate
    var actualEnd: NSDate
    var requestedByGroup: String = ""
    var requestedByGroupBusinessArea: String = ""
    var requestedByGroupBusinessUnit: String = ""
    var requestedByGroupSubBusinessUnit: String = ""
    var causeCompleteServiceAppOutage: String = ""
    var risk: String = ""
    var type: String = ""
    var impactScore: String = ""
    var shortDescription: String = ""
    var changeReason: String = ""
    var closureCode: String = ""
    var ImpactedEnviroment: String = ""
    var SecondaryClosureCode:String = ""
    var PartofRelease: String = ""
    var BusinessApplication: String = ""
    var BusinessApplicationCriticalityTier: String = ""
    
    let DateFormat = NSDateFormatter()
    
    
    init(number: String, approver: String, plannedStart: String, plannedEnd: String, actualStart: String, actualEnd: String, requestedByGroup: String, requestedByGroupBusinessArea:String, requestedByGroupBusinessUnit: String, requestedByGroupSubBusinessUnit: String, causeCompleteServiceAppOutage: String, risk: String, type:String, impactScore:String, shortDescription:String, changeReason: String, closureCode: String, ImpactedEnviroment: String, SecondaryClosureCode: String, PartofRelease: String, BusinessApplication: String, BusinessApplicationCriticalityTier: String)
    {
        DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.number = number
        self.approver = approver
        self.plannedStart = DateFormat.dateFromString(plannedStart)!
        self.plannedEnd = DateFormat.dateFromString(plannedEnd)!
        self.actualStart = DateFormat.dateFromString(actualStart)!
        self.actualEnd = DateFormat.dateFromString(actualEnd)!
        self.requestedByGroup = requestedByGroup
        self.requestedByGroupBusinessArea = requestedByGroupBusinessArea
        self.requestedByGroupBusinessUnit = requestedByGroupBusinessUnit
        self.requestedByGroupSubBusinessUnit = requestedByGroupSubBusinessUnit
        self.causeCompleteServiceAppOutage = causeCompleteServiceAppOutage
        self.risk = risk
        self.type = type
        self.impactScore = impactScore
        self.shortDescription = shortDescription
        self.changeReason = changeReason
        self.closureCode = closureCode
        self.ImpactedEnviroment = ImpactedEnviroment
        self.SecondaryClosureCode = SecondaryClosureCode
        self.PartofRelease = PartofRelease
        self.BusinessApplication = BusinessApplication
        self.BusinessApplicationCriticalityTier = BusinessApplicationCriticalityTier
    }
    
    //getters
    func getNumber() -> String
    {
        return self.number
    }
    func getApprover() -> String
    {
        return self.approver
    }
    func getPlannedStart() -> NSDate
    {
        return self.plannedStart
    }
    func getPlannedEnd() -> NSDate
    {
        return self.plannedEnd
    }
    func getActualStart() -> NSDate
    {
        return self.actualStart
    }
    func getActualEnd()-> NSDate
    {
        return self.actualEnd
    }
    func getRequestedByGroup() -> String
    {
        return self.requestedByGroup
    }
    func getRequestedByGroupBusinessArea() -> String
    {
        return self.requestedByGroupBusinessArea
    }
    func getRequestedByGroupBusinessUnit() -> String
    {
        return self.requestedByGroupBusinessUnit
    }
    func getRequestedByGroupSubBusinessUnit() -> String
    {
        return self.requestedByGroupSubBusinessUnit
    }
    func getCauseCompleteServiceAppOutage() -> String
    {
        return self.causeCompleteServiceAppOutage
    }
    func getRisk() -> String
    {
        return self.risk
    }
    func getType() -> String
    {
        return self.type
    }
    func getImpactScore() -> String
    {
        return self.impactScore
    }
    func getShortDescription() -> String
    {
        return self.shortDescription
    }
    func getChangeReason() -> String
    {
        return self.changeReason
    }
    func getClosureCode() -> String
    {
        return self.closureCode
    }
    func getImpactedEnviroment() -> String
    {
        return self.ImpactedEnviroment
    }
    func getSecondaryClosureCode() -> String
    {
        return self.SecondaryClosureCode
    }
    func getPartofRelease() -> String
    {
        return self.PartofRelease
    }
    func getBusinessApplication() -> String
    {
        return self.BusinessApplication
    }
    func getBusinessApplicationCriticalityTier() -> String
    {
        return self.BusinessApplicationCriticalityTier
    }
    //setters
    func setNumber(number: String)
    {
        self.number = number
    }
    func setApprover(approver: String)
    {
        self.approver = approver
    }
    func setPlannedStart(plannedStart: NSDate)
    {
        self.plannedStart = plannedStart
    }
    func setPlannedEnd(plannedEnd: NSDate)
    {
        self.plannedEnd = plannedEnd
    }
    func setActualStart(actualStart: NSDate)
    {
        self.actualStart = actualStart
    }
    func setActualEnd(actualEnd: NSDate)
    {
        self.actualEnd = actualEnd
    }
    func setRequestedByGroup(requestedByGroup: String)
    {
        self.requestedByGroup = requestedByGroup
    }
    func setRequestedByGroupBusinessArea(requestedByGroupBusinessArea: String)
    {
        self.requestedByGroupBusinessArea = requestedByGroupBusinessArea
    }
    func setRequestedByGroupBusinessUnit(requestedByGroupBusinessUnit: String)
    {
        self.requestedByGroupBusinessUnit = requestedByGroupBusinessUnit
    }
    func setRequestedByGroupSubBusinessUnit(requestedByGroupBusinessUnit: String)
    {
        self.requestedByGroupSubBusinessUnit = requestedByGroupBusinessUnit
    }
    func setCauseCompleteServiceAppOutage(causeCompleteServiceAppOutage: String)
    {
        self.causeCompleteServiceAppOutage = causeCompleteServiceAppOutage
    }
    func setRisk(risk: String)
    {
        self.risk = risk
    }
    func setType(type: String)
    {
        self.type = type
    }
    func setImpactScore(impactScore: String)
    {
        self.impactScore = impactScore
    }
    func setShortDescription(shortDescription: String)
    {
        self.shortDescription = shortDescription
    }
    func setChangeReason(changeReason: String)
    {
        self.changeReason = changeReason
    }
    func setClosureCode(closureCode: String)
    {
        self.closureCode = closureCode
    }
    func setImpactedEnviroment(ImpactedEnviroment: String)
    {
        self.ImpactedEnviroment = ImpactedEnviroment
    }
    func setSecondaryClosureCode(SecondaryClosureCode: String)
    {
        self.SecondaryClosureCode = SecondaryClosureCode
    }
    func setPartofRelease(PartofRelease: String)
    {
        self.PartofRelease = PartofRelease
    }
    func setBusinessApplication(BusinessApplication: String)
    {
        self.BusinessApplication = BusinessApplication
    }
    func setBusinessApplicationCriticalityTier(BusinessApplicationCriticalityTier: String)
    {
        self.BusinessApplicationCriticalityTier = BusinessApplicationCriticalityTier
    }
}
