//
//  ConnectService.swift
//  Test
//
//  Created by Rose, Colton (ASU) on 3/19/16.
//  Copyright © 2016 Rose, Colton (ASU). All rights reserved.
//

import Foundation

class ConnectionService : NSObject, NSURLSessionDelegate {
    
    let userName = "sys_ws_asu_poly"
    let passWord = "ASU_Test#1"
    
    let proxyHost : CFString = NSString(string: "10.195.244.100") as CFString
    let proxyPort : CFNumber = NSNumber(int: 8080) as CFNumber
    let proxyEnable : CFNumber = NSNumber(int: 1) as CFNumber
    
    func parseChange(xml: AEXMLDocument) {
        
    }
    
    func parseBusiness(xml: AEXMLDocument) {
        
    }
    
    func getChange() {
        
        let soapRequest = AEXMLDocument()
        
        let attributes = ["xmlns:soapenv" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:u" : "http://www.service-now.com/u_platform_integration"]
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: attributes)
        
        envelope.addChild(name: "soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        let insert = body.addChild(name: "u:insert")
        insert.addChild(name: "u:template_import_log")
        insert.addChild(name: "u:u_action", value: "eProjectChange")
        let xmlMessage = insert.addChild(name: "u:u_message")
        insert.addChild(name: "u:u_process", value: "ASU.B.eChangeProject")
        insert.addChild(name: "u:u_product", value: "CHG")
        let xml = sendData(soapRequest.xmlString)
        print(xml.xmlString)
        
    }
    
    func getBusiness() {
        let soapRequest = AEXMLDocument()
        
        let attributes = ["xmlns:soapenv" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:u" : "http://www.service-now.com/u_platform_integration"]
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: attributes)
        
        envelope.addChild(name: "soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        let insert = body.addChild(name: "u:insert")
        insert.addChild(name: "u:template_import_log")
        insert.addChild(name: "u:u_action", value: "eProjectChange")
        let xmlMessage = insert.addChild(name: "u:u_message")
        insert.addChild(name: "u:u_process", value: "ASU.B.eChangeProject")
        insert.addChild(name: "u:u_product", value: "CHG")
        let xml = sendData(soapRequest.xmlString)
        print(xml.xmlString)
        
    }
    
    func sendData(soapMessage: String) -> AEXMLDocument {
        
        let loginString = "\(userName):\(passWord)"
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let url = NSURL(string: "https://allstatetrain.service-now.com/u_platform_integration.do?SOAP")
        let request = NSMutableURLRequest(URL: url!)
        
        var xmlDoc = AEXMLDocument()
        
        let message = soapMessage
        let msgLength = String(message.characters.count)
        
        let proxyDic = [
            String(kCFNetworkProxiesHTTPEnable): proxyEnable,
            String(kCFNetworkProxiesHTTPProxy): proxyHost,
            String(kCFNetworkProxiesHTTPPort): proxyPort,
        ];
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.connectionProxyDictionary = proxyDic as [NSObject : AnyObject]
        config.HTTPAdditionalHeaders = ["Authorization" : "Basic \(base64LoginString)"]
        config.timeoutIntervalForRequest = 3
        
        let session : NSURLSession = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //print("\(response)")
            if (data != nil) {
                var nData = String(data: data!, encoding: NSUTF8StringEncoding)
                //print("\(nData)")
                do {
                    nData = nData!.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
                    nData = nData!.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
                    let returnData = nData!.dataUsingEncoding(NSUTF8StringEncoding)
                    let xml = try AEXMLDocument(xmlData: returnData!)
                    xmlDoc = xml
                    //print(xml.root.xmlString)

                }
                catch {
                    print("\(error)")
                }

            }
            
            if (error != nil) {
                print("\(error)")
            }
            
        })
        task.resume()
        
        return xmlDoc
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = NSURLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
            
        }
    }
    
}