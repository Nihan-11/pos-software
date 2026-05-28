from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class AnimationConfig:
    quick: int = 120
    normal: int = 240
    smooth: int = 360
    dramatic: int = 540


ANIMATIONS = AnimationConfig()
