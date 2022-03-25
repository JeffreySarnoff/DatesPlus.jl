# This file is a part of Julia. License is MIT: https://julialang.org/license

module QueryTests

using Test
using Dates

Jan = DatesPlus.DateTime(2013, 1, 1) # Tuesday
Feb = DatesPlus.DateTime(2013, 2, 2) # Saturday
Mar = DatesPlus.DateTime(2013, 3, 3) # Sunday
Apr = DatesPlus.DateTime(2013, 4, 4) # Thursday
May = DatesPlus.DateTime(2013, 5, 5) # Sunday
Jun = DatesPlus.DateTime(2013, 6, 7) # Friday
Jul = DatesPlus.DateTime(2013, 7, 7) # Sunday
Aug = DatesPlus.DateTime(2013, 8, 8) # Thursday
Sep = DatesPlus.DateTime(2013, 9, 9) # Monday
Oct = DatesPlus.DateTime(2013, 10, 10) # Thursday
Nov = DatesPlus.DateTime(2013, 11, 11) # Monday
Dec = DatesPlus.DateTime(2013, 12, 11) # Wednesday
monthnames = ["January", "February", "March", "April",
                "May", "June", "July", "August", "September",
                "October", "November", "December"]
daysofweek = [DatesPlus.Tue, DatesPlus.Sat, DatesPlus.Sun, DatesPlus.Thu, DatesPlus.Sun, DatesPlus.Fri,
              DatesPlus.Sun, DatesPlus.Thu, DatesPlus.Mon, DatesPlus.Thu, DatesPlus.Mon, DatesPlus.Wed]
dows = ["Tuesday", "Saturday", "Sunday", "Thursday", "Sunday", "Friday",
        "Sunday", "Thursday", "Monday", "Thursday", "Monday", "Wednesday"]
daysinmonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
@testset "Name functions" begin
    for (i, dt) in enumerate([Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec])
        @test DatesPlus.month(dt) == i
        @test DatesPlus.monthname(dt) == monthnames[i]
        @test DatesPlus.monthname(i) == monthnames[i]
        @test DatesPlus.monthabbr(dt) == monthnames[i][1:3]
        @test DatesPlus.monthabbr(i) == monthnames[i][1:3]
        @test DatesPlus.dayofweek(dt) == daysofweek[i]
        @test DatesPlus.dayname(dt) == dows[i]
        @test DatesPlus.dayname(DatesPlus.dayofweek(dt)) == dows[i]
        @test DatesPlus.dayabbr(dt) == dows[i][1:3]
        @test DatesPlus.dayabbr(DatesPlus.dayofweek(dt)) == dows[i][1:3]
        @test DatesPlus.daysinmonth(dt) == daysinmonth[i]
    end
end
@testset "Customizing locale" begin
    DatesPlus.LOCALES["french"] = DatesPlus.DateLocale(
        ["janvier", "février", "mars", "avril", "mai", "juin",
         "juillet", "août", "septembre", "octobre", "novembre", "décembre"],
        ["janv", "févr", "mars", "avril", "mai", "juin",
         "juil", "août", "sept", "oct", "nov", "déc"],
        ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"],
        [""],
    )
    @test DatesPlus.dayname(Nov; locale="french") == "lundi"
    @test DatesPlus.dayname(Jan; locale="french") == "mardi"
    @test DatesPlus.dayname(Dec; locale="french") == "mercredi"
    @test DatesPlus.dayname(Apr; locale="french") == "jeudi"
    @test DatesPlus.dayname(Jun; locale="french") == "vendredi"
    @test DatesPlus.dayname(Feb; locale="french") == "samedi"
    @test DatesPlus.dayname(May; locale="french") == "dimanche"

    @test DatesPlus.monthname(Jan; locale="french") == "janvier"
    @test DatesPlus.monthname(Feb; locale="french") == "février"
    @test DatesPlus.monthname(Mar; locale="french") == "mars"
    @test DatesPlus.monthname(Apr; locale="french") == "avril"
    @test DatesPlus.monthname(May; locale="french") == "mai"
    @test DatesPlus.monthname(Jun; locale="french") == "juin"
    @test DatesPlus.monthname(Jul; locale="french") == "juillet"
    @test DatesPlus.monthname(Aug; locale="french") == "août"
    @test DatesPlus.monthname(Sep; locale="french") == "septembre"
    @test DatesPlus.monthname(Oct; locale="french") == "octobre"
    @test DatesPlus.monthname(Nov; locale="french") == "novembre"
    @test DatesPlus.monthname(Dec; locale="french") == "décembre"
