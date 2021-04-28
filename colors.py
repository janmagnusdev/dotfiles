# pylint: disable=bad-whitespace,redefined-outer-name
import itertools
import subprocess
from typing import Dict, List, Tuple

import attr
import click
import hsluv


HSLuv = Tuple[float, float, float]  # (0-360, 0-100, 0-100)
RGB = Tuple[int, int , int]  # (0-255, 0-255, 0-255)


#   Color             HSLuv             RGB              HEX        256-color
COLORS = {}
COLORS["dark"] = {  # dark, futuristic
    "base00":         ((230,   7,   9), ( 24,  26,  27), "#181A1B", 234),
    "base01":         ((230,  15,  13), ( 31,  34,  36), "#1F2224", 235),
    "base02":         ((230,  20,  23), ( 49,  56,  60), "#31383C",   8),
    "base03":         ((230,  30,  28), ( 56,  68,  75), "#38444B", 238),
    "base04":         ((230,  35,  40), ( 78,  97, 109), "#4E616D", 240),
    "base05":         ((230,  35,  70), (144, 176, 196), "#90B0C4", 110),
    "base06":         ((230,  50,  86), (194, 219, 235), "#C2DBEB",   7),
    "base07":         ((230,  45,  93), (226, 236, 244), "#E2ECF4",  15),
    "red":            (( 20,  60,  65), (225, 133, 117), "#E18575",   1),
    "orange":         (( 40,  75,  65), (214, 142,  78), "#D68E4E", 173),
    "yellow":         (( 65,  85,  65), (187, 154,  60), "#BB9A3C",   3),
    "green":          ((145,  50,  65), (112, 170, 137), "#70AA89",   2),
    "cyan":           ((200,  70,  65), ( 91, 170, 176), "#5BAAB0",   6),
    "blue":           ((245,  55,  65), (116, 161, 212), "#74A1D4",   4),
    "purple":         ((260,  50,  65), (145, 155, 208), "#919BD0",   5),
    "magenta":        ((340,  45,  63), (205, 130, 166), "#CD82A6", 175),
    "bright_red":     (( 20,  90,  60), (247,  95,  44), "#F75F2C",   9),
    "bright_orange":  (( 40, 100,  75), (255, 164,  74), "#FFA44A", 215),
    "bright_yellow":  (( 65, 100,  75), (222, 180,   0), "#DEB400",  11),
    "bright_green":   ((145, 100,  60), (  0, 166, 104), "#00A668",  10),
    "bright_cyan":    ((200, 100,  60), (  0, 160, 168), "#00A0A8",  14),
    "bright_blue":    ((245,  90,  60), ( 53, 150, 225), "#3596E1",  12),
    "bright_purple":  ((260,  90,  60), (111, 138, 244), "#6F8AF4",  13),
    "bright_magenta": ((340,  70,  60), (227,  99, 167), "#E363A7", 169),
}

COLORS["light"] = {  # light, warm
    "base00":         (( 66,  52,  97), (251, 246, 237), "#FBF6ED", 255),
    "base01":         (( 68,  14,  92), (236, 232, 224), "#ECE8E0",   0),
    "base02":         ((  0,   0,  85), (213, 213, 213), "#D5D5D5",   8),
    "base03":         ((  0,   0,  77), (191, 191, 191), "#BFBFBF", 250),
    "base04":         ((  0,   0,  60), (145, 145, 145), "#919191", 246),
    "base05":         ((  0,   0,  40), ( 94,  94,  94), "#5E5E5E",  15),
    "base06":         ((  0,   0,  25), ( 47,  47,  47), "#2F2F2F",   7),
    "base07":         ((  0,   0,   9), ( 26,  26,  26), "#1A1A1A", 234),
    "red":            (( 15,  70,  40), (164,  59,  49), "#A43B31",   1),
    "orange":         (( 30, 100,  50), (188,  92,   0), "#BC5C00",  11),
    "yellow":         (( 50, 100,  65), (211, 145,   0), "#D39100",   3),
    "green":          ((110,  90,  45), ( 82, 117,  29), "#52751d",   2),
    "cyan":           ((200,  90,  50), ( 38, 131, 137), "#268389",   6),
    "blue":           ((250,  80,  40), ( 47,  96, 153), "#2F6099",   4),
    "purple":         ((300,  60,  40), (135,  67, 146), "#874392",   5),
    "magenta":        ((  0,  70,  40), (167,  52,  84), "#A73454",  13),
    "bright_red":     (( 15,  90,  50), (220,  58,  35), "#DC3A23",   9),
    "bright_orange":  (( 30, 100,  70), (188,  92,   0), "#BC5C00",  11),
    "bright_yellow":  (( 50, 100,  75), (211, 145,   0), "#D39100",   3),
    "bright_green":   ((110, 100,  65), ( 82, 117,  29), "#77AE00",   2),
    "bright_cyan":    ((200,  90,  55), ( 38, 131, 137), "#00ACCD",   6),
    "bright_blue":    ((250, 100,  55), ( 47,  96, 153), "#0087E6",   4),
    "bright_purple":  ((300,  70,  55), (135,  67, 146), "#C455D5",   5),
    "bright_magenta": ((  0,  70,  55), (167,  52,  84), "#ED4074",  13),
}

BACKGROUND = "base00"
TEXT = "base05"
TERM_COLORS = [
    # 30-37
    "base01",
    "red",
    "green",
    "yellow",
    "blue",
    "purple",
    "cyan",
    "base06",
    # 90-97
    "base02",
    "bright_red",
    "bright_green",
    "bright_yellow",
    "bright_blue",
    "bright_purple",
    "bright_cyan",
    "base07",
]


