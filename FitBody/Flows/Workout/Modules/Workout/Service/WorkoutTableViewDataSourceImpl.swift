import UIKit

// MARK: - WorkoutTableViewDataSourceImpl

final class WorkoutTableViewDataSourceImpl: NSObject {
    var sections: [WorkoutSection] = []
    
    private let parameters: WorkoutParameters
    
    init(with parameters: WorkoutParameters) {
        self.parameters = parameters
    }
}

// MARK: - UITableViewDataSource

extension WorkoutTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case let .top(kind):
            let cell: WorkoutTopCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: WorkoutTopViewModel(with: kind)
            )
            return cell
        case let .info(workoutListItem):
            let cell: WorkoutInfoCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: WorkoutInfoViewModel(with: workoutListItem)
            )
            return cell
        case let .difficulty(difficulty):
            let cell: WorkoutDifficultyCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: difficulty)
            return cell
        case let .equipments(equipments):
            let cell: WorkoutEquipmentsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: equipments)
            return cell
        case let .exercise(exercise):
            let cell: WorkoutExerciseCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: WorkoutExerciseViewModel(with: exercise)
            )
            return cell
        }
    }
}
