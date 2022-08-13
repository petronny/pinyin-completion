#!/usr/bin/env python
# vim: set fileencoding=utf-8 :

pinyin = {}
pinyin_initial = {}

if __name__ == "__main__":

    lines = open("unicode-han-pinyin.txt").readlines()

    for line in lines:

        line = line[:-1] if line[-1] == "\n" else line

        unichar, accent = line.split("=")

        accent = accent.lower()
        initial = accent[0]

        try:
            pinyin[unichar].append(accent)
        except KeyError:
            pinyin[unichar] = [
                accent,
            ]

        try:
            pinyin_initial[unichar].append(initial)
        except KeyError:
            pinyin_initial[unichar] = [
                initial,
            ]

    # remove duplication
    for key in pinyin.keys():
        pinyin[key] = list(set(pinyin[key]))
    for key in pinyin_initial.keys():
        pinyin_initial[key] = list(set(pinyin_initial[key]))

    # now generate an python module containing pinyin table
    print("# vim: set fileencoding=utf-8 :")
    print("")

    print("")
    print("")

    print("pinyin_initial = {")
    for key in pinyin_initial.keys():
        print("u'%s' : %s ," % (key.encode("utf-8"), pinyin_initial[key]))
    print("}")
