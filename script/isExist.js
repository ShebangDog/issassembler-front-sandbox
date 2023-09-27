const [labels, targetLabelName] = process.argv.slice(2)
console.log(labels)

const isExist = labels.map(label => label.name).include(targetLabelName)

console.log(isExist)