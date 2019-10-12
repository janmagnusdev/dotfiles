# pylint: disable=bad-whitespace,line-too-long
# flake8: noqa: E241
import colorsys
import itertools

import attr
import colorspacious


@attr.s(auto_attribs=True)
class Color:
    jch: tuple
    rgb: tuple
    hex: str
    term: int

    def pretty_str(self):
        return (
            f"("
            f"({self.jch[0]:3}, {self.jch[1]:3}, {self.jch[2]:3}), "
            f"({self.rgb[0]:3}, {self.rgb[1]:3}, {self.rgb[2]:3}), "
            f"'{self.hex}', "
            f"{self.term:2}"
            f")"
        )


def hex2rgb(color):
    return (int(color[1:3], 16), int(color[3:5], 16), int(color[5:7], 16))


def rgb2hex(color):
    return f'#{color[0]:02X}{color[1]:02X}{color[2]:02X}'


def jch2rgb(color):
    rgb = colorspacious.cspace_convert(color, 'JCh', 'sRGB255').round()
    return tuple(int(i) for i in rgb)


def hex2jch(color):
    rgb = hex2rgb(color)
    jch = colorspacious.cspace_convert(rgb, 'sRGB255', 'JCh').round()
    return tuple(int(i) for i in jch)


def jch2hex(color):
    rgb = jch2rgb(color)
    return rgb2hex(rgb)


def convert_colors_from(colors, attr):
    for color in colors.values():
        if attr == 'hex':
            color.jch = hex2jch(color.hex)
            color.rgb = hex2rgb(color.hex)
        elif attr == 'jch':
            color.rgb = jch2rgb(color.jch)
            color.hex = jch2hex(color.jch)
        else:
            raise ValueError(f'Cannot convert from attribute "{attr}"')


def print_colors(colors):
    max_len = max(len(name) for name in colors)
    print('colors = {')
    for name, color in colors.items():
        spaces = ' ' * (max_len - len(name) + 1)
        print(f"    '{name}':{spaces}{color.pretty_str()},")
    print('}')


def print_vim_colors(colors):
    max_len = max(len(name) for name in colors)
    print('    if s:HAS_GUI')
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.hex}"')
    print('    else')
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.term}"')
    print('    endif')


def print_konsole_scheme(colors, name):
    color_types = [
        'Background',
        'Foreground',
    ] + [f'Color{i}' for i in range(8)]
    variations = ['', 'Faint', 'Intense']
    cmap = {
        ('Background', ''): 'base00',
        ('Background', 'Faint'): 'base00',
        ('Background', 'Intense'): 'base00',
        ('Foreground', ''): 'base05',  # Wird das für Schrift genutzt?
        ('Foreground', 'Faint'): 'base05',
        ('Foreground', 'Intense'): 'base06',
        ('Color0', ''): 'base01',
        ('Color0', 'Faint'): 'base01',
        ('Color0', 'Intense'): 'base02',
        ('Color1', ''): 'red',
        ('Color1', 'Intense'): 'orange',
        ('Color2', ''): 'green',
        ('Color3', ''): 'yellow',
        ('Color4', ''): 'blue',
        ('Color5', ''): 'purple',
        ('Color5', 'Intense'): 'magenta',
        ('Color6', ''): 'cyan',
        ('Color7', ''): 'base00',
        ('Color7', 'Faint'): 'base06',
        ('Color7', 'Intense'): 'base07',
    }

    for t, v in itertools.product(color_types, variations):
        try:
            rgb = colors[cmap[(t, v)]].rgb
        except KeyError:
            assert v in {'Faint', 'Intense'}, v
            j, c, h = colors[cmap[(t, '')]].jch
            if v == 'Intense':
                j += 5
                c += 5
            else:
                j += 5
                c -= 5
            rgb = jch2rgb((j, c, h))
        r, g, b = rgb
        print(f'[{t}{v}]')
        print(f'Color={r},{g},{b}')
        print()

    print(f'[General]')
    print(f'Description={name}')


# Color         JCh              RGB              HEX        256-color
colors = {  # dark, futuristic
    'base00':  ((  8,   3, 235), ( 25,  26,  28), '#191A1C', 10),
    'base01':  (( 10,   5, 235), ( 31,  34,  37), '#1F2225',  0),
    'base02':  (( 15,  10, 235), ( 44,  52,  58), '#2C343A',  8),
    'base03':  (( 20,  15, 235), ( 54,  68,  79), '#36444F', 11),
    'base04':  (( 30,  20, 180), ( 76,  98, 114), '#4C6272', 12),
    'base05':  (( 60,  23, 230), (144, 175, 192), '#90AFC0', 14),
    'base06':  (( 80,  20, 235), (194, 217, 235), '#C2D9EB',  7),
    'base07':  (( 90,  10, 235), (228, 236, 244), '#E4ECF4', 15),
    'red':     (( 55,  40,  30), (218, 127, 113), '#DA7F71',  1),
    'orange':  (( 55,  40,  60), (206, 138,  79), '#CE8A4F',  9),
    'yellow':  (( 55,  45, 100), (169, 159,  58), '#A99F3A',  3),
    'green':   (( 55,  35, 150), ( 98, 175, 141), '#62AF8D',  2),
    'cyan':    (( 55,  35, 205), ( 94, 172, 179), '#5EACB3',  6),
    'blue':    (( 55,  40, 245), (117, 163, 211), '#75A3D3',  4),
    'purple':  (( 55,  35, 270), (147, 154, 209), '#939AD1',  5),
    'magenta': (( 55,  35, 350), (205, 131, 166), '#CD83A6', 13),
}

colors = {  # light, warm
    'base00':  (( 96,   4,  98), (251, 246, 237), '#FBF6ED', 10),
    'base01':  (( 89,   4, 102), (236, 232, 223), '#ECE8DF',  0),
    'base02':  (( 80,   3, 211), (213, 213, 213), '#D5D5D5',  8),
    'base03':  (( 70,   2, 211), (192, 191, 191), '#C0BFBF', 11),
    'base04':  (( 50,   2, 211), (145, 145, 145), '#919191', 12),
    'base05':  (( 30,   2, 211), ( 94,  94,  94), '#5E5E5E', 14),
    'base06':  (( 14,   1, 211), ( 47,  47,  47), '#2F2F2F',  7),
    'base07':  ((  8,   1, 211), ( 26,  26,  26), '#1A1A1A', 15),
    'red':     (( 30,  70,  30), (167,  38,  28), '#A7261C',  1),
    'orange':  (( 30,  55,  50), (150,  64,   3), '#964003',  9),
    'yellow':  (( 50,  54,  85), (180, 136,   5), '#B48805',  3),
    'green':   (( 30,  47, 115), ( 86, 102,   3), '#566603',  2),
    'cyan':    (( 30,  35, 205), ( 11, 108, 114), '#0B6C72',  6),
    'blue':    (( 30,  40, 250), ( 59,  98, 147), '#3B6293',  4),
    'purple':  (( 30,  55, 330), (144,  51, 140), '#90338C',  5),
    'magenta': (( 30,  60,   0), (160,  40,  92), '#A0285C', 13),
}

colors = {k: Color(*v) for k, v in colors.items()}


# convert_colors_from(colors, 'hex')
convert_colors_from(colors, 'jch')
print_colors(colors)
print_vim_colors(colors)
# print_konsole_scheme(colors, 'Stefan Light')
