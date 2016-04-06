//
//  ConnectService.swift
//  Test
//
//  Created by Rose, Colton (ASU) on 3/19/16.
//  Copyright © 2016 Rose, Colton (ASU). All rights reserved.
//

import Foundation

class ConnectionService : NSObject, NSURLSessionDelegate {
    
    static let sharedInstance = ConnectionService()
    private override init(){}
    
    let userName = "sys_ws_asu_poly"
    let passWord = "ASU_Test#1"
    
    let proxyHost : CFString = NSString(string: "10.195.244.100") as CFString
    let proxyPort : CFNumber = NSNumber(int: 8080) as CFNumber
    let proxyEnable : CFNumber = NSNumber(int: 1) as CFNumber
    
    var businessApps = [BusinessApp]()
    
    func parseChange(xml: AEXMLDocument) -> ([ChangeTicket]) {
        var ticketList = [ChangeTicket]()
        if let tickets = xml.root["SOAP-ENV:Body"]["insertResponse"]["status_message"]["ReturnMessage"]["ChangeStatus"]["changeInformation"].all {
            for ticket in tickets {
                if ticket["Requested_By_Group_Business_Area"].count == 0 {
                    ticket.addChild(name: "Requested_By_Group_Business_Area", value: " ")
                }
                
                let newTicket = ChangeTicket(number: ticket["Number"].value!, approver: ticket["Approver"].value!, plannedStart: ticket["PlannedStart"].value!, plannedEnd: ticket["PlannedEnd"].value!, actualStart: ticket["ActualStart"].value!, actualEnd: ticket["ActualEnd"].value!, requestedByGroup: ticket["Requested_By_Group"].value!,
                    requestedByGroupBusinessArea: "", requestedByGroupBusinessUnit: ticket["Requested_By_Group_Business_Unit"].value!, requestedByGroupSubBusinessUnit: ticket["Requested_By_GroupSub_Business_Unit"].value!, causeCompleteServiceAppOutage: ticket["Causes_Complete_ServiceApplication_Outage"].value!, risk: ticket["Risk"].value!, type:ticket["Type"].value!, impactScore:ticket["Impact_Score"].value!, shortDescription:ticket["Short_Description"].value!, changeReason: ticket["Change_Reason"].value!, closureCode: ticket["Closure_Code"].value!, ImpactedEnviroment: ticket["Impacted_Environments"].value!, SecondaryClosureCode: ticket["Secondary_Closure_Code"].value!, PartofRelease: ticket["Part_of_a_release"].value!, BusinessApplication: ticket["business_Application"]["businessAppName"].value!, BusinessApplicationCriticalityTier: ticket["business_Application"]["Business_ApplicationSys"].value!)
                ticketList.append(newTicket)
            }
        }
        return ticketList
    }
    
    func parseBusiness(xml: AEXMLDocument) -> ([BusinessApp]) {
        var businessApp = [BusinessApp]()
        if let apps = xml.root["SOAP-ENV:Body"]["insertResponse"]["status_message"]["ReturnMessage"]["applicationData"]["application"].all {
            for app in apps {
                let newApp = BusinessApp(appId: app["appID"].value!, businessAppSys: app["businessAppSys"].value!, businessApp: app["businessApp"].value!, appCriticality: app["appCriticality"].value!,
                    owner: app["owner"].value!, ownerSys: app["ownerSys"].value!, businessArea: app["appBusinessArea"].value!, businessAreaSys: app["appBusinessAreaSys"].value!, businessUnit: app["appBusinessUnit"].value!,
                    businessUnitSys: app["appBusinessUnitSys"].value!, businessSubUnitSys: app["appBusinessSubUnitSys"].value!, businessSubUnit: app["appBusinessSubUnit"].value!, ticketCount: 0)
                businessApp.append(newApp)
                print(newApp.appId)
            }
            
        }
        return businessApp
    }
    
