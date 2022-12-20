import math
import re
import subprocess
from pathlib import Path
from typing import Any, NamedTuple, Tuple

import attr
import click
import coloraide
import coloraide.spaces.okhsl
import jinja2


coloraide.Color.register(coloraide.spaces.okhsl.Okhsl())


Colors = tuple[tuple[int ,int, int], tuple[int, int, int], str]


TEMPLATE_DIR = Path(__file__).parent.joinpath("templates")
THEME_NAME = {
    "dark": "Stylo Dark",
    "light": "Stylo Light",
}

# fmt: off
#       Color             Okhsl             HSL              HEX
COLORS: dict[str, dict[str, Colors]] = {
    "dark": {  # dark, futuristic
        "base00":         ((229,   4,  11), (200,   6,  10), "#181A1B"),
        "base01":         ((248,   7,  16), (210,   8,  15), "#232629"),
        "base02":         ((239,  10,  25), (205,  11,  22), "#333A3F"),
        "base03":         ((237,  15,  30), (204,  14,  27), "#3C4850"),
        "base04":         ((236,  19,  40), (203,  17,  37), "#4E616D"),
        "base05":         ((236,  28,  70), (203,  31,  67), "#90B0C4"),
        "base06":         ((236,  41,  86), (203,  51,  84), "#C2DBEB"),
        "base07":         ((242,  36,  93), (207,  45,  92), "#E2ECF4"),
        "red":            (( 31,  65,  66), (  9,  64,  67), "#E18575"),
        "orange":         (( 61,  68,  66), ( 28,  62,  57), "#D68E4E"),
        "yellow":         (( 89,  74,  65), ( 44,  51,  48), "#BB9A3C"),
        "green":          ((159,  46,  64), (146,  25,  55), "#70AA89"),
        "cyan":           ((202,  54,  64), (184,  35,  52), "#5BAAB0"),
        "blue":           ((252,  52,  65), (212,  53,  64), "#74A1D4"),
        "purple":         ((276,  45,  65), (230,  40,  69), "#919BD0"),
        "magenta":        ((350,  49,  65), (331,  43,  66), "#CD82A6"),
        "bright_red":     (( 38,  95,  62), ( 15,  93,  57), "#F75F2C"),
        "bright_orange":  (( 62, 100,  76), ( 30, 100,  65), "#FFA44A"),
        "bright_yellow":  (( 92, 100,  75), ( 49, 100,  44), "#DEB400"),
        "bright_green":   ((158, 100,  58), (158, 100,  33), "#00A668"),
        "bright_cyan":    ((201, 100,  58), (183, 100,  33), "#00A0A8"),
        "bright_blue":    ((246,  85,  60), (206,  74,  55), "#3596E1"),
        "bright_purple":  ((271,  87,  61), (228,  86,  70), "#6F8AF4"),
        "bright_magenta": ((350,  74,  63), (328,  70,  64), "#E363A7"),
    },

    "light": {  # light, warm
        "base00":         (( 66,  52,  97), (251, 246, 237), "#FBF6ED"),
        "base01":         (( 68,  14,  92), (236, 232, 224), "#ECE8E0"),
        "base02":         ((  0,   0,  85), (212, 212, 212), "#D4D4D4"),
        "base03":         ((  0,   0,  77), (190, 190, 190), "#BEBEBE"),
        "base04":         ((  0,   0,  60), (145, 145, 145), "#919191"),
        "base05":         ((  0,   0,  40), ( 94,  94,  94), "#5E5E5E"),
        "base06":         ((  0,   0,  25), ( 59,  59,  59), "#3B3B3B"),
        "base07":         ((  0,   0,   9), ( 25,  25,  25), "#191919"),
        "red":            (( 15,  70,  40), (164,  59,  49), "#A43B31"),
        "orange":         (( 30, 100,  50), (188,  92,   0), "#BC5C00"),
        "yellow":         (( 50, 100,  65), (211, 145,   0), "#D39100"),
        "green":          ((110,  90,  45), ( 82, 117,  29), "#52751D"),
        "cyan":           ((200,  90,  50), ( 38, 131, 137), "#268389"),
        "blue":           ((250,  80,  40), ( 47,  96, 153), "#2F6099"),
        "purple":         ((300,  60,  40), (135,  67, 146), "#874392"),
        "magenta":        ((  0,  70,  40), (167,  52,  84), "#A73454"),
        "bright_red":     (( 15,  70,  50), (205,  76,  64), "#CD4C40"),
        "bright_orange":  (( 30, 100,  65), (247, 123,   0), "#F77B00"),
        "bright_yellow":  (( 50, 100,  70), (228, 157,   0), "#E49D00"),
        "bright_green":   ((110,  90,  55), (102, 144,  38), "#669026"),
        "bright_cyan":    ((200,  90,  55), ( 43, 145, 151), "#2B9197"),
        "bright_blue":    ((250,  80,  50), ( 61, 121, 191), "#3D79BF"),
        "bright_purple":  ((300,  60,  50), (169,  86, 183), "#A956B7"),
        "bright_magenta": ((  0,  70,  50), (208,  66, 106), "#D0426A"),
    },
}
# fmt: on

