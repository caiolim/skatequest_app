class HomeController {
  var daysSkate = 0;
  var skateToday = false;
  var skateDaysOnWeek = 2;

  void confirmSkateToday() {
    daysSkate += 1;
    skateToday = true;
    skateDaysOnWeek += 1;
  }
}
