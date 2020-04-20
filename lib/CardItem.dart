// This is an object which will handle the necessary attributes of a card,
// ie. the name of the card (title) and the file names for the front and back
// images (front & back)
class CardItem {
  String front;
  String back;
  String title;

  CardItem(front, back, title) {
    this.front = front;
    this.back = back;
    this.title = title;
  }

  void setFront(String front) {
    this.front = front;
  }

  void setBack(String back) {
    this.back = back;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getFront() {
    return front;
  }

  String getBack() {
    return back;
  }

  String getTitle() {
    return title;
  }
}
