const [labels, targetLabelName] = process.argv.slice(2)

const labelList = JSON.parse(labels)
const isExist = labelList.map(label => label.name).include(targetLabelName)

console.log(isExist)