//
//  Upload.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/24/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UploadController: SKScene {
//    func submitAction(sender: AnyObject) {
//        
//        //declare parameter as a dictionary which contains string as key and value combination.
//        var parameters = ["name": UIDevice.currentDevice().name, "password": UIDevice.currentDevice().localizedModel] as Dictionary<String, String>
//        
//        //create the url with NSURL
//        let url = NSURL(string: "http://myServerName.com/api") //change the url
//        
//        //create the session object
//        var session = NSURLSession.sharedSession()
//        
//        //now create the NSMutableRequest object using the url object
//        let request = NSMutableURLRequest(URL: url!)
//        request.HTTPMethod = "POST" //set http method as POST
//        
//        var err: NSError?
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil) // pass dictionary to nsdata object and set it as request body
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        //create dataTask using the session object to send data to the server
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Body: \(strData)")
//            var err: NSError?
//            var json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    var success = parseJSON["success"] as? Int
//                    print("Succes: \(success)")
//                }
//                else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print("Error could not parse JSON: \(jsonStr)")
//                }
//            }
//        })
//        
//        task.resume()
//    }
    
//    class func postScore() {
    
//        // post to Rails Api, via post route
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://boiling-ridge-62596.herokuapp.com/scan_code")!)
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // set raw data to send to Rails Api
//        let postString = "player=\(UIDevice.currentDevice().name)&score=\(NSUserDefaults.standardUserDefaults().objectForKey("LastScore"))&uuid=\(UIDevice.currentDevice().identifierForVendor)"
//
//        // send postString
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
//            
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("postString =\(postString)")
//            print("responseString = \(responseString!)")
//        }
//    
//        task.resume()
//        
//        
//        let string = "http://boiling-ridge-62596.herokuapp.com/scan_code"
//        let url = NSURL(string: string)
//        let session = NSURLSession.sharedSession()
//        let request = NSMutableURLRequest(URL: url!)
//        let params = ["title": "Fifth Title"]
//        
//        request.setValue("XXXXXXXXXX", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.HTTPMethod = "POST"
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
//        }
//        catch {
//            
//        }
//        let tache = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
//            if let antwort = response as? NSHTTPURLResponse {
//                let code = antwort.statusCode
//                print(code)
//            }
//        }
//        tache.resume()
//    }
    
    class func post(params : Dictionary<String, String>, url : String) {
        let json = [
            [
            "name":"Keenan" ,
            "score": 144
                ]
            ]
        
        
        do {
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            let url = NSURL(string: "http://boiling-ridge-62596.herokuapp.com/scan_code")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
            
            
        } catch {
            print(error)
        }
    }
}

