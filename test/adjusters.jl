# This file is a part of Julia. License is MIT: https://julialang.org/license

module AdjustersTest

using Test
using Dates

@testset "trunc" begin
    dt = DatesPlus.Date(2012, 12, 21)
    @test trunc(dt, DatesPlus.Year) == DatesPlus.Date(2012)
    @test trunc(dt, DatesPlus.Quarter) == DatesPlus.Date(2012, 10)
    @test trunc(dt, DatesPlus.Month) == DatesPlus.Date(2012, 12)
    @test trunc(dt, DatesPlus.Day) == DatesPlus.Date(2012, 12, 21)
    dt = DatesPlus.DateTime(2012, 12, 21, 16, 30, 20, 200)
    @test trunc(dt, DatesPlus.Year) == DatesPlus.DateTime(2012)
    @test trunc(dt, DatesPlus.Quarter) == DatesPlus.DateTime(2012, 10)
    @test trunc(dt, DatesPlus.Month) == DatesPlus.DateTime(2012, 12)
    @test trunc(dt, DatesPlus.Day) == DatesPlus.DateTime(2012, 12, 21)
    @test trunc(dt, DatesPlus.Hour) == DatesPlus.DateTime(2012, 12, 21, 16)
    @test trunc(dt, DatesPlus.Minute) == DatesPlus.DateTime(2012, 12, 21, 16, 30)
    @test trunc(dt, DatesPlus.Second) == DatesPlus.DateTime(2012, 12, 21, 16, 30, 20)
    @test trunc(dt, DatesPlus.Millisecond) == DatesPlus.DateTime(2012, 12, 21, 16, 30, 20, 200)
    t = DatesPlus.Time(1, 2, 3, 4, 5, 6)
    @test trunc(t, DatesPlus.Hour) == DatesPlus.Time(1)
    @test trunc(t, DatesPlus.Minute) == DatesPlus.Time(1, 2)
    @test trunc(t, DatesPlus.Second) == DatesPlus.Time(1, 2, 3)
    @test trunc(t, DatesPlus.Millisecond) == DatesPlus.Time(1, 2, 3, 4)
    @test trunc(t, DatesPlus.Microsecond) == DatesPlus.Time(1, 2, 3, 4, 5)
    @test trunc(t, DatesPlus.Nanosecond) == DatesPlus.Time(1, 2, 3, 4, 5, 6)
end

Jan = DatesPlus.DateTime(2013, 1, 1) #Tuesday
Feb = DatesPlus.DateTime(2013, 2, 2) #Saturday
Mar = DatesPlus.DateTime(2013, 3, 3) #Sunday
Apr = DatesPlus.DateTime(2013, 4, 4) #Thursday
May = DatesPlus.DateTime(2013, 5, 5) #Sunday
Jun = DatesPlus.DateTime(2013, 6, 7) #Friday
Jul = DatesPlus.DateTime(2013, 7, 7) #Sunday
Aug = DatesPlus.DateTime(2013, 8, 8) #Thursday
Sep = DatesPlus.DateTime(2013, 9, 9) #Monday
Oct = DatesPlus.DateTime(2013, 10, 10) #Thursday
Nov = DatesPlus.DateTime(2013, 11, 11) #Monday
Dec = DatesPlus.DateTime(2013, 12, 11) #Wednesday