@attr.dataclass()
class Color:
    hsluv: HSLuv
    rgb: RGB
    hex: str
    term: int

    def pretty_str(self) -> str:
        """
        Returns a pretty and colorful representation of this color.
        """
        r, g, b = self.rgb
        return (
            f"\033[38;2;{r};{g};{b}m"
            f"("
            f"({self.hsluv[0]:3}, {self.hsluv[1]:3}, {self.hsluv[2]:3}), "
            f"({self.rgb[0]:3}, {self.rgb[1]:3}, {self.rgb[2]:3}), "
            f'"{self.hex}", '
            f"{self.term:3}"
            f")"
            f"\033[0m"
        )


def hex2rgb(color: str) -> RGB:
    color = color.lstrip("#")
    return (int(color[0:2], 16), int(color[2:4], 16), int(color[4:6], 16))


def rgb2hex(color: RGB) -> str:
    return f"#{color[0]:02X}{color[1]:02X}{color[2]:02X}"


def hsluv2rgb(color: HSLuv) -> RGB:
    r, g, b = [round(i * 255) for i in hsluv.hsluv_to_rgb(color)]
    return r, g, b


def hsluv2hex(color: HSLuv) -> str:
    return hsluv.hsluv_to_hex(color).upper()


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
    def product(codes: List["str"]) -> List[str]:
        """Calculate product of *codes* for RGB channels."""
        return [f"{i}{j}{k}" for i in codes for j in codes for k in codes]

    def distance(item: Tuple[str, int]) -> float:
        """Calculate distance between *item* and current color."""
        errors = []
        rgb_a = hex2rgb(item[0])
        rgb_b = hex2rgb(color)
        for a, b in zip(rgb_a, rgb_b):
            errors.append(abs(a - b))
        errors.append((max(errors) - min(errors)) * 2)  # Minimize diff btw. errors

        # Calc RMSE
        return (sum(e ** 2 for e in errors) / len(errors)) ** 0.5

    increments = ["00", "5F", "87", "AF", "D7", "FF"]
    xterm_colors = product(increments)  # Colors
    xterm_colors += [f"{i:02X}" * 3 for i in range(8, 239, 10)]  # Gray tones

    hex_color_lut = {c: i for i, c in enumerate(term_colors)}
    for a, v in enumerate(xterm_colors, start=16):
        hex_color_lut[f"#{v}"] = a

    if color in hex_color_lut:
        # Return exact matches directly
        return hex_color_lut[color]

    # Calculate distance of all colors to current color and return best result
    candidates = list(hex_color_lut.items())[16:]
    candidates = sorted(candidates, key=distance)
    return candidates[0][1]


def convert_colors_from(
    attr: str, colors: Dict[str, Color], term_colors: List[str]
) -> None:
    term_colors = [colors[c].hex for c in term_colors]
    for color in colors.values():
        if attr == "hex":
            color.hsluv = hex2hsluv(color.hex)
            color.rgb = hex2rgb(color.hex)
            color.term = hex2xterm256(color.hex, term_colors)
        elif attr == "hsluv":
            color.rgb = hsluv2rgb(color.hsluv)
            color.hex = hsluv2hex(color.hsluv)
            color.term = hex2xterm256(color.hex, term_colors)
        else:
            raise ValueError(f"Cannot convert from attribute '{attr}'")


def print_colors(colors: Dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print("colors = {")
    for name, color in colors.items():
        spaces = " " * (max_len - len(name) + 1)
        print(f'    "{name}":{spaces}{color.pretty_str()},')
    print("}")


def print_vim_colors(colors: Dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print("    if s:HAS_GUI")
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.hex}"')
    print("    else")
    for name, color in colors.items():
        print(f'        let s:{name:{max_len}} = "{color.term}"')
    print("    endif")


def print_konsole_scheme(colors: Dict[str, Color], name: str) -> None:
    color_types = [
        "Background",
        "Foreground",
    ] + [f"Color{i}" for i in range(8)]
    variations = ["", "Faint", "Intense"]
    cmap = {
        ("Background", ""): "base00",
        ("Background", "Faint"): "base00",
        ("Background", "Intense"): "base00",
        ("Foreground", ""): "base05",  # Wird das für Schrift genutzt?
        ("Foreground", "Faint"): "base05",
        ("Foreground", "Intense"): "base06",
        ("Color0", ""): "base01",
        ("Color0", "Faint"): "base01",
        ("Color0", "Intense"): "base02",
        ("Color1", ""): "red",
        ("Color1", "Intense"): "orange",
        ("Color2", ""): "green",
        ("Color3", ""): "yellow",
        ("Color4", ""): "blue",
        ("Color5", ""): "purple",
        ("Color5", "Intense"): "magenta",
        ("Color6", ""): "cyan",
        ("Color7", ""): "base00",
        ("Color7", "Faint"): "base06",
        ("Color7", "Intense"): "base07",
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


@click.command()
@click.argument(
    "mode",
    type=click.Choice(["dark", "light"]),
    default=subprocess.check_output(["dm", "get"], text=True).strip(),
)
def main(mode):
    colors = {k: Color(*v) for k, v in COLORS[mode].items()}
    convert_colors_from("hsluv", colors, TERM_COLORS)
    print_colors(colors)

    # print()
    # print_vim_colors(colors)
    # print_konsole_scheme(colors, 'Stylo Light')


if __name__ == "__main__":
    main()
