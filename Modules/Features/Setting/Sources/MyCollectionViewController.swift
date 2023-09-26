import FeatureSupport
import SnapKit
import UIKit

class MyCollectionViewController: BaseViewController {

    enum MySection {
        case first([FirstItem])
        case second([SecondItem])

        struct FirstItem {
            let value: String
        }
        struct SecondItem {
            let value: String
        }
    }

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.configureLayout())
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "\(MyCollectionViewCell.self)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dataSource: [MySection] = [
        .first((1...15).map(String.init).map(MySection.FirstItem.init(value:))),
        .second((16...30).map(String.init).map(MySection.SecondItem.init(value:)))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "😃 My Setting"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 3개의 셀
                let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
                let itemInset: CGFloat = 2.5

                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: itemInset,
                    leading: itemInset,
                    bottom: itemInset,
                    trailing: itemInset
                )

                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: itemInset,
                    leading: itemInset,
                    bottom: itemInset,
                    trailing: itemInset
                )
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                return section
            default:
                let itemFractionalWidthFraction = 1.0
                let groupFractionalHeightFraction = 1.0 / 8.0
                let itemInset: CGFloat = 2.5

                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: itemInset,
                    leading: itemInset,
                    bottom: itemInset,
                    trailing: itemInset
                )

                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: itemInset,
                    leading: itemInset,
                    bottom: itemInset,
                    trailing: itemInset
                )
                return section
            }
        }
    }

}

extension MyCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "\(MyCollectionViewCell.self)",
            for: indexPath
        ) as! MyCollectionViewCell
        switch self.dataSource[indexPath.section] {
        case let .first(items):
            cell.configure(text: items[indexPath.item].value)
        case let .second(items):
            cell.configure(text: items[indexPath.item].value)
        }
        return cell
    }
}

extension MyCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MyDataSourceCollectionViewController(), animated: true)
    }
}

final class MyCollectionViewCell: UICollectionViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        self.contentView.addSubview(self.label)
        self.label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func configure(text: String) {
        self.label.text = text
    }
}
