const [authorName, commentList] = process.argv.slice(2)

const Type = {
    BOT: "BOT"
}

const {BOT} = Type

const filteredByAuthorName = commentList
    .filter(comment => comment.type === BOT && comment.user.login.startsWith(authorName))

const sortedByUpdatedAt = [...filteredByAuthorName].sort((left, right) => new Date(left.updated_at) - new Date(right.updated_at))

console.log(sortedByUpdatedAt[0])
    