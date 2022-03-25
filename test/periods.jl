# This file is a part of Julia. License is MIT: https://julialang.org/license

module PeriodsTest

using Dates
using Test

@testset "basic arithmetic" begin
    @test -DatesPlus.Year(1) == DatesPlus.Year(-1)
    @test DatesPlus.Year(1) > DatesPlus.Year(0)
    @test (DatesPlus.Year(1) < DatesPlus.Year(0)) == false
    @test DatesPlus.Year(1) == DatesPlus.Year(1)
    @test DatesPlus.Year(1) != 1
    @test DatesPlus.Year(1) + DatesPlus.Year(1) == DatesPlus.Year(2)
    @test DatesPlus.Year(1) - DatesPlus.Year(1) == zero(DatesPlus.Year)
    @test 1 == one(DatesPlus.Year)
    @test_throws MethodError DatesPlus.Year(1) * DatesPlus.Year(1) == DatesPlus.Year(1)
    t = DatesPlus.Year(1)
    t2 = DatesPlus.Year(2)
    @test ([t, t, t, t, t] .+ DatesPlus.Year(1)) == ([t2, t2, t2, t2, t2])
    @test (DatesPlus.Year(1) .+ [t, t, t, t, t]) == ([t2, t2, t2, t2, t2])
    @test ([t2, t2, t2, t2, t2] .- DatesPlus.Year(1)) == ([t, t, t, t, t])
    @test_throws MethodError ([t, t, t, t, t] .* DatesPlus.Year(1)) == ([t, t, t, t, t])
    @test ([t, t, t, t, t] * 1) == ([t, t, t, t, t])
    @test ([t, t, t, t, t] .% t2) == ([t, t, t, t, t])
    @test div.([t, t, t, t, t], DatesPlus.Year(1)) == ([1, 1, 1, 1, 1])
    @test mod.([t, t, t, t, t], DatesPlus.Year(2)) == ([t, t, t, t, t])
    @test [t, t, t] / t2 == [0.5, 0.5, 0.5]
    @test abs(-t) == t
    @test sign(t) == sign(t2) == 1
    @test sign(-t) == sign(-t2) == -1
    @test sign(DatesPlus.Year(0)) == 0
end
@testset "div/mod/gcd/lcm/rem" begin
    @test DatesPlus.Year(10) % DatesPlus.Year(4) == DatesPlus.Year(2)
    @test gcd(DatesPlus.Year(10), DatesPlus.Year(4)) == DatesPlus.Year(2)
    @test lcm(DatesPlus.Year(10), DatesPlus.Year(4)) == DatesPlus.Year(20)
    @test div(DatesPlus.Year(10), DatesPlus.Year(3)) == 3
    @test div(DatesPlus.Year(10), DatesPlus.Year(4)) == 2
    @test div(DatesPlus.Year(10), 4) == DatesPlus.Year(2)
    @test DatesPlus.Year(10) / DatesPlus.Year(4) == 2.5

    @test mod(DatesPlus.Year(10), DatesPlus.Year(4)) == DatesPlus.Year(2)
    @test mod(DatesPlus.Year(-10), DatesPlus.Year(4)) == DatesPlus.Year(2)
    @test mod(DatesPlus.Year(10), 4) == DatesPlus.Year(2)
    @test mod(DatesPlus.Year(-10), 4) == DatesPlus.Year(2)

    @test rem(DatesPlus.Year(10), DatesPlus.Year(4)) == DatesPlus.Year(2)
    @test rem(DatesPlus.Year(-10), DatesPlus.Year(4)) == DatesPlus.Year(-2)
    @test rem(DatesPlus.Year(10), 4) == DatesPlus.Year(2)
    @test rem(DatesPlus.Year(-10), 4) == DatesPlus.Year(-2)
end

