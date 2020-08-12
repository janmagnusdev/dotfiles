# pylint: disable=bad-whitespace,redefined-outer-name
from typing import Dict, List, Tuple
import itertools

import attr
import hsluv


HSLuv = Tuple[float, float, float]  # (0-360, 0-100, 0-100)
RGB = Tuple[int, int , int]  # (0-255, 0-255, 0-255)


@attr.dataclass()
class Color:
    hsluv: HSLuv
    rgb: RGB
    hex: str
    term: int

    def pretty_str(self) -> str:
        return (
            f"("
            f"({self.hsluv[0]:3}, {self.hsluv[1]:3}, {self.hsluv[2]:3}), "
            f"({self.rgb[0]:3}, {self.rgb[1]:3}, {self.rgb[2]:3}), "
            f"'{self.hex}', "
            f"{self.term:3}"
            f")"
        )


def hex2rgb(color: str) -> RGB:
    color = color.lstrip('#')
    return (int(color[0:2], 16), int(color[2:4], 16), int(color[4:6], 16))


def rgb2hex(color: RGB) -> str:
    return f'#{color[0]:02X}{color[1]:02X}{color[2]:02X}'


def hsluv2rgb(color: HSLuv) -> RGB:
    r, g, b = [round(i * 255) for i in hsluv.hsluv_to_rgb(color)]
    return r, g, b


def hsluv2hex(color: HSLuv) -> str:
    return hsluv.hsluv_to_hex(color)


def hex2hsluv(color: str) -> HSLuv:
    h, s, l = [round(i) for i in hsluv.hex_to_hsluv(color)]
    return h, s, l


def hex2xterm256(color: str, term_colors: List[str]) -> int:
    """ Convert values between RGB hex codes and xterm-256 color codes.

    Resources:
    * http://en.wikipedia.org/wiki/8-bit_color
    * http://en.wikipedia.org/wiki/ANSI_escape_code
    * /usr/share/X11/rgb.txt

    """
    def prod(codes: List['str']) -> List[str]:
        """Calculate product of *codes* for RGB channels."""
        return [f'{i}{j}{k}' for i in codes for j in codes for k in codes]

    def dist(item: Tuple[str, int]) -> float:
        """Calculate distance between *item* and current color."""
        errors = []
        rgb_a = hex2rgb(item[0])
        rgb_b = hex2rgb(color)
        for a, b in zip(rgb_a, rgb_b):
            errors.append(abs(a - b))
        errors.append((max(errors) - min(errors)) * 2)  # Minimize diff btw. errors

        # Calc RMSE
        return (sum(e ** 2 for e in errors) / len(errors)) ** 0.5

    increments = ['00', '5F', '87', 'AF', 'D7', 'FF']
    xterm_colors = prod(increments)  # Colors
    xterm_colors += [f'{i:02X}' * 3 for i in range(8, 239, 10)]  # Gray tones

    clut = {c: i for i, c in enumerate(term_colors)}
    for a, v in enumerate(xterm_colors, start=16):
        clut[f'#{v}'] = a

    if color in clut:
        # Return exact matches directly
        return clut[color]

    # Calculate distance of all colors to current color and return best result
    candidates = list(clut.items())[16:]
    candidates = sorted(candidates, key=dist)
    return candidates[0][1]


def convert_colors_from(
    attr: str, colors: Dict[str, Color], term_colors: List[str]
) -> None:
    for color in colors.values():
        if attr == 'hex':
            color.hsluv = hex2hsluv(color.hex)
            color.rgb = hex2rgb(color.hex)
            color.term = hex2xterm256(color.hex, term_colors)
        elif attr == 'hsluv':
            color.rgb = hsluv2rgb(color.hsluv)
            color.hex = hsluv2hex(color.hsluv)
            color.term = hex2xterm256(color.hex, term_colors)
        else:
            raise ValueError(f'Cannot convert from attribute "{attr}"')


def print_colors(colors: Dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print('colors = {')
    for name, color in colors.items():
        spaces = ' ' * (max_len - len(name) + 1)
        print(f"    '{name}':{spaces}{color.pretty_str()},")
    print('}')


def print_vim_colors(colors: Dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print('    if s:HAS_GUI')
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.hex}"')
    print('    else')
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.term}"')
    print('    endif')


def print_konsole_scheme(colors: Dict[str, Color], name: str) -> None:
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
            h, s, l = colors[cmap[(t, '')]].hsluv
            if v == 'Intense':
                h += 5
                s += 5
            else:
                h += 5
                s -= 5
            rgb = hsluv2rgb((h, s, l))
        r, g, b = rgb
        print(f'[{t}{v}]')
        print(f'Color={r},{g},{b}')
        print()

    print(f'[General]')
    print(f'Description={name}')


