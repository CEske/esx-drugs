ConfigServer = {
    stoffer = {
        {
            price = 150,
            favoritzone = 'DELBE',
            drug = "cannabis",
        }
    },
    maksimalPoint = 1000, -- maksimal point i en zone
    startPoint = 0, -- startpoint i en zone
    minimalReward = 100, -- den mindste reward hvis man ejer zonen
    maksimalReward = 200, -- den højeste reward hvis man ejer zonen
    favoritMultiply = 10, -- %, hvor mange procent ekstra skal man få hvis drugget er favorit i zonen
    politiMin = 3, -- hvor mange betjente skal der mindst være for at man får mere for at sælge
    politiMulti = 10, -- %, hvor meget skal gevinsten stige med for hver betjent der er over minimumsgrænsen
    politiMaks = 10, -- hvor mange betjente skal der være på før den ikke ganger mere

    gangs = {
        'ms13',
        'taxi'
    }
}