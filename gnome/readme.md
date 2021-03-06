# Importing a Terminal Profile in Ubuntu 16

See this Stack Overflow answer for details: http://askubuntu.com/a/874073/329923

List contents and profiles:

```
dconf dump /org/gnome/terminal/legacy/profiles:/ | grep -e "\[\:\|visible-name"
```

Export based on the profile name:

```
dconf dump /org/gnome/terminal/legacy/profiles:/:xx-xx-xx-xx/ > sample.dconf
```

Example profile id, export your profile:

```
dconf dump /org/gnome/terminal/legacy/profiles:/:129ed6a8-b501-42a4-9f94-361a491d0051/ > my-profile.dconf
```

Import your profile:

```
# Import from sample.dconf
dconf load /org/gnome/terminal/legacy/profiles:/:129ed6a8-b501-42a4-9f94-361a491d0051/ < sample.dconf
```