# Color               HSLuv            RGB              HEX        256-color
colors = {  # dark, futuristic
    'base00':        Color((249,   7,   9), ( 25,  26,  28), '#191A1C', 234),
    'base01':        Color((237,  15,  13), ( 31,  34,  37), '#1F2225',   0),
    'base02':        Color((233,  27,  21), ( 44,  52,  58), '#2C343A',   8),
    'base03':        Color((235,  37,  28), ( 54,  68,  79), '#36444F', 238),
    'base04':        Color((234,  41,  40), ( 76,  98, 114), '#4C6272',  59),
    'base05':        Color((226,  34,  70), (144, 175, 192), '#90AFC0',  15),
    'base06':        Color((233,  50,  86), (194, 217, 235), '#C2D9EB',   7),
    'base07':        Color((236,  45,  93), (228, 236, 244), '#E4ECF4', 255),
    'red':           Color(( 19,  54,  63), (218, 127, 113), '#DA7F71',   1),
    'orange':        Color(( 40,  73,  63), (206, 138,  79), '#CE8A4F', 173),
    'yellow':        Color(( 64,  85,  65), (187, 154,  60), '#BB9A3C', 179),
    'green':         Color((151,  64,  66), ( 98, 175, 141), '#62AF8D',  10),
    'green2':        Color((151,  64,  66), ( 98, 175, 141), '#62AF8D',  10),
    'cyan':          Color((201,  69,  66), ( 94, 172, 179), '#5EACB3',   6),
    'blue':          Color((243,  55,  65), (117, 163, 211), '#75A3D3',   4),
    'purple':        Color((262,  52,  65), (147, 154, 209), '#939AD1',   5),
    'magenta':       Color((341,  45,  63), (205, 131, 166), '#CD83A6',  13),
    'bright_red':    Color(( 20,  90,  60), (247,  95,  44), '#F75F2C',   9),
    'bright_orange': Color(( 40,  90,  60), (204, 127,  43), '#CC7F2B',  11),
    'bright_yellow': Color(( 60,  90,  60), (178, 139,  43), '#B28B2B',   3),
}

colors = {  # light, warm
    'base00':        Color(( 66,  52,  97), (251, 246, 237), '#FBF6ED', 255),
    'base01':        Color(( 68,  14,  92), (236, 232, 224), '#ECE8E0',   0),
    'base02':        Color((  0,   0,  85), (213, 213, 213), '#D5D5D5',   8),
    'base03':        Color((  0,   0,  77), (191, 191, 191), '#BFBFBF', 250),
    'base04':        Color((  0,   0,  60), (145, 145, 145), '#919191', 246),
    'base05':        Color((  0,   0,  40), ( 94,  94,  94), '#5E5E5E',  15),
    'base06':        Color((  0,   0,  19), ( 47,  47,  47), '#2F2F2F',   7),
    'base07':        Color((  0,   0,   9), ( 26,  26,  26), '#1A1A1A', 234),
    'red':           Color(( 15,  70,  40), (164,  59,  49), '#A43B31',   1),
    'orange':        Color(( 30,  90,  50), (183,  95,  34), '#B75F22', 172),
    'yellow':        Color(( 50,  90,  50), (157, 110,  34), '#9D6E22', 100),
    'green':         Color((110,  90,  45), ( 82, 117,  29), '#52751d',   2),
    'green2':        Color((150,  90,  45), ( 31, 121,  86), '#1F7956',  10),
    'cyan':          Color((200,  90,  50), ( 38, 131, 137), '#268389',   6),
    'blue':          Color((250,  80,  40), ( 47,  96, 153), '#2F6099',   4),
    'purple':        Color((300,  60,  40), (135,  67, 146), '#874392',   5),
    'magenta':       Color((  0,  70,  40), (167,  52,  84), '#A73454',  13),
    'bright_red':    Color(( 15,  90,  50), (220,  58,  35), '#DC3A23',   9),
    'bright_orange': Color(( 30, 100,  50), (188,  92,   0), '#BC5C00',  11),
    'bright_yellow': Color(( 50, 100,  65), (211, 145,   0), '#D39100',   3),
}

term_colors = [colors[c].hex for c in [
    'base01',
    'red',
    'green',
    'bright_yellow',
    'blue',
    'purple',
    'cyan',
    'base06',
    'base02',
    'bright_red',
    'green2',
    'bright_orange',
    'blue',
    'magenta',
    'cyan',
    'base05',
]]

convert_colors_from('hex', colors, term_colors)
print_colors(colors)
print_vim_colors(colors)
# print_konsole_scheme(colors, 'Stylo Light')
