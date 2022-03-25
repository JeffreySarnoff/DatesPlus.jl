# This file is a part of Julia. License is MIT: https://julialang.org/license

module ArithmeticTest

using Test
using Dates

@testset "Time arithmetic" begin
    a = DatesPlus.Time(23, 59, 59)
    b = DatesPlus.Time(11, 59, 59)
    @test DatesPlus.CompoundPeriod(a - b) == DatesPlus.Hour(12)
end
@testset "Wrapping arithmetic for Months" begin
    # This ends up being trickier than expected because
    # the user might do 2014-01-01 + Month(-14)
    # monthwrap figures out the resulting month
    # when adding/subtracting months from a date
    @test DatesPlus.monthwrap(1, -14) == 11
    @test DatesPlus.monthwrap(1, -13) == 12
    @test DatesPlus.monthwrap(1, -12) == 1
    @test DatesPlus.monthwrap(1, -11) == 2
    @test DatesPlus.monthwrap(1, -10) == 3
    @test DatesPlus.monthwrap(1, -9) == 4
    @test DatesPlus.monthwrap(1, -8) == 5
    @test DatesPlus.monthwrap(1, -7) == 6
    @test DatesPlus.monthwrap(1, -6) == 7
    @test DatesPlus.monthwrap(1, -5) == 8
    @test DatesPlus.monthwrap(1, -4) == 9
    @test DatesPlus.monthwrap(1, -3) == 10
    @test DatesPlus.monthwrap(1, -2) == 11
    @test DatesPlus.monthwrap(1, -1) == 12
    @test DatesPlus.monthwrap(1, 0) == 1
    @test DatesPlus.monthwrap(1, 1) == 2
    @test DatesPlus.monthwrap(1, 2) == 3
    @test DatesPlus.monthwrap(1, 3) == 4
    @test DatesPlus.monthwrap(1, 4) == 5
    @test DatesPlus.monthwrap(1, 5) == 6
    @test DatesPlus.monthwrap(1, 6) == 7
    @test DatesPlus.monthwrap(1, 7) == 8
    @test DatesPlus.monthwrap(1, 8) == 9
    @test DatesPlus.monthwrap(1, 9) == 10
    @test DatesPlus.monthwrap(1, 10) == 11
    @test DatesPlus.monthwrap(1, 11) == 12
    @test DatesPlus.monthwrap(1, 12) == 1
    @test DatesPlus.monthwrap(1, 13) == 2
    @test DatesPlus.monthwrap(1, 24) == 1
    @test DatesPlus.monthwrap(12, -14) == 10
    @test DatesPlus.monthwrap(12, -13) == 11
    @test DatesPlus.monthwrap(12, -12) == 12
    @test DatesPlus.monthwrap(12, -11) == 1
    @test DatesPlus.monthwrap(12, -2) == 10
    @test DatesPlus.monthwrap(12, -1) == 11
    @test DatesPlus.monthwrap(12, 0) == 12
    @test DatesPlus.monthwrap(12, 1) == 1
    @test DatesPlus.monthwrap(12, 2) == 2
    @test DatesPlus.monthwrap(12, 11) == 11
    @test DatesPlus.monthwrap(12, 12) == 12
    @test DatesPlus.monthwrap(12, 13) == 1
