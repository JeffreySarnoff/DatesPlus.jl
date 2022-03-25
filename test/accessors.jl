# This file is a part of Julia. License is MIT: https://julialang.org/license

module AccessorsTest

using Dates
using Test

@testset "yearmonthday/yearmonth/monthday" begin
    # yearmonthday is the opposite of totaldays
    # taking Rata Die Day # and returning proleptic Gregorian date
    @test DatesPlus.yearmonthday(-306) == (0, 2, 29)
    @test DatesPlus.yearmonth(-306) == (0, 2)
    @test DatesPlus.monthday(-306) == (2, 29)
    @test DatesPlus.yearmonthday(-305) == (0, 3, 1)
    @test DatesPlus.yearmonth(-305) == (0, 3)
    @test DatesPlus.monthday(-305) == (3, 1)
    @test DatesPlus.yearmonthday(-2) == (0, 12, 29)
    @test DatesPlus.yearmonth(-2) == (0, 12)
    @test DatesPlus.monthday(-2) == (12, 29)
    @test DatesPlus.yearmonthday(-1) == (0, 12, 30)
    @test DatesPlus.yearmonth(-1) == (0, 12)
    @test DatesPlus.monthday(-1) == (12, 30)
    @test DatesPlus.yearmonthday(0) == (0, 12, 31)
    @test DatesPlus.yearmonth(-0) == (0, 12)
    @test DatesPlus.monthday(-0) == (12, 31)
    @test DatesPlus.yearmonthday(1) == (1, 1, 1)
    @test DatesPlus.yearmonth(1) == (1, 1)
    @test DatesPlus.monthday(1) == (1, 1)
    @test DatesPlus.yearmonthday(730120) == (2000, 1, 1)
end
@testset "year/month/day" begin
    # year, month, and day return the indivial components
    # of yearmonthday, avoiding additional calculations when possible
    @test DatesPlus.year(-1) == 0
    @test DatesPlus.month(-1) == 12
    @test DatesPlus.day(-1) == 30
    @test DatesPlus.year(0) == 0
    @test DatesPlus.month(0) == 12
    @test DatesPlus.day(0) == 31
    @test DatesPlus.year(1) == 1
    @test DatesPlus.month(1) == 1
    @test DatesPlus.day(1) == 1
    @test DatesPlus.year(730120) == 2000
    @test DatesPlus.month(730120) == 1
    @test DatesPlus.day(730120) == 1
end
@testset "totaldays/yearmonthday over many years" begin
    # Test totaldays and yearmonthday from January 1st of "from" to December 31st of "to"
    # test_dates(-10000, 10000) takes about 15 seconds
    # test_dates(year(typemin(Date)), year(typemax(Date))) is full range
    # and would take.......a really long time
    let from=0, to=2100, y=0, m=0, d=0
        test_day = DatesPlus.totaldays(from, 1, 1)
        for y in from:to
            for m = 1:12
                for d = 1:DatesPlus.daysinmonth(y, m)
                    days = DatesPlus.totaldays(y, m, d)
                    @test days == test_day
                    @test (y, m, d) == DatesPlus.yearmonthday(days)
                    test_day += 1
                end
            end
        end
    end
end

@testset "year, month, day, hour, minute" begin
    let y=0, m=0, d=0, h=0, mi=0
        for m = 1:12
            for d = 1:DatesPlus.daysinmonth(y, m)
                for h = 0:23
                    for mi = 0:59
                        dt = DatesPlus.DateTime(y, m, d, h, mi)
                        @test y == DatesPlus.year(dt)
                        @test m == DatesPlus.month(dt)
                        @test d == DatesPlus.day(dt)
                        @test d == DatesPlus.dayofmonth(dt)
                        @test h == DatesPlus.hour(dt)
                        @test mi == DatesPlus.minute(dt)
                        @test (m, d) == DatesPlus.monthday(dt)
                    end
                end
            end
        end
    end
end
@testset "second, millisecond" begin
    let y=0, m=0, d=0, h=0, mi=0, s=0, ms=0
        for y in [-2013, -1, 0, 1, 2013]
            for m in [1, 6, 12]
                for d in [1, 15, DatesPlus.daysinmonth(y, m)]
                    for h in [0, 12, 23]
                        for s = 0:59
                            for ms in [0, 1, 500, 999]
                                dt = DatesPlus.DateTime(y, m, d, h, mi, s, ms)
                                @test y == DatesPlus.year(dt)
                                @test m == DatesPlus.month(dt)
                                @test d == DatesPlus.day(dt)
                                @test h == DatesPlus.hour(dt)
                                @test s == DatesPlus.second(dt)
                                @test ms == DatesPlus.millisecond(dt)
                            end
                        end
                    end
                end
            end
        end
    end
end
@testset "year, month, day, hour, minute, second over many years" begin
    let from=0, to=2100, y=0, m=0, d=0
        for y in from:to
            for m = 1:12
                for d = 1:DatesPlus.daysinmonth(y, m)
                    dt = DatesPlus.Date(y, m, d)
                    @test y == DatesPlus.year(dt)
                    @test m == DatesPlus.month(dt)
                    @test d == DatesPlus.day(dt)
                end
            end
        end
    end

    # test hour, minute, second
    let h=0, mi=0, s=0, ms=0, us=0, ns=0
        for h = (0, 23), mi = (0, 59), s = (0, 59),
            ms in (0, 1, 500, 999), us in (0, 1, 500, 999), ns in (0, 1, 500, 999)
            t = DatesPlus.Time(h, mi, s, ms, us, ns)
            @test h == DatesPlus.hour(t)
            @test mi == DatesPlus.minute(t)
            @test s == DatesPlus.second(t)
            @test ms == DatesPlus.millisecond(t)
            @test us == DatesPlus.microsecond(t)
            @test ns == DatesPlus.nanosecond(t)
        end
    end
