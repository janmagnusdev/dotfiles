import math
import re
import subprocess
from pathlib import Path
from typing import Any, NamedTuple, Tuple

import attrs
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
        # This is a deeper blue and looks "cooler",
        # but it also makes the text less legible:
        # "base00":         ((250,  45,  11), (210,  52,  10), "#0C1A27"),
        # "base01":         ((250,  50,  16), (210,  51,  15), "#13263A"),
        # "base02":         ((250,  60,  25), (210,  55,  23), "#1B3C5C"),
        # "base03":         ((250,  20,  30), (211,  18,  28), "#3A4755"),
        # "base04":         ((250,  20,  40), (211,  17,  38), "#506071"),
        # "base05":         ((250,  28,  70), (211,  31,  69), "#96AEC7"),
        # "base06":         ((250,  40,  86), (211,  48,  86), "#C8DAEC"),
        # "base07":         ((250,  40,  93), (211,  49,  93), "#E4ECF6"),
        "base00":         ((250,   4,  11), (211,   5,  10), "#18191A"),
        "base01":         ((250,   7,  16), (211,   8,  15), "#222528"),
        "base02":         ((250,  10,  25), (211,  10,  23), "#353B41"),
        "base03":         ((250,  15,  30), (211,  14,  28), "#3D4751"),
        "base04":         ((250,  19,  50), (211,  16,  38), "#516070"),
        "base05":         ((250,  28,  70), (211,  31,  69), "#96AEC7"),
        "base06":         ((250,  41,  86), (211,  49,  86), "#C8DAEC"),
        "base07":         ((250,  36,  93), (211,  44,  93), "#E4ECF5"),
        "red":            (( 15,  50,  62), (355,  45,  64), "#CD7B82"),
        "orange":         (( 50,  45,  65), ( 21,  45,  61), "#C88F70"),
        "yellow":         (( 92,  55,  65), ( 45,  37,  52), "#B29D5A"),
        "green":          ((160,  50,  65), (149,  31,  55), "#68B08A"),
        "cyan":           ((200,  50,  65), (183,  36,  53), "#5CADB2"),
        "blue":           ((250,  55,  65), (210,  56,  64), "#70A3D6"),
        "purple":         ((294,  55,  65), (254,  48,  71), "#A191D9"),
        "magenta":        ((320,  55,  65), (289,  40,  66), "#BE85CB"),
        "bright_red":     (( 15,  90,  60), (350,  88,  62), "#F34A67"),
        "bright_orange":  (( 50,  92,  65), ( 24,  85,  55), "#EE7928"),
        "bright_yellow":  (( 92,  95,  70), ( 48,  84,  44), "#CDA712"),
        "bright_green":   ((160,  90,  60), (154,  58,  42), "#2DA974"),
        "bright_cyan":    ((200,  90,  62), (183,  71,  40), "#1DAAB1"),
        "bright_blue":    ((250,  90,  60), (209,  84,  57), "#3395ED"),
        "bright_purple":  ((294,  85,  57), (258,  85,  68), "#9369F2"),
        "bright_magenta": ((320,  75,  57), (289,  56,  58), "#BA59D0"),
        "dim_red":        (( 15,  87,  30), (346,  73,  29), "#80142C"),
        "dim_orange":     (( 50,  90,  33), ( 26,  89,  25), "#793807"),
        "dim_yellow":     (( 92,  95,  34), ( 48,  91,  20), "#604D05"),
        "dim_green":      ((160,  96,  31), (156,  79,  19), "#0A5638"),
        "dim_cyan":       ((200,  96,  33), (183,  91,  19), "#04585C"),
        "dim_blue":       ((250,  94,  32), (206,  93,  27), "#054C85"),
        "dim_purple":     ((294,  78,  29), (261,  56,  35), "#4B288C"),
        "dim_magenta":    ((320,  75,  28), (289,  57,  27), "#601E6E"),
    },

    "light": {  # light, warm
        "base00":         (( 82,  54,  97), ( 38,  64,  96), "#FBF6ED"),
        "base01":         (( 85,  20,  92), ( 40,  24,  90), "#ECE8E0"),
        "base02":         ((  0,   0,  85), (224,   0,  83), "#D4D4D4"),
        "base03":         ((  0,   0,  80), (224,   0,  75), "#BEBEBE"),
        "base04":         ((  0,   0,  60), (224,   0,  57), "#919191"),
        "base05":         ((  0,   0,  40), (224,   0,  37), "#5E5E5E"),
        "base06":         ((  0,   0,  26), (224,   0,  24), "#3C3C3C"),
        "base07":         ((  0,   0,  11), (224,   0,  10), "#191919"),
        "red":            (( 29,  76,  42), (  6,  54,  42), "#A43C31"),
        "orange":         (( 53, 100,  51), ( 30, 100,  36), "#BA5C00"),
        "yellow":         (( 76, 100,  62), ( 41, 100,  40), "#D59200"),
        "green":          ((129,  88,  44), ( 84,  60,  29), "#52751D"),
        "cyan":           ((201,  78,  49), (183,  57,  34), "#268389"),
        "blue":           ((254,  65,  40), (212,  53,  39), "#2F5F98"),
        "purple":         ((322,  62,  42), (292,  37,  42), "#874292"),
        "magenta":        ((  8,  73,  42), (344,  53,  42), "#A63352"),
        "bright_red":     (( 29,  85,  50), (  5,  59,  50), "#CA4134"),
        "bright_orange":  (( 53,  95,  62), ( 28,  83,  48), "#E27415"),
        "bright_yellow":  (( 76, 100,  72), ( 41, 100,  46), "#EAA000"),
        "bright_green":   ((129, 100,  53), ( 80, 100,  28), "#618F00"),
        "bright_cyan":    ((201,  95,  52), (183,  84,  32), "#0D8D94"),
        "bright_blue":    ((254,  80,  50), (212,  62,  49), "#2F78CA"),
        "bright_purple":  ((322,  70,  50), (292,  41,  50), "#A54BB4"),
        "bright_magenta": ((  8,  74,  50), (344,  53,  51), "#C44164"),
        "dim_red":        (( 29,  45,  85), (  9,  51,  85), "#ECCCC7"),
        "dim_orange":     (( 53,  45,  85), ( 23,  55,  83), "#ECCEBC"),
        "dim_yellow":     (( 76,  45,  85), ( 35,  54,  81), "#E8D1B1"),
        "dim_green":      ((129,  45,  85), ( 90,  40,  78), "#C8DDB1"),
        "dim_cyan":       ((201,  45,  85), (184,  48,  78), "#AEDFE2"),
        "dim_blue":       ((254,  45,  85), (213,  53,  85), "#C5D6ED"),
        "dim_purple":     ((322,  45,  85), (292,  35,  85), "#E3CCE6"),
        "dim_magenta":    ((  8,  45,  85), (351,  49,  86), "#EDCBD0"),
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
TERM_COLORS_EXTRA = [
    "base01",
    "dim_red",
    "dim_green",
    "dim_yellow",
    "dim_blue",
    "dim_purple",
    "dim_cyan",
    "base06",
]


class Okhsl(NamedTuple):
    h: float  # 0-360
    s: float  # 0-100
    l: float  # 0-100


class HSL(NamedTuple):
    h: float  # 0-360
    s: float  # 0-100
    l: float  # 0-100


class RGB(NamedTuple):
    r: int  # 0-255
    g: int  # 0-255
    b: int  # 0-255


@attrs.frozen
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
            # f"\033[1m\033[38;2;{rgb}m"
            f"\033[38;2;{rgb}m"
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
    def hsl_html(self) -> str:
        """
        Return an HTML HSL string, e.g. ``hsl(6, 54%, 42%)``.
        """
        h, s, l = self.hsl
        return f"hsl({h:3}, {s:3}%, {l:3}%)"

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


def render_html_preview(all_colors: dict[str, dict[str, Color]]) -> None:
    context: dict[str, Any] = {
        "background": BACKGROUND,
        "text": TEXT,
    }
    for mode, colors in all_colors.items():
        # GUI colors
        context[f"colors_{mode}"] = colors

    start_marker = "/* Generated color values */"
    end_marker = "/* End generated color values */"
    pattern = f'({re.escape(start_marker)}\n).*\n({re.escape(end_marker)}\n)'
    new_data = render("colors.html.j2", context)

    colors_html = Path("colors.html")
    data = colors_html.read_text()
    data = re.sub(pattern, rf"\1{new_data}\2", data, flags=re.DOTALL)
    colors_html.write_text(data)


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


def render_neovim_colors(all_colors: dict[str, dict[str, Color]]) -> None:
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
        r'(-- Generated color values \{\{\{\n).*\n(-- \}\}\} Generated color values\n)'
    )
    new_data = render("stylo.lua.j2", context)

    stylo_vim = Path("nvim/lua/stefan/stylo.lua")
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


