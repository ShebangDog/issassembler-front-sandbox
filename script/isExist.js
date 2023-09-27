const [context, targetLabelName] = process.argv.slice(2)

const isExist = context.labels.map(label => label.name).include(targetLabelName)

console.log(isExist)