end
@testset "Wrapping arithmetic for years" begin
    # yearwrap figures out the resulting year
    # when adding/subtracting months from a date
    @test DatesPlus.yearwrap(2000, 1, -3600) == 1700
    @test DatesPlus.yearwrap(2000, 1, -37) == 1996
    @test DatesPlus.yearwrap(2000, 1, -36) == 1997
    @test DatesPlus.yearwrap(2000, 1, -35) == 1997
    @test DatesPlus.yearwrap(2000, 1, -25) == 1997
    @test DatesPlus.yearwrap(2000, 1, -24) == 1998
    @test DatesPlus.yearwrap(2000, 1, -23) == 1998
    @test DatesPlus.yearwrap(2000, 1, -14) == 1998
    @test DatesPlus.yearwrap(2000, 1, -13) == 1998
    @test DatesPlus.yearwrap(2000, 1, -12) == 1999
    @test DatesPlus.yearwrap(2000, 1, -11) == 1999
    @test DatesPlus.yearwrap(2000, 1, -2) == 1999
    @test DatesPlus.yearwrap(2000, 1, -1) == 1999
    @test DatesPlus.yearwrap(2000, 1, 0) == 2000
    @test DatesPlus.yearwrap(2000, 1, 1) == 2000
    @test DatesPlus.yearwrap(2000, 1, 11) == 2000
    @test DatesPlus.yearwrap(2000, 1, 12) == 2001
    @test DatesPlus.yearwrap(2000, 1, 13) == 2001
    @test DatesPlus.yearwrap(2000, 1, 23) == 2001
    @test DatesPlus.yearwrap(2000, 1, 24) == 2002
    @test DatesPlus.yearwrap(2000, 1, 25) == 2002
    @test DatesPlus.yearwrap(2000, 1, 36) == 2003
    @test DatesPlus.yearwrap(2000, 1, 3600) == 2300
    @test DatesPlus.yearwrap(2000, 2, -2) == 1999
    @test DatesPlus.yearwrap(2000, 3, 10) == 2001
    @test DatesPlus.yearwrap(2000, 4, -4) == 1999
    @test DatesPlus.yearwrap(2000, 5, 8) == 2001
    @test DatesPlus.yearwrap(2000, 6, -18) == 1998
    @test DatesPlus.yearwrap(2000, 6, -6) == 1999
    @test DatesPlus.yearwrap(2000, 6, 6) == 2000
    @test DatesPlus.yearwrap(2000, 6, 7) == 2001
    @test DatesPlus.yearwrap(2000, 6, 19) == 2002
    @test DatesPlus.yearwrap(2000, 12, -3600) == 1700
    @test DatesPlus.yearwrap(2000, 12, -36) == 1997
    @test DatesPlus.yearwrap(2000, 12, -35) == 1998
    @test DatesPlus.yearwrap(2000, 12, -24) == 1998
    @test DatesPlus.yearwrap(2000, 12, -23) == 1999
    @test DatesPlus.yearwrap(2000, 12, -14) == 1999
    @test DatesPlus.yearwrap(2000, 12, -13) == 1999
    @test DatesPlus.yearwrap(2000, 12, -12) == 1999
    @test DatesPlus.yearwrap(2000, 12, -11) == 2000
    @test DatesPlus.yearwrap(2000, 12, -2) == 2000
    @test DatesPlus.yearwrap(2000, 12, -1) == 2000
    @test DatesPlus.yearwrap(2000, 12, 0) == 2000
    @test DatesPlus.yearwrap(2000, 12, 1) == 2001
    @test DatesPlus.yearwrap(2000, 12, 11) == 2001
    @test DatesPlus.yearwrap(2000, 12, 12) == 2001
    @test DatesPlus.yearwrap(2000, 12, 13) == 2002
    @test DatesPlus.yearwrap(2000, 12, 24) == 2002
    @test DatesPlus.yearwrap(2000, 12, 25) == 2003
    @test DatesPlus.yearwrap(2000, 12, 36) == 2003
    @test DatesPlus.yearwrap(2000, 12, 37) == 2004
    @test DatesPlus.yearwrap(2000, 12, 3600) == 2300