def render_konsole_scheme(all_colors: dict[str, dict[str, Color]]) -> None:
    variations = ["", "Intense", "Faint"]

    for mode, colors in all_colors.items():
        cmap = {}
        for title, cname in [("Background", BACKGROUND), ("Foreground", TEXT)]:
            for var in variations:
                cmap[f"{title}{var}"] = colors[cname]
        for i, cname in enumerate(TERM_COLORS[:8]):
            cmap[f"Color{i}"] = colors[cname]
            cmap[f"Color{i}Intense"] = colors[TERM_COLORS[i + 8]]
            cmap[f"Color{i}Faint"] = colors[TERM_COLORS_EXTRA[i]]

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
@click.option(
    "--mode",
    "-m",
    type=click.Choice(["dark", "light"]),
    default=subprocess.check_output(["dm", "get"], text=True).strip(),
    show_default=True,
)
@click.option(
    "--space",
    "-s",
    type=click.Choice(["hex", "hsl", "okhsl"]),
    default="okhsl",
    show_default=True,
)
def main(mode: str, space: str) -> None:
    colors = {
        mode: convert_colors_from(space, mode_colors)
        for mode, mode_colors in COLORS.items()
    }
    print_colors(colors[mode])

    render_html_preview(colors)
    render_vim_colors(colors)
    render_neovim_colors(colors)
    render_iterm_colors(colors)
    render_konsole_scheme(colors)
    # render_tmtheme(colors)
    render_windows_terminal_settings(colors)


if __name__ == "__main__":
    main()  # pylint: disable=no-value-for-parameter
