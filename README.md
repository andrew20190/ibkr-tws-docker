# Dockerized Interactive Brokers Trader Workstation

Inspired by https://github.com/ib-controller/ib-controller/ and https://github.com/mvberg/ib-gateway-docker, but unfortunately as of September 2021, neither of those seems to be working (at least for me), so I recreated them, "liberating" the Xvfb code, which was helpful.

This version just sends keystrokes at login using `xdotool` and then does nothing more.

# Current known defects

There is some sort of Java / Chromium packaging issue which causes the Fundamentals page to display in a weird duplicated state, that looks like an old-school CRT monitor that's out of sync.

# Selecting paper trading mode 

The first time you run a container, you can set it to switch over to paper trading mode, by including the environment variable:

    -e INIT_PAPER=1

*DO NOT* set that variable on subsequent runs, though, if reusing the same container. If you remove the container after exit, it's safe to run every time. 

This is because of how the code activates paper trading, by navigating to a button relative to its current position. This could be made smarter, but it's good enough for my purposes, so probably won't be changed.