@testset "Date functions" begin
    @testset "lastdayofmonth" begin
        @test DatesPlus.lastdayofmonth(Jan) == DatesPlus.DateTime(2013, 1, 31)
        @test DatesPlus.lastdayofmonth(Feb) == DatesPlus.DateTime(2013, 2, 28)
        @test DatesPlus.lastdayofmonth(Mar) == DatesPlus.DateTime(2013, 3, 31)
        @test DatesPlus.lastdayofmonth(Apr) == DatesPlus.DateTime(2013, 4, 30)
        @test DatesPlus.lastdayofmonth(May) == DatesPlus.DateTime(2013, 5, 31)
        @test DatesPlus.lastdayofmonth(Jun) == DatesPlus.DateTime(2013, 6, 30)
        @test DatesPlus.lastdayofmonth(Jul) == DatesPlus.DateTime(2013, 7, 31)
        @test DatesPlus.lastdayofmonth(Aug) == DatesPlus.DateTime(2013, 8, 31)
        @test DatesPlus.lastdayofmonth(Sep) == DatesPlus.DateTime(2013, 9, 30)
        @test DatesPlus.lastdayofmonth(Oct) == DatesPlus.DateTime(2013, 10, 31)
        @test DatesPlus.lastdayofmonth(Nov) == DatesPlus.DateTime(2013, 11, 30)
        @test DatesPlus.lastdayofmonth(Dec) == DatesPlus.DateTime(2013, 12, 31)

        @test DatesPlus.lastdayofmonth(Date(Jan)) == DatesPlus.Date(2013, 1, 31)
        @test DatesPlus.lastdayofmonth(Date(Feb)) == DatesPlus.Date(2013, 2, 28)
        @test DatesPlus.lastdayofmonth(Date(Mar)) == DatesPlus.Date(2013, 3, 31)
        @test DatesPlus.lastdayofmonth(Date(Apr)) == DatesPlus.Date(2013, 4, 30)
        @test DatesPlus.lastdayofmonth(Date(May)) == DatesPlus.Date(2013, 5, 31)
        @test DatesPlus.lastdayofmonth(Date(Jun)) == DatesPlus.Date(2013, 6, 30)
        @test DatesPlus.lastdayofmonth(Date(Jul)) == DatesPlus.Date(2013, 7, 31)
        @test DatesPlus.lastdayofmonth(Date(Aug)) == DatesPlus.Date(2013, 8, 31)
        @test DatesPlus.lastdayofmonth(Date(Sep)) == DatesPlus.Date(2013, 9, 30)
        @test DatesPlus.lastdayofmonth(Date(Oct)) == DatesPlus.Date(2013, 10, 31)
        @test DatesPlus.lastdayofmonth(Date(Nov)) == DatesPlus.Date(2013, 11, 30)
        @test DatesPlus.lastdayofmonth(Date(Dec)) == DatesPlus.Date(2013, 12, 31)
    end
    @testset "firstdayofmonth" begin
        @test DatesPlus.firstdayofmonth(Jan) == DatesPlus.DateTime(2013, 1, 1)
        @test DatesPlus.firstdayofmonth(Feb) == DatesPlus.DateTime(2013, 2, 1)
        @test DatesPlus.firstdayofmonth(Mar) == DatesPlus.DateTime(2013, 3, 1)
        @test DatesPlus.firstdayofmonth(Apr) == DatesPlus.DateTime(2013, 4, 1)
        @test DatesPlus.firstdayofmonth(May) == DatesPlus.DateTime(2013, 5, 1)
        @test DatesPlus.firstdayofmonth(Jun) == DatesPlus.DateTime(2013, 6, 1)
        @test DatesPlus.firstdayofmonth(Jul) == DatesPlus.DateTime(2013, 7, 1)
        @test DatesPlus.firstdayofmonth(Aug) == DatesPlus.DateTime(2013, 8, 1)
        @test DatesPlus.firstdayofmonth(Sep) == DatesPlus.DateTime(2013, 9, 1)
        @test DatesPlus.firstdayofmonth(Oct) == DatesPlus.DateTime(2013, 10, 1)
        @test DatesPlus.firstdayofmonth(Nov) == DatesPlus.DateTime(2013, 11, 1)
        @test DatesPlus.firstdayofmonth(Dec) == DatesPlus.DateTime(2013, 12, 1)

        @test DatesPlus.firstdayofmonth(Date(Jan)) == DatesPlus.Date(2013, 1, 1)
        @test DatesPlus.firstdayofmonth(Date(Feb)) == DatesPlus.Date(2013, 2, 1)
        @test DatesPlus.firstdayofmonth(Date(Mar)) == DatesPlus.Date(2013, 3, 1)
        @test DatesPlus.firstdayofmonth(Date(Apr)) == DatesPlus.Date(2013, 4, 1)
        @test DatesPlus.firstdayofmonth(Date(May)) == DatesPlus.Date(2013, 5, 1)
        @test DatesPlus.firstdayofmonth(Date(Jun)) == DatesPlus.Date(2013, 6, 1)
        @test DatesPlus.firstdayofmonth(Date(Jul)) == DatesPlus.Date(2013, 7, 1)
        @test DatesPlus.firstdayofmonth(Date(Aug)) == DatesPlus.Date(2013, 8, 1)
        @test DatesPlus.firstdayofmonth(Date(Sep)) == DatesPlus.Date(2013, 9, 1)
        @test DatesPlus.firstdayofmonth(Date(Oct)) == DatesPlus.Date(2013, 10, 1)
        @test DatesPlus.firstdayofmonth(Date(Nov)) == DatesPlus.Date(2013, 11, 1)
        @test DatesPlus.firstdayofmonth(Date(Dec)) == DatesPlus.Date(2013, 12, 1)
    end
    @testset "firstdayofweek" begin
        # 2014-01-06 is a Monday = 1st day of week
        a = DatesPlus.Date(2014, 1, 6)
        b = DatesPlus.Date(2014, 1, 7)
        c = DatesPlus.Date(2014, 1, 8)
        d = DatesPlus.Date(2014, 1, 9)
        e = DatesPlus.Date(2014, 1, 10)
        f = DatesPlus.Date(2014, 1, 11)
        g = DatesPlus.Date(2014, 1, 12)
        @test DatesPlus.firstdayofweek(a) == a
        @test DatesPlus.firstdayofweek(b) == a
        @test DatesPlus.firstdayofweek(c) == a
        @test DatesPlus.firstdayofweek(d) == a
        @test DatesPlus.firstdayofweek(e) == a
        @test DatesPlus.firstdayofweek(f) == a
        @test DatesPlus.firstdayofweek(g) == a
        # Test firstdayofweek over the course of the year
        dt = a
        for i = 0:364
            @test DatesPlus.firstdayofweek(dt) == a + DatesPlus.Week(div(i, 7))
            dt += DatesPlus.Day(1)
        end
        a = DatesPlus.DateTime(2014, 1, 6)
        b = DatesPlus.DateTime(2014, 1, 7)
        c = DatesPlus.DateTime(2014, 1, 8)
        d = DatesPlus.DateTime(2014, 1, 9)
        e = DatesPlus.DateTime(2014, 1, 10)
        f = DatesPlus.DateTime(2014, 1, 11)
        g = DatesPlus.DateTime(2014, 1, 12)
        @test DatesPlus.firstdayofweek(a) == a
        @test DatesPlus.firstdayofweek(b) == a
        @test DatesPlus.firstdayofweek(c) == a
        @test DatesPlus.firstdayofweek(d) == a
        @test DatesPlus.firstdayofweek(e) == a
        @test DatesPlus.firstdayofweek(f) == a
        @test DatesPlus.firstdayofweek(g) == a
        dt = a
        for i = 0:364
            @test DatesPlus.firstdayofweek(dt) == a + DatesPlus.Week(div(i, 7))
            dt += DatesPlus.Day(1)
        end
        @test DatesPlus.firstdayofweek(DatesPlus.DateTime(2013, 12, 24)) == DatesPlus.DateTime(2013, 12, 23)
    end
    @testset "lastdayofweek" begin
        # Sunday = last day of week
        # 2014-01-12 is a Sunday
        a = DatesPlus.Date(2014, 1, 6)
        b = DatesPlus.Date(2014, 1, 7)
        c = DatesPlus.Date(2014, 1, 8)
        d = DatesPlus.Date(2014, 1, 9)
        e = DatesPlus.Date(2014, 1, 10)
        f = DatesPlus.Date(2014, 1, 11)
        g = DatesPlus.Date(2014, 1, 12)
        @test DatesPlus.lastdayofweek(a) == g
        @test DatesPlus.lastdayofweek(b) == g
        @test DatesPlus.lastdayofweek(c) == g
        @test DatesPlus.lastdayofweek(d) == g
        @test DatesPlus.lastdayofweek(e) == g
        @test DatesPlus.lastdayofweek(f) == g
        @test DatesPlus.lastdayofweek(g) == g
        dt = a
        for i = 0:364
            @test DatesPlus.lastdayofweek(dt) == g + DatesPlus.Week(div(i, 7))
            dt += DatesPlus.Day(1)
        end
        a = DatesPlus.DateTime(2014, 1, 6)
        b = DatesPlus.DateTime(2014, 1, 7)
        c = DatesPlus.DateTime(2014, 1, 8)
        d = DatesPlus.DateTime(2014, 1, 9)
        e = DatesPlus.DateTime(2014, 1, 10)
        f = DatesPlus.DateTime(2014, 1, 11)
        g = DatesPlus.DateTime(2014, 1, 12)
        @test DatesPlus.lastdayofweek(a) == g
        @test DatesPlus.lastdayofweek(b) == g
        @test DatesPlus.lastdayofweek(c) == g
        @test DatesPlus.lastdayofweek(d) == g
        @test DatesPlus.lastdayofweek(e) == g
        @test DatesPlus.lastdayofweek(f) == g
        @test DatesPlus.lastdayofweek(g) == g
        dt = a
        for i = 0:364
            @test DatesPlus.lastdayofweek(dt) == g + DatesPlus.Week(div(i, 7))
            dt += DatesPlus.Day(1)
        end
        @test DatesPlus.lastdayofweek(DatesPlus.DateTime(2013, 12, 24)) == DatesPlus.DateTime(2013, 12, 29)
    end
    @testset "first/lastdayofquarter" begin
        @test DatesPlus.firstdayofquarter(DatesPlus.Date(2014, 2, 2)) == DatesPlus.Date(2014, 1, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.Date(2014, 5, 2)) == DatesPlus.Date(2014, 4, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.Date(2014, 8, 2)) == DatesPlus.Date(2014, 7, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.Date(2014, 12, 2)) == DatesPlus.Date(2014, 10, 1)

        @test DatesPlus.firstdayofquarter(DatesPlus.DateTime(2014, 2, 2)) == DatesPlus.DateTime(2014, 1, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.DateTime(2014, 5, 2)) == DatesPlus.DateTime(2014, 4, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.DateTime(2014, 8, 2)) == DatesPlus.DateTime(2014, 7, 1)
        @test DatesPlus.firstdayofquarter(DatesPlus.DateTime(2014, 12, 2)) == DatesPlus.DateTime(2014, 10, 1)

        @test DatesPlus.lastdayofquarter(DatesPlus.Date(2014, 2, 2)) == DatesPlus.Date(2014, 3, 31)
        @test DatesPlus.lastdayofquarter(DatesPlus.Date(2014, 5, 2)) == DatesPlus.Date(2014, 6, 30)
        @test DatesPlus.lastdayofquarter(DatesPlus.Date(2014, 8, 2)) == DatesPlus.Date(2014, 9, 30)
        @test DatesPlus.lastdayofquarter(DatesPlus.Date(2014, 12, 2)) == DatesPlus.Date(2014, 12, 31)

        @test DatesPlus.lastdayofquarter(DatesPlus.DateTime(2014, 2, 2)) == DatesPlus.DateTime(2014, 3, 31)
        @test DatesPlus.lastdayofquarter(DatesPlus.DateTime(2014, 5, 2)) == DatesPlus.DateTime(2014, 6, 30)
        @test DatesPlus.lastdayofquarter(DatesPlus.DateTime(2014, 8, 2)) == DatesPlus.DateTime(2014, 9, 30)
        @test DatesPlus.lastdayofquarter(DatesPlus.DateTime(2014, 12, 2)) == DatesPlus.DateTime(2014, 12, 31)
    end
    @testset "first/lastdayofyear" begin
        firstday = DatesPlus.Date(2014, 1, 1)
        lastday = DatesPlus.Date(2014, 12, 31)
        for i = 0:364
            dt = firstday + DatesPlus.Day(i)

            @test DatesPlus.firstdayofyear(dt) == firstday
            @test DatesPlus.firstdayofyear(DateTime(dt)) == DateTime(firstday)

            @test DatesPlus.lastdayofyear(dt) == lastday
            @test DatesPlus.lastdayofyear(DateTime(dt)) == DateTime(lastday)
        end
    end