ITERM_COLORS = {
    "link_color": "#005BBB",
    "badge_color": "#FF2600",
    "cursor_guide_color": "#B3ECFF",
}

BACKGROUND = "base00"
TEXT = "base05"
CURSOR = "base05"
CURSOR_TEXT = "base00"
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


class Okhsl(NamedTuple):
    h: float  # 0-360
    s: float  # 0-360
    l: float  # 0-100


class HSL(NamedTuple):
    h: float  # 0-360
    s: float  # 0-360
    l: float  # 0-100


class RGB(NamedTuple):
    r: int  # 0-255
    g: int  # 0-255
    b: int  # 0-255


@attr.frozen
class Color:
    c: coloraide.Color

    @classmethod
    def from_tuple(cls, space: str, colors: Colors) -> "Color":
        match space:
            case "okhsl":
                h, s, l = colors[0]
                c = coloraide.Color("okhsl", (h, s / 100, l / 100))
                assert c.convert("srgb").to_string(fit=False) == c.convert("srgb").to_string(fit=True)
            case "hsl":
                h, s, l = colors[1]
                c = coloraide.Color("hsl", (h, s / 100, l / 100)).convert("okhsl")
            case "hex":
                c = coloraide.Color(colors[2])
                c = c.convert("okhsl")
            case _:
                raise ValueError(f"Invalid color space: {space}")

        if math.isnan(c.get("h")):
            c.set("h", 0)
        return cls(c)

    def pretty_str(self) -> str:
        """
        Returns a pretty and colorful representation of this color.
        """
        okhsl = self.okhsl
        hsl = self.hsl
        rgb = ";".join(str(i) for i in self.rgb)
        return (
            f"\033[1m\033[38;2;{rgb}m"
            f"("
            f"({okhsl.h:3}, {okhsl.s:3}, {okhsl.l:3}), "
            f"({hsl.h:3}, {hsl.s:3}, {hsl.l:3}), "
            f'"{self.hex}"'
            f")"
            f"\033[0m"
        )

    @property
    def okhsl(self) -> Okhsl:
        """
        Return a tuple of Okhsl components in the ranges ([0, 360], [0, 100], [0, 100]).
        """
        h, s, l = self.c[:3]
        h, s, l = round(h), round(s * 100), round(l * 100)
        return Okhsl(h, s, l)

    @property
    def hsl(self) -> HSL:
        """
        Return a tuple of HSL components in the ranges ([0, 360], [0, 100], [0, 100]).
        """
        h, s, l = self.c.convert("hsl")[:3]
        h, s, l = round(h), round(s * 100), round(l * 100)
        return HSL(h, s, l)

    @property
    def rgb(self) -> RGB:
        """
        Return a tuple of RGB components in the ranges ([0, 255], [0, 255], [0, 255]).
        """
        return RGB(*[round(i * 255) for i in self.c.convert("srgb")[:3]])

    @property
    def hex(self) -> str:
        """
        Return an RGB hex string.
        """
        return self.c.convert("srgb").to_string(hex=True, upper=True)

    def to_xterm256(self, term_colors: list[str]) -> int:
        """
        Convert values between RGB hex codes and xterm-256 color codes.

        Resources:
        * http://en.wikipedia.org/wiki/8-bit_color
        * http://en.wikipedia.org/wiki/ANSI_escape_code
        * /usr/share/X11/rgb.txt

        """

        def product(codes: list["str"]) -> list[str]:
            """Calculate product of *codes* for RGB channels."""
            return [f"{i}{j}{k}" for i in codes for j in codes for k in codes]

        def distance(item: Tuple[str, int]) -> float:
            """Calculate distance between *item* and current color."""
            c = coloraide.Color(item[0])
            return self.c.distance(c)

        increments = ["00", "5F", "87", "AF", "D7", "FF"]
        xterm_colors = product(increments)  # Colors
        xterm_colors += [f"{i:02X}" * 3 for i in range(8, 239, 10)]  # Gray tones

        hex_color_lut = {c: i for i, c in enumerate(term_colors)}
        for a, v in enumerate(xterm_colors, start=16):
            hex_color_lut[f"#{v}"] = a

        if self.hex in hex_color_lut:
            # Return exact matches directly
            return hex_color_lut[self.hex]

        # Calculate distance of all colors to current color and return best result
        candidates = list(hex_color_lut.items())[16:]
        candidates = sorted(candidates, key=distance)
        return candidates[0][1]


