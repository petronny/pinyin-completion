import pickle
import argparse

parser = argparse.ArgumentParser(description='Generate pinyin initials pickle file.')
parser.add_argument('input_file', help='Input file containing pinyin mappings')
parser.add_argument('output_file', help='Output pickle file for pinyin initials')

args = parser.parse_args()

pinyin = {}
pinyin_initial = {}

DOUBLE_WIDTH = {
    "～": "~", "！": "!", "＠": "@", "＃": "#", "＄": "$", "％": "%", "＆": "&", "＊": "*",
    "（": "(", "）": ")", "＿": "_", "－": "-", "＋": "+", "［": "[", "］": "]", "＜": "<",
    "＞": ">", "？": "?", "，": ",", "。": ".", "／": "/", "、": "u",
}


lines = open(args.input_file).readlines()

for line in lines:
    line = line.strip()

    unichar, accent = line.split("=")

    accent = accent.lower()
    initial = accent[0]

    pinyin.setdefault(unichar, set()).add(accent)
    pinyin_initial.setdefault(unichar, set()).add(initial)

for k, v in pinyin_initial.items():
    pinyin_initial[k] = v.pop() if len(v) == 1 else f"`{''.join(sorted(list(v)))}`"

pinyin_initial.update(DOUBLE_WIDTH)
with open(args.output_file, 'wb') as f:
    pickle.dump(pinyin_initial, f)