end
# Adjusters
@testset "Adjuster Constructors" begin
    @test DatesPlus.Date(DatesPlus.ismonday, 2014) == DatesPlus.Date(2014, 1, 6)
    @test DatesPlus.Date(DatesPlus.ismonday, 2014, 5) == DatesPlus.Date(2014, 5, 5)

    @test DatesPlus.DateTime(DatesPlus.ismonday, 2014) == DatesPlus.DateTime(2014, 1, 6)
    @test DatesPlus.DateTime(DatesPlus.ismonday, 2014, 5) == DatesPlus.DateTime(2014, 5, 5)
    @test DatesPlus.DateTime(x->DatesPlus.hour(x)==12, 2014, 5, 21) == DatesPlus.DateTime(2014, 5, 21, 12)
    @test DatesPlus.DateTime(x->DatesPlus.minute(x)==30, 2014, 5, 21, 12) == DatesPlus.DateTime(2014, 5, 21, 12, 30)
    @test DatesPlus.DateTime(x->DatesPlus.second(x)==30, 2014, 5, 21, 12, 30) == DatesPlus.DateTime(2014, 5, 21, 12, 30, 30)
    @test DatesPlus.DateTime(x->DatesPlus.millisecond(x)==500, 2014, 5, 21, 12, 30, 30) == DatesPlus.DateTime(2014, 5, 21, 12, 30, 30, 500)
