//
//  ViewModel.swift
//  StudyDriveTest
//
//  Created by Eric Mok on 27/7/2022.
//

import Foundation

protocol ViewModelType {
    var dataSource: Observable<[String]> { get }
    func numberOfItem() -> Int
    func createProducer()
    func createConsumer()
    func invalidateTimers()
}

final class ViewModel: ViewModelType {
    private var cells: Observable<[String]> = Observable([])
    private var producerTimers: [Timer] = []
    private var customerTimers: [Timer] = []
    
    var dataSource: Observable<[String]> {
        return cells
    }
    
    func numberOfItem() -> Int {
        return cells.value?.count ?? 0
    }
    
    func createProducer() {
        print("Created new Producer")
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addCell), userInfo: nil, repeats: true)
        producerTimers.append(timer)
    }
    
    func createConsumer() {
        print("Created new Consumer")
        let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(deleteCell), userInfo: nil, repeats: true)
        customerTimers.append(timer)
    }
    
    func invalidateTimers() {
        producerTimers.forEach { $0.invalidate() }
        customerTimers.forEach {  $0.invalidate() }
        print("All timers invalidated")
    }
    
    @objc private func addCell() {
        self.cells.value?.append("cell")
        print("Produced new cell")
    }
    
    @objc private func deleteCell() {
        if let cells = self.cells.value, !cells.isEmpty {
            self.cells.value?.removeLast()
            print("Deleted latest cell")
        }
    }
}
