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
//        File Name:       HSCSLiveSocketIOManager.swift
//        Product Name:    TEAYANGPROJECT
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/8/7 1:28 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import SocketIO

let EMIT_CONNECT: String = "connect"
let EMIT_CONNECTING: String = "connecting"
let EMIT_DISCONNECT: String = "disconnect"

private let single = HSCSLiveSocketIOManager()

typealias HSCSIOResponse = (_ response: Any) -> Void

class HSCSLiveSocketIOManager: NSObject {

    private var socketManager: SocketManager?
    private var socketIOClient: SocketIOClient?
    private var wsRoom: String = ""

    @objc open class var shared: HSCSLiveSocketIOManager {
        return single
    }

    @objc open func socketIOWithURL(url: String, wsRoom: String, callback: @escaping HSCSIOResponse)
    {
        self.wsRoom = wsRoom;
        socketManager = SocketManager(socketURL: URL(string: url)!, config: [.forceWebsockets(true), .reconnects(true), .log(true)])
        socketIOClient = socketManager?.defaultSocket
        let _ = socketManager?.socket(forNamespace: "/socket.io/")
        onEvents(response: callback)
        onConnect(response: callback, wsRoom: wsRoom)
        onConnecting(response: callback)
        onDisConnect(response: callback)
        socketIOClient?.connect()
    }
    @objc open func socketIOClose()
    {
        if socketIOClient != nil {
            socketIOClient?.emit("leaveRoom", wsRoom)
            socketIOClient?.off("commonMessage")
            socketIOClient?.off("ensureMessage")
            socketIOClient?.off(EMIT_CONNECT)
            socketIOClient?.off(EMIT_CONNECTING)
            socketIOClient?.off(EMIT_DISCONNECT)
            socketManager = nil;
            socketIOClient = nil
        }
    }
}

extension HSCSLiveSocketIOManager
{
    private func onConnect(response: @escaping HSCSIOResponse, wsRoom: String)
    {
        socketIOClient?.on(EMIT_CONNECT, callback: { [weak self] (data, ask) in
            print("socket connected  = \(wsRoom)")
            guard let weakself = self else { return }
            weakself.socketIOClient?.emit("joinRoom", wsRoom)
        })
    }
    private func onConnecting(response: @escaping HSCSIOResponse)
    {
        socketIOClient?.on(EMIT_CONNECTING, callback: { (data, ask) in
            print("socket connecting")
        })
    }
    private func onDisConnect(response: @escaping HSCSIOResponse)
    {
        socketIOClient?.on(EMIT_DISCONNECT, callback: { (data, ask) in
            print("socket disconnect")
        })
    }
    private func onEvents(response: @escaping HSCSIOResponse)
    {
        socketIOClient?.on("commonMessage", callback: { [weak self] (data, ask) in
            print("data : \(data)")
            guard let weakself = self else { return }
            if data.count > 0 {
                let dict: Dictionary<String, Any>? = weakself.jsonToDictionary(json: data[0] as! String)
                let ws: String = dict?["room"] as! String
                if weakself.wsRoom == ws {
                    response(dict?["postData"] as Any)
                }
            }
        })
        socketIOClient?.on("ensureMessage", callback: { [weak self] (data, ask) in
            print("data : \(data)")
            guard let weakself = self else { return }
            if data.count > 0 {
                let dict: Dictionary<String, Any>? = weakself.jsonToDictionary(json: data[0] as! String)
                let msgId = dict!["msgId"] as! String
                weakself.socketIOClient?.emit("confirmMessage", msgId)
                response(dict?["postData"] as Any)
            }
        })
    }

    private func jsonToDictionary(json: String) -> Dictionary<String, Any>
    {
        let jsonData: Data = json.data(using: String.Encoding.utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String, Any>
        print("postData : \(String(describing: dict?["postData"]))")
        return dict!
    }
}
