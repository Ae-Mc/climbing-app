export default class Track {
  name!: string
  category!: string
  author!: { username: string, email?: string }
  description!: string
  images!: Iterable<string>
  creationDate!: Date
}