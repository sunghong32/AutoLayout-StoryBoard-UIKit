//
//  RankingFeatureSectionView.swift
//  AppStore
//
//  Created by 민성홍 on 2022/06/27.
//

import UIKit
import SnapKit

final class RankingFeatureSectionView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .black)
        label.text = "iPhone이 처음이라면"

        return label
    }()

    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(RakingFeatureCollectionViewCell.self, forCellWithReuseIdentifier: "RankingFeatureSectionViewCell")

        return collectionView
    }()

    private let separatorView = SeparatorView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: RakingFeatureCollectionViewCell.height)
    }
}

extension RankingFeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureSectionViewCell", for: indexPath) as? RakingFeatureCollectionViewCell
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
}

private extension RankingFeatureSectionView {
    func setupViews() {
        [titleLabel, showAllAppsButton, collectionView, separatorView]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }

        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.height.equalTo(RakingFeatureCollectionViewCell.height * 3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
