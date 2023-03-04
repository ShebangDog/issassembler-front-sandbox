module Color exposing (palette)

import Css


palette : { turkishRose : Css.Color, apache : Css.Color, flatBlue : Css.Color }
palette =
    { turkishRose = Css.hex "#BF6F94"
    , apache = Css.hex "#DFC370"
    , flatBlue = Css.hex "#3F76A6"
    }


theme : { primary : Css.Color, secondary : Css.Color, tertiary : Css.Color }
theme =
    { primary = palette.turkishRose
    , secondary = palette.flatBlue
    , tertiary = palette.apache
    }
