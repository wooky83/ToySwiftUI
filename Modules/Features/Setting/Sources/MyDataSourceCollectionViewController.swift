import FeatureSupport
import UIKit

class MyDataSourceCollectionViewController: BaseViewController {

    struct Item: Hashable {
        let name: String
        let age: Int
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    lazy var dataSource = makeDataSource()

    enum Section: Int, CaseIterable, Hashable {
        case availableHorizontal
        case availableVertical
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "😃 Use DiffableDatasource"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        applyInitialSnapshots()
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, layoutEnv in
            let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            return .list(using: configuration, layoutEnvironment: layoutEnv)
        }
    }

    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)

        var horizontalSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        let hItems = [Item(name: "K", age: 1), Item(name: "S", age: 2), Item(name: "W", age: 3)]
        horizontalSnapshot.append(hItems)
        dataSource.apply(horizontalSnapshot, to: .availableHorizontal, animatingDifferences: false)

        var vertialSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        let vItems = [Item(name: "K", age: 4), Item(name: "S", age: 5), Item(name: "W", age: 6)]
        vertialSnapshot.append(vItems)
        dataSource.apply(vertialSnapshot, to: .availableVertical, animatingDifferences: false)
    }

    func makeDataSource() -> DataSource {
        let horizontalCell = horizontalCellRegistration()
        let verticalCell = verticalCellRegistration()
        return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            switch section {
            case .availableHorizontal:
                return collectionView.dequeueConfiguredReusableCell(using: horizontalCell, for: indexPath, item: item)
            case .availableVertical:
                return collectionView.dequeueConfiguredReusableCell(using: verticalCell, for: indexPath, item: item)
            }
        }
    }

    func updateDataSource(_ index: Int) {
        var snapshot = dataSource.snapshot()
        let items = snapshot.itemIdentifiers
        if let item = items.first(where: { $0.age == index }) {
            snapshot.deleteItems([item])
            dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}

extension MyDataSourceCollectionViewController {
    func horizontalCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        .init { cell, _, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = "🥃 : " + item.name
            configuration.secondaryText = "\(item.age)"
            cell.contentConfiguration = configuration
        }
    }

    func verticalCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        .init { cell, _, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = "🐝 : " + item.name
            configuration.secondaryText = "\(item.age)"
            cell.contentConfiguration = configuration
        }
    }

}

extension MyDataSourceCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateDataSource(Int.random(in: 1...6))
    }
}
