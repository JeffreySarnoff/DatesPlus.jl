# This file is a part of Julia. License is MIT: https://julialang.org/license

module RoundingTests

using Test
using Dates

@testset "conversion to and from the rounding epoch (ISO 8601 year 0000)" begin
    @test DatesPlus.epochdays2date(-1) == DatesPlus.Date(-1, 12, 31)
    @test DatesPlus.epochdays2date(0) == DatesPlus.Date(0, 1, 1)
    @test DatesPlus.epochdays2date(1) == DatesPlus.Date(0, 1, 2)
    @test DatesPlus.epochdays2date(736329) == DatesPlus.Date(2016, 1, 1)
    @test DatesPlus.epochms2datetime(-86400000) == DatesPlus.DateTime(-1, 12, 31)
    @test DatesPlus.epochms2datetime(0) == DatesPlus.DateTime(0, 1, 1)
    @test DatesPlus.epochms2datetime(86400000) == DatesPlus.DateTime(0, 1, 2)
    @test DatesPlus.epochms2datetime(Int64(736329) * 86400000) == DatesPlus.DateTime(2016, 1, 1)
    @test DatesPlus.date2epochdays(DatesPlus.Date(-1, 12, 31)) == -1
    @test DatesPlus.date2epochdays(DatesPlus.Date(0, 1, 1)) == 0
    @test DatesPlus.date2epochdays(DatesPlus.Date(2016, 1, 1)) == 736329
    @test DatesPlus.datetime2epochms(DatesPlus.DateTime(-1, 12, 31)) == -86400000
    @test DatesPlus.datetime2epochms(DatesPlus.DateTime(0, 1, 1)) == 0
    @test DatesPlus.datetime2epochms(DatesPlus.DateTime(2016, 1, 1)) == Int64(736329) * 86400000
end
@testset "Basic rounding" begin
    dt = DatesPlus.Date(2016, 2, 28)    # Sunday
    @test floor(dt, DatesPlus.Year) == DatesPlus.Date(2016)
    @test floor(dt, DatesPlus.Year(5)) == DatesPlus.Date(2015)
    @test floor(dt, DatesPlus.Year(10)) == DatesPlus.Date(2010)
    @test floor(dt, DatesPlus.Quarter) == DatesPlus.Date(2016, 1)
    @test floor(dt, DatesPlus.Quarter(6)) == DatesPlus.Date(2016, 1)
    @test floor(dt, DatesPlus.Month) == DatesPlus.Date(2016, 2)
    @test floor(dt, DatesPlus.Month(6)) == DatesPlus.Date(2016, 1)
    @test floor(dt, DatesPlus.Week) == DatesPlus.toprev(dt, DatesPlus.Monday)
    @test ceil(dt, DatesPlus.Year) == DatesPlus.Date(2017)
    @test ceil(dt, DatesPlus.Year(5)) == DatesPlus.Date(2020)
    @test ceil(dt, DatesPlus.Quarter) == DatesPlus.Date(2016, 4)
    @test ceil(dt, DatesPlus.Quarter(6)) == DatesPlus.Date(2017, 7)
    @test ceil(dt, DatesPlus.Month) == DatesPlus.Date(2016, 3)
    @test ceil(dt, DatesPlus.Month(6)) == DatesPlus.Date(2016, 7)
    @test ceil(dt, DatesPlus.Week) == DatesPlus.tonext(dt, DatesPlus.Monday)
    @test round(dt, DatesPlus.Year) == DatesPlus.Date(2016)
    @test round(dt, DatesPlus.Month) == DatesPlus.Date(2016, 3)
    @test round(dt, DatesPlus.Week) == DatesPlus.Date(2016, 2, 29)

    dt = DatesPlus.DateTime(2016, 2, 28, 15, 10, 50, 500)
    @test floor(dt, DatesPlus.Day) == DatesPlus.DateTime(2016, 2, 28)
    @test floor(dt, DatesPlus.Hour) == DatesPlus.DateTime(2016, 2, 28, 15)
    @test floor(dt, DatesPlus.Hour(2)) == DatesPlus.DateTime(2016, 2, 28, 14)
    @test floor(dt, DatesPlus.Hour(12)) == DatesPlus.DateTime(2016, 2, 28, 12)
    @test floor(dt, DatesPlus.Minute) == DatesPlus.DateTime(2016, 2, 28, 15, 10)
    @test floor(dt, DatesPlus.Minute(15)) == DatesPlus.DateTime(2016, 2, 28, 15, 0)
    @test floor(dt, DatesPlus.Second) == DatesPlus.DateTime(2016, 2, 28, 15, 10, 50)
    @test floor(dt, DatesPlus.Second(30)) == DatesPlus.DateTime(2016, 2, 28, 15, 10, 30)
    @test ceil(dt, DatesPlus.Day) == DatesPlus.DateTime(2016, 2, 29)
    @test ceil(dt, DatesPlus.Hour) == DatesPlus.DateTime(2016, 2, 28, 16)
    @test ceil(dt, DatesPlus.Hour(2)) == DatesPlus.DateTime(2016, 2, 28, 16)
    @test ceil(dt, DatesPlus.Hour(12)) == DatesPlus.DateTime(2016, 2, 29, 0)
    @test ceil(dt, DatesPlus.Minute) == DatesPlus.DateTime(2016, 2, 28, 15, 11)
    @test ceil(dt, DatesPlus.Minute(15)) == DatesPlus.DateTime(2016, 2, 28, 15, 15)
    @test ceil(dt, DatesPlus.Second) == DatesPlus.DateTime(2016, 2, 28, 15, 10, 51)
    @test ceil(dt, DatesPlus.Second(30)) == DatesPlus.DateTime(2016, 2, 28, 15, 11, 0)
    @test round(dt, DatesPlus.Day) == DatesPlus.DateTime(2016, 2, 29)
    @test round(dt, DatesPlus.Hour) == DatesPlus.DateTime(2016, 2, 28, 15)
    @test round(dt, DatesPlus.Hour(2)) == DatesPlus.DateTime(2016, 2, 28, 16)
    @test round(dt, DatesPlus.Hour(12)) == DatesPlus.DateTime(2016, 2, 28, 12)
    @test round(dt, DatesPlus.Minute) == DatesPlus.DateTime(2016, 2, 28, 15, 11)
    @test round(dt, DatesPlus.Minute(15)) == DatesPlus.DateTime(2016, 2, 28, 15, 15)
    @test round(dt, DatesPlus.Second) == DatesPlus.DateTime(2016, 2, 28, 15, 10, 51)
    @test round(dt, DatesPlus.Second(30)) == DatesPlus.DateTime(2016, 2, 28, 15, 11, 0)