end
@testset "DateTime arithmetic" begin
    # DatesPlus.DateTime arithmetic
    a = DatesPlus.DateTime(2013, 1, 1, 0, 0, 0, 1)
    b = DatesPlus.DateTime(2013, 1, 1, 0, 0, 0, 0)
    @test a - b == DatesPlus.Millisecond(1)
    @test DatesPlus.DateTime(2013, 1, 2) - b == DatesPlus.Millisecond(86400000)

    @testset "DatesPlus.DateTime-Year arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Year(1) == DatesPlus.DateTime(2000, 12, 27)
        @test dt + DatesPlus.Year(100) == DatesPlus.DateTime(2099, 12, 27)
        @test dt + DatesPlus.Year(1000) == DatesPlus.DateTime(2999, 12, 27)
        @test dt - DatesPlus.Year(1) == DatesPlus.DateTime(1998, 12, 27)
        @test dt - DatesPlus.Year(100) == DatesPlus.DateTime(1899, 12, 27)
        @test dt - DatesPlus.Year(1000) == DatesPlus.DateTime(999, 12, 27)
        dt = DatesPlus.DateTime(2000, 2, 29)
        @test dt + DatesPlus.Year(1) == DatesPlus.DateTime(2001, 2, 28)
        @test dt - DatesPlus.Year(1) == DatesPlus.DateTime(1999, 2, 28)
        @test dt + DatesPlus.Year(4) == DatesPlus.DateTime(2004, 2, 29)
        @test dt - DatesPlus.Year(4) == DatesPlus.DateTime(1996, 2, 29)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Year(1) == DatesPlus.DateTime(1973, 6, 30, 23, 59, 59)
        @test dt - DatesPlus.Year(1) == DatesPlus.DateTime(1971, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Year(-1) == DatesPlus.DateTime(1971, 6, 30, 23, 59, 59)
        @test dt - DatesPlus.Year(-1) == DatesPlus.DateTime(1973, 6, 30, 23, 59, 59)

        dt = DatesPlus.DateTime(2000, 1, 1, 12, 30, 45, 500)
        dt2 = dt + DatesPlus.Year(1)
        @test DatesPlus.year(dt2) == 2001
        @test DatesPlus.month(dt2) == 1
        @test DatesPlus.day(dt2) == 1
        @test DatesPlus.hour(dt2) == 12
        @test DatesPlus.minute(dt2) == 30
        @test DatesPlus.second(dt2) == 45
        @test DatesPlus.millisecond(dt2) == 500
    end
    @testset "DateTime-Quarter arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Quarter(1) == DatesPlus.DateTime(2000, 3, 27)
        @test dt + DatesPlus.Quarter(-1) == DatesPlus.DateTime(1999, 9, 27)
    end

    @testset "DateTime-Month arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Month(1) == DatesPlus.DateTime(2000, 1, 27)
        @test dt + DatesPlus.Month(-1) == DatesPlus.DateTime(1999, 11, 27)
        @test dt + DatesPlus.Month(-11) == DatesPlus.DateTime(1999, 1, 27)
        @test dt + DatesPlus.Month(11) == DatesPlus.DateTime(2000, 11, 27)
        @test dt + DatesPlus.Month(-12) == DatesPlus.DateTime(1998, 12, 27)
        @test dt + DatesPlus.Month(12) == DatesPlus.DateTime(2000, 12, 27)
        @test dt + DatesPlus.Month(13) == DatesPlus.DateTime(2001, 1, 27)
        @test dt + DatesPlus.Month(100) == DatesPlus.DateTime(2008, 4, 27)
        @test dt + DatesPlus.Month(1000) == DatesPlus.DateTime(2083, 4, 27)
        @test dt - DatesPlus.Month(1) == DatesPlus.DateTime(1999, 11, 27)
        @test dt - DatesPlus.Month(-1) == DatesPlus.DateTime(2000, 1, 27)
        @test dt - DatesPlus.Month(100) == DatesPlus.DateTime(1991, 8, 27)
        @test dt - DatesPlus.Month(1000) == DatesPlus.DateTime(1916, 8, 27)
        dt = DatesPlus.DateTime(2000, 2, 29)
        @test dt + DatesPlus.Month(1) == DatesPlus.DateTime(2000, 3, 29)
        @test dt - DatesPlus.Month(1) == DatesPlus.DateTime(2000, 1, 29)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Month(1) == DatesPlus.DateTime(1972, 7, 30, 23, 59, 59)
        @test dt - DatesPlus.Month(1) == DatesPlus.DateTime(1972, 5, 30, 23, 59, 59)
        @test dt + DatesPlus.Month(-1) == DatesPlus.DateTime(1972, 5, 30, 23, 59, 59)
    end
    @testset "DateTime-Week arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Week(1) == DatesPlus.DateTime(2000, 1, 3)
        @test dt + DatesPlus.Week(100) == DatesPlus.DateTime(2001, 11, 26)
        @test dt + DatesPlus.Week(1000) == DatesPlus.DateTime(2019, 2, 25)
        @test dt - DatesPlus.Week(1) == DatesPlus.DateTime(1999, 12, 20)
        @test dt - DatesPlus.Week(100) == DatesPlus.DateTime(1998, 1, 26)
        @test dt - DatesPlus.Week(1000) == DatesPlus.DateTime(1980, 10, 27)
        dt = DatesPlus.DateTime(2000, 2, 29)
        @test dt + DatesPlus.Week(1) == DatesPlus.DateTime(2000, 3, 7)
        @test dt - DatesPlus.Week(1) == DatesPlus.DateTime(2000, 2, 22)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Week(1) == DatesPlus.DateTime(1972, 7, 7, 23, 59, 59)
        @test dt - DatesPlus.Week(1) == DatesPlus.DateTime(1972, 6, 23, 23, 59, 59)
        @test dt + DatesPlus.Week(-1) == DatesPlus.DateTime(1972, 6, 23, 23, 59, 59)
    end
    @testset "DateTime-Day arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Day(1) == DatesPlus.DateTime(1999, 12, 28)
        @test dt + DatesPlus.Day(100) == DatesPlus.DateTime(2000, 4, 5)
        @test dt + DatesPlus.Day(1000) == DatesPlus.DateTime(2002, 9, 22)
        @test dt - DatesPlus.Day(1) == DatesPlus.DateTime(1999, 12, 26)
        @test dt - DatesPlus.Day(100) == DatesPlus.DateTime(1999, 9, 18)
        @test dt - DatesPlus.Day(1000) == DatesPlus.DateTime(1997, 4, 1)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Day(1) == DatesPlus.DateTime(1972, 7, 1, 23, 59, 59)
        @test dt - DatesPlus.Day(1) == DatesPlus.DateTime(1972, 6, 29, 23, 59, 59)
        @test dt + DatesPlus.Day(-1) == DatesPlus.DateTime(1972, 6, 29, 23, 59, 59)
    end
    @testset "DateTime-Hour arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Hour(1) == DatesPlus.DateTime(1999, 12, 27, 1)
        @test dt + DatesPlus.Hour(100) == DatesPlus.DateTime(1999, 12, 31, 4)
        @test dt + DatesPlus.Hour(1000) == DatesPlus.DateTime(2000, 2, 6, 16)
        @test dt - DatesPlus.Hour(1) == DatesPlus.DateTime(1999, 12, 26, 23)
        @test dt - DatesPlus.Hour(100) == DatesPlus.DateTime(1999, 12, 22, 20)
        @test dt - DatesPlus.Hour(1000) == DatesPlus.DateTime(1999, 11, 15, 8)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Hour(1) == DatesPlus.DateTime(1972, 7, 1, 0, 59, 59)
        @test dt - DatesPlus.Hour(1) == DatesPlus.DateTime(1972, 6, 30, 22, 59, 59)
        @test dt + DatesPlus.Hour(-1) == DatesPlus.DateTime(1972, 6, 30, 22, 59, 59)
    end
    @testset "DateTime-Minute arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Minute(1) == DatesPlus.DateTime(1999, 12, 27, 0, 1)
        @test dt + DatesPlus.Minute(100) == DatesPlus.DateTime(1999, 12, 27, 1, 40)
        @test dt + DatesPlus.Minute(1000) == DatesPlus.DateTime(1999, 12, 27, 16, 40)
        @test dt - DatesPlus.Minute(1) == DatesPlus.DateTime(1999, 12, 26, 23, 59)
        @test dt - DatesPlus.Minute(100) == DatesPlus.DateTime(1999, 12, 26, 22, 20)
        @test dt - DatesPlus.Minute(1000) == DatesPlus.DateTime(1999, 12, 26, 7, 20)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Minute(1) == DatesPlus.DateTime(1972, 7, 1, 0, 0, 59)
        @test dt - DatesPlus.Minute(1) == DatesPlus.DateTime(1972, 6, 30, 23, 58, 59)
        @test dt + DatesPlus.Minute(-1) == DatesPlus.DateTime(1972, 6, 30, 23, 58, 59)
    end
    @testset "DateTime-Second arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Second(1) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 1)
        @test dt + DatesPlus.Second(100) == DatesPlus.DateTime(1999, 12, 27, 0, 1, 40)
        @test dt + DatesPlus.Second(1000) == DatesPlus.DateTime(1999, 12, 27, 0, 16, 40)
        @test dt - DatesPlus.Second(1) == DatesPlus.DateTime(1999, 12, 26, 23, 59, 59)
        @test dt - DatesPlus.Second(100) == DatesPlus.DateTime(1999, 12, 26, 23, 58, 20)
        @test dt - DatesPlus.Second(1000) == DatesPlus.DateTime(1999, 12, 26, 23, 43, 20)
    end
    @testset "DateTime-Millisecond arithmetic" begin
        dt = DatesPlus.DateTime(1999, 12, 27)
        @test dt + DatesPlus.Millisecond(1) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 0, 1)
        @test dt + DatesPlus.Millisecond(100) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 0, 100)
        @test dt + DatesPlus.Millisecond(1000) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 1)
        @test dt - DatesPlus.Millisecond(1) == DatesPlus.DateTime(1999, 12, 26, 23, 59, 59, 999)
        @test dt - DatesPlus.Millisecond(100) == DatesPlus.DateTime(1999, 12, 26, 23, 59, 59, 900)
        @test dt - DatesPlus.Millisecond(1000) == DatesPlus.DateTime(1999, 12, 26, 23, 59, 59)
        dt = DatesPlus.DateTime(1972, 6, 30, 23, 59, 59)
        @test dt + DatesPlus.Millisecond(1) == DatesPlus.DateTime(1972, 6, 30, 23, 59, 59, 1)
        @test dt - DatesPlus.Millisecond(1) == DatesPlus.DateTime(1972, 6, 30, 23, 59, 58, 999)
        @test dt + DatesPlus.Millisecond(-1) == DatesPlus.DateTime(1972, 6, 30, 23, 59, 58, 999)
    end