end
@testset "tonext, toprev, tofirst, tolast" begin
    dt = DatesPlus.Date(2014, 5, 21)
    @test DatesPlus.tonext(dt, DatesPlus.Wed) == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.tonext(dt, DatesPlus.Wed; same=true) == dt
    @test DatesPlus.tonext(dt, DatesPlus.Thu) == DatesPlus.Date(2014, 5, 22)
    @test DatesPlus.tonext(dt, DatesPlus.Fri) == DatesPlus.Date(2014, 5, 23)
    @test DatesPlus.tonext(dt, DatesPlus.Sat) == DatesPlus.Date(2014, 5, 24)
    @test DatesPlus.tonext(dt, DatesPlus.Sun) == DatesPlus.Date(2014, 5, 25)
    @test DatesPlus.tonext(dt, DatesPlus.Mon) == DatesPlus.Date(2014, 5, 26)
    @test DatesPlus.tonext(dt, DatesPlus.Tue) == DatesPlus.Date(2014, 5, 27)
    # No dayofweek function for out of range values
    @test_throws KeyError DatesPlus.tonext(dt, 8)

    @test DatesPlus.tonext(DatesPlus.Date(0), DatesPlus.Mon) == DatesPlus.Date(0, 1, 3)
    @testset "func, diff steps, same" begin
        @test DatesPlus.tonext(DatesPlus.iswednesday, dt) == DatesPlus.Date(2014, 5, 28)
        @test DatesPlus.tonext(DatesPlus.iswednesday, dt; same=true) == dt
        @test DatesPlus.tonext(DatesPlus.isthursday, dt) == DatesPlus.Date(2014, 5, 22)
        @test DatesPlus.tonext(DatesPlus.isfriday, dt) == DatesPlus.Date(2014, 5, 23)
        @test DatesPlus.tonext(DatesPlus.issaturday, dt) == DatesPlus.Date(2014, 5, 24)
        @test DatesPlus.tonext(DatesPlus.issunday, dt) == DatesPlus.Date(2014, 5, 25)
        @test DatesPlus.tonext(DatesPlus.ismonday, dt) == DatesPlus.Date(2014, 5, 26)
        @test DatesPlus.tonext(DatesPlus.istuesday, dt) == DatesPlus.Date(2014, 5, 27)
        @test DatesPlus.tonext(DatesPlus.ismonday, DatesPlus.Date(0)) == DatesPlus.Date(0, 1, 3)

        @test DatesPlus.tonext(!DatesPlus.iswednesday, dt) == DatesPlus.Date(2014, 5, 22)
        @test DatesPlus.tonext(!DatesPlus.isthursday, dt) == DatesPlus.Date(2014, 5, 23)
    end

    # Reach adjust limit
    @test_throws ArgumentError DatesPlus.tonext(DatesPlus.iswednesday, dt; limit=6)

    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(2)) == DatesPlus.Date(2014, 6, 4)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(3)) == DatesPlus.Date(2014, 6, 11)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(4)) == DatesPlus.Date(2014, 6, 18)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(5)) == DatesPlus.Date(2014, 6, 25)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(6)) == DatesPlus.Date(2014, 7, 2)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Day(7)) == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(1)) == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(2)) == DatesPlus.Date(2014, 6, 4)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(3)) == DatesPlus.Date(2014, 6, 11)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(4)) == DatesPlus.Date(2014, 6, 18)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(5)) == DatesPlus.Date(2014, 6, 25)
    @test DatesPlus.tonext(DatesPlus.iswednesday, dt;step=DatesPlus.Week(6)) == DatesPlus.Date(2014, 7, 2)

    @test DatesPlus.tonext(DatesPlus.iswednesday, dt; same=true) == dt
    @test DatesPlus.tonext(DatesPlus.isthursday, dt) == DatesPlus.Date(2014, 5, 22)
