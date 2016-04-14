# Misc-Scripts

Contains installations scripts for [Arch Linux][1] and [Gentoo][2].
Please only use if:

- You're comfortable with using scripts that are:
  - a work in progress
  - from someone random on the internet
- You have already done non-graphical installations a few times.
- You are comfortable debugging bash scripts

I still don't have the use case for these scripts well defined,
so it may evolve with time, but this is what I'm trying to accomplish:

## Clarity and Sanity
Currently the top priority is clarity, after that its sanity.
For example:
while `wifi-menu` is easier to use,
I have been bitten by it too many times,
and prefer using `wpa_supplicant` directly instead.

## Finish the installation in a minimal fashion.
The structure will be as follows:
Try to get a bootable installation as quickly as possible.
Before when I was using Arch, I would try to get everything (ie a Desktop Enviroment) installed with pacstrap.
It felt great booting into your system for the first time, and not being greeted by a console demanding more work.
However if your using source-based distros this will diffentively not scale.
So in order to maintain an uniform structure, the installation of things not required to boot will not be done on the liveUSB.


[1]: https://wiki.archlinux.org/index.php/Installation_guide
[2]: https://wiki.gentoo.org/wiki/Handbook:Main_Page