end
@testset "week" begin
    # Tests from https://en.wikipedia.org/wiki/ISO_week_date
    @test DatesPlus.week(DatesPlus.Date(2005, 1, 1)) == 53
    @test DatesPlus.week(DatesPlus.Date(2005, 1, 2)) == 53
    @test DatesPlus.week(DatesPlus.Date(2005, 12, 31)) == 52
    @test DatesPlus.week(DatesPlus.Date(2007, 1, 1)) == 1
    @test DatesPlus.week(DatesPlus.Date(2007, 12, 30)) == 52
    @test DatesPlus.week(DatesPlus.Date(2007, 12, 31)) == 1
    @test DatesPlus.week(DatesPlus.Date(2008, 1, 1)) == 1
    @test DatesPlus.week(DatesPlus.Date(2008, 12, 28)) == 52
    @test DatesPlus.week(DatesPlus.Date(2008, 12, 29)) == 1
    @test DatesPlus.week(DatesPlus.Date(2008, 12, 30)) == 1
    @test DatesPlus.week(DatesPlus.Date(2008, 12, 31)) == 1
    @test DatesPlus.week(DatesPlus.Date(2009, 1, 1)) == 1
    @test DatesPlus.week(DatesPlus.Date(2009, 12, 31)) == 53
    @test DatesPlus.week(DatesPlus.Date(2010, 1, 1)) == 53
    @test DatesPlus.week(DatesPlus.Date(2010, 1, 2)) == 53
    @test DatesPlus.week(DatesPlus.Date(2010, 1, 2)) == 53
    # Tests from http://www.epochconverter.com/date-and-time/weeknumbers-by-year.php?year=1999
    dt = DatesPlus.DateTime(1999, 12, 27)
    dt1 = DatesPlus.Date(1999, 12, 27)
    check = (52, 52, 52, 52, 52, 52, 52, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2)
    for i = 1:21
        @test DatesPlus.week(dt) == check[i]
        @test DatesPlus.week(dt1) == check[i]
        dt = dt + DatesPlus.Day(1)
        dt1 = dt1 + DatesPlus.Day(1)
    end
    # Tests from http://www.epochconverter.com/date-and-time/weeknumbers-by-year.php?year=2000
    dt = DatesPlus.DateTime(2000, 12, 25)
    dt1 = DatesPlus.Date(2000, 12, 25)
    for i = 1:21
        @test DatesPlus.week(dt) == check[i]
        @test DatesPlus.week(dt1) == check[i]
        dt = dt + DatesPlus.Day(1)
        dt1 = dt1 + DatesPlus.Day(1)
    end
    # Test from http://www.epochconverter.com/date-and-time/weeknumbers-by-year.php?year=2030
    dt = DatesPlus.DateTime(2030, 12, 23)
    dt1 = DatesPlus.Date(2030, 12, 23)
    for i = 1:21
        @test DatesPlus.week(dt) == check[i]
        @test DatesPlus.week(dt1) == check[i]
        dt = dt + DatesPlus.Day(1)
        dt1 = dt1 + DatesPlus.Day(1)
    end
    # Tests from http://www.epochconverter.com/date-and-time/weeknumbers-by-year.php?year=2004
    dt = DatesPlus.DateTime(2004, 12, 20)
    dt1 = DatesPlus.Date(2004, 12, 20)
    check = (52, 52, 52, 52, 52, 52, 52, 53, 53, 53, 53, 53, 53, 53, 1, 1, 1, 1, 1, 1, 1)
    for i = 1:21
        @test DatesPlus.week(dt) == check[i]
        @test DatesPlus.week(dt1) == check[i]
        dt = dt + DatesPlus.Day(1)
        dt1 = dt1 + DatesPlus.Day(1)
    end
end
@testset "Vectorized accessors" begin
    a = DatesPlus.Date(2014, 1, 1)
    dr = [a, a, a, a, a, a, a, a, a, a]
    @test DatesPlus.year.(dr) == repeat([2014], 10)
    @test DatesPlus.month.(dr) == repeat([1], 10)
    @test DatesPlus.day.(dr) == repeat([1], 10)

    a = DatesPlus.DateTime(2014, 1, 1)
    dr = [a, a, a, a, a, a, a, a, a, a]
    @test DatesPlus.year.(dr) == repeat([2014], 10)
    @test DatesPlus.month.(dr) == repeat([1], 10)
    @test DatesPlus.day.(dr) == repeat([1], 10)
    @test DatesPlus.hour.(dr) == repeat([0], 10)
    @test DatesPlus.minute.(dr) == repeat([0], 10)
    @test DatesPlus.second.(dr) == repeat([0], 10)
    @test DatesPlus.millisecond.(dr) == repeat([0], 10)

    b = DatesPlus.Time(1, 2, 3, 4, 5, 6)
    tr = [b, b, b, b, b, b, b, b, b, b]
    @test DatesPlus.hour.(tr) == repeat([1], 10)
    @test DatesPlus.minute.(tr) == repeat([2], 10)
    @test DatesPlus.second.(tr) == repeat([3], 10)
    @test DatesPlus.millisecond.(tr) == repeat([4], 10)
    @test DatesPlus.microsecond.(tr) == repeat([5], 10)
    @test DatesPlus.nanosecond.(tr) == repeat([6], 10)
end

end
