//
//                         __   _,--="=--,_   __
//                        /  \."    .-.    "./  \
//                       /  ,/  _   : :   _  \/` \
//                       \  `| /o\  :_:  /o\ |\__/
//                        `-'| :="~` _ `~"=: |
//                           \`     (_)     `/
//                    .-"-.   \      |      /   .-"-.
//.------------------{     }--|  /,.-'-.,\  |--{     }-----------------.
// )                 (_)_)_)  \_/`~-===-~`\_/  (_(_(_)                (
//
//		File Name:		HSCSExtension.swift
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	5.0
//		Created Date:	2019/5/7 9:51 AM
//
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import Foundation
import AppTrackingTransparency
import AdSupport
import UIKit
import YYText

class App: NSObject
{
    @objc static let SCREENWITH = UIScreen.main.bounds.width
    @objc static let SCREENHEIGHT = UIScreen.main.bounds.height
}

/* 当前设备屏幕的宽度 */
let SCREENWITH = UIScreen.main.bounds.width
/* 当前设备屏幕的高度 */
let SCREENHEIGHT = UIScreen.main.bounds.height

let kTabbarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49

let kNavigationBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 88 : 64

let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

let MyUIScreen: CGFloat = 375.0

extension UIFont
{
    class func PingFang_Medium(fontSize: CGFloat) -> UIFont
    {
        let size = fontSize * SCREENWITH / MyUIScreen;
        if #available(iOS 9.0, *) {
            //高于 iOS 8.0
            return UIFont(name: "PingFang-SC-Medium", size: size)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    class func PingFang_Regular(fontSize: CGFloat) -> UIFont
    {
        let size = fontSize * SCREENWITH / MyUIScreen;
        if #available(iOS 9.0, *) {
            //高于 iOS 8.0
            return UIFont(name: "PingFang-SC-Regular", size: size)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    class func PingFang_Bold(fontSize: CGFloat) -> UIFont
    {
        let size = fontSize * SCREENWITH / MyUIScreen;
        if #available(iOS 9.0, *) {
            //高于 iOS 8.0
            return UIFont(name: "PingFangSC-Semibold", size: size)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    class func PingFang_Light(fontSize: CGFloat) -> UIFont
    {
        let size = fontSize * SCREENWITH / MyUIScreen;
        if #available(iOS 9.0, *) {
            //高于 iOS 8.0
            return UIFont(name: "PingFangSC-Light", size: size)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }

    class func Impact_Regular(fontSize: CGFloat) -> UIFont
    {
        let size = fontSize * SCREENWITH / MyUIScreen;
        if #available(iOS 9.0, *) {
            //高于 iOS 8.0
            return UIFont(name: "Impact", size: size)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension UIColor
{
    // 字体
//    struct Text {
//        static let LightOrange = UIColor.init(hex: "#EEE4C1")
//    }

    static let lightOrange = UIColor.init(hex: "#EEE4C1")

    static let spaceLine = UIColor.init(hex: "#F1F1F1")

    convenience init(hex: String)
    {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: 1)
        }
    }
    convenience init(hex: String, alpha: CGFloat)
    {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
        }
    }
}

extension DateFormatter
{
    // 日期字符串转化为Date类型
    @objc static func stringConvertDate(dateString: String, format: String) -> Date
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    // Date类型转化为日期字符串
    @objc static func dateConverString(date: Date, format: String) -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}

extension Calendar
{
    //获取当前时间 - 年月日时分秒星期
    static func getTimes() -> [Int]
    {
        var timers: [Int] = [] //  返回的数组
        var calendar: Calendar = Calendar(identifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar.timeZone = timeZone! as TimeZone
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: Date())
        timers.append(comps.year! % 2000) // 年 ，后2位数
        timers.append(comps.month!) // 月
        timers.append(comps.day!) // 日
        timers.append(comps.hour!) // 小时
        timers.append(comps.minute!) // 分钟
        timers.append(comps.second!) // 秒
        timers.append(comps.weekday! - 1) //星期
        return timers;
    }