    func getChange(number: String?="", approver: String?="", plannedStart: String?="", plannedEnd: String?="", actualStart: String?="", actualEnd: String?="", plannedStart2: String?="", plannedEnd2: String?="", actualStart2: String?="", actualEnd2: String?="", reqByGroup: String?="", reqByGrp_BusArea: String?="", reqByGrpBusUnit: String?="", reqByGrpSubBusUnit: String?="", risk: String?="", psD: String?="", peD: String?="", asD: String?="", aeD: String?="", application: String?="") -> ([ChangeTicket]) {
        
        let soapRequest = AEXMLDocument()
        
        let attributes = ["xmlns:soapenv" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:u" : "http://www.service-now.com/u_platform_integration"]
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: attributes)
        
        envelope.addChild(name: "soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        let insert = body.addChild(name: "u:insert")
        insert.addChild(name: "u:template_import_log")
        insert.addChild(name: "u:u_action", value: "eProjectChange")
        let xmlMessage = insert.addChild(name: "u:u_message")
        
        let message = xmlMessage.addChild(name: "Message")
        
        message.addChild(name: "number", value: number)
        message.addChild(name: "approver", value: approver)
        message.addChild(name: "plannedStart", value: plannedStart)
        message.addChild(name: "plannedEnd", value: plannedEnd)
        message.addChild(name: "actualStart", value: actualStart)
        message.addChild(name: "actualEnd", value: actualEnd)
        message.addChild(name: "plannedStart2", value: plannedStart2)
        message.addChild(name: "plannedEnd2", value: plannedEnd2)
        message.addChild(name: "actualStart2", value: actualStart2)
        message.addChild(name: "actualEnd2", value: actualEnd2)
        message.addChild(name: "reqByGrp", value: reqByGroup)
        message.addChild(name: "reqByGrp_BusArea", value: reqByGrp_BusArea)
        message.addChild(name: "reqByGrpBusUnit", value: reqByGrpBusUnit)
        message.addChild(name: "reqByGrpSubBusUnit", value: reqByGrpSubBusUnit)
        message.addChild(name: "risk", value: risk)
        message.addChild(name: "psD", value: psD)
        message.addChild(name: "peD", value: peD)
        message.addChild(name: "asD", value: asD)
        message.addChild(name: "aeD", value: aeD)
        message.addChild(name: "application", value: application)
        
        insert.addChild(name: "u:u_process", value: "ASU.B.eChangeProject")
        insert.addChild(name: "u:u_product", value: "CHG")
        
        var ticketList = [ChangeTicket]()
        sendData(soapRequest.xmlString) {xml in
            if let xml = xml {
                ticketList = self.parseChange(xml)
                print (xml.root.xmlString)
            }
            
        }
        return ticketList
        
    }
    
    func getBusiness(appName: String?="", appUnit: String?="", appArea: String?="", appSubUnit: String?="", requestUnits: String?="", requestAreas: String?="", requestApprovers: String?="") {
        let soapRequest = AEXMLDocument()
        
        let attributes = ["xmlns:soapenv" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:u" : "http://www.service-now.com/u_platform_integration"]
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: attributes)
        
        envelope.addChild(name: "soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        let insert = body.addChild(name: "u:insert")
        insert.addChild(name: "u:template_import_log")
        insert.addChild(name: "u:u_action", value: "eProjectAppData")
        let xmlMessage = insert.addChild(name: "u:u_message")
        let message = xmlMessage.addChild(name: "Message")
        
        message.addChild(name: "appName", value: appName)
        message.addChild(name: "appUnit", value: appUnit)
        message.addChild(name: "appArea", value: appArea)
        message.addChild(name: "appSubUnit", value: appSubUnit)
        message.addChild(name: "requestUnits", value: requestUnits)
        message.addChild(name: "requestAreas", value: requestAreas)
        message.addChild(name: "requestApprovers", value: requestApprovers)
        
        insert.addChild(name: "u:u_process", value: "ASU.B.eChangeProject")
        insert.addChild(name: "u:u_product", value: "CHG")
        
        sendData(soapRequest.xmlString) {xml in
            if let xml = xml {
                self.businessApps = self.parseBusiness(xml)
                //print (xml.root.xmlString)
                for app in self.businessApps {
                    print(app.businessApp)
                }
            }
        }
    }
    
    func sendData(soapMessage: String, completionHandler: (AEXMLDocument?) -> Void) -> NSURLSessionTask {
        
        // Create login data
        let semaphore = dispatch_semaphore_create(0)
        
        let loginString = "\(userName):\(passWord)"
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        // create URL
        let url = NSURL(string: "https://allstatetrain.service-now.com/u_platform_integration.do?SOAP")
        let request = NSMutableURLRequest(URL: url!)
        // create message and message length
        let message = soapMessage
        let msgLength = String(message.characters.count)
        // create the NSURLConfiguration Proxy Dictionary
        let proxyDic = [
            String(kCFNetworkProxiesHTTPEnable): proxyEnable,
            String(kCFNetworkProxiesHTTPProxy): proxyHost,
            String(kCFNetworkProxiesHTTPPort): proxyPort,
        ];
        
        // configure the NSURLSession with authentication and proxy settings
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.connectionProxyDictionary = proxyDic as [NSObject : AnyObject]
        config.HTTPAdditionalHeaders = ["Authorization" : "Basic \(base64LoginString)"]
        config.timeoutIntervalForRequest = 3
        
        // create session
        let session : NSURLSession = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        // fill request
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        // send request and capture output in completion handler
        let task = session.dataTaskWithRequest(request) {data, response, error   -> Void in
            // if the data is not nil then convert data into a string
            if (data != nil) {
                var nData = String(data: data!, encoding: NSUTF8StringEncoding)
                //print("\(nData)")
                do {
                    // replace all occurences of '&lt;' and '&gt;' with < and > respectively
                    nData = nData!.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
                    nData = nData!.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
                    // convert string back into NSData object
                    
                    let returnData = nData!.dataUsingEncoding(NSUTF8StringEncoding)
                    // create AEXMLDocument with returnData
                    let xml = try AEXMLDocument(xmlData: returnData!)
                    completionHandler(xml)
                    dispatch_semaphore_signal(semaphore)
                }
                catch {
                    print("\(error)")
                }
                
            }
            
        }
        task.resume()
        //print(xmlDoc.root.xmlString)
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return task
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = NSURLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
            
        }
    }
    
}