end
@testset "Date arithmetic" begin
    @testset "Date-Year arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Year(1) == DatesPlus.Date(2000, 12, 27)
        @test dt + DatesPlus.Year(100) == DatesPlus.Date(2099, 12, 27)
        @test dt + DatesPlus.Year(1000) == DatesPlus.Date(2999, 12, 27)
        @test dt - DatesPlus.Year(1) == DatesPlus.Date(1998, 12, 27)
        @test dt - DatesPlus.Year(100) == DatesPlus.Date(1899, 12, 27)
        @test dt - DatesPlus.Year(1000) == DatesPlus.Date(999, 12, 27)
        dt = DatesPlus.Date(2000, 2, 29)
        @test dt + DatesPlus.Year(1) == DatesPlus.Date(2001, 2, 28)
        @test dt - DatesPlus.Year(1) == DatesPlus.Date(1999, 2, 28)
        @test dt + DatesPlus.Year(4) == DatesPlus.Date(2004, 2, 29)
        @test dt - DatesPlus.Year(4) == DatesPlus.Date(1996, 2, 29)
    end
    @testset "Date-Quarter arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Quarter(1) == DatesPlus.Date(2000, 3, 27)
        @test dt - DatesPlus.Quarter(1) == DatesPlus.Date(1999, 9, 27)
    end
    @testset "Date-Month arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Month(1) == DatesPlus.Date(2000, 1, 27)
        @test dt + DatesPlus.Month(100) == DatesPlus.Date(2008, 4, 27)
        @test dt + DatesPlus.Month(1000) == DatesPlus.Date(2083, 4, 27)
        @test dt - DatesPlus.Month(1) == DatesPlus.Date(1999, 11, 27)
        @test dt - DatesPlus.Month(100) == DatesPlus.Date(1991, 8, 27)
        @test dt - DatesPlus.Month(1000) == DatesPlus.Date(1916, 8, 27)
        dt = DatesPlus.Date(2000, 2, 29)
        @test dt + DatesPlus.Month(1) == DatesPlus.Date(2000, 3, 29)
        @test dt - DatesPlus.Month(1) == DatesPlus.Date(2000, 1, 29)
    end
    @testset "Date-Week arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Week(1) == DatesPlus.Date(2000, 1, 3)
        @test dt + DatesPlus.Week(100) == DatesPlus.Date(2001, 11, 26)
        @test dt + DatesPlus.Week(1000) == DatesPlus.Date(2019, 2, 25)
        @test dt - DatesPlus.Week(1) == DatesPlus.Date(1999, 12, 20)
        @test dt - DatesPlus.Week(100) == DatesPlus.Date(1998, 1, 26)
        @test dt - DatesPlus.Week(1000) == DatesPlus.Date(1980, 10, 27)
        dt = DatesPlus.Date(2000, 2, 29)
        @test dt + DatesPlus.Week(1) == DatesPlus.Date(2000, 3, 7)
        @test dt - DatesPlus.Week(1) == DatesPlus.Date(2000, 2, 22)
    end
    @testset "Date-Day arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Day(1) == DatesPlus.Date(1999, 12, 28)
        @test dt + DatesPlus.Day(100) == DatesPlus.Date(2000, 4, 5)
        @test dt + DatesPlus.Day(1000) == DatesPlus.Date(2002, 9, 22)
        @test dt - DatesPlus.Day(1) == DatesPlus.Date(1999, 12, 26)
        @test dt - DatesPlus.Day(100) == DatesPlus.Date(1999, 9, 18)
        @test dt - DatesPlus.Day(1000) == DatesPlus.Date(1997, 4, 1)
    end
    @testset "Date-Time arithmetic" begin
        dt = DatesPlus.Date(1999, 12, 27)
        @test dt + DatesPlus.Time(0, 0, 0) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 0)
        @test dt + DatesPlus.Time(1, 0, 0) == DatesPlus.DateTime(1999, 12, 27, 1, 0, 0)
        @test dt + DatesPlus.Time(0, 1, 0) == DatesPlus.DateTime(1999, 12, 27, 0, 1, 0)
        @test dt + DatesPlus.Time(0, 0, 1) == DatesPlus.DateTime(1999, 12, 27, 0, 0, 1)
        @test DatesPlus.Time(0, 0, 1) + dt == DatesPlus.DateTime(1999, 12, 27, 0, 0, 1)

        t = DatesPlus.Time(0, 0, 0) + DatesPlus.Hour(24)
        @test dt + t == DatesPlus.DateTime(1999, 12, 27, 0, 0, 0)
    end