end
@testset "Rounding for dates at the rounding epoch (year 0000)" begin
    dt = DatesPlus.DateTime(0)
    @test floor(dt, DatesPlus.Year) == dt
    @test floor(dt, DatesPlus.Month) == dt
    @test floor(dt, DatesPlus.Week) == DatesPlus.Date(-1, 12, 27)   # Monday prior to 0000-01-01
    @test floor(DatesPlus.Date(-1, 12, 27), DatesPlus.Week) == DatesPlus.Date(-1, 12, 27)
    @test floor(dt, DatesPlus.Day) == dt
    @test floor(dt, DatesPlus.Hour) == dt
    @test floor(dt, DatesPlus.Minute) == dt
    @test floor(dt, DatesPlus.Second) == dt
    @test ceil(dt, DatesPlus.Year) == dt
    @test ceil(dt, DatesPlus.Month) == dt
    @test ceil(dt, DatesPlus.Week) == DatesPlus.Date(0, 1, 3)       # Monday following 0000-01-01
    @test ceil(DatesPlus.Date(0, 1, 3), DatesPlus.Week) == DatesPlus.Date(0, 1, 3)
    @test ceil(dt, DatesPlus.Day) == dt
    @test ceil(dt, DatesPlus.Hour) == dt
    @test ceil(dt, DatesPlus.Minute) == dt
    @test ceil(dt, DatesPlus.Second) == dt
end
@testset "Rounding for multiples of a period" begin
    # easiest to test close to rounding epoch
    dt = DatesPlus.DateTime(0, 1, 19, 19, 19, 19, 19)
    @test floor(dt, DatesPlus.Year(2)) == DateTime(0)
    @test floor(dt, DatesPlus.Month(2)) == DateTime(0, 1)       # Odd number; months are 1-indexed
    @test floor(dt, DatesPlus.Week(2)) == DateTime(0, 1, 17)    # Third Monday of 0000
    @test floor(dt, DatesPlus.Day(2)) == DateTime(0, 1, 19)     # Odd number; days are 1-indexed
    @test floor(dt, DatesPlus.Hour(2)) == DateTime(0, 1, 19, 18)
    @test floor(dt, DatesPlus.Minute(2)) == DateTime(0, 1, 19, 19, 18)
    @test floor(dt, DatesPlus.Second(2)) == DateTime(0, 1, 19, 19, 19, 18)
    @test ceil(dt, DatesPlus.Year(2)) == DateTime(2)
    @test ceil(dt, DatesPlus.Month(2)) == DateTime(0, 3)        # Odd number; months are 1-indexed
    @test ceil(dt, DatesPlus.Week(2)) == DateTime(0, 1, 31)     # Fifth Monday of 0000
    @test ceil(dt, DatesPlus.Day(2)) == DateTime(0, 1, 21)      # Odd number; days are 1-indexed
    @test ceil(dt, DatesPlus.Hour(2)) == DateTime(0, 1, 19, 20)
    @test ceil(dt, DatesPlus.Minute(2)) == DateTime(0, 1, 19, 19, 20)
    @test ceil(dt, DatesPlus.Second(2)) == DateTime(0, 1, 19, 19, 19, 20)
