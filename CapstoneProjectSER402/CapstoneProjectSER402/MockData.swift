//
//  MockData.swift
//  CapstoneProjectSER402
//
//  Created by Cuahuc on 4/18/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation


class MockData
{
    var MOCK_DATA_ARRAY = [ChangeTicket]()
    var i = 0
    
    func setMockData(data: ChangeTicket)
    {
        MOCK_DATA_ARRAY.append(data)
    }
    
    func getMockData() -> [ChangeTicket]
    {
        return MOCK_DATA_ARRAY
    }
    func parseExampleXMLFileForPublic() -> [ChangeTicket]
    {
        guard let
            xmlPath = NSBundle.mainBundle().pathForResource("changeList_public", ofType: "xml"),
            data = NSData(contentsOfFile: xmlPath)
            else
        {
            return MOCK_DATA_ARRAY
        }
        
        do
        {
            let xmlDoc = try AEXMLDocument(xmlData: data)
            
            //ConnectionService.sharedInstance.parseChange(xmlDoc)
            
            print("XML Information\n")
            
            
            if let tickets = xmlDoc.root["SOAP-ENV:Body"]["insertResponse"]["status_message"]["ReturnMessage"]["ChangeStatus"]["changeInformation"].all
            {
                for ticket in tickets
                {
                    if ticket["business_Application"].name == AEXMLElement.errorElementName
                    {
                        //print("no business app")
                        //D0 Nothing
                    }
                    else
                    {
                        ticket["Requested_By_Group_Business_Area"].removeFromParent()
                        ticket.addChild(name: "Requested_By_Group_Business_Area", value: "Lorem ipsum")
                        
                        ticket["Requested_By_Group_Business_Unit"].removeFromParent()
                        ticket.addChild(name: "Requested_By_Group_Business_Unit", value: "Lorem ipsum")
                        
                        ticket["Requested_By_GroupSub_Business_Unit"].removeFromParent()
                        ticket.addChild(name: "Requested_By_GroupSub_Business_Unit", value: "Lorem ipsum")
                        
                        //ticket.addChild(name: "Requested_By_GroupSub_Business_Unit", value: "Lorem ipsum")
                        
                        let newTicket = ChangeTicket(number: ticket["Number"].stringValue, approver: ticket["Approver"].stringValue, plannedStart: ticket["Planned_Start"].stringValue, plannedEnd: ticket["Planned_End"].stringValue, actualStart: ticket["Actual_Start"].stringValue, actualEnd: ticket["Actual_End"].stringValue, requestedByGroup: ticket["Requested_By_Group"].stringValue,
                                                     requestedByGroupBusinessArea: ticket["Requested_By_Group_Business_Area"].stringValue, requestedByGroupBusinessUnit: ticket["Requested_By_Group_Business_Unit"].stringValue, requestedByGroupSubBusinessUnit: ticket["Requested_By_GroupSub_Business_Unit"].stringValue, causeCompleteServiceAppOutage: ticket["Causes_Complete_ServiceApplication_Outage"].stringValue, risk: ticket["Risk"].stringValue, type:ticket["Type"].stringValue, impactScore:ticket["Impact_Score"].stringValue, shortDescription:ticket["Short_Description"].stringValue, changeReason: ticket["Change_Reason"].stringValue, closureCode: ticket["Closure_Code"].stringValue, ImpactedEnviroment: ticket["Impacted_Environments"].value!, SecondaryClosureCode: ticket["Secondary_Closure_Code"].stringValue, PartofRelease: ticket["Part_of_a_release"].stringValue, BusinessApplication: ticket["business_Application"]["businessAppName"].stringValue, BusinessApplicationCriticalityTier: ticket["business_Application"]["Business_Application_CriticalityTier"].stringValue)
                        setMockData(newTicket)
                    }
                }
                return MOCK_DATA_ARRAY
            }
            
        }
        catch
        {
            print("\(error)" + "this is the error")
        }
        return MOCK_DATA_ARRAY
    }

    func parseExampleXMLFile() -> [ChangeTicket]
    {
        guard let
            xmlPath = NSBundle.mainBundle().pathForResource("changeList", ofType: "xml"),
            data = NSData(contentsOfFile: xmlPath)
        else
        {
            return MOCK_DATA_ARRAY
        }
        
        do
        {
            let xmlDoc = try AEXMLDocument(xmlData: data)
            
            //ConnectionService.sharedInstance.parseChange(xmlDoc)
            
            print("XML Information\n")
            
            
            if let tickets = xmlDoc.root["SOAP-ENV:Body"]["insertResponse"]["status_message"]["ReturnMessage"]["ChangeStatus"]["changeInformation"].all
            {
                for ticket in tickets
                {
                    if ticket["business_Application"].name == AEXMLElement.errorElementName
                    {
                        //print("no business app")
                        //D0 Nothing
                    }
                    else
                    {
                        let newTicket = ChangeTicket(number: ticket["Number"].stringValue, approver: ticket["Approver"].stringValue, plannedStart: ticket["Planned_Start"].stringValue, plannedEnd: ticket["Planned_End"].stringValue, actualStart: ticket["Actual_Start"].stringValue, actualEnd: ticket["Actual_End"].stringValue, requestedByGroup: ticket["Requested_By_Group"].stringValue,
                                                     requestedByGroupBusinessArea: ticket["Requested_By_Group_Business_Area"].stringValue, requestedByGroupBusinessUnit: ticket["Requested_By_Group_Business_Unit"].stringValue, requestedByGroupSubBusinessUnit: ticket["Requested_By_GroupSub_Business_Unit"].stringValue, causeCompleteServiceAppOutage: ticket["Causes_Complete_ServiceApplication_Outage"].stringValue, risk: ticket["Risk"].stringValue, type:ticket["Type"].stringValue, impactScore:ticket["Impact_Score"].stringValue, shortDescription:ticket["Short_Description"].stringValue, changeReason: ticket["Change_Reason"].stringValue, closureCode: ticket["Closure_Code"].stringValue, ImpactedEnviroment: ticket["Impacted_Environments"].value!, SecondaryClosureCode: ticket["Secondary_Closure_Code"].stringValue, PartofRelease: ticket["Part_of_a_release"].stringValue, BusinessApplication: ticket["business_Application"]["businessAppName"].stringValue, BusinessApplicationCriticalityTier: ticket["business_Application"]["Business_Application_CriticalityTier"].stringValue)
                        setMockData(newTicket)
                    }
                }
                return MOCK_DATA_ARRAY
            }
            
        }
        catch
        {
            print("\(error)" + "this is the error")
        }
        return MOCK_DATA_ARRAY
    }
}