//
//  TargetSpecificsViewModel.swift
//  Test
//
//  Created by Adrian Pandelea on 27.05.2024.
//

import Foundation

protocol TargetSpecificsViewModelDelegate: AnyObject {
    func targetSpecificsViewModel(_ vieModel: TargetSpecificsViewModel, didSelectSpecifics _selectedSpecifics: [TargetSpecific])
}

class TargetSpecificsViewModel {
    private var targetSpecifics: [TargetSpecific] = []
    private var targetSpecificCellViewModels: [TargetSpecificCellViewModel] = []
    private var selectedSpecificsIndexes: [Int] = []
    private let targetSpecificService: TargetSpecificServiceProtocol
    private weak var delegate: TargetSpecificsViewModelDelegate?

    init(targetSpecificService: TargetSpecificServiceProtocol = TargetSpecificService(), delegate: TargetSpecificsViewModelDelegate) {
        self.targetSpecificService = targetSpecificService
        self.delegate = delegate
    }
    
    private func makeSpecificCellViewModels() {
        targetSpecificCellViewModels = targetSpecifics.map { TargetSpecificCellViewModel(title: $0.name) }
    }
    
    private var selectedSpecifics: [TargetSpecific] {
        selectedSpecificsIndexes.map { targetSpecifics[$0] }
    }
    
    var numberOfRows: Int {
        targetSpecificCellViewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> TargetSpecificCellViewModel {
        targetSpecificCellViewModels[indexPath.row]
    }

    func selectSpecific(at indextPath: IndexPath) {
        selectedSpecificsIndexes.append(indextPath.row)
    }
    
    func deselectSpecific(at indextPath: IndexPath) {
        selectedSpecificsIndexes.removeAll(where: { $0 == indextPath.row })
    }
    
    func selectSpecifics() {
        delegate?.targetSpecificsViewModel(self, didSelectSpecifics: selectedSpecifics)
    }
        
    func fetchTargetSpecifics(completion: @escaping (Error?) -> ()) {
        targetSpecificService.fetchTargetSpecifics { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let targetSpecifics):
                    self.targetSpecifics = targetSpecifics
                    self.makeSpecificCellViewModels()
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
}