end
@testset "Time-TimePeriod arithmetic" begin
    t = DatesPlus.Time(0)
    @test t + DatesPlus.Hour(1) == DatesPlus.Time(1)
    @test t - DatesPlus.Hour(1) == DatesPlus.Time(23)
    @test t - DatesPlus.Nanosecond(1) == DatesPlus.Time(23, 59, 59, 999, 999, 999)
    @test t + DatesPlus.Nanosecond(-1) == DatesPlus.Time(23, 59, 59, 999, 999, 999)
    @test t + DatesPlus.Hour(24) == t
    @test t + DatesPlus.Nanosecond(86400000000000) == t
    @test t - DatesPlus.Nanosecond(86400000000000) == t
    @test t + DatesPlus.Minute(1) == DatesPlus.Time(0, 1)
    @test t + DatesPlus.Second(1) == DatesPlus.Time(0, 0, 1)
    @test t + DatesPlus.Millisecond(1) == DatesPlus.Time(0, 0, 0, 1)
    @test t + DatesPlus.Microsecond(1) == DatesPlus.Time(0, 0, 0, 0, 1)
    @test_throws MethodError t + DatesPlus.Day(1)
    @testset "Time-TimePeriod arithmetic inequalities" begin
        t = DatesPlus.Time(4, 20)
        @test t - DatesPlus.Nanosecond(1) < t
        @test t + DatesPlus.Nanosecond(1) > t
        @test t + DatesPlus.Hour(24) < typemax(DatesPlus.Time)
        @test t - DatesPlus.Hour(24) > typemin(DatesPlus.Time)
        @test t + DatesPlus.Hour(23) < t
        @test t + DatesPlus.Hour(25) > t
    end
end
@testset "Month arithmetic and non-associativity" begin
    # Month arithmetic minimizes "edit distance", or number of changes
    # needed to get a correct answer
    # This approach results in a few cases of non-associativity
    a = DatesPlus.Date(2012, 1, 29)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 1, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 2, 29)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 3, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 4, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 5, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 6, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 8, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 9, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 10, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
    a = DatesPlus.Date(2012, 11, 30)
    @test (a + DatesPlus.Day(1)) + DatesPlus.Month(1) != (a + DatesPlus.Month(1)) + DatesPlus.Day(1)