end
@testset "Rounding for dates with negative years" begin
    dt = DatesPlus.DateTime(-1, 12, 29, 19, 19, 19, 19)
    @test floor(dt, DatesPlus.Year(2)) == DateTime(-2)
    @test floor(dt, DatesPlus.Month(2)) == DateTime(-1, 11)     # Odd number; months are 1-indexed
    @test floor(dt, DatesPlus.Week(2)) == DateTime(-1, 12, 20)  # 2 weeks prior to 0000-01-03
    @test floor(dt, DatesPlus.Day(2)) == DateTime(-1, 12, 28)   # Even; 4 days prior to 0000-01-01
    @test floor(dt, DatesPlus.Hour(2)) == DateTime(-1, 12, 29, 18)
    @test floor(dt, DatesPlus.Minute(2)) == DateTime(-1, 12, 29, 19, 18)
    @test floor(dt, DatesPlus.Second(2)) == DateTime(-1, 12, 29, 19, 19, 18)
    @test ceil(dt, DatesPlus.Year(2)) == DateTime(0)
    @test ceil(dt, DatesPlus.Month(2)) == DateTime(0, 1)        # Odd number; months are 1-indexed
    @test ceil(dt, DatesPlus.Week(2)) == DateTime(0, 1, 3)      # First Monday of 0000
    @test ceil(dt, DatesPlus.Day(2)) == DateTime(-1, 12, 30)    # Even; 2 days prior to 0000-01-01
    @test ceil(dt, DatesPlus.Hour(2)) == DateTime(-1, 12, 29, 20)
    @test ceil(dt, DatesPlus.Minute(2)) == DateTime(-1, 12, 29, 19, 20)
    @test ceil(dt, DatesPlus.Second(2)) == DateTime(-1, 12, 29, 19, 19, 20)
end
@testset "Rounding for dates that should not need rounding" begin
    for dt in [DatesPlus.DateTime(2016, 1, 1), DatesPlus.DateTime(-2016, 1, 1)]
        local dt
        for p in [DatesPlus.Year, DatesPlus.Month, DatesPlus.Day, DatesPlus.Hour, DatesPlus.Minute, DatesPlus.Second]
            local p
            @test floor(dt, p) == dt
            @test ceil(dt, p) == dt
        end
    end
end
@testset "Various available RoundingModes" begin
    dt = DatesPlus.DateTime(2016, 2, 28, 12)
    @test round(dt, DatesPlus.Day, RoundNearestTiesUp) == DatesPlus.DateTime(2016, 2, 29)
    @test round(dt, DatesPlus.Day, RoundUp) == DatesPlus.DateTime(2016, 2, 29)
    @test round(dt, DatesPlus.Day, RoundDown) == DatesPlus.DateTime(2016, 2, 28)
    @test_throws DomainError round(dt, DatesPlus.Day, RoundNearest)
    @test_throws DomainError round(dt, DatesPlus.Day, RoundNearestTiesAway)
    @test_throws DomainError round(dt, DatesPlus.Day, RoundToZero)
    @test round(dt, DatesPlus.Day) == round(dt, DatesPlus.Day, RoundNearestTiesUp)
end
@testset "Rounding datetimes to invalid resolutions" begin
    dt = DatesPlus.DateTime(2016, 2, 28, 12, 15)
    for p in [DatesPlus.Year, DatesPlus.Month, DatesPlus.Week, DatesPlus.Day, DatesPlus.Hour]
        local p
        for v in [-1, 0]
            @test_throws DomainError floor(dt, p(v))
            @test_throws DomainError ceil(dt, p(v))
            @test_throws DomainError round(dt, p(v))
        end
    end
