module Color exposing (palette)

import Css


palette : { turkishRose : Css.Color, apache : Css.Color, flatBlue : Css.Color }
palette =
    { turkishRose = Css.hex "#BF6F94"
    , apache = Css.hex "#DFC370"
    , flatBlue = Css.hex "#3F76A6"
    }