    func getDayText(date: Date) -> String
    {
        var comps: DateComponents = DateComponents()
        comps = self.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: date)
        return String(format: "%02ld", comps.day!)
    }
}

extension Date
{
    func weekDay() -> String
    {
        let weekDays = [NSNull.init(), "周日", "周一", "周二", "周三", "周四", "周五", "周六"] as [Any]
        let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = timeZone! as TimeZone
        let calendarUnit = NSCalendar.Unit.weekday
        let theComponents = calendar?.components(calendarUnit, from: self)
        return weekDays[(theComponents?.weekday)!]as! String
    }

    func getMonthText() -> String
    {
        let month = [NSNull.init(), "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"] as [Any]
        let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = timeZone! as TimeZone
        let calendarUnit = NSCalendar.Unit.month
        let theComponents = calendar?.components(calendarUnit, from: self)
        return month[(theComponents?.month)!]as! String
    }

    func getDayText() -> String
    {
        var calendar: Calendar = Calendar(identifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar.timeZone = timeZone! as TimeZone
        return calendar.getDayText(date: self)
    }

    static func currentTimes(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
}

extension UILabel
{
    //获取Label宽度
    class func getWidth(title: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 0))
        label.text = title
        label.font = font
        label.sizeToFit()
        return label.frame.size.width
    }
    //获取Label高度
    @objc class func getHeight(title: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: 0))
        label.text = title
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.size.height
    }

    @objc class func getHeight(title: String, font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: 0))
        label.text = title
        label.font = font
        label.numberOfLines = 0
        UILabel.changeLineSpace(for: label, withSpace: Float(lineSpace))
        label.sizeToFit()
        return label.frame.size.height
    }

    @objc class func getHeight(title: String, font: UIFont, width: CGFloat, lineSpace: CGFloat, numberOfLines: Int) -> CGFloat {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: 0))
        label.text = title
        label.font = font
        label.numberOfLines = numberOfLines
        UILabel.changeLineSpace(for: label, withSpace: Float(lineSpace))
        label.sizeToFit()
        return label.frame.size.height
    }
}

extension String
{
    static func secondTimeForDate(_ time: String) -> Int {
        var long = 0
        // 时间  几分几秒 0:00  计算秒
        if time.count == 4 {
            // 获取分
            let minute = time.substring(to: time.index(time.startIndex, offsetBy: 1))
            // 获取秒
            let second = time.substring(from: time.index(time.startIndex, offsetBy: 2))
            long = Int(minute)! * 60 + Int(second)!
            return long
        }
        // 时间  几十分几秒 00:00 计算秒
        if time.count == 5 {
            // 获取分
            let minute = time.substring(to: time.index(time.startIndex, offsetBy: 2))
            // 获取秒
            let second = time.substring(from: time.index(time.startIndex, offsetBy: 3))
            long = Int(minute)! * 60 + Int(second)!
            return long
        }
        return long
    }

    func stringValueDictionary(_ str: String) -> [String: Any]?
    {
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)as? [String: Any] {
            return dict
        }
        return nil
    }

    static func convertDictionaryToJSONString(dict: Dictionary<String, Any>?) -> String {
        if let dic = dict {
            let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            let jsonString = String(data: data!, encoding: .utf8)
            return jsonString! as String
        }
        return ""
    }

    //手机号验证
    static func isPhoneNumber(num: String) -> Bool
    {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$"
        let CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        let CU = "^(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
        let CT = "^(^1(33|53|77|73|8[019]|9[0-9])\\d{8}$)|(^1700\\d{7}$)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        if ((regextestmobile.evaluate(with: num) == true)
                || (regextestcm.evaluate(with: num) == true)
                || (regextestct.evaluate(with: num) == true)
                || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
}

extension String
{
    /*
     *去掉首尾空格
     */
    var trimming: String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    //MARK: - 每隔range位添加一个separator
    func separate(range: Int!, separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % range == 0 ? [separator, $1] : [$1] }.joined())
    }
    //MARK: - 替换指定范围字符串 从0开始
    func replace(start: Int, end: Int, replacement: String) -> String {

        guard start <= end && start < self.count && end < self.count else {
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        var replaceString = ""
        for _ in 0..<end - start + 1
        {
            replaceString.append(replacement)
        }
        let str = self.replacingCharacters(in: startIndex...endIndex, with: replaceString)
        return str
    }
}

extension String
{
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
//        result.deinitialize(count: 0)
        return String(format: hash as String)
    }

    func sha1() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
