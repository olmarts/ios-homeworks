import UIKit

extension UICollectionViewFlowLayout {
    
    // MARK: - возвращвет ширину каждой ячейки, исходя из ширины всей строки, расстояния между соседними ячейками и  количества ячеек в строке.
    func calcCellWidth(rowWidth: CGFloat, cellSpacing: CGFloat, cellsInRow: CGFloat) -> CGFloat {
        let cellsInRow: CGFloat = cellsInRow > 0 ? cellsInRow : 1
        return (rowWidth - cellSpacing * (cellsInRow - 1))/cellsInRow
    }
   
}
