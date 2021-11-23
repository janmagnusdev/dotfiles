#!/usr/bin/env python3
import asyncio
import subprocess
from pathlib import Path

import iterm2


GIT_CONFIG = Path.home().joinpath(".dotfiles", "_gitconfig")


async def main(connection):
    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()

            # Themes have space-delimited attributes, one of which will be light or dark.
            parts = theme.split(" ")
            if "dark" in parts:
                preset = await iterm2.ColorPreset.async_get(connection, "Stylo Dark")
                mode = "dark"
            else:
                preset = await iterm2.ColorPreset.async_get(connection, "Stylo Light")
                mode = "light"

            # Update the list of all profiles and iterate over them.
            profiles = await iterm2.PartialProfile.async_query(connection)
            for partial in profiles:
                # Fetch the full profile and then set the color preset in it.
                # profile = await partial.async_get_full_profile()
                # await profile.async_set_color_preset(preset)
                await partial.async_set_color_preset(preset)

            update_git_config(mode)


def update_git_config(mode: str) -> None:
    cmd = [
        "/usr/local/bin/sd",
        "delta --(light|dark)",
        f"delta --{mode}",
        str(GIT_CONFIG),
    ]
    subprocess.run(cmd, check=False)


iterm2.run_forever(main)