//        result.deinitialize(count: 0)
        return String(format: hash as String)
    }


    //Base64编码
    func encodBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    //Base64解码
    func decodeBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

public extension String
{
    static func getUUIDByKeyChain2() -> String
    {
        let bundle: String = Bundle.main.bundleIdentifier ?? ""
        var strUUID: String = ""
        if let UUID: String = HSCSKeychainStore.keyChainReadData(identifier: bundle) as? String {
            strUUID = UUID
        } else {
            if strUUID.count == 0 {
                strUUID = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                if(strUUID.count == 0 || strUUID == "00000000-0000-0000-0000-000000000000")
                {
                    let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
                    strUUID = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)! as String
                }
            }
        }
        HSCSKeychainStore.keyChainSaveData(data: AppUtils.nullEmpty(strUUID), withIdentifier: bundle)
        return strUUID
    }
}


//extension Date {
//    //获取当前日期年
//    static func getCurrentYear()->String{
//        let date = Date()
//        format.dateFormat = "yyyy"
//        return format.string(from: date)
//    }
//    //获取当前日期月
//    static func getCurrentMonth()->String{
//        let date = Date()
//        format.dateFormat = "MM"
//        return format.string(from: date)
//    }
//    //获取当前日期天
//    static func getCurrentDay()->String{
//        let date = Date()
//        format.dateFormat = "dd"
//        return format.string(from: date)
//    }
//    //计算指定日期月份的天数
//    static func numberOfDayInMonthWithDateStr(dateStr: String)->String{
//        let date: Date? = Date.dateWithdateSr(dateStr: dateStr)
//        let calendar = Calendar(identifier: .gregorian)
//        // 通过该方法计算特定日期月份的天数
//        var monthRange: Range<Int>?
//        if let date = date {
//            monthRange = calendar.range(of: .day, in: .month, for: date)
//        }
//        return String.init(format: "%ld", monthRange?.count ?? "")
//    }
//    static func dateWithdateSr(dateStr: String) ->Date? {
//        format.dateFormat = "yyyy-MM"
//        return format.date(from: dateStr)
//    }
//}

extension UIViewController
{
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

// 下标截取任意位置的便捷方法
extension String {

    /*
         *去掉首尾空格
         */
    var removeHeadAndTailSpace: String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }

    var length: Int {
        return self.count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    /// 获取字符出现的位置信息(支持多次位置获取)
    /// - Parameter string: 原始文本
    /// - Parameter inString: 需要查找的字符
    static func rangeOfString(string: NSString,
        andInString inString: String) -> [NSRange] {

        var arrRange = [NSRange]()
        var _fullText = string
        var rang: NSRange = _fullText.range(of: inString)

        while rang.location != NSNotFound {
            var location: Int = 0
            if arrRange.count > 0 {
                if arrRange.last!.location + arrRange.last!.length < string.length {
                    location = arrRange.last!.location + arrRange.last!.length
                }
            }

            _fullText = NSString.init(string: _fullText.substring(from: rang.location + rang.length))

            if arrRange.count > 0 {
                rang.location += location
            }
            arrRange.append(rang)

            rang = _fullText.range(of: inString)
        }

        return arrRange
    }

    static func nullEmpty(text: String?) -> String
    {
        if let str = text {
            return str
        }
        return ""
    }
}

func HeightScale(height: CGFloat) -> CGFloat
{
    return height * SCREENWITH / 375.0
}

//MARK: - UIDevice延展
public extension UIDevice
{
    class func isiPhoneXAll() -> Bool
    {
        if (UIDevice.current.userInterfaceIdiom != .phone) {
            return false;
        }
        if #available(iOS 11.0, *) {
            let mainWindow = (UIApplication.shared.delegate?.window)!! as UIWindow
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                return true
            }
            return false
        }
        return false
    }

    class func isiPhone5() -> Bool
    {
        let screenWidth = UIScreen.main.bounds.size.width;
        let screenHeight = UIScreen.main.bounds.size.height;
        if screenWidth == 320.0 && screenHeight != 480.0 {
            return true
        }
        return false
    }

    var iPhoneXMax: Bool {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPhone11,6", "iPhone11,4": return true
        case "iPhone12,5": return true
        case "iPhone13,4": return true
        default: return false
        }
    }

    var modeNameIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

    var modeName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod1,1": return "iPod Touch 1"
        case "iPod2,1": return "iPod Touch 2"
        case "iPod3,1": return "iPod Touch 3"
        case "iPod4,1": return "iPod Touch 4"
        case "iPod5,1": return "iPod Touch (5 Gen)"
        case "iPod7,1": return "iPod Touch 6"

        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1": return "iPhone 5"
        case "iPhone5,2": return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3": return "iPhone 5c (GSM)"
        case "iPhone5,4": return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1": return "iPhone 5s (GSM)"
        case "iPhone6,2": return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "国行、日版、港行iPhone 7"
        case "iPhone9,2": return "港行、国行iPhone 7 Plus"
        case "iPhone9,3": return "美版、台版iPhone 7"
        case "iPhone9,4": return "美版、台版iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"

        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,6", "iPhone11,4": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"

        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"

        case "iPhone14,1": return "iPhone 13 mini"
        case "iPhone14,2": return "iPhone 13"
        case "iPhone14,3": return "iPhone 13 Pro"
        case "iPhone14,4": return "iPhone 13 Pro Max"

        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"
        case "AppleTV2,1": return "Apple TV 2"
        case "AppleTV3,1", "AppleTV3,2": return "Apple TV 3"
        case "AppleTV5,3": return "Apple TV 4"
        case "i386", "x86_64": return "Simulator"
        default: return identifier
        }
    }
}