end

@testset "toprev" begin
    dt = DatesPlus.Date(2014, 5, 21)
    @test DatesPlus.toprev(dt, DatesPlus.Wed) == DatesPlus.Date(2014, 5, 14)
    @test DatesPlus.toprev(dt, DatesPlus.Wed; same=true) == dt
    @test DatesPlus.toprev(dt, DatesPlus.Thu) == DatesPlus.Date(2014, 5, 15)
    @test DatesPlus.toprev(dt, DatesPlus.Fri) == DatesPlus.Date(2014, 5, 16)
    @test DatesPlus.toprev(dt, DatesPlus.Sat) == DatesPlus.Date(2014, 5, 17)
    @test DatesPlus.toprev(dt, DatesPlus.Sun) == DatesPlus.Date(2014, 5, 18)
    @test DatesPlus.toprev(dt, DatesPlus.Mon) == DatesPlus.Date(2014, 5, 19)
    @test DatesPlus.toprev(dt, DatesPlus.Tue) == DatesPlus.Date(2014, 5, 20)
    # No dayofweek function for out of range values
    @test_throws KeyError DatesPlus.toprev(dt, 8)

    @test DatesPlus.toprev(DatesPlus.Date(0), DatesPlus.Mon) == DatesPlus.Date(-1, 12, 27)
