#shape moving python

import pygame
pygame.init()
SCREEN_HEIGHT = 450
SCREEN_WIDTH = 450
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Shape Moving - 103441107")
done=False
is_blue=True
x=30
y=30
time=pygame.time

while not done:
  for event in pygame.event.get():
    if event.type == pygame.QUIT:
      done = True
    if event.type == pygame.KEYDOWN and event.type == pygame.K_SPACE:
      is_blue = not is_blue
    pressed = pygame.key.get_pressed()
    if pressed[pygame.K_LEFT]: x -= 3
    if pressed[pygame.K_RIGHT]: x += 3
    if pressed[pygame.K_UP]: y -= 3 #Adding at here
    if pressed[pygame.K_DOWN]: y += 3
    if x > (SCREEN_WIDTH - 60): x -=3
    if x < 0: x +=3
    if y > (SCREEN_HEIGHT - 60): y -=3
    if y < 0: y +=3
    print(f"x is {x} y is {y} timer is {time.get_ticks()}")
    screen.fill((0,0,0))
    if is_blue: color = (135,0,113)
    else: color = (179,255,255)
    rect = pygame.Rect(x,y,60,60)

    pygame.draw.rect(screen, color, rect)
    pygame.display.flip()
