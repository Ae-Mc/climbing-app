export default class SendableTrack {
  name?: string
  category?: string
  description?: string
  creationDate?: string
  images?: File[]

  constructor(
    name?: string,
    category?: string,
    description?: string,
    creationDate?: string,
    images?: File[],
  ) {
    this.name = name;
    this.category = category;
    this.description = description;
    this.creationDate = creationDate;
    this.images = images;
  }
}