end
@testset "Vectorized arithmetic" begin
    # Vectorized Time arithmetic
    a = DatesPlus.Time(1, 1, 1)
    dr = [a, a, a, a, a, a, a, a, a, a]
    b = a + DatesPlus.Hour(1)
    @test dr .+ DatesPlus.Hour(1) == repeat([b], 10)
    b = a + DatesPlus.Second(1)
    @test dr .+ DatesPlus.Second(1) == repeat([b], 10)
    b = a + DatesPlus.Millisecond(1)
    @test dr .+ DatesPlus.Millisecond(1) == repeat([b], 10)
    b = a + DatesPlus.Microsecond(1)
    @test dr .+ DatesPlus.Microsecond(1) == repeat([b], 10)
    b = a + DatesPlus.Nanosecond(1)
    @test dr .+ DatesPlus.Nanosecond(1) == repeat([b], 10)

    b = a - DatesPlus.Hour(1)
    @test dr .- DatesPlus.Hour(1) == repeat([b], 10)
    b = a - DatesPlus.Second(1)
    @test dr .- DatesPlus.Second(1) == repeat([b], 10)
    b = a - DatesPlus.Millisecond(1)
    @test dr .- DatesPlus.Millisecond(1) == repeat([b], 10)
    b = a - DatesPlus.Microsecond(1)
    @test dr .- DatesPlus.Microsecond(1) == repeat([b], 10)
    b = a - DatesPlus.Nanosecond(1)
    @test dr .- DatesPlus.Nanosecond(1) == repeat([b], 10)

    # Vectorized arithmetic
    a = DatesPlus.Date(2014, 1, 1)
    dr = [a, a, a, a, a, a, a, a, a, a]
    b = a + DatesPlus.Year(1)
    @test dr .+ DatesPlus.Year(1) == repeat([b], 10)
    b = a + DatesPlus.Month(1)
    @test dr .+ DatesPlus.Month(1) == repeat([b], 10)
    b = a + DatesPlus.Day(1)
    @test dr .+ DatesPlus.Day(1) == repeat([b], 10)
    b = a - DatesPlus.Year(1)
    @test dr .- DatesPlus.Year(1) == repeat([b], 10)
    b = a - DatesPlus.Month(1)
    @test dr .- DatesPlus.Month(1) == repeat([b], 10)
    b = a - DatesPlus.Day(1)
    @test dr .- DatesPlus.Day(1) == repeat([b], 10)

    # Vectorized arithmetic
    b = a + DatesPlus.Year(1)
    @test dr .+ DatesPlus.Year(1) == repeat([b], 10)
    b = a + DatesPlus.Month(1)
    @test dr .+ DatesPlus.Month(1) == repeat([b], 10)
    b = a + DatesPlus.Day(1)
    @test dr .+ DatesPlus.Day(1) == repeat([b], 10)
    b = a - DatesPlus.Year(1)
    @test dr .- DatesPlus.Year(1) == repeat([b], 10)
    b = a - DatesPlus.Month(1)
    @test dr .- DatesPlus.Month(1) == repeat([b], 10)
    b = a - DatesPlus.Day(1)
    @test dr .- DatesPlus.Day(1) == repeat([b], 10)
    t1 = [DatesPlus.Date(2009, 1, 1) DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 1, 3); DatesPlus.Date(2009, 2, 1) DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3)]
    t2 = [DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2010, 1, 3); DatesPlus.Date(2010, 2, 1) DatesPlus.Date(2009, 3, 2) DatesPlus.Date(2009, 2, 4)]
    t3 = [DatesPlus.DateTime(2009, 1, 1), DatesPlus.DateTime(2009, 1, 2), DatesPlus.DateTime(2009, 1, 3)]
    t4 = [DatesPlus.DateTime(2009, 1, 1, 0, 0, 1), DatesPlus.DateTime(2009, 1, 2, 0, 1), DatesPlus.DateTime(2009, 1, 3, 1)]
    t5 = [DatesPlus.Time(0, 0, 0) DatesPlus.Time(0, 0, 1) DatesPlus.Time(0, 0, 2); DatesPlus.Time(0, 1, 0) DatesPlus.Time(0, 2, 0) DatesPlus.Time(0, 3, 0)]

    @testset "TimeType, Array{TimeType}" begin
        @test DatesPlus.Date(2010, 1, 1) .- t1 == [DatesPlus.Day(365) DatesPlus.Day(364) DatesPlus.Day(363); DatesPlus.Day(334) DatesPlus.Day(333) DatesPlus.Day(332)]
        @test t1 .- DatesPlus.Date(2010, 1, 1) == [DatesPlus.Day(-365) DatesPlus.Day(-364) DatesPlus.Day(-363); DatesPlus.Day(-334) DatesPlus.Day(-333) DatesPlus.Day(-332)]
        @test DatesPlus.DateTime(2009, 1, 1) .- t3 == [DatesPlus.Millisecond(0), DatesPlus.Millisecond(-86400000), DatesPlus.Millisecond(-172800000)]
        @test t3 .- DatesPlus.DateTime(2009, 1, 1) == [DatesPlus.Millisecond(0), DatesPlus.Millisecond(86400000), DatesPlus.Millisecond(172800000)]
        @test DatesPlus.Time(2) .- t5 == [DatesPlus.Nanosecond(7200000000000) DatesPlus.Nanosecond(7199000000000) DatesPlus.Nanosecond(7198000000000);
                                      DatesPlus.Nanosecond(7140000000000) DatesPlus.Nanosecond(7080000000000) DatesPlus.Nanosecond(7020000000000)]
    end
    @testset "GeneralPeriod, Array{TimeType}" begin
        @test DatesPlus.Day(1) .+ t1 == [DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 1, 3) DatesPlus.Date(2009, 1, 4); DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4)]
        @test DatesPlus.Hour(1) .+ t3 == [DatesPlus.DateTime(2009, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1), DatesPlus.DateTime(2009, 1, 3, 1)]
        @test t1 .+ DatesPlus.Day(1) == [DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 1, 3) DatesPlus.Date(2009, 1, 4); DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4)]
        @test t3 .+ DatesPlus.Hour(1) == [DatesPlus.DateTime(2009, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1), DatesPlus.DateTime(2009, 1, 3, 1)]

        @test (DatesPlus.Month(1) + DatesPlus.Day(1)) .+ t1 == [DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4); DatesPlus.Date(2009, 3, 2) DatesPlus.Date(2009, 3, 3) DatesPlus.Date(2009, 3, 4)]
        @test (DatesPlus.Hour(1) + DatesPlus.Minute(1)) .+ t3 == [DatesPlus.DateTime(2009, 1, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1, 1), DatesPlus.DateTime(2009, 1, 3, 1, 1)]
        @test t1 .+ (DatesPlus.Month(1) + DatesPlus.Day(1)) == [DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4); DatesPlus.Date(2009, 3, 2) DatesPlus.Date(2009, 3, 3) DatesPlus.Date(2009, 3, 4)]
        @test t3 .+ (DatesPlus.Hour(1) + DatesPlus.Minute(1)) == [DatesPlus.DateTime(2009, 1, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1, 1), DatesPlus.DateTime(2009, 1, 3, 1, 1)]

        @test t1 .- DatesPlus.Day(1) == [DatesPlus.Date(2008, 12, 31) DatesPlus.Date(2009, 1, 1) DatesPlus.Date(2009, 1, 2); DatesPlus.Date(2009, 1, 31) DatesPlus.Date(2009, 2, 1) DatesPlus.Date(2009, 2, 2)]
        @test t3 .- DatesPlus.Hour(1) == [DatesPlus.DateTime(2008, 12, 31, 23), DatesPlus.DateTime(2009, 1, 1, 23), DatesPlus.DateTime(2009, 1, 2, 23)]

        @test t1 .- (DatesPlus.Month(1) + DatesPlus.Day(1)) == [DatesPlus.Date(2008, 11, 30) DatesPlus.Date(2008, 12, 1) DatesPlus.Date(2008, 12, 2); DatesPlus.Date(2008, 12, 31) DatesPlus.Date(2009, 1, 1) DatesPlus.Date(2009, 1, 2)]
        @test t3 .- (DatesPlus.Hour(1) + DatesPlus.Minute(1)) == [DatesPlus.DateTime(2008, 12, 31, 22, 59), DatesPlus.DateTime(2009, 1, 1, 22, 59), DatesPlus.DateTime(2009, 1, 2, 22, 59)]
    end
    @testset "#20205" begin
        # ensure commutative subtraction methods are not defined
        @test_throws MethodError DatesPlus.Day(1) .- t1
        @test_throws MethodError DatesPlus.Hour(1) .- t3
        @test_throws MethodError (DatesPlus.Month(1) + DatesPlus.Day(1)) .- t1
        @test_throws MethodError (DatesPlus.Hour(1) + DatesPlus.Minute(1)) .- t3
    end
    @testset "deprecated" begin
        @test DatesPlus.Date(2010, 1, 1) - t1 == [DatesPlus.Day(365) DatesPlus.Day(364) DatesPlus.Day(363); DatesPlus.Day(334) DatesPlus.Day(333) DatesPlus.Day(332)]
        @test t1 - DatesPlus.Date(2010, 1, 1) == [DatesPlus.Day(-365) DatesPlus.Day(-364) DatesPlus.Day(-363); DatesPlus.Day(-334) DatesPlus.Day(-333) DatesPlus.Day(-332)]
        @test DatesPlus.DateTime(2009, 1, 1) - t3 == [DatesPlus.Millisecond(0), DatesPlus.Millisecond(-86400000), DatesPlus.Millisecond(-172800000)]
        @test t3 - DatesPlus.DateTime(2009, 1, 1) == [DatesPlus.Millisecond(0), DatesPlus.Millisecond(86400000), DatesPlus.Millisecond(172800000)]
        @test DatesPlus.Day(1) + t1 == [DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 1, 3) DatesPlus.Date(2009, 1, 4); DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4)]
        @test DatesPlus.Hour(1) + t3 == [DatesPlus.DateTime(2009, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1), DatesPlus.DateTime(2009, 1, 3, 1)]
        @test t1 + DatesPlus.Day(1) == [DatesPlus.Date(2009, 1, 2) DatesPlus.Date(2009, 1, 3) DatesPlus.Date(2009, 1, 4); DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4)]
        @test t3 + DatesPlus.Hour(1) == [DatesPlus.DateTime(2009, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1), DatesPlus.DateTime(2009, 1, 3, 1)]
        @test t5 + DatesPlus.Hour(1) == [DatesPlus.Time(1, 0, 0) DatesPlus.Time(1, 0, 1) DatesPlus.Time(1, 0, 2); DatesPlus.Time(1, 1, 0) DatesPlus.Time(1, 2, 0) DatesPlus.Time(1, 3, 0)]
        @test (DatesPlus.Month(1) + DatesPlus.Day(1)) + t1 == [DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4); DatesPlus.Date(2009, 3, 2) DatesPlus.Date(2009, 3, 3) DatesPlus.Date(2009, 3, 4)]
        @test (DatesPlus.Hour(1) + DatesPlus.Minute(1)) + t3 == [DatesPlus.DateTime(2009, 1, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1, 1), DatesPlus.DateTime(2009, 1, 3, 1, 1)]
        @test t1 + (DatesPlus.Month(1) + DatesPlus.Day(1)) == [DatesPlus.Date(2009, 2, 2) DatesPlus.Date(2009, 2, 3) DatesPlus.Date(2009, 2, 4); DatesPlus.Date(2009, 3, 2) DatesPlus.Date(2009, 3, 3) DatesPlus.Date(2009, 3, 4)]
        @test t3 + (DatesPlus.Hour(1) + DatesPlus.Minute(1)) == [DatesPlus.DateTime(2009, 1, 1, 1, 1), DatesPlus.DateTime(2009, 1, 2, 1, 1), DatesPlus.DateTime(2009, 1, 3, 1, 1)]
        @test t1 - DatesPlus.Day(1) == [DatesPlus.Date(2008, 12, 31) DatesPlus.Date(2009, 1, 1) DatesPlus.Date(2009, 1, 2); DatesPlus.Date(2009, 1, 31) DatesPlus.Date(2009, 2, 1) DatesPlus.Date(2009, 2, 2)]
        @test t3 - DatesPlus.Hour(1) == [DatesPlus.DateTime(2008, 12, 31, 23), DatesPlus.DateTime(2009, 1, 1, 23), DatesPlus.DateTime(2009, 1, 2, 23)]
        @test t1 - (DatesPlus.Month(1) + DatesPlus.Day(1)) == [DatesPlus.Date(2008, 11, 30) DatesPlus.Date(2008, 12, 1) DatesPlus.Date(2008, 12, 2); DatesPlus.Date(2008, 12, 31) DatesPlus.Date(2009, 1, 1) DatesPlus.Date(2009, 1, 2)]
        @test t3 - (DatesPlus.Hour(1) + DatesPlus.Minute(1)) == [DatesPlus.DateTime(2008, 12, 31, 22, 59), DatesPlus.DateTime(2009, 1, 1, 22, 59), DatesPlus.DateTime(2009, 1, 2, 22, 59)]
        @test t2 - t1 == [DatesPlus.Day(1) DatesPlus.Day(31) DatesPlus.Day(365); DatesPlus.Day(365) DatesPlus.Day(28) DatesPlus.Day(1)]
        @test t4 - t3 == [DatesPlus.Millisecond(1000), DatesPlus.Millisecond(60000), DatesPlus.Millisecond(3600000)]
        @test (DatesPlus.Date(2009, 1, 1):DatesPlus.Week(1):DatesPlus.Date(2009, 1, 21)) - (DatesPlus.Date(2009, 1, 1):DatesPlus.Day(1):DatesPlus.Date(2009, 1, 3)) == [DatesPlus.Day(0), DatesPlus.Day(6), DatesPlus.Day(12)]
        @test (DatesPlus.DateTime(2009, 1, 1, 1, 1, 1):DatesPlus.Second(1):DatesPlus.DateTime(2009, 1, 1, 1, 1, 3)) - (DatesPlus.DateTime(2009, 1, 1, 1, 1):DatesPlus.Second(1):DatesPlus.DateTime(2009, 1, 1, 1, 1, 2)) == [DatesPlus.Second(1), DatesPlus.Second(1), DatesPlus.Second(1)]
        @test_throws MethodError DatesPlus.Day(1) - t1
        @test_throws MethodError DatesPlus.Hour(1) - t3
        @test_throws MethodError (DatesPlus.Month(1) + DatesPlus.Day(1)) - t1
        @test_throws MethodError (DatesPlus.Hour(1) + DatesPlus.Minute(1)) - t3
    end
    @testset "TimeZone" begin
        # best we can get in Dates as there is no other tz functionality
        @test ((a, b) -> now(typeof(a))).(UTC(), [1,2,3]) isa Vector{DateTime}
    end
end

@testset "Missing arithmetic" begin
    for t ∈ [Date, Time, Day, Month, Week, Year, Hour, Microsecond, Millisecond, Minute, Nanosecond, Second]
        @test ismissing(t(1) + missing)
        @test ismissing(missing + t(1))
        @test ismissing(t(1) - missing)
        @test ismissing(missing - t(1))
    end
end

@testset "Diff of dates" begin
    for t ∈ [Day, Week, Hour, Minute]
        a = DateTime(2021,1,1):t(1):DateTime(2021,2,1)
        d = diff(a)
        @test d == diff(collect(a))
        @test eltype(d) === typeof(a[1] - a[2])
    end
end

end
