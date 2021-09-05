export default class FetchedTrack {
  id!: number
  name!: string
  category!: string
  author!: string
  uploader!: { username: string, email?: string }
  description!: string
  images!: { image: string }[]
  creationDate!: string

  static quarterDate(track: FetchedTrack): string {
    const d = new Date(track.creationDate);
    return `${d.getFullYear()} Q${Math.floor(d.getMonth() / 3 + 1)}`;
  }
}