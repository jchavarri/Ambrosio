//
//  APITaskModelWrapper.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class APITaskDescriptionWrapper {
    
    private func getStringForAlarmStatus(alarm:AlarmStatus) -> String {
        var alarmString = "Disabled"
        switch alarm {
        case .WhenArriving:
            alarmString = "WhenArriving"
        case .WhenLeaving:
            alarmString = "WhenLeaving"
        default:
            break
        }
        return alarmString
    }
    
    private func getAlarmStatusForString(alarmString:String) -> AlarmStatus {
        var returnAlarm = AlarmStatus.Disabled
        switch alarmString {
        case "WhenArriving":
            returnAlarm = AlarmStatus.WhenArriving
        case "WhenLeaving":
            returnAlarm = AlarmStatus.WhenLeaving
        default:
            break
        }
        return returnAlarm
    }
    
    // Helper - extracts Ambrosio info from description
    // Ambrosio info is embedded in this way:
    // "My description of a task[ambrosio]0[/ambrosio]"
    private func unwrapDescription(description: String) -> (description: String?, alarm: AlarmStatus) {
        
        do {
            let tag = "ambrosio"
            let numCharsBrackets = 5 // [,],[,/,]
            let regex = try NSRegularExpression(pattern: "\\["+tag+"\\](.+?)\\[/"+tag+"\\]", options: [])
            let nsString = description as NSString
            
            var returnDescription = ""
            var alarmString = ""
            var lastProcessedIndex = 0
            
            let results = regex.matchesInString(description,
                options: [], range: NSMakeRange(0, nsString.length))
            
            for match in results {
                returnDescription += nsString.substringWithRange(NSMakeRange(lastProcessedIndex, match.range.location - lastProcessedIndex))
                //We just return the latest occurrence
                alarmString = nsString.substringWithRange(NSMakeRange(match.range.location + tag.characters.count + 2, match.range.length - tag.characters.count * 2 - numCharsBrackets))
                lastProcessedIndex = match.range.location
            }
            
            // If there's text after the last tag, add it to the description so it's not lost
            lastProcessedIndex = lastProcessedIndex + alarmString.characters.count + tag.characters.count * 2 + numCharsBrackets
            let remainingChars = description.characters.count - lastProcessedIndex
            if (remainingChars > 0) {
                returnDescription += nsString.substringWithRange(NSMakeRange(lastProcessedIndex, remainingChars))
            }
            
            let returnAlarm = getAlarmStatusForString(alarmString)
            
            return (.Some(returnDescription), returnAlarm)
            
        } catch {
            return (.None, .Disabled)
        }
    }
    
    
    func unwrapTaskDescription(task: TaskModel) -> TaskModel {
        var newTask = task
        if let description = task.description {
            (newTask.description, newTask.alarm) = unwrapDescription(description)
        }
        return newTask
    }
    
    func wrapTaskDescription(task:TaskModel) -> TaskModel {
        let alarmAppendix = "[ambrosio]" + getStringForAlarmStatus(task.alarm) + "[/ambrosio]"
        var newTask = task
        if let description = task.description {
            newTask.description = .Some(description + alarmAppendix)
        }
        else {
            newTask.description = alarmAppendix
        }
        return newTask
    }
}