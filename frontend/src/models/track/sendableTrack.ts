export default class SendableTrack {
  name?: string
  category?: string
  description?: string
  author?: string
  creationDate?: string
  images: File[]

  constructor(
    name?: string,
    category?: string,
    description?: string,
    author?: string,
    creationDate?: string,
    images: File[] = [],
  ) {
    this.name = name;
    this.category = category;
    this.description = description;
    this.author = author
    this.creationDate = creationDate;
    this.images = images;
  }
}
