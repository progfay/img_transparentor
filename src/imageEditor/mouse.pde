void mousePressed() {
  // button is pressed
  for (Button button : buttons.values()) {
    if (button.bounds()) {
      button.behavior.behave();
      return;
    }
  }

  // work spase is pressed
  if (mode == RECTANGLE) {
    rectStartX = mouseX;
    rectStartY = mouseY;
    return;
  }

  // image is pressed
  if (graphics == null || graphics.width == 0 || graphics.height == 0) return;
  if (on_img(mouseX, mouseY)) {
    switch(mode) {
    case TRANS:
      makeTransparencyImage(get(mouseX, mouseY));
      break;
    case FLOOD_TRANS:
      makeFloodTransImage(tranlatePositionX(mouseX), tranlatePositionY(mouseY));
      break;
    default:
      break;
    }
  }
}

void mouseReleased() {
  if (graphics == null || graphics.width == 0 || graphics.height == 0) return;
  switch(mode) {
  case BRUSH:
    if (!isBrushed) break;
    history.save();
    isBrushed = false;
    break;
  case RECTANGLE:
    if (rectStartX == -1 || rectStartY == -1) break;
    rectangleTransImage(tranlatePositionX(rectStartX), tranlatePositionY(rectStartY), tranlatePositionX(mouseX), tranlatePositionY(mouseY));
    rectStartX = -1;
    rectStartX = -1;
    break;
  }
}

int tranlatePositionX(int originX) {
  return int((originX-(WORK_WIDTH-graphics.width*SCALE)*0.5) / SCALE);
}

int tranlatePositionY(int originY) {
  return int((originY-(WORK_HEIGHT-graphics.height*SCALE)*0.5) / SCALE);
}