def render(template_file: str, context: dict[str, Any]) -> str:
    env = jinja2.Environment(trim_blocks=True, lstrip_blocks=True, keep_trailing_newline=True)
    template = TEMPLATE_DIR.joinpath(template_file).read_text()
    return env.from_string(template).render(context)


def convert_colors_from(space: str, colors: dict[str, Colors]) -> dict[str, Color]:
    return {name: Color.from_tuple(space, value) for name, value in colors.items()}


def print_colors(colors: dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print("    colors = {")
    for name, color in colors.items():
        spaces = " " * (max_len - len(name) + 1)
        print(f'        "{name}":{spaces}{color.pretty_str()},')
    print("    }")


def render_vim_colors(all_colors: dict[str, dict[str, Color]]) -> None:
    context: dict[str, Any] = {
        "background": BACKGROUND,
        "text": TEXT,
        "cursor": CURSOR,
        "cursor_text": CURSOR_TEXT,
        "term_colors": TERM_COLORS,
    }
    for mode, colors in all_colors.items():
        # GUI colors
        context[f"colors_{mode}"] = colors
        # CTERM colors
        term_colors = [colors[c].hex for c in TERM_COLORS]
        context[f"cterm_colors_{mode}"] = {
            n: c.to_xterm256(term_colors) for n, c in colors.items()
        }

    pattern = (
        r'(" Generated color values \{\{\{\n).*\n(" \}\}\} Generated color values\n)'
    )
    new_data = render("stylo.vim.j2", context)

    stylo_vim = Path("_vim/colors/stylo.vim")
    data = stylo_vim.read_text()
    data = re.sub(pattern, rf"\1{new_data}\2", data, flags=re.DOTALL)
    stylo_vim.write_text(data)


def render_iterm_colors(all_colors: dict[str, dict[str, Color]]) -> None:
    iterm = {
        key: Color(coloraide.Color(val)) for key, val in ITERM_COLORS.items()
    }
    for mode, colors in all_colors.items():
        color_list = [
            (f"Ansi {i} Color", colors[name], 1.0) for i, name in enumerate(TERM_COLORS)
        ]
        color_list.append(("Background Color", colors[BACKGROUND], 1.0))
        color_list.append(("Foreground Color", colors[TEXT], 1.0))
        color_list.append(("Bold Color", colors[TEXT], 1.0))
        color_list.append(("Cursor Color", colors[CURSOR], 1.0))
        color_list.append(("Cursor Text Color", colors[CURSOR_TEXT], 1.0))
        color_list.append(("Cursor Guide Color", iterm["cursor_guide_color"], 0.25))
        color_list.append(("Selection Color", colors["base02"], 1.0))
        color_list.append(("Selected Text Color", colors["base07"], 1.0))
        color_list.append(("Link Color", iterm["link_color"], 1.0))
        color_list.append(("Badge Color", iterm["badge_color"], 0.5))

        context = {"colors": sorted(color_list)}
        data = render("Stylo.itermcolors.j2", context)
        Path(f"{THEME_NAME[mode]}.itermcolors").write_text(data)


def render_konsole_scheme(all_colors: dict[str, dict[str, Colors]]) -> None:
    variations = ["", "Intense", "Faint"]

    for mode, colors in all_colors.items():
        cmap = {}
        for title, cname in [("Background", BACKGROUND), ("Foreground", TEXT)]:
            for var in variations:
                cmap[f"{title}{var}"] = colors[cname]
        for i, cname in enumerate(TERM_COLORS[:8]):
            cmap[f"Color{i}"] = colors[cname]
            cmap[f"Color{i}Intense"] = colors[TERM_COLORS[i + 8]]
            cmap[f"Color{i}Faint"] = colors[cname]

        context = {
            "name": THEME_NAME[mode],
            "colors": cmap,
        }
        data = render("Stylo.colorscheme.j2", context)
        Path(f"{THEME_NAME[mode]}.colorscheme").write_text(data)


def render_tmtheme() -> None:
    pass
    # context = {
    #     "theme_name": "Stylo",
    #     "uuid": uuid.uuid4(),
    # }
    # for mode, colors in COLORS.items()
    #     data = render("Stylo.tmtheme.j2", context)
    #     Path(f"{THEME_NAME[mode]}.colorscheme").write_text(data)


def render_windows_terminal_settings(all_colors: dict[str, dict[str, Color]]) -> None:
    colors = {}
    names = [
        "black",
        "red",
        "green",
        "yellow",
        "blue",
        "purple",
        "cyan",
        "white",
        "brightBlack",
        "brightRed",
        "brightGreen",
        "brightYellow",
        "brightBlue",
        "brightPurple",
        "brightCyan",
        "brightWhite",
    ]
    for theme, theme_colors in all_colors.items():
        ctx_colors = {
            "name": THEME_NAME[theme],
            "foreground": theme_colors[TEXT].hex,
            "background": theme_colors[BACKGROUND].hex,
            "cursorColor": theme_colors[CURSOR].hex,
        }
        for name, cname in zip(names, TERM_COLORS):
            ctx_colors[name] = theme_colors[cname].hex
        colors[theme] = ctx_colors

    context = {
        "default_theme": THEME_NAME["dark"],
        "colors": colors,
    }
    data = render("windows-terminal-settings.json.j2", context)
    Path("windows-terminal-settings.json").write_text(data)


@click.command()
@click.argument(
    "mode",
    type=click.Choice(["dark", "light"]),
    default=subprocess.check_output(["dm", "get"], text=True).strip(),
)
def main(mode):
    colors = {
        mode: convert_colors_from("hex", mode_colors)
        for mode, mode_colors in COLORS.items()
    }
    print_colors(colors[mode])

    render_vim_colors(colors)
    render_iterm_colors(colors)
    render_konsole_scheme(colors)
    # render_tmtheme(colors)
    render_windows_terminal_settings(colors)


if __name__ == "__main__":
    main()  # pylint: disable=no-value-for-parameter