y = DatesPlus.Year(1)
q = DatesPlus.Quarter(1)
m = DatesPlus.Month(1)
w = DatesPlus.Week(1)
d = DatesPlus.Day(1)
h = DatesPlus.Hour(1)
mi = DatesPlus.Minute(1)
s = DatesPlus.Second(1)
ms = DatesPlus.Millisecond(1)
us = DatesPlus.Microsecond(1)
ns = DatesPlus.Nanosecond(1)
emptyperiod = ((y + d) - d) - y
@testset "Period arithmetic" begin
    @test DatesPlus.Year(y) == y
    @test DatesPlus.Quarter(q) == q
    @test DatesPlus.Month(m) == m
    @test DatesPlus.Week(w) == w
    @test DatesPlus.Day(d) == d
    @test DatesPlus.Hour(h) == h
    @test DatesPlus.Minute(mi) == mi
    @test DatesPlus.Second(s) == s
    @test DatesPlus.Millisecond(ms) == ms
    @test DatesPlus.Microsecond(us) == us
    @test DatesPlus.Nanosecond(ns) == ns
    @test DatesPlus.Year(convert(Int8, 1)) == y
    @test DatesPlus.Year(convert(UInt8, 1)) == y
    @test DatesPlus.Year(convert(Int16, 1)) == y
    @test DatesPlus.Year(convert(UInt16, 1)) == y
    @test DatesPlus.Year(convert(Int32, 1)) == y
    @test DatesPlus.Year(convert(UInt32, 1)) == y
    @test DatesPlus.Year(convert(Int64, 1)) == y
    @test DatesPlus.Year(convert(UInt64, 1)) == y
    @test DatesPlus.Year(convert(Int128, 1)) == y
    @test DatesPlus.Year(convert(UInt128, 1)) == y
    @test DatesPlus.Year(convert(BigInt, 1)) == y
    @test DatesPlus.Year(convert(BigFloat, 1)) == y
    @test DatesPlus.Year(convert(Complex, 1)) == y
    @test DatesPlus.Year(convert(Rational, 1)) == y
    @test DatesPlus.Year(convert(Float16, 1)) == y
    @test DatesPlus.Year(convert(Float32, 1)) == y
    @test DatesPlus.Year(convert(Float64, 1)) == y
    @test y == y
    @test m == m
    @test w == w
    @test d == d
    @test h == h
    @test mi == mi
    @test s == s
    @test ms == ms
    @test us == us
    @test ns == ns
    y2 = DatesPlus.Year(2)
    @test y < y2
    @test y2 > y
    @test y != y2

    @test DatesPlus.Year(Int8(1)) == y
    @test DatesPlus.Year(UInt8(1)) == y
    @test DatesPlus.Year(Int16(1)) == y
    @test DatesPlus.Year(UInt16(1)) == y
    @test DatesPlus.Year(Int(1)) == y
    @test DatesPlus.Year(UInt(1)) == y
    @test DatesPlus.Year(Int64(1)) == y
    @test DatesPlus.Year(UInt64(1)) == y
    @test DatesPlus.Year(UInt128(1)) == y
    @test DatesPlus.Year(UInt128(1)) == y
    @test DatesPlus.Year(big(1)) == y
    @test DatesPlus.Year(BigFloat(1)) == y
    @test DatesPlus.Year(float(1)) == y
    @test DatesPlus.Year(Float32(1)) == y
    @test DatesPlus.Year(Rational(1)) == y
    @test DatesPlus.Year(complex(1)) == y
    @test_throws InexactError DatesPlus.Year(BigFloat(1.2)) == y
    @test_throws InexactError DatesPlus.Year(1.2) == y
    @test_throws InexactError DatesPlus.Year(Float32(1.2)) == y
    @test_throws InexactError DatesPlus.Year(3//4) == y
    @test_throws InexactError DatesPlus.Year(complex(1.2)) == y
    @test_throws InexactError DatesPlus.Year(Float16(1.2)) == y
    @test DatesPlus.Year(true) == y
    @test DatesPlus.Year(false) != y
    @test_throws MethodError DatesPlus.Year(:hey) == y
    @test DatesPlus.Year(real(1)) == y
    @test_throws InexactError DatesPlus.Year(m) == y
    @test_throws MethodError DatesPlus.Year(w) == y
    @test_throws MethodError DatesPlus.Year(d) == y
    @test_throws MethodError DatesPlus.Year(h) == y
    @test_throws MethodError DatesPlus.Year(mi) == y
    @test_throws MethodError DatesPlus.Year(s) == y
    @test_throws MethodError DatesPlus.Year(ms) == y
    @test DatesPlus.Year(DatesPlus.Date(2013, 1, 1)) == DatesPlus.Year(2013)
    @test DatesPlus.Year(DatesPlus.DateTime(2013, 1, 1)) == DatesPlus.Year(2013)
    @test typeof(y + m) <: DatesPlus.CompoundPeriod
    @test typeof(m + y) <: DatesPlus.CompoundPeriod
    @test typeof(y + w) <: DatesPlus.CompoundPeriod
    @test typeof(y + d) <: DatesPlus.CompoundPeriod
    @test typeof(y + h) <: DatesPlus.CompoundPeriod
    @test typeof(y + mi) <: DatesPlus.CompoundPeriod
    @test typeof(y + s) <: DatesPlus.CompoundPeriod
    @test typeof(y + ms) <: DatesPlus.CompoundPeriod
    @test typeof(y + us) <: DatesPlus.CompoundPeriod
    @test typeof(y + ns) <: DatesPlus.CompoundPeriod
    @test y > m
    @test d < w
    @test mi < h
    @test ms < h
    @test ms < mi
    @test us < ms
    @test ns < ms
    @test ns < us
    @test ns < w
    @test us < w
    @test typemax(DatesPlus.Year) == DatesPlus.Year(typemax(Int64))
    @test typemax(DatesPlus.Year) + y == DatesPlus.Year(-9223372036854775808)
    @test typemin(DatesPlus.Year) == DatesPlus.Year(-9223372036854775808)
end
@testset "Period-Real arithmetic" begin
    @test_throws MethodError y + 1 == DatesPlus.Year(2)
    @test_throws MethodError y + true == DatesPlus.Year(2)
    @test_throws InexactError y + DatesPlus.Year(1.2)
    @test y + DatesPlus.Year(1f0) == DatesPlus.Year(2)
    @test y * 4 == DatesPlus.Year(4)
    @test y * 4f0 == DatesPlus.Year(4)
    @test DatesPlus.Year(2) * 0.5 == y
    @test DatesPlus.Year(2) * 3//2 == DatesPlus.Year(3)
    @test_throws InexactError y * 0.5
    @test_throws InexactError y * 3//4
    @test (1:1:5)*Second(5) === Second(5)*(1:1:5) === Second(5):Second(5):Second(25) === (1:5)*Second(5)
    @test collect(1:1:5)*Second(5) == Second(5)*collect(1:1:5) == (1:5)*Second(5)
    @test (Second(2):Second(2):Second(10))/Second(2) === 1.0:1.0:5.0 == collect(Second(2):Second(2):Second(10))/Second(2)
    @test (Second(2):Second(2):Second(10)) / 2 == Second(1):Second(1):Second(5) == collect(Second(2):Second(2):Second(10)) / 2
    @test DatesPlus.Year(4) / 2 == DatesPlus.Year(2)
    @test DatesPlus.Year(4) / 2f0 == DatesPlus.Year(2)
    @test DatesPlus.Year(4) / 0.5 == DatesPlus.Year(8)
    @test DatesPlus.Year(4) / 2//3 == DatesPlus.Year(6)
    @test_throws InexactError DatesPlus.Year(4) / 3.0
    @test_throws InexactError DatesPlus.Year(4) / 3//2
    @test div(y, 2) == DatesPlus.Year(0)
    @test_throws MethodError div(2, y) == DatesPlus.Year(2)
    @test div(y, y) == 1
    @test y*10 % DatesPlus.Year(5) == DatesPlus.Year(0)
    @test_throws MethodError (y > 3) == false
    @test_throws MethodError (4 < y) == false
    @test 1 != y
    t = [y, y, y, y, y]
    @test t .+ DatesPlus.Year(2) == [DatesPlus.Year(3), DatesPlus.Year(3), DatesPlus.Year(3), DatesPlus.Year(3), DatesPlus.Year(3)]

    let x = DatesPlus.Year(5), y = DatesPlus.Year(2)
        @test div(x, y) * y + rem(x, y) == x
        @test fld(x, y) * y + mod(x, y) == x
    end
end
@testset "Associativity" begin
    dt = DatesPlus.DateTime(2012, 12, 21)
    test = ((((((((dt + y) - m) + w) - d) + h) - mi) + s) - ms)
    @test test == dt + y - m + w - d + h - mi + s - ms
    @test test == y - m + w - d + dt + h - mi + s - ms
    @test test == dt - m + y - d + w - mi + h - ms + s
    @test test == dt + (y - m + w - d + h - mi + s - ms)
    @test test == dt + y - m + w - d + (h - mi + s - ms)
    @test (dt + DatesPlus.Year(4)) + DatesPlus.Day(1) == dt + (DatesPlus.Year(4) + DatesPlus.Day(1))
    @test DatesPlus.Date(2014, 1, 29) + DatesPlus.Month(1) + DatesPlus.Day(1) + DatesPlus.Month(1) + DatesPlus.Day(1) ==
        DatesPlus.Date(2014, 1, 29) + DatesPlus.Day(1) + DatesPlus.Month(1) + DatesPlus.Month(1) + DatesPlus.Day(1)
    @test DatesPlus.Date(2014, 1, 29) + DatesPlus.Month(1) + DatesPlus.Day(1) == DatesPlus.Date(2014, 1, 29) + DatesPlus.Day(1) + DatesPlus.Month(1)
end
@testset "traits" begin
    @test DatesPlus._units(DatesPlus.Year(0)) == " years"
    @test DatesPlus._units(DatesPlus.Year(1)) == " year"
    @test DatesPlus._units(DatesPlus.Year(-1)) == " year"
    @test DatesPlus._units(DatesPlus.Year(2)) == " years"
    @test DatesPlus.string(DatesPlus.Year(0)) == "0 years"
    @test DatesPlus.string(DatesPlus.Year(1)) == "1 year"
    @test DatesPlus.string(DatesPlus.Year(-1)) == "-1 year"
    @test DatesPlus.string(DatesPlus.Year(2)) == "2 years"
    @test isfinite(DatesPlus.Year)
    @test isfinite(DatesPlus.Year(0))
    @test zero(DatesPlus.Year) == DatesPlus.Year(0)
    @test zero(DatesPlus.Year(10)) == DatesPlus.Year(0)
    @test zero(DatesPlus.Month) == DatesPlus.Month(0)
    @test zero(DatesPlus.Month(10)) == DatesPlus.Month(0)
    @test zero(DatesPlus.Day) == DatesPlus.Day(0)
    @test zero(DatesPlus.Day(10)) == DatesPlus.Day(0)
    @test zero(DatesPlus.Hour) == DatesPlus.Hour(0)
    @test zero(DatesPlus.Hour(10)) == DatesPlus.Hour(0)
    @test zero(DatesPlus.Minute) == DatesPlus.Minute(0)
    @test zero(DatesPlus.Minute(10)) == DatesPlus.Minute(0)
    @test zero(DatesPlus.Second) == DatesPlus.Second(0)
    @test zero(DatesPlus.Second(10)) == DatesPlus.Second(0)
    @test zero(DatesPlus.Millisecond) == DatesPlus.Millisecond(0)
    @test zero(DatesPlus.Millisecond(10)) == DatesPlus.Millisecond(0)
    @test DatesPlus.Year(-1) < DatesPlus.Year(1)
    @test !(DatesPlus.Year(-1) > DatesPlus.Year(1))
    @test DatesPlus.Year(1) == DatesPlus.Year(1)
    @test DatesPlus.Year(1) != 1
    @test 1 != DatesPlus.Year(1)
    @test DatesPlus.Month(-1) < DatesPlus.Month(1)
    @test !(DatesPlus.Month(-1) > DatesPlus.Month(1))
    @test DatesPlus.Month(1) == DatesPlus.Month(1)
    @test DatesPlus.Day(-1) < DatesPlus.Day(1)
    @test !(DatesPlus.Day(-1) > DatesPlus.Day(1))
    @test DatesPlus.Day(1) == DatesPlus.Day(1)
    @test DatesPlus.Hour(-1) < DatesPlus.Hour(1)
    @test !(DatesPlus.Hour(-1) > DatesPlus.Hour(1))
    @test DatesPlus.Hour(1) == DatesPlus.Hour(1)
    @test DatesPlus.Minute(-1) < DatesPlus.Minute(1)
    @test !(DatesPlus.Minute(-1) > DatesPlus.Minute(1))
    @test DatesPlus.Minute(1) == DatesPlus.Minute(1)
    @test DatesPlus.Second(-1) < DatesPlus.Second(1)
    @test !(DatesPlus.Second(-1) > DatesPlus.Second(1))
    @test DatesPlus.Second(1) == DatesPlus.Second(1)
    @test DatesPlus.Millisecond(-1) < DatesPlus.Millisecond(1)
    @test !(DatesPlus.Millisecond(-1) > DatesPlus.Millisecond(1))
    @test DatesPlus.Millisecond(1) == DatesPlus.Millisecond(1)
    @test_throws MethodError DatesPlus.Year(1) < DatesPlus.Millisecond(1)
    @test_throws MethodError DatesPlus.Millisecond(1) < DatesPlus.Year(1)

    # issue #27076
    @test DatesPlus.Year(1) != DatesPlus.Millisecond(1)
    @test DatesPlus.Millisecond(1) != DatesPlus.Year(1)
end

struct Beat <: DatesPlus.Period
    value::Int64
end

Beat(p::Period) = Beat(DatesPlus.toms(p) ÷ 86400)

@testset "comparisons with new subtypes of Period" begin
    # https://en.wikipedia.org/wiki/Swatch_Internet_Time
    DatesPlus.value(b::Beat) = b.value
    DatesPlus.toms(b::Beat) = DatesPlus.value(b) * 86400
    DatesPlus._units(b::Beat) = " beat" * (abs(DatesPlus.value(b)) == 1 ? "" : "s")
    Base.promote_rule(::Type{DatesPlus.Day}, ::Type{Beat}) = DatesPlus.Millisecond
    Base.convert(::Type{T}, b::Beat) where {T<:DatesPlus.Millisecond} = T(DatesPlus.toms(b))

    @test Beat(1000) == DatesPlus.Day(1)
    @test Beat(1) < DatesPlus.Day(1)
end

@testset "basic properties" begin
    @test DatesPlus.Year("1") == y
    @test DatesPlus.Quarter("1") == q
    @test DatesPlus.Month("1") == m
    @test DatesPlus.Week("1") == w
    @test DatesPlus.Day("1") == d
    @test DatesPlus.Hour("1") == h
    @test DatesPlus.Minute("1") == mi
    @test DatesPlus.Second("1") == s
    @test DatesPlus.Millisecond("1") == ms
    @test DatesPlus.Microsecond("1") == us
    @test DatesPlus.Nanosecond("1") == ns
    @test_throws ArgumentError DatesPlus.Year("1.0")
    @test DatesPlus.Year(parse(Float64, "1.0")) == y

    dt = DatesPlus.DateTime(2014)
    @test typeof(DatesPlus.Year(dt)) <: DatesPlus.Year
    @test typeof(DatesPlus.Quarter(dt)) <: DatesPlus.Quarter
    @test typeof(DatesPlus.Month(dt)) <: DatesPlus.Month
    @test typeof(DatesPlus.Week(dt)) <: DatesPlus.Week
    @test typeof(DatesPlus.Day(dt)) <: DatesPlus.Day
    @test typeof(DatesPlus.Hour(dt)) <: DatesPlus.Hour
    @test typeof(DatesPlus.Minute(dt)) <: DatesPlus.Minute
    @test typeof(DatesPlus.Second(dt)) <: DatesPlus.Second
    @test typeof(DatesPlus.Millisecond(dt)) <: DatesPlus.Millisecond
end
@testset "Default values" begin
    @test DatesPlus.default(DatesPlus.Year) == y
    @test DatesPlus.default(DatesPlus.Quarter) == q
    @test DatesPlus.default(DatesPlus.Month) == m
    @test DatesPlus.default(DatesPlus.Week) == w
    @test DatesPlus.default(DatesPlus.Day) == d
    @test DatesPlus.default(DatesPlus.Hour) == zero(DatesPlus.Hour)
    @test DatesPlus.default(DatesPlus.Minute) == zero(DatesPlus.Minute)
    @test DatesPlus.default(DatesPlus.Second) == zero(DatesPlus.Second)
    @test DatesPlus.default(DatesPlus.Millisecond) == zero(DatesPlus.Millisecond)
    @test DatesPlus.default(DatesPlus.Microsecond) == zero(DatesPlus.Microsecond)
    @test DatesPlus.default(DatesPlus.Nanosecond) == zero(DatesPlus.Nanosecond)
end
@testset "Conversions" begin
    @test DatesPlus.toms(ms) == DatesPlus.value(DatesPlus.Millisecond(ms)) == 1
    @test DatesPlus.toms(s)  == DatesPlus.value(DatesPlus.Millisecond(s)) == 1000
    @test DatesPlus.toms(mi) == DatesPlus.value(DatesPlus.Millisecond(mi)) == 60000
    @test DatesPlus.toms(h)  == DatesPlus.value(DatesPlus.Millisecond(h)) == 3600000
    @test DatesPlus.toms(d)  == DatesPlus.value(DatesPlus.Millisecond(d)) == 86400000
    @test DatesPlus.toms(w)  == DatesPlus.value(DatesPlus.Millisecond(w)) == 604800000

    @test DatesPlus.days(ms) == DatesPlus.days(s) == DatesPlus.days(mi) == DatesPlus.days(h) == 0
    @test DatesPlus.days(DatesPlus.Millisecond(86400000)) == 1
    @test DatesPlus.days(DatesPlus.Second(86400)) == 1
    @test DatesPlus.days(DatesPlus.Minute(1440)) == 1
    @test DatesPlus.days(DatesPlus.Hour(24)) == 1
    @test DatesPlus.days(d) == 1
    @test DatesPlus.days(w) == 7
end
@testset "issue #9214" begin
    @test 2s + (7ms + 1ms) == (2s + 7ms) + 1ms == 1ms + (2s + 7ms) == 1ms + (1s + 7ms) + 1s == 1ms + (2s + 3d + 7ms) + (-3d) == (1ms + (2s + 3d)) + (7ms - 3d) == (1ms + (2s + 3d)) - (3d - 7ms)
    @test 1ms - (2s + 7ms) == -((2s + 7ms) - 1ms) == (-6ms) - 2s
    @test emptyperiod == ((d + y) - y) - d == ((d + y) - d) - y
    @test emptyperiod == 2y + (m - d) + ms - ((m - d) + 2y + ms)
    @test emptyperiod == 0ms
    @test string(emptyperiod) == "empty period"
    @test string(ms + mi + d + m + y + w + h + s + 2y + m) == "3 years, 2 months, 1 week, 1 day, 1 hour, 1 minute, 1 second, 1 millisecond"
    @test 8d - s == 1w + 23h + 59mi + 59s
    @test h + 3mi == 63mi
    @test y - m == 11m
end
@testset "compound periods and types" begin
    # compound periods should avoid automatically converting period types
    @test (d - h).periods == DatesPlus.Period[d, -h]
    @test d - h == 23h
    @test !isequal(d - h, 23h)
    @test isequal(d - h, 2d - 2h - 1d + 1h)
    @test sprint(show, y + m) == string(y + m)
    @test convert(DatesPlus.CompoundPeriod, y) + m == y + m
    @test DatesPlus.periods(convert(DatesPlus.CompoundPeriod, y)) == convert(DatesPlus.CompoundPeriod, y).periods
end
@testset "compound period simplification" begin
    # reduce compound periods into the most basic form
    @test DatesPlus.canonicalize(h - mi).periods == DatesPlus.Period[59mi]
    @test DatesPlus.canonicalize(-h + mi).periods == DatesPlus.Period[-59mi]
    @test DatesPlus.canonicalize(-y + d).periods == DatesPlus.Period[-y, d]
    @test DatesPlus.canonicalize(-y + m - w + d).periods == DatesPlus.Period[-11m, -6d]
    @test DatesPlus.canonicalize(-y + m - w + ms).periods == DatesPlus.Period[-11m, -6d, -23h, -59mi, -59s, -999ms]
    @test DatesPlus.canonicalize(y - m + w - d + h - mi + s - ms).periods == DatesPlus.Period[11m, 6d, 59mi, 999ms]
    @test DatesPlus.canonicalize(-y + m - w + d - h + mi - s + ms).periods == DatesPlus.Period[-11m, -6d, -59mi, -999ms]

    @test DatesPlus.Date(2009, 2, 1) - (DatesPlus.Month(1) + DatesPlus.Day(1)) == DatesPlus.Date(2008, 12, 31)
    @test_throws MethodError (DatesPlus.Month(1) + DatesPlus.Day(1)) - DatesPlus.Date(2009,2,1)
end

@testset "canonicalize Period" begin
    # reduce individual Period into most basic CompoundPeriod
    @test DatesPlus.canonicalize(DatesPlus.Nanosecond(1000000)) == DatesPlus.canonicalize(DatesPlus.Millisecond(1))
    @test DatesPlus.canonicalize(DatesPlus.Millisecond(1000)) == DatesPlus.canonicalize(DatesPlus.Second(1))
    @test DatesPlus.canonicalize(DatesPlus.Second(60)) == DatesPlus.canonicalize(DatesPlus.Minute(1))
    @test DatesPlus.canonicalize(DatesPlus.Minute(60)) == DatesPlus.canonicalize(DatesPlus.Hour(1))
    @test DatesPlus.canonicalize(DatesPlus.Hour(24)) == DatesPlus.canonicalize(DatesPlus.Day(1))
    @test DatesPlus.canonicalize(DatesPlus.Day(7)) == DatesPlus.canonicalize(DatesPlus.Week(1))
    @test DatesPlus.canonicalize(DatesPlus.Month(12)) == DatesPlus.canonicalize(DatesPlus.Year(1))
    @test DatesPlus.canonicalize(DatesPlus.Minute(24*60*1 + 12*60)) == DatesPlus.canonicalize(DatesPlus.CompoundPeriod([DatesPlus.Day(1),DatesPlus.Hour(12)]))
end
@testset "unary ops and vectorized period arithmetic" begin
    pa = [1y 1m 1w 1d; 1h 1mi 1s 1ms]
    cpa = [1y + 1s 1m + 1s 1w + 1s 1d + 1s; 1h + 1s 1mi + 1s 2m + 1s 1s + 1ms]

    @test +pa == pa == -(-pa)
    @test -pa == map(-, pa)
    @test 1y .+ pa == [2y 1y + 1m 1y + 1w 1y + 1d; 1y + 1h 1y + 1mi 1y + 1s 1y + 1ms]
    @test (1y + 1m) .+ pa == [2y + 1m 1y + 2m 1y + 1m + 1w 1y + 1m + 1d; 1y + 1m + 1h 1y + 1m + 1mi 1y + 1m + 1s 1y + 1m + 1ms]
    @test pa .+ 1y == [2y 1y + 1m 1y + 1w 1y + 1d; 1y + 1h 1y + 1mi 1y + 1s 1y + 1ms]
    @test pa .+ (1y + 1m) == [2y + 1m 1y + 2m 1y + 1m + 1w 1y + 1m + 1d; 1y + 1m + 1h 1y + 1m + 1mi 1y + 1m + 1s 1y + 1m + 1ms]

    @test 1y .+ cpa == [2y + 1s 1y + 1m + 1s 1y + 1w + 1s 1y + 1d + 1s; 1y + 1h + 1s 1y + 1mi + 1s 1y + 2m + 1s 1y + 1ms + 1s]
    @test (1y + 1m) .+ cpa == [2y + 1m + 1s 1y + 2m + 1s 1y + 1m + 1w + 1s 1y + 1m + 1d + 1s; 1y + 1m + 1h + 1s 1y + 1m + 1mi + 1s 1y + 3m + 1s 1y + 1m + 1s + 1ms]
    @test cpa .+ 1y == [2y + 1s 1y + 1m + 1s 1y + 1w + 1s 1y + 1d + 1s; 1y + 1h + 1s 1y + 1mi + 1s 1y + 2m + 1s 1y + 1ms + 1s]
    @test cpa .+ (1y + 1m) == [2y + 1m + 1s 1y + 2m + 1s 1y + 1m + 1w + 1s 1y + 1m + 1d + 1s; 1y + 1m + 1h + 1s 1y + 1m + 1mi + 1s 1y + 3m + 1s 1y + 1m + 1s + 1ms]

    @test 1y .+ pa == [2y 1y + 1m 1y + 1w 1y + 1d; 1y + 1h 1y + 1mi 1y + 1s 1y + 1ms]
    @test (1y + 1m) .+ pa == [2y + 1m 1y + 2m 1y + 1m + 1w 1y + 1m + 1d; 1y + 1m + 1h 1y + 1m + 1mi 1y + 1m + 1s 1y + 1m + 1ms]
    @test pa .+ 1y == [2y 1y + 1m 1y + 1w 1y + 1d; 1y + 1h 1y + 1mi 1y + 1s 1y + 1ms]
    @test pa .+ (1y + 1m) == [2y + 1m 1y + 2m 1y + 1m + 1w 1y + 1m + 1d; 1y + 1m + 1h 1y + 1m + 1mi 1y + 1m + 1s 1y + 1m + 1ms]

    @test 1y .+ cpa == [2y + 1s 1y + 1m + 1s 1y + 1w + 1s 1y + 1d + 1s; 1y + 1h + 1s 1y + 1mi + 1s 1y + 2m + 1s 1y + 1ms + 1s]
    @test (1y + 1m) .+ cpa == [2y + 1m + 1s 1y + 2m + 1s 1y + 1m + 1w + 1s 1y + 1m + 1d + 1s; 1y + 1m + 1h + 1s 1y + 1m + 1mi + 1s 1y + 3m + 1s 1y + 1m + 1s + 1ms]
    @test cpa .+ 1y == [2y + 1s 1y + 1m + 1s 1y + 1w + 1s 1y + 1d + 1s; 1y + 1h + 1s 1y + 1mi + 1s 1y + 2m + 1s 1y + 1ms + 1s]
    @test cpa .+ (1y + 1m) == [2y + 1m + 1s 1y + 2m + 1s 1y + 1m + 1w + 1s 1y + 1m + 1d + 1s; 1y + 1m + 1h + 1s 1y + 1m + 1mi + 1s 1y + 3m + 1s 1y + 1m + 1s + 1ms]

    @test 1y .- pa == [0y 1y-1m 1y-1w 1y-1d; 1y-1h 1y-1mi 1y-1s 1y-1ms]
    @test (1y + 1m) .- pa == [1m 1y 1y + 1m-1w 1y + 1m-1d; 1y + 1m-1h 1y + 1m-1mi 1y + 1m-1s 1y + 1m-1ms]
    @test pa .- (1y + 1m) == [-1m -1y -1y-1m + 1w -1y-1m + 1d; -1y-1m + 1h -1y-1m + 1mi -1y-1m + 1s -1y-1m + 1ms]
    @test pa .- 1y == [0y 1m-1y -1y + 1w -1y + 1d; -1y + 1h -1y + 1mi -1y + 1s -1y + 1ms]

    @test 1y .- cpa == [-1s 1y-1m-1s 1y-1w-1s 1y-1d-1s; 1y-1h-1s 1y-1mi-1s 1y-2m-1s 1y-1ms-1s]
    @test (1y + 1m) .- cpa == [1m-1s 1y-1s 1y + 1m-1w-1s 1y + 1m-1d-1s; 1y + 1m-1h-1s 1y + 1m-1mi-1s 1y-1m-1s 1y + 1m-1s-1ms]
    @test cpa .- 1y == [1s -1y + 1m + 1s -1y + 1w + 1s -1y + 1d + 1s; -1y + 1h + 1s -1y + 1mi + 1s -1y + 2m + 1s -1y + 1ms + 1s]
    @test cpa .- (1y + 1m) == [-1m + 1s -1y + 1s -1y-1m + 1w + 1s -1y-1m + 1d + 1s; -1y-1m + 1h + 1s -1y-1m + 1mi + 1s -1y + 1m + 1s -1y + -1m + 1s + 1ms]

    @test [1y 1m; 1w 1d] + [1h 1mi; 1s 1ms] == [1y + 1h 1m + 1mi; 1w + 1s 1d + 1ms]
    @test [1y 1m; 1w 1d] - [1h 1mi; 1s 1ms] == [1y-1h 1m-1mi; 1w-1s 1d-1ms]
    @test [1y 1m; 1w 1d] - [1h 1mi; 1s 1ms] - [1y-1h 1m-1mi; 1w-1s 1d-1ms] == [emptyperiod emptyperiod; emptyperiod emptyperiod]

    @test [1y + 1s 1m + 1s; 1w + 1s 1d + 1s] + [1h 1mi; 1s 1ms] == [1y + 1h + 1s 1m + 1mi + 1s; 1w + 2s 1d + 1s + 1ms]
    @test [1y + 1s 1m + 1s; 1w + 1s 1d + 1s] - [1h 1mi; 1s 1ms] == [1y-1h + 1s 1m-1mi + 1s; 1w 1d + 1s-1ms]

    @test [1y 1m; 1w 1d] + [1h + 1s 1mi + 1s; 1m + 1s 1s + 1ms] == [1y + 1h + 1s 1m + 1mi + 1s; 1w + 1m + 1s 1d + 1s + 1ms]
    @test [1y 1m; 1w 1d] - [1h + 1s 1mi + 1s; 1m + 1s 1s + 1ms] == [1y-1h-1s 1m-1mi-1s; 1w-1m-1s 1d-1s-1ms]

    @test [1y + 1s 1m + 1s; 1w + 1s 1d + 1s] + [1y + 1h 1y + 1mi; 1y + 1s 1y + 1ms] == [2y + 1h + 1s 1y + 1m + 1mi + 1s; 1y + 1w + 2s 1y + 1d + 1s + 1ms]
    @test [1y + 1s 1m + 1s; 1w + 1s 1d + 1s] - [1y + 1h 1y + 1mi; 1y + 1s 1y + 1ms] == [1s-1h 1m + 1s-1y-1mi; 1w-1y 1d + 1s-1y-1ms]
end
@testset "Equality and hashing between FixedPeriod types" begin
    let types = (DatesPlus.Week, DatesPlus.Day, DatesPlus.Hour, DatesPlus.Minute,
                 DatesPlus.Second, DatesPlus.Millisecond, DatesPlus.Microsecond, DatesPlus.Nanosecond)
        for i in 1:length(types), j in i:length(types), x in (0, 1, 235, -4677, 15250)
            local T, U, y, z
            T = types[i]
            U = types[j]
            y = T(x)
            z = convert(U, y)
            @test y == z
            @test hash(y) == hash(z)
        end
    end
end
@testset "Equality and hashing between OtherPeriod types" begin
    for x in (0, 1, 235, -4677, 15250)
        local x, y, z
        y = DatesPlus.Year(x)
        z = convert(DatesPlus.Month, y)
        @test y == z
        @test hash(y) == hash(z)

        y = DatesPlus.Quarter(x)
        z = convert(DatesPlus.Month, y)
        @test y == z
        @test hash(y) == hash(z)

        y = DatesPlus.Year(x)
        z = convert(DatesPlus.Quarter, y)
        @test y == z
        @test hash(y) == hash(z)
    end
end
@testset "Equality and hashing between FixedPeriod/OtherPeriod/CompoundPeriod (#37459)" begin
    function test_hash_equality(x, y)
        @test x == y
        @test y == x
        @test isequal(x, y)
        @test isequal(y, x)
        @test hash(x) == hash(y)
    end
    for FP = (DatesPlus.Week, DatesPlus.Day, DatesPlus.Hour, DatesPlus.Minute,
              DatesPlus.Second, DatesPlus.Millisecond, DatesPlus.Microsecond, DatesPlus.Nanosecond)
        for OP = (DatesPlus.Year, DatesPlus.Quarter, DatesPlus.Month)
            test_hash_equality(FP(0), OP(0))
        end
    end
end
@testset "Hashing for CompoundPeriod (#37447)" begin
    periods = [DatesPlus.Year(0), DatesPlus.Minute(0), DatesPlus.Second(0), DatesPlus.CompoundPeriod(),
               DatesPlus.Minute(2), DatesPlus.Second(120), DatesPlus.CompoundPeriod(DatesPlus.Minute(2)),
               DatesPlus.CompoundPeriod(DatesPlus.Second(120)), DatesPlus.CompoundPeriod(DatesPlus.Minute(1), DatesPlus.Second(60))]
    for x = periods, y = periods
        @test isequal(x,y) == (hash(x) == hash(y))
    end
end

@testset "#30832" begin
    @test DatesPlus.toms(DatesPlus.Second(1) + DatesPlus.Nanosecond(1)) == 1e3
    @test DatesPlus.tons(DatesPlus.Second(1) + DatesPlus.Nanosecond(1)) == 1e9 + 1
    @test DatesPlus.toms(DatesPlus.Second(1) + DatesPlus.Microsecond(1)) == 1e3
end

@testset "CompoundPeriod and Period isless()" begin
    #tests for allowed comparisons
    #FixedPeriod
    @test (h - ms < h + ns) == true
    @test (h + ns < h -ms) == false
    @test (h  < h -ms) == false
    @test (h-ms  < h) == true
    #OtherPeriod
    @test (2y-m < 25m+1y) == true
    @test (2y < 25m+1y) == true
    @test (25m+1y < 2y) == false
    #Test combined Fixed and Other Periods
    @test (1m + 1d < 1m + 1s) == false
end

@testset "Convert CompoundPeriod to Period" begin
    @test convert(Month, Year(1) + Month(1)) === Month(13)
    @test convert(Second, Minute(1) + Second(30)) === Second(90)
    @test convert(Minute, Minute(1) + Second(60)) === Minute(2)
    @test convert(Millisecond, Minute(1) + Second(30)) === Millisecond(90_000)
    @test_throws InexactError convert(Minute, Minute(1) + Second(30))
    @test_throws MethodError convert(Month, Minute(1) + Second(30))
    @test_throws MethodError convert(Second, Month(1) + Second(30))
    @test_throws MethodError convert(Period, Minute(1) + Second(30))
    @test_throws MethodError convert(DatesPlus.FixedPeriod, Minute(1) + Second(30))
end

end

