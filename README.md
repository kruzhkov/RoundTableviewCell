# RoundTableviewCell
RoundTableviewCell like iPad setting

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

#Minimum
iOS 7.0

#Install

Carthage
```
github 'mrchenhao/RoundTableviewCell'
```
then carthage update.

#How to use

Create a UITableviewCell inherit RoundTableviewCell

```
class TableViewCell: RoundTableviewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
```

 ![image](https://raw.githubusercontent.com/mrchenhao/RoundTableviewCell/master/ScreenShot/screenshot.png)