end
@testset "tofirst" begin
    dt = DatesPlus.Date(2014, 5, 21)
    @test DatesPlus.tofirst(dt, DatesPlus.Mon) == DatesPlus.Date(2014, 5, 5)
    @test DatesPlus.tofirst(dt, DatesPlus.Tue) == DatesPlus.Date(2014, 5, 6)
    @test DatesPlus.tofirst(dt, DatesPlus.Wed) == DatesPlus.Date(2014, 5, 7)
    @test DatesPlus.tofirst(dt, DatesPlus.Thu) == DatesPlus.Date(2014, 5, 1)
    @test DatesPlus.tofirst(dt, DatesPlus.Fri) == DatesPlus.Date(2014, 5, 2)
    @test DatesPlus.tofirst(dt, DatesPlus.Sat) == DatesPlus.Date(2014, 5, 3)
    @test DatesPlus.tofirst(dt, DatesPlus.Sun) == DatesPlus.Date(2014, 5, 4)

    @test DatesPlus.tofirst(dt, DatesPlus.Mon, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 6)
    @test DatesPlus.tofirst(dt, DatesPlus.Tue, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 7)
    @test DatesPlus.tofirst(dt, DatesPlus.Wed, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 1)
    @test DatesPlus.tofirst(dt, DatesPlus.Thu, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 2)
    @test DatesPlus.tofirst(dt, DatesPlus.Fri, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 3)
    @test DatesPlus.tofirst(dt, DatesPlus.Sat, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 4)
    @test DatesPlus.tofirst(dt, DatesPlus.Sun, of=DatesPlus.Year) == DatesPlus.Date(2014, 1, 5)

    @test DatesPlus.tofirst(DatesPlus.Date(0), DatesPlus.Mon) == DatesPlus.Date(0, 1, 3)
end
@testset "tolast" begin
    dt = DatesPlus.Date(2014, 5, 21)
    @test DatesPlus.tolast(dt, DatesPlus.Mon) == DatesPlus.Date(2014, 5, 26)
    @test DatesPlus.tolast(dt, DatesPlus.Tue) == DatesPlus.Date(2014, 5, 27)
    @test DatesPlus.tolast(dt, DatesPlus.Wed) == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.tolast(dt, DatesPlus.Thu) == DatesPlus.Date(2014, 5, 29)
    @test DatesPlus.tolast(dt, DatesPlus.Fri) == DatesPlus.Date(2014, 5, 30)
    @test DatesPlus.tolast(dt, DatesPlus.Sat) == DatesPlus.Date(2014, 5, 31)
    @test DatesPlus.tolast(dt, DatesPlus.Sun) == DatesPlus.Date(2014, 5, 25)

    @test DatesPlus.tolast(dt, DatesPlus.Mon, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 29)
    @test DatesPlus.tolast(dt, DatesPlus.Tue, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 30)
    @test DatesPlus.tolast(dt, DatesPlus.Wed, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 31)
    @test DatesPlus.tolast(dt, DatesPlus.Thu, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 25)
    @test DatesPlus.tolast(dt, DatesPlus.Fri, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 26)
    @test DatesPlus.tolast(dt, DatesPlus.Sat, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 27)
    @test DatesPlus.tolast(dt, DatesPlus.Sun, of=DatesPlus.Year) == DatesPlus.Date(2014, 12, 28)

    @test DatesPlus.tolast(DatesPlus.Date(0), DatesPlus.Mon) == DatesPlus.Date(0, 1, 31)
