//
//  ViewController.swift
//  StudyDriveTest
//
//  Created by Eric Mok on 27/7/2022.
//

import UIKit

final class ViewController: UIViewController {
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    private let producerButton = UIButton()
    private let consumerButton = UIButton()
    
    let viewModel = ViewModel()
    private var cellsPerRow:CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Test"
        self.view.backgroundColor = .white
        setupViews()
        setupBindings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.invalidateTimers()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .compact) ? 4 : 4
        collectionView.reloadData()
    }

    private func setupViews() {
        collectionView.register(RoundCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
       
        view.add(collectionView, producerButton, consumerButton)
        
        producerButton.addRoundCorner()
        producerButton.setTitle("Producer", for: .normal)
        producerButton.addTarget(self, action: #selector(didTapProducerButton), for: .touchUpInside)
        
        consumerButton.addRoundCorner(backgroundColor: .systemRed)
        consumerButton.setTitle("Consumer", for: .normal)
        consumerButton.addTarget(self, action: #selector(didTapCustomerButton), for: .touchUpInside)
    
        let views: [String: Any] = ["collectionView": collectionView,
                                    "producerButton": producerButton,
                                    "customerButton": consumerButton]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[collectionView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]-16-[producerButton(48)]-32-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[producerButton]-[customerButton(producerButton)]-16-|", options: [.alignAllCenterY], metrics: nil, views: views))
        consumerButton.heightAnchor.constraint(equalTo: producerButton.heightAnchor).isActive = true
    }
    
    private func setupBindings() {
        viewModel.dataSource.bind { [weak self] cells in
           self?.collectionView.reloadData()
        }
    }
    
    @objc func didTapProducerButton() {
        viewModel.createProducer()
    }
    
    @objc func didTapCustomerButton() {
        viewModel.createConsumer()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.label.text = "\(indexPath.item)"
        cell.label.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding:CGFloat = 5
        
        let widthMinusPadding = UIScreen.main.bounds.width - (cellPadding + cellPadding * cellsPerRow)
        let width = widthMinusPadding / cellsPerRow
        return CGSize(width: width, height: width)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 13
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }
}
