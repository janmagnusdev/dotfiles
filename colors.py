# pylint: disable=redefined-builtin,redefined-outer-name
import re
import subprocess
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import attr
import click
import jinja2
import hsluv


@attr.frozen
class HSLuv:
    h: float  # 0-360
    s: float  # 0-360
    l: float  # 0-100


@attr.frozen
class RGB:
    r: int  # 0-255
    g: int  # 0-255
    b: int  # 0-255

    @property
    def tuple(self) -> Tuple[int, ...]:
        return attr.astuple(self)


@attr.frozen
class Color:
    hsluv: HSLuv = attr.field(converter=lambda v: v if isinstance(v, HSLuv) else HSLuv(*v))
    rgb: RGB = attr.field(converter=lambda v: v if isinstance(v, RGB) else RGB(*v))
    hex: str

    @classmethod
    def from_hsluv(cls, hsluv: HSLuv) -> "Color":
        rgb = cls.hsluv2rgb(hsluv)
        hex = cls.hsluv2hex(hsluv)
        return cls(hsluv, rgb, hex)

    @classmethod
    def from_hex(cls, hex: str) -> "Color":
        hsluv = cls.hex2hsluv(hex)
        rgb = cls.hex2rgb(hex)
        return cls(hsluv, rgb, hex)

    def pretty_str(self) -> str:
        """
        Returns a pretty and colorful representation of this color.
        """
        return (
            f"\033[1m\033[38;2;{self.rgb.r};{self.rgb.g};{self.rgb.b}m"
            f"Color("
            f"({self.hsluv.h:3}, {self.hsluv.s:3}, {self.hsluv.l:3}), "
            f"({self.rgb.r:3}, {self.rgb.g:3}, {self.rgb.b:3}), "
            f'"{self.hex}"'
            f")"
            f"\033[0m"
        )

    @staticmethod
    def hex2rgb(color: str) -> RGB:
        color = color.lstrip("#")
        return RGB(int(color[0:2], 16), int(color[2:4], 16), int(color[4:6], 16))

    @staticmethod
    def rgb2hex(color: RGB) -> str:
        return f"#{color.r:02X}{color.g:02X}{color.b:02X}"

    @staticmethod
    def hsluv2rgb(color: HSLuv) -> RGB:
        return RGB(*[round(i * 255) for i in hsluv.hsluv_to_rgb(attr.astuple(color))])

    @staticmethod
    def hsluv2hex(color: HSLuv) -> str:
        return hsluv.hsluv_to_hex(attr.astuple(color)).upper()

    @staticmethod
    def hex2hsluv(color: str) -> HSLuv:
        return HSLuv(*[round(i) for i in hsluv.hex_to_hsluv(color)])

    @staticmethod
    def hex2xterm256(color: str, term_colors: List[str]) -> int:
        """Convert values between RGB hex codes and xterm-256 color codes.

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
            rgb_a = attr.astuple(Color.hex2rgb(item[0]))
            rgb_b = attr.astuple(Color.hex2rgb(color))
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


@attr.frozen
class Style:
    fg: Optional[str] = None
    bg: Optional[str] = None
    sp: Optional[str] = None  # special (e.g.: underline, undercurl)
    bold: bool = False
    italic: bool = False
    underline: bool = False
    undercurl: bool = False
    inverse: bool = False


TEMPLATE_DIR = Path(__file__).parent.joinpath("templates")
THEME_NAME = {
    "dark": "Stylo Dark",
    "light": "Stylo Light",
}

# fmt: off
#       Color             HSLuv             RGB              HEX
COLORS = {
    "dark": {  # dark, futuristic
        "base00":         Color((230,   7,   9), ( 24,  26,  27), "#181A1B"),
        "base01":         Color((230,  15,  15), ( 35,  38,  41), "#232629"),
        "base02":         Color((230,  20,  24), ( 51,  58,  63), "#333A3F"),
        "base03":         Color((230,  30,  30), ( 60,  72,  80), "#3C4850"),
        "base04":         Color((230,  35,  40), ( 78,  97, 109), "#4E616D"),
        "base05":         Color((230,  35,  70), (144, 176, 196), "#90B0C4"),
        "base06":         Color((230,  50,  86), (194, 219, 235), "#C2DBEB"),
        "base07":         Color((230,  45,  93), (226, 236, 244), "#E2ECF4"),
        "red":            Color(( 20,  60,  65), (225, 133, 117), "#E18575"),
        "orange":         Color(( 40,  75,  65), (214, 142,  78), "#D68E4E"),
        "yellow":         Color(( 65,  85,  65), (187, 154,  60), "#BB9A3C"),
        "green":          Color((145,  50,  65), (112, 170, 137), "#70AA89"),
        "cyan":           Color((200,  70,  65), ( 91, 170, 176), "#5BAAB0"),
        "blue":           Color((245,  55,  65), (116, 161, 212), "#74A1D4"),
        "purple":         Color((260,  50,  65), (145, 155, 208), "#919BD0"),
        "magenta":        Color((340,  45,  63), (205, 130, 166), "#CD82A6"),
        "bright_red":     Color(( 20,  90,  60), (247,  95,  44), "#F75F2C"),
        "bright_orange":  Color(( 40, 100,  75), (255, 164,  74), "#FFA44A"),
        "bright_yellow":  Color(( 65, 100,  75), (222, 180,   0), "#DEB400"),
        "bright_green":   Color((145, 100,  60), (  0, 166, 104), "#00A668"),
        "bright_cyan":    Color((200, 100,  60), (  0, 160, 168), "#00A0A8"),
        "bright_blue":    Color((245,  90,  60), ( 53, 150, 225), "#3596E1"),
        "bright_purple":  Color((260,  90,  60), (111, 138, 244), "#6F8AF4"),
        "bright_magenta": Color((340,  70,  60), (227,  99, 167), "#E363A7"),
    },

    "light": {  # light, warm
        "base00":         Color(( 66,  52,  97), (251, 246, 237), "#FBF6ED"),
        "base01":         Color(( 68,  14,  92), (236, 232, 224), "#ECE8E0"),
        "base02":         Color((  0,   0,  85), (212, 212, 212), "#D4D4D4"),
        "base03":         Color((  0,   0,  77), (190, 190, 190), "#BEBEBE"),
        "base04":         Color((  0,   0,  60), (145, 145, 145), "#919191"),
        "base05":         Color((  0,   0,  40), ( 94,  94,  94), "#5E5E5E"),
        "base06":         Color((  0,   0,  25), ( 59,  59,  59), "#3B3B3B"),
        "base07":         Color((  0,   0,   9), ( 25,  25,  25), "#191919"),
        "red":            Color(( 15,  70,  40), (164,  59,  49), "#A43B31"),
        "orange":         Color(( 30, 100,  50), (188,  92,   0), "#BC5C00"),
        "yellow":         Color(( 50, 100,  65), (211, 145,   0), "#D39100"),
        "green":          Color((110,  90,  45), ( 82, 117,  29), "#52751D"),
        "cyan":           Color((200,  90,  50), ( 38, 131, 137), "#268389"),
        "blue":           Color((250,  80,  40), ( 47,  96, 153), "#2F6099"),
        "purple":         Color((300,  60,  40), (135,  67, 146), "#874392"),
        "magenta":        Color((  0,  70,  40), (167,  52,  84), "#A73454"),
        "bright_red":     Color(( 15,  70,  50), (205,  76,  64), "#CD4C40"),
        "bright_orange":  Color(( 30, 100,  65), (247, 123,   0), "#F77B00"),
        "bright_yellow":  Color(( 50, 100,  70), (228, 157,   0), "#E49D00"),
        "bright_green":   Color((110,  90,  55), (102, 144,  38), "#669026"),
        "bright_cyan":    Color((200,  90,  55), ( 43, 145, 151), "#2B9197"),
        "bright_blue":    Color((250,  80,  50), ( 61, 121, 191), "#3D79BF"),
        "bright_purple":  Color((300,  60,  50), (169,  86, 183), "#A956B7"),
        "bright_magenta": Color((  0,  70,  50), (208,  66, 106), "#D0426A"),
    },
}
# fmt: on

ITERM_LINK_COLOR = Color.from_hex("#005bbb")
ITERM_BADGE_COLOR = Color.from_hex("#ff2600")
ITERM_CURSOR_GUIDE_COLOR = Color.from_hex("#b3ecff")

BACKGROUND = "base00"
TEXT = "base05"
CURSOR = "base05"
CURSOR_TEXT = "base00"
# SCOPES = {
#     "cursor_line": Style(bg="base01"),
#     "cursor_line_nr": Style(bg="base01", fg="red"),
#     "line_nr": Style(fg="base03"),
# }
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


def render(template_file: str, context: Dict[str, Any]) -> str:
    env = jinja2.Environment(trim_blocks=True, lstrip_blocks=True, keep_trailing_newline=True)
    template = TEMPLATE_DIR.joinpath(template_file).read_text()
    return env.from_string(template).render(context)


def convert_colors_from(attr: str, colors: Dict[str, Color]) -> None:
    for name, color in colors.items():
        if attr == "hex":
            colors[name] = Color.from_hex(color.hex)
        elif attr == "hsluv":
            colors[name] = Color.from_hsluv(color.hsluv)
        else:
            raise ValueError(f"Cannot convert from attribute '{attr}'")


def print_colors(colors: Dict[str, Color]) -> None:
    max_len = max(len(name) for name in colors)
    print("    colors = {")
    for name, color in colors.items():
        spaces = " " * (max_len - len(name) + 1)
        print(f'        "{name}":{spaces}{color.pretty_str()},')
    print("    }")


def render_vim_colors() -> None:
    context: Dict[str, Any] = {
        "background": BACKGROUND,
        "text": TEXT,
        "cursor": CURSOR,
        "cursor_text": CURSOR_TEXT,
        "term_colors": TERM_COLORS,
    }
    for mode, colors in COLORS.items():
        # GUI colors
        context[f"colors_{mode}"] = colors
        # CTERM colors
        term_colors = [colors[c].hex for c in TERM_COLORS]
        context[f"cterm_colors_{mode}"] = {
            n: Color.hex2xterm256(c.hex, term_colors) for n, c in colors.items()
        }
    # # Scope styles
    # for scope_name, style in SCOPES.items():
    #     fg = style.fg or "none"
    #     bg = style.bg or "none"
    #     sp = style.sp or "none"
    #     attrs = ["bold", "inverse", "underline", "undercurl"]
    #     attrs = [f"s:{a}" for a in attrs if getattr(style, a)]
    #     attr_str = '.",".'.join(attrs)
    #     context[scope_name] = f"s:{fg}, s:{bg}, s:{sp}, {attr_str}"

    pattern = r'(" Generated color values \{\{\{\n).*\n(" \}\}\} Generated color values\n)'
    new_data = render("stylo.vim.j2", context)

    stylo_vim = Path("_vim/colors/stylo.vim")
    data = stylo_vim.read_text()
    data = re.sub(pattern, rf"\1{new_data}\2", data, flags=re.DOTALL)
    stylo_vim.write_text(data)


def render_iterm_colors() -> None:
    for mode, colors in COLORS.items():
        color_list = [
            (f"Ansi {i} Color", colors[name], 1.0) for i, name in enumerate(TERM_COLORS)
        ]
        color_list.append(("Background Color", colors[BACKGROUND], 1.0))
        color_list.append(("Foreground Color", colors[TEXT], 1.0))
        color_list.append(("Bold Color", colors[TEXT], 1.0))
        color_list.append(("Cursor Color", colors[CURSOR], 1.0))
        color_list.append(("Cursor Text Color", colors[CURSOR_TEXT], 1.0))
        color_list.append(("Cursor Guide Color", ITERM_CURSOR_GUIDE_COLOR, 0.25))
        color_list.append(("Selection Color", colors["base02"], 1.0))
        color_list.append(("Selected Text Color", colors["base07"], 1.0))
        color_list.append(("Link Color", ITERM_LINK_COLOR, 1.0))
        color_list.append(("Badge Color", ITERM_BADGE_COLOR, 0.5))

        context = {"colors": sorted(color_list)}
        data = render("Stylo.itermcolors.j2", context)
        Path(f"{THEME_NAME[mode]}.itermcolors").write_text(data)


def render_konsole_scheme() -> None:
    variations = ["", "Intense", "Faint"]

    for mode, colors in COLORS.items():
        cmap = {}
        for title, cname in [("Background", BACKGROUND), ("Foreground", TEXT)]:
            for var in variations:
                cmap[f"{title}{var}"] = colors[cname]
        for i, cname in enumerate(TERM_COLORS[:8]):
            cmap[f"Color{i}"] = colors[cname]
            cmap[f"Color{i}Intense"] = colors[TERM_COLORS[i + 8]]
            hsluv = colors[cname].hsluv
            hsluv = attr.evolve(hsluv, s=hsluv.s - 20)
            cmap[f"Color{i}Faint"] = Color.from_hsluv(hsluv)

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


def render_windows_terminal_settings() -> None:
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
    for theme, theme_colors in COLORS.items():
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
    colors = COLORS[mode]
    convert_colors_from("hsluv", colors)
    print_colors(colors)

    render_vim_colors()
    render_iterm_colors()
    render_konsole_scheme()
    # render_tmtheme()
    render_windows_terminal_settings()


if __name__ == "__main__":
    main()  # pylint: disable=no-value-for-parameter