end
@testset "filter" begin # was recur
    startdate = DatesPlus.Date(2014, 1, 1)
    stopdate = DatesPlus.Date(2014, 2, 1)
    @test length(filter(x->true, startdate:DatesPlus.Day(1):stopdate))  == 32
    @test length(filter(x->true, stopdate:DatesPlus.Day(-1):startdate)) == 32

    Januarymondays2014 = [DatesPlus.Date(2014, 1, 6), DatesPlus.Date(2014, 1, 13), DatesPlus.Date(2014, 1, 20), DatesPlus.Date(2014, 1, 27)]
    @test filter(DatesPlus.ismonday, startdate:DatesPlus.Day(1):stopdate) == Januarymondays2014

    @test_throws MethodError filter((x, y)->x + y, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2014))
    @test_throws MethodError DatesPlus.DateFunction((x, y)->x + y, Date(0))
    @test_throws ArgumentError DatesPlus.DateFunction((dt)->2, Date(0))
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 2))) == 32
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 1))) == 1
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 2))) == 2
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 3))) == 3
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 4))) == 4
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 5))) == 5
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 6))) == 6
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 7))) == 7
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 8))) == 8
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Month(1):DatesPlus.Date(2013, 1, 1))) == 1
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(-1):DatesPlus.Date(2012, 1, 1))) == 367

    # Empty range
    @test length(filter(x->true, DatesPlus.Date(2013):DatesPlus.Day(1):DatesPlus.Date(2012, 1, 1))) == 0

    # All leap days in 20th century
    @test length(filter(DatesPlus.Date(1900):DatesPlus.Day(1):DatesPlus.Date(2000)) do x
        DatesPlus.month(x) == DatesPlus.Feb && DatesPlus.day(x) == 29
    end) == 24
end