enum HSCSGradientType
{
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}

extension CAGradientLayer
{
    class func gradientLayerWithType(type: HSCSGradientType, frame: CGRect, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        var startPoint: CGPoint = CGPoint(x: 0, y: 0)
        var endPoint: CGPoint = CGPoint(x: 0, y: 0)
        switch type {
        case .LeftToRight:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
            break
        case .RightToLeft:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = CGPoint(x: 0, y: 0)
            break
        case .TopToBottom:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
            break
        case .BottomToTop:
            startPoint = CGPoint(x: 0, y: 1)
            endPoint = CGPoint(x: 0, y: 0)
            break
        default:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
            break
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        return gradientLayer
    }

    class func gradientLayerWithType(type: HSCSGradientType, frame: CGRect, colors: [UIColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map { $0.cgColor }
        var startPoint: CGPoint = CGPoint(x: 0, y: 0)
        var endPoint: CGPoint = CGPoint(x: 0, y: 0)
        switch type {
        case .LeftToRight:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
            break
        case .RightToLeft:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = CGPoint(x: 0, y: 0)
            break
        case .TopToBottom:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
            break
        case .BottomToTop:
            startPoint = CGPoint(x: 0, y: 1)
            endPoint = CGPoint(x: 0, y: 0)
            break
        default:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
            break
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        return gradientLayer
    }
}

extension UIView
{
    @objc class func bezierPathWithRounded(stateView: UIView, corners: UIRectCorner, cornerRadii: CGSize)
    {
        let maskPath = UIBezierPath(roundedRect: stateView.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = stateView.bounds
        maskLayer.path = maskPath.cgPath
        stateView.layer.mask = maskLayer
    }
}

extension NSMutableAttributedString
{
    ///方法1-->通过'<head>'将html字符串转化为 NSMutableAttributedString
    @objc class func getAttriFromHtml(str: String) -> NSMutableAttributedString {

        let fontSize = Int(16 * Int(SCREENWITH) / 375);
        let replaceStr = str.replacingOccurrences(of: "1em", with: "\(fontSize)px")
        let htmlStr = "<span style=\"color:#2C2E3A;font-size:\(Int(14 * SCREENWITH / 375))px\">" + replaceStr.removeHeadAndTailSpace + "</span>"
        let attStr = try? NSMutableAttributedString.init(data: htmlStr.data(using: String.Encoding.utf16)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attStr ?? NSMutableAttributedString()
    }

    ///方法2-->通过'<html>'htmlStr 转化为 NSMutableAttributedString
    @objc class func getAttriFromHtml2(str: String) -> NSMutableAttributedString {
        let headerS = "<html lang=\"zh-cn\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, nickName-scalable=no\"></meta><style>img{max-width: 100%; width:auto; height:auto;}body{text-align:justify;font-size:14px !important;}</style></head><body>"
        let endS = "</body></html>"
        let htmlStr = headerS + str + endS
        let attStr = try? NSMutableAttributedString.init(data: htmlStr.data(using: String.Encoding.utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attStr ?? NSMutableAttributedString()
    }

    @objc class func getAttriHeight(attri: NSMutableAttributedString, width: CGFloat) -> CGSize
    {
        let size = attri.boundingRect(with: CGSize(width: width, height: 9999), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil).size as CGSize
        return size
    }

    class func createImageAttributedString(image: UIImage, content: String, font: UIFont, color: UIColor) -> NSMutableAttributedString
    {
        let icon = UIButton(frame: CGRect(x: 0, y: 0, width: image.size.width + 3, height: image.size.height))
        icon.setImage(image, for: .normal)
        let attri = NSMutableAttributedString(string: content)
        attri.yy_font = font
        attri.yy_color = color
        attri.yy_lineSpacing = 1
        let attri2 = NSMutableAttributedString.yy_attachmentString(withContent: icon, contentMode: .scaleAspectFit, attachmentSize: icon.size, alignTo: font, alignment: .center)
        attri.insert(attri2, at: 0)
        return attri
    }

    class func createImageAttributedString(image: UIImage, size: CGSize, content: String, font: UIFont, color: UIColor) -> NSMutableAttributedString
    {
        let icon = UIButton(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        icon.setBackgroundImage(image, for: .normal)
        let attri = NSMutableAttributedString(string: content)
        attri.yy_font = font
        attri.yy_color = color
        attri.yy_lineSpacing = 2
        let attri2 = NSMutableAttributedString.yy_attachmentString(withContent: icon, contentMode: .scaleAspectFit, attachmentSize: icon.size, alignTo: font, alignment: .center)
        attri.insert(attri2, at: 0)
        return attri
    }

    class func createViewAttributedString(view: UIView, size: CGSize, content: String, font: UIFont, color: UIColor) -> NSMutableAttributedString
    {
        let attri = NSMutableAttributedString(string: content)
        attri.yy_font = font
        attri.yy_color = color
        attri.yy_lineSpacing = 2
        let attri2 = NSMutableAttributedString.yy_attachmentString(withContent: view, contentMode: .scaleAspectFit, attachmentSize: view.size, alignTo: font, alignment: .center)
        attri.insert(attri2, at: 0)
        return attri
    }
}


extension UILabel
{
    /// UILabel根据文字的需要的高度
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: 999)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height + 2
    }

    /// UILabel根据文字的需要的宽度
    public var requiredWidth: CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width + 2
    }

    /// UILabel根据文字实际的行数
    public var lines: Int {
        return Int(requiredHeight / font.lineHeight)
    }

    public class func requiredWidth(font: UIFont, text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: 9999,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width + 2
    }
}

extension String
{
    /// 字符串的匹配范围 方法二(推荐)
    ///
    /// - Parameters:
    ///     - matchStr: 要匹配的字符串
    /// - Returns: 返回所有字符串范围
    @discardableResult
    func exMatchStrRange(_ matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") //辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location, length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }
}

extension UIImage
{
    class func placeholderImage(bgColor: UIColor, image: UIImage, size: CGSize, iconSize: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        bgColor.setFill()
        path.fill()
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.setFillColor(bgColor.cgColor);
        ctx!.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image.draw(in: CGRect(x: size.width / 2 - iconSize.width / 2, y: size.height / 2 - iconSize.height / 2, width: iconSize.width, height: iconSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension Collection {
    /// 判断集合非空
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}


extension Date {
    // 转成当前时区的日期
    static func dateFromGMT(_ date: Date) -> Date {
        let secondFromGMT: TimeInterval = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(secondFromGMT)
    }
}


func HSCSLog(_ any: Any, obj: Any, line: Int)
{
    let date = Date()
    let timeFormatter = DateFormatter()
    //日期显示格式，可按自己需求显示
    timeFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss.SSS"
    let strNowTime = timeFormatter.string(from: date) as String
    print("\(strNowTime):  \(any)  \(type(of: obj))  \(line)")
}

extension Array {
    subscript (safe index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
}

extension URL {
    var urlParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
