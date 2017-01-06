//
//  JYViewController.swift
//  JYRouterDemoForSwift
//
//  Created by 杨权 on 2017/1/3.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

import UIKit

let fullScreenSize = UIScreen.main.bounds.size
let cellIdentifier:String = "cell"


class JYViewController: UIViewController {
    
    // MARK: -
    var parameterString:String = ""
    var parameterNumber:NSNumber = 0
    var parameterDictionary:[AnyHashable: Any] = [:]

    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        showParameter()
        view.addSubview(tableView)
    }
    
    // MARK: - setup methods
    func setNavigation() {
        navigationItem.title = "JYRouter"
        let red   = CGFloat(arc4random() % 255)
        let green = CGFloat(arc4random() % 255)
        let bule  = CGFloat(arc4random() % 255)
        navigationController?.navigationBar.barTintColor = UIColor(red: red/255.0, green: green/255.0, blue: bule/255.0, alpha: 1)
    }
    
    func showParameter() {
        print("-----------------------------------------------")
        print("⭕️parameterString     = \(parameterString)")
        print("⭕️parameterNumber     = \(parameterNumber)")
        print("⭕️parameterDictionary = \(parameterDictionary)")
        print("-----------------------------------------------\n\n");
    }
    
    // MARK: - event & response
    func routerAtIndexPath(indexPath: IndexPath) {
        
        let group = dataList[indexPath.section]["group"] as! String?
        let params = [
            "parameterString" : "我是一个字符串-\(group)",
            "parameterNumber" : 123456789,
            "parameterDictionary" : [
                "key1": "Value1-\(group)",
                "key2": "Value2-\(group)"
            ]
        ] as [String : Any]
        
        
        switch indexPath.section {
        case 0: break
            
        default: break
            
        }
        
        switch indexPath.section {
        // ---------------------- Push ----------------------
        case 0:
            switch indexPath.row {
            /**
             Push跳转
             */
            case 0:
                JYRouter().push("JYViewController")
                break
            /**
             Push跳转,附带参数
             */
            case 1:
                JYRouter().push("JYViewController", animated: true, params: params)
                break
            /**
             Push跳转,附带参数,完成回调
             */
            case 2:
                JYRouter().push("JYViewController", animated: true, params: params, completion: {
                    print("🔥🔥🔥Push完成回调🔥🔥🔥")
                })
                break
            default: break
            }
            break
            
            
        // ---------------------- Pop ----------------------
        case 1:
            switch indexPath.row {
            /**
             Pop到上级
             */
            case 0:
//                [[JYRouter router] pop];
                break
            /**
             Pop到根控制器
             */
            case 1:
//                [[JYRouter router] popToRoot];
                break
            /**
             Pop到根控制器,完成回调
             */
            case 2:
//                [[JYRouter router] popToRootAnimated:YES completion:^{
//                    NSLog(@"💧💧💧Pop完成回调💧💧💧");
//                    }];
                break
            /**
             Pop到指定控制器
             */
            case 3:
//                [[JYRouter router] popTo:@"JYViewController"];
                break
            /**
             Pop到指定控制器,完成回调
             */
            case 4:
//                [[JYRouter router] popTo:@"JYViewController" animated:YES completion:^{
//                    NSLog(@"💧💧💧Pop完成回调💧💧💧");
//                }];
                break
            default: break
            }
            break
            
        // ---------------------- Present ----------------------
        case 2:
            switch indexPath.row {
            /**
             present跳转
             */
            case 0:
//                [[JYRouter router] present:@"JYViewController"];
                break
            /**
             Present跳转,附带参数
             */
            case 1:
//                [[JYRouter router] present:@"JYViewController" animated:YES params:params];
                break
            /**
             Present跳转,附带参数,完成回调
             */
            case 2:
//                [[JYRouter router] present:@"JYViewController" animated:YES params:params completion:^{
//                    NSLog(@"🌧🌧🌧Pop完成回调🌧🌧🌧");
//                }];
                break
            default: break
            }
            break
            
        // ---------------------- Dismiss ----------------------
        case 3:
            switch indexPath.row {
            /**
             Dismiss
             */
            case 0:
//                [[JYRouter router] dismiss];
                break
            /**
             Dismiss,完成回调
             */
            case 1:
//                [[JYRouter router] dismiss:YES completion:^{
//                    NSLog(@"⚡️⚡️⚡️Dismiss完成回调⚡️⚡️⚡️");
//                    }];
                break
            default: break
            }
            break;
        default: break;
        }
        
        
    }
    
    // MARK: - getter & setter
    lazy var dataList: [[String: AnyObject]] = {
        let path = Bundle.main.path(forResource: "dataList", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        if let result = try? JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as? [[String: AnyObject]] {
            return result!
        }
        return []
    }()
    
    lazy var tableView: UITableView = {
        var tableView: UITableView
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height-64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

}


//MARK: - UITableViewDelegate AND UITableViewDataSource
extension JYViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((dataList[section]["list"])?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataList[section]["group"] as! String?
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = dataList[indexPath.section]["list"]![indexPath.row] as! String?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        routerAtIndexPath(indexPath: indexPath)
    }
}