end
@testset "Rounding for periods" begin
    x = DatesPlus.Second(172799)
    @test floor(x, DatesPlus.Week) == DatesPlus.Week(0)
    @test floor(x, DatesPlus.Day) == DatesPlus.Day(1)
    @test floor(x, DatesPlus.Hour) == DatesPlus.Hour(47)
    @test floor(x, DatesPlus.Minute) == DatesPlus.Minute(2879)
    @test floor(x, DatesPlus.Second) == DatesPlus.Second(172799)
    @test floor(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(172799000)
    @test ceil(x, DatesPlus.Week) == DatesPlus.Week(1)
    @test ceil(x, DatesPlus.Day) == DatesPlus.Day(2)
    @test ceil(x, DatesPlus.Hour) == DatesPlus.Hour(48)
    @test ceil(x, DatesPlus.Minute) == DatesPlus.Minute(2880)
    @test ceil(x, DatesPlus.Second) == DatesPlus.Second(172799)
    @test ceil(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(172799000)
    @test round(x, DatesPlus.Week) == DatesPlus.Week(0)
    @test round(x, DatesPlus.Day) == DatesPlus.Day(2)
    @test round(x, DatesPlus.Hour) == DatesPlus.Hour(48)
    @test round(x, DatesPlus.Minute) == DatesPlus.Minute(2880)
    @test round(x, DatesPlus.Second) == DatesPlus.Second(172799)
    @test round(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(172799000)

    x = DatesPlus.Nanosecond(2000999999)
    @test floor(x, DatesPlus.Second) == DatesPlus.Second(2)
    @test floor(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(2000)
    @test floor(x, DatesPlus.Microsecond) == DatesPlus.Microsecond(2000999)
    @test floor(x, DatesPlus.Nanosecond) == x
    @test ceil(x, DatesPlus.Second) == DatesPlus.Second(3)
    @test ceil(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(2001)
    @test ceil(x, DatesPlus.Microsecond) == DatesPlus.Microsecond(2001000)
    @test ceil(x, DatesPlus.Nanosecond) == x
    @test round(x, DatesPlus.Second) == DatesPlus.Second(2)
    @test round(x, DatesPlus.Millisecond) == DatesPlus.Millisecond(2001)
    @test round(x, DatesPlus.Microsecond) == DatesPlus.Microsecond(2001000)
    @test round(x, DatesPlus.Nanosecond) == x
end

@testset "Rouding DateTime to Date" begin
    now_ = DateTime(2020, 9, 1, 13)
    for p in (Year, Month, Day)
        for r in (RoundUp, RoundDown)
            @test round(Date, now_, p, r) == round(Date(now_), p, r)
        end
        @test round(Date, now_, p) == round(Date, now_, p, RoundNearestTiesUp)
        @test floor(Date, now_, p) == round(Date, now_, p, RoundDown)
        @test ceil(Date, now_, p)  == round(Date, now_, p, RoundUp)
    end
end
@testset "Rounding for periods that should not need rounding" begin
    for x in [DatesPlus.Week(3), DatesPlus.Day(14), DatesPlus.Second(604800)]
        local x
        for p in [DatesPlus.Week, DatesPlus.Day, DatesPlus.Hour, DatesPlus.Second, DatesPlus.Millisecond, DatesPlus.Microsecond, DatesPlus.Nanosecond]
            local p
            @test floor(x, p) == p(x)
            @test ceil(x, p) == p(x)
        end
    end
end
@testset "Various available RoundingModes for periods" begin
    x = DatesPlus.Hour(36)
    @test round(x, DatesPlus.Day, RoundNearestTiesUp) == DatesPlus.Day(2)
    @test round(x, DatesPlus.Day, RoundUp) == DatesPlus.Day(2)
    @test round(x, DatesPlus.Day, RoundDown) == DatesPlus.Day(1)
    @test_throws DomainError round(x, DatesPlus.Day, RoundNearest)
    @test_throws DomainError round(x, DatesPlus.Day, RoundNearestTiesAway)
    @test_throws DomainError round(x, DatesPlus.Day, RoundToZero)
    @test round(x, DatesPlus.Day) == round(x, DatesPlus.Day, RoundNearestTiesUp)
end
@testset "Rounding periods to invalid resolutions" begin
    x = DatesPlus.Hour(86399)
    for p in [DatesPlus.Week, DatesPlus.Day, DatesPlus.Hour, DatesPlus.Second, DatesPlus.Millisecond, DatesPlus.Microsecond, DatesPlus.Nanosecond]
        local p
        for v in [-1, 0]
            @test_throws DomainError floor(x, p(v))
            @test_throws DomainError ceil(x, p(v))
            @test_throws DomainError round(x, p(v))
        end
    end
    for p in [DatesPlus.Year, DatesPlus.Month]
        local p
        for v in [-1, 0, 1]
            @test_throws MethodError floor(x, p(v))
            @test_throws MethodError ceil(x, p(v))
            @test_throws DomainError round(x, p(v))
        end
    end
end

end
