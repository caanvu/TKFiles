//
//  TKFileViewController.swift
//  TKFiles
//
//  Created by wuwei on 2020/6/8.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class TKFileViewController: TKBaseViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    let cellId = "cellId"
    var model: TKFileModel? = tkSharedFileManager.rootModel
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        title = model?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.clickAdd(button:)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.register(TKFileTableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func addFolder() {
        let alertController = UIAlertController(title: "提示", message: "请输入名称", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { [weak self](_) in
            if let text = alertController.textFields?.first?.text, let model = self?.model {
                tkSharedFileManager.createFolder(text, model: model)
                self?.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        alertController.addTextField { (textField) in
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func image(model: TKFileModel?) -> UIImage? {
        guard let model = model else {
            return nil
        }
        var image = UIImage.listFile
        let size = tkFileTableViewCellImageSize
        if model.type == .folder {
            image = .folder
        } else if model.type == .video {
            image = TKThumbnailGenerator.videoThumbnail(url: model.url, with: size)
        } else if model.type == .image {
            image = TKThumbnailGenerator.imageThumbnail(url: model.url, with: size)
        } else if model.type == .pdf {
            image = TKThumbnailGenerator.pdfThumbnail(url: model.url, with: size)
        }
        return image
    }
    // MARK: - action
    @objc func clickAdd(button: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addAction = UIAlertAction(title: "新建文件夹", style: .default) { [weak self](_) in
            self?.addFolder()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - tableviewDelegate
extension TKFileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tabBarController?.hidesBottomBarWhenPushed = true
        if let current = model?.children[indexPath.row] {
            switch current.type {
            case .folder:
                let vc = TKFileViewController()
                vc.model = current
                tabBarController?.hidesBottomBarWhenPushed = false
                TKRouter.push(from: self, to: vc)
            case .image:
                let vc = TKImageViewController()
                vc.models = model?.children.filter({ $0.type == .image }) ?? []
                vc.index = vc.models.firstIndex(of: current) ?? 0
                let nav = TKNavigationViewController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                TKRouter.present(from: self, to: nav)
            case .video:
                let vc = AVPlayerViewController()
                vc.player = AVPlayer(url: current.url)
                TKRouter.present(from: self, to: vc)
            default:
                break
            }
        }
    }
}
//MARK: - tableViewDataSource
extension TKFileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.children.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let fileCell = cell as? TKFileTableViewCell {
            let current = model?.children[indexPath.row]
            fileCell.updateUI(current?.name, image: nil)
            fileCell.url = current?.url
            DispatchQueue.global().async { [weak self] in
                let image = self?.image(model: current)
                DispatchQueue.main.async {
                    if current?.url == fileCell.url {
                        fileCell.updateUI(current?.name, image: image)
                    }
                }
            }
        }
        return cell
    }
}