@testset "Holiday test cases" begin
    dt = DatesPlus.Date(2014, 5, 21)
    dr = DatesPlus.Date(2014):DatesPlus.Day(1):DatesPlus.Date(2015)
    @testset "Thanksgiving" begin
        # 4th Thursday of November
        thanksgiving = x->DatesPlus.dayofweek(x) == DatesPlus.Thu &&
                              DatesPlus.month(x) == DatesPlus.Nov &&
                   DatesPlus.dayofweekofmonth(x) == 4

        d = DatesPlus.Date(2014, 6, 5)

        @test DatesPlus.tonext(d) do x
            thanksgiving(x)
        end == DatesPlus.Date(2014, 11, 27)

        @test DatesPlus.toprev(d) do x
            thanksgiving(x)
        end == DatesPlus.Date(2013, 11, 28)
    end
    @testset "Pittsburgh street cleaning" begin
        @test length(filter(dr) do x
            DatesPlus.dayofweek(x) == DatesPlus.Tue &&
            DatesPlus.April < DatesPlus.month(x) < DatesPlus.Nov &&
            DatesPlus.dayofweekofmonth(x) == 2
        end) == 6
    end
    @testset "U.S. Federal Holidays" begin
        newyears(y) = (y, 1, 1)
        independenceday(y) = (y, 7, 4)
        veteransday(y) = (y, 11, 11)
        christmas(y) = (y, 12, 25)

        isnewyears(dt) = DatesPlus.yearmonthday(dt) == newyears(DatesPlus.year(dt))
        isindependenceday(dt) = DatesPlus.yearmonthday(dt) == independenceday(DatesPlus.year(dt))
        isveteransday(dt) = DatesPlus.yearmonthday(dt) == veteransday(DatesPlus.year(dt))
        ischristmas(dt) = DatesPlus.yearmonthday(dt) == christmas(DatesPlus.year(dt))
        ismartinlutherking(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Mon &&
            DatesPlus.month(dt) == DatesPlus.Jan && DatesPlus.dayofweekofmonth(dt) == 3
        ispresidentsday(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Mon &&
            DatesPlus.month(dt) == DatesPlus.Feb && DatesPlus.dayofweekofmonth(dt) == 3
        # Last Monday of May
        ismemorialday(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Mon &&
                            DatesPlus.month(dt) == DatesPlus.May &&
                            DatesPlus.dayofweekofmonth(dt) == DatesPlus.daysofweekinmonth(dt)
        islaborday(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Mon &&
            DatesPlus.month(dt) == DatesPlus.Sep && DatesPlus.dayofweekofmonth(dt) == 1
        iscolumbusday(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Mon &&
            DatesPlus.month(dt) == DatesPlus.Oct && DatesPlus.dayofweekofmonth(dt) == 2
        isthanksgiving(dt) = DatesPlus.dayofweek(dt) == DatesPlus.Thu &&
            DatesPlus.month(dt) == DatesPlus.Nov && DatesPlus.dayofweekofmonth(dt) == 4

        function easter(y)
            # Butcher's Algorithm: http://www.smart.net/~mmontes/butcher.html
            a = y % 19
            b = div(y, 100)
            c = y % 100
            d = div(b, 4)
            e = b % 4
            f = div(b + 8, 25)
            g = div(b - f + 1, 3)
            h = (19 * a + b - d - g + 15) % 30
            i = div(c, 4)
            k = c % 4
            l = (32 + 2 * e + 2 * i - h - k) % 7
            m = div(a + 11 * h + 22 * l, 451)
            month = div(h + l - 7 * m + 114, 31)
            p = (h + l - 7 * m + 114) % 31
            return (y, month, p + 1)
        end
        iseaster(dt) = DatesPlus.yearmonthday(dt) == easter(DatesPlus.year(dt))

        HOLIDAYS = x->isnewyears(x) || isindependenceday(x) ||
                      isveteransday(x) || ischristmas(x) ||
                      ismartinlutherking(x) || ispresidentsday(x) ||
                      ismemorialday(x) || islaborday(x) ||
                      iscolumbusday(x) || isthanksgiving(x)

        @test length(filter(HOLIDAYS, dr)) == 11

        OBSERVEDHOLIDAYS = x->begin
            # If the holiday is on a weekday
            if HOLIDAYS(x) && DatesPlus.dayofweek(x) < DatesPlus.Saturday
                return true
            # Holiday is observed Monday if falls on Sunday
            elseif DatesPlus.dayofweek(x) == 1 && HOLIDAYS(x - DatesPlus.Day(1))
                return true
            # Holiday is observed Friday if falls on Saturday
            elseif DatesPlus.dayofweek(x) == 5 && HOLIDAYS(x + DatesPlus.Day(1))
                return true
            else
                return false
            end
        end

        observed = filter(OBSERVEDHOLIDAYS, DatesPlus.Date(1999):DatesPlus.Day(1):DatesPlus.Date(2000))
        @test length(observed) == 11
        @test observed[10] == DatesPlus.Date(1999, 12, 24)
        @test observed[11] == DatesPlus.Date(1999, 12, 31)

        # Get all business/working days of 2014
        # Since we have already defined observed holidays,
        # we just look at weekend days and negate the result
        @test length(filter(DatesPlus.Date(2014):DatesPlus.Day(1):DatesPlus.Date(2015)) do x
            !(OBSERVEDHOLIDAYS(x) ||
            DatesPlus.dayofweek(x) > 5)
        end) == 251
    end
end

@testset "proof-of-concepts" begin
    # First day of the next month for each day of 2014
    @test length([DatesPlus.firstdayofmonth(i + DatesPlus.Month(1))
        for i in DatesPlus.Date(2014):DatesPlus.Day(1):DatesPlus.Date(2014, 12, 31)]) == 365

    # From those goofy email forwards claiming a "special, lucky month"
    # that has 5 Fridays, 5 Saturdays, and 5 Sundays and that it only
    # occurs every 823 years
    @test length(filter(Date(2000):DatesPlus.Month(1):Date(2016)) do dt
        sum = 0
        for i = 1:7
            sum += DatesPlus.dayofweek(dt) > 4 ? DatesPlus.daysofweekinmonth(dt) : 0
            dt += DatesPlus.Day(1)
        end
        return sum == 15
    end) == 15 # On average, there's one of those months every year

    r = DatesPlus.Time(x->DatesPlus.second(x) == 5, 1)
    @test r == DatesPlus.Time(1, 0, 5)

    r = filter(x->DatesPlus.second(x) == 5, DatesPlus.Time(0):DatesPlus.Second(1):DatesPlus.Time(10))
    @test length(r) == 600
    @test first(r) == DatesPlus.Time(0, 0, 5)
    @test last(r) == DatesPlus.Time(9, 59, 5)
end
end # module