end
@testset "leap years" begin
    @test DatesPlus.isleapyear(DatesPlus.DateTime(1900)) == false
    @test DatesPlus.isleapyear(DatesPlus.DateTime(2000)) == true
    @test DatesPlus.isleapyear(DatesPlus.DateTime(2004)) == true
    @test DatesPlus.isleapyear(DatesPlus.DateTime(2008)) == true
    @test DatesPlus.isleapyear(DatesPlus.DateTime(0)) == true
    @test DatesPlus.isleapyear(DatesPlus.DateTime(1)) == false
    @test DatesPlus.isleapyear(DatesPlus.DateTime(-1)) == false
    @test DatesPlus.isleapyear(DatesPlus.DateTime(4)) == true
    @test DatesPlus.isleapyear(DatesPlus.DateTime(-4)) == true

    @test DatesPlus.daysinyear(2000) == 366
    @test DatesPlus.daysinyear(2001) == 365
    @test DatesPlus.daysinyear(2000) == 366
    @test DatesPlus.daysinyear(2001) == 365

    @test DatesPlus.daysinyear(DatesPlus.Date(2000)) == 366
    @test DatesPlus.daysinyear(DatesPlus.Date(2001)) == 365
    @test DatesPlus.daysinyear(DatesPlus.DateTime(2000)) == 366
    @test DatesPlus.daysinyear(DatesPlus.DateTime(2001)) == 365
end
@testset "dayofweek" begin
    # Days of week from Monday = 1 to Sunday = 7
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 22)) == 7
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 23)) == 1
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 24)) == 2
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 25)) == 3
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 26)) == 4
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 27)) == 5
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 28)) == 6
    @test DatesPlus.dayofweek(DatesPlus.DateTime(2013, 12, 29)) == 7
end
@testset "daysofweekinmonth" begin
    # There are 5 Sundays in December, 2013
    @test DatesPlus.daysofweekinmonth(DatesPlus.DateTime(2013, 12, 1)) == 5
    # There are 4 Sundays in November, 2013
    @test DatesPlus.daysofweekinmonth(DatesPlus.DateTime(2013, 11, 24)) == 4

    @test DatesPlus.dayofweekofmonth(DatesPlus.DateTime(2013, 12, 1)) == 1
    @test DatesPlus.dayofweekofmonth(DatesPlus.DateTime(2013, 12, 8)) == 2
    @test DatesPlus.dayofweekofmonth(DatesPlus.DateTime(2013, 12, 15)) == 3
    @test DatesPlus.dayofweekofmonth(DatesPlus.DateTime(2013, 12, 22)) == 4
    @test DatesPlus.dayofweekofmonth(DatesPlus.DateTime(2013, 12, 29)) == 5
end
@testset "dayofyear" begin
    @test DatesPlus.dayofyear(2000, 1, 1) == 1
    @test DatesPlus.dayofyear(2004, 1, 1) == 1
    @test DatesPlus.dayofyear(20013, 1, 1) == 1
    # Leap year
    @test DatesPlus.dayofyear(2000, 12, 31) == 366
    # Non-leap year
    @test DatesPlus.dayofyear(2001, 12, 31) == 365

    @test DatesPlus.dayofyear(DatesPlus.DateTime(2000, 1, 1)) == 1
    @test DatesPlus.dayofyear(DatesPlus.DateTime(2004, 1, 1)) == 1
    @test DatesPlus.dayofyear(DatesPlus.DateTime(20013, 1, 1)) == 1
    # Leap year
    @test DatesPlus.dayofyear(DatesPlus.DateTime(2000, 12, 31)) == 366
    # Non-leap year
    @test DatesPlus.dayofyear(DatesPlus.DateTime(2001, 12, 31)) == 365
    # Test every day of a year
    dt = DatesPlus.DateTime(2000, 1, 1)
    for i = 1:366
        @test DatesPlus.dayofyear(dt) == i
        dt += DatesPlus.Day(1)
    end
    dt = DatesPlus.DateTime(2001, 1, 1)
    for i = 1:365
        @test DatesPlus.dayofyear(dt) == i
        dt += DatesPlus.Day(1)
    end
end
@testset "quarterofyear" begin
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 1, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 1, 31))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 2, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 2, 29))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 3, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 3, 31))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 4, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 4, 30)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 5, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 5, 31)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 6, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 6, 30)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 7, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 7, 31)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 8, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 8, 31)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 9, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 9, 30)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 10, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 10, 31)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 11, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 11, 30)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 12, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.Date(2000, 12, 31)) == 4

    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 1, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 1, 31))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 2, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 2, 29))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 3, 1))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 3, 31))  == 1
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 4, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 4, 30)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 5, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 5, 31)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 6, 1)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 6, 30)) == 2
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 7, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 7, 31)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 8, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 8, 31)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 9, 1)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 9, 30)) == 3
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 10, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 10, 31)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 11, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 11, 30)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 12, 1)) == 4
    @test DatesPlus.quarterofyear(DatesPlus.DateTime(2000, 12, 31)) == 4
end
@testset "dayofquarter" begin
    # Non-leap and leap year
    for y in (2014, 2020)
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 1, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 4, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 7, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 10, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 3, 31)) == 90 + isleapyear(y)
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 6, 30)) == 91
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 9, 30)) == 92
        @test DatesPlus.dayofquarter(DatesPlus.Date(y, 12, 31)) == 92
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 1, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 4, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 7, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 10, 1)) == 1
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 3, 31)) == 90 + isleapyear(y)
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 6, 30)) == 91
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 9, 30)) == 92
        @test DatesPlus.dayofquarter(DatesPlus.DateTime(y, 12, 31)) == 92
    end
end

end
