# This file is a part of Julia. License is MIT: https://julialang.org/license

module TypesTest

using Test
using Dates

# Date internal algorithms
@testset "totaldays" begin
    @test DatesPlus.totaldays(0, 2, 28) == -307
    @test DatesPlus.totaldays(0, 2, 29) == -306
    @test DatesPlus.totaldays(0, 3, 1) == -305
    @test DatesPlus.totaldays(0, 12, 31) == 0
    # Rata Die Days # start from 0001-01-01
    @test DatesPlus.totaldays(1, 1, 1) == 1
    @test DatesPlus.totaldays(1, 1, 2) == 2
    @test DatesPlus.totaldays(2013, 1, 1) == 734869
end
@testset "daysinmonth" begin
    @test DatesPlus.daysinmonth(2000, 1) == 31
    @test DatesPlus.daysinmonth(2000, 2) == 29
    @test DatesPlus.daysinmonth(2000, 3) == 31
    @test DatesPlus.daysinmonth(2000, 4) == 30
    @test DatesPlus.daysinmonth(2000, 5) == 31
    @test DatesPlus.daysinmonth(2000, 6) == 30
    @test DatesPlus.daysinmonth(2000, 7) == 31
    @test DatesPlus.daysinmonth(2000, 8) == 31
    @test DatesPlus.daysinmonth(2000, 9) == 30
    @test DatesPlus.daysinmonth(2000, 10) == 31
    @test DatesPlus.daysinmonth(2000, 11) == 30
    @test DatesPlus.daysinmonth(2000, 12) == 31
    @test DatesPlus.daysinmonth(2001, 2) == 28
end
@testset "isleapyear" begin
    @test DatesPlus.isleapyear(1900) == false
    @test DatesPlus.isleapyear(2000) == true
    @test DatesPlus.isleapyear(2004) == true
    @test DatesPlus.isleapyear(2008) == true
    @test DatesPlus.isleapyear(0) == true
    @test DatesPlus.isleapyear(1) == false
    @test DatesPlus.isleapyear(-1) == false
    @test DatesPlus.isleapyear(4) == true
    @test DatesPlus.isleapyear(-4) == true
end
# Create "test" check manually
y = DatesPlus.Year(1)
m = DatesPlus.Month(1)
w = DatesPlus.Week(1)
d = DatesPlus.Day(1)
h = DatesPlus.Hour(1)
mi = DatesPlus.Minute(1)
s = DatesPlus.Second(1)
ms = DatesPlus.Millisecond(1)
@testset "DateTime construction by parts" begin
    test = DatesPlus.DateTime(DatesPlus.UTM(63492681600000))
    @test DatesPlus.DateTime(2013) == test
    @test DatesPlus.DateTime(2013, 1) == test
    @test DatesPlus.DateTime(2013, 1, 1) == test
    @test DatesPlus.DateTime(2013, 1, 1, 0) == test
    @test DatesPlus.DateTime(2013, 1, 1, 0, 0) == test
    @test DatesPlus.DateTime(2013, 1, 1, 0, 0, 0) == test
    @test DatesPlus.DateTime(2013, 1, 1, 0, 0, 0, 0) == test

    @test DatesPlus.DateTime(y) == DatesPlus.DateTime(1)
    @test DatesPlus.DateTime(y, m) == DatesPlus.DateTime(1, 1)
    @test DatesPlus.DateTime(y, m, d) == DatesPlus.DateTime(1, 1, 1)
    @test DatesPlus.DateTime(y, m, d, h) == DatesPlus.DateTime(1, 1, 1, 1)
    @test DatesPlus.DateTime(y, m, d, h, mi) == DatesPlus.DateTime(1, 1, 1, 1, 1)
    @test DatesPlus.DateTime(y, m, d, h, mi, s) == DatesPlus.DateTime(1, 1, 1, 1, 1, 1)
    @test DatesPlus.DateTime(y, m, d, h, mi, s, ms) == DatesPlus.DateTime(1, 1, 1, 1, 1, 1, 1)
    @test DatesPlus.DateTime(DatesPlus.Day(10), DatesPlus.Month(2), y) == DatesPlus.DateTime(1, 2, 10)
    @test DatesPlus.DateTime(DatesPlus.Second(10), DatesPlus.Month(2), y, DatesPlus.Hour(4)) == DatesPlus.DateTime(1, 2, 1, 4, 0, 10)
    @test DatesPlus.DateTime(DatesPlus.Year(1), DatesPlus.Month(2), DatesPlus.Day(1),
                         DatesPlus.Hour(4), DatesPlus.Second(10)) == DatesPlus.DateTime(1, 2, 1, 4, 0, 10)
end

@testset "Date construction by parts" begin
    test = DatesPlus.Date(DatesPlus.UTD(734869))
    @test DatesPlus.Date(2013) == test
    @test DatesPlus.Date(2013, 1) == test
    @test DatesPlus.Date(2013, 1, 1) == test
    @test DatesPlus.Date(y) == DatesPlus.Date(1)
    @test DatesPlus.Date(y, m) == DatesPlus.Date(1, 1)
    @test DatesPlus.Date(y, m, d) == DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(m) == DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(d, y) == DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(d, m) == DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(m, y) == DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(DatesPlus.Day(10), DatesPlus.Month(2), y) == DatesPlus.Date(1, 2, 10)
end

@testset "Time construction by parts" begin
    t = DatesPlus.Time(DatesPlus.Nanosecond(82800000000000))
    @test DatesPlus.Time(23) == t
    @test DatesPlus.Time(23, 0) == t
    @test DatesPlus.Time(23, 0, 0) == t
    @test DatesPlus.Time(23, 0, 0, 0) == t
    @test DatesPlus.Time(23, 0, 0, 0, 0) == t
    @test DatesPlus.Time(23, 0, 0, 0, 0, 0) == t
    us = DatesPlus.Microsecond(1)
    ns = DatesPlus.Nanosecond(1)
    @test DatesPlus.Time(h) == DatesPlus.Time(1)
    @test DatesPlus.Time(h, mi) == DatesPlus.Time(1, 1)
    @test DatesPlus.Time(h, mi, s) == DatesPlus.Time(1, 1, 1)
    @test DatesPlus.Time(h, mi, s, ms) == DatesPlus.Time(1, 1, 1, 1)
    @test DatesPlus.Time(h, mi, s, ms, us) == DatesPlus.Time(1, 1, 1, 1, 1)
    @test DatesPlus.Time(h, mi, s, ms, us, ns) == DatesPlus.Time(1, 1, 1, 1, 1, 1)
    @test DatesPlus.Time(us, h, s, ns, mi, ms) == DatesPlus.Time(1, 1, 1, 1, 1, 1)
    @test DatesPlus.Time(DatesPlus.Second(10), DatesPlus.Minute(2), us, DatesPlus.Hour(4)) == DatesPlus.Time(4, 2, 10, 0, 1)
    @test DatesPlus.Time(DatesPlus.Hour(4), DatesPlus.Second(10), DatesPlus.Millisecond(15),
                     DatesPlus.Microsecond(20), DatesPlus.Nanosecond(25)) == DatesPlus.Time(4, 0, 10, 15, 20, 25)
end

@testset "various input types for Date/DateTime" begin
    test = DatesPlus.Date(1, 1, 1)
    @test DatesPlus.Date(Int8(1), Int8(1), Int8(1)) == test
    @test DatesPlus.Date(UInt8(1), UInt8(1), UInt8(1)) == test
    @test DatesPlus.Date(Int16(1), Int16(1), Int16(1)) == test
    @test DatesPlus.Date(UInt8(1), UInt8(1), UInt8(1)) == test
    @test DatesPlus.Date(Int32(1), Int32(1), Int32(1)) == test
    @test DatesPlus.Date(UInt32(1), UInt32(1), UInt32(1)) == test
    @test DatesPlus.Date(Int64(1), Int64(1), Int64(1)) == test
    @test DatesPlus.Date('\x01', '\x01', '\x01') == test
    @test DatesPlus.Date(true, true, true) == test
    @test_throws ArgumentError DatesPlus.Date(false, true, false)
    @test DatesPlus.Date(false, true, true) == test - DatesPlus.Year(1)
    @test_throws ArgumentError DatesPlus.Date(true, true, false)
    @test DatesPlus.Date(UInt64(1), UInt64(1), UInt64(1)) == test
    @test DatesPlus.Date(-1, UInt64(1), UInt64(1)) == test - DatesPlus.Year(2)
    @test DatesPlus.Date(Int128(1), Int128(1), Int128(1)) == test
    @test_throws InexactError DatesPlus.Date(170141183460469231731687303715884105727, Int128(1), Int128(1))
    @test DatesPlus.Date(UInt128(1), UInt128(1), UInt128(1)) == test
    @test DatesPlus.Date(big(1), big(1), big(1)) == test
    @test DatesPlus.Date(big(1), big(1), big(1)) == test
    # Potentially won't work if can't losslessly convert to Int64
    @test DatesPlus.Date(BigFloat(1), BigFloat(1), BigFloat(1)) == test
    @test DatesPlus.Date(complex(1), complex(1), complex(1)) == test
    @test DatesPlus.Date(Float64(1), Float64(1), Float64(1)) == test
    @test DatesPlus.Date(Float32(1), Float32(1), Float32(1)) == test
    @test DatesPlus.Date(Float16(1), Float16(1), Float16(1)) == test
    @test DatesPlus.Date(Rational(1), Rational(1), Rational(1)) == test
    @test_throws InexactError DatesPlus.Date(BigFloat(1.2), BigFloat(1), BigFloat(1))
    @test_throws InexactError DatesPlus.Date(1 + im, complex(1), complex(1))
    @test_throws InexactError DatesPlus.Date(1.2, 1.0, 1.0)
    @test_throws InexactError DatesPlus.Date(1.2f0, 1.f0, 1.f0)
    @test_throws InexactError DatesPlus.Date(3//4, Rational(1), Rational(1)) == test

    # Months, days, hours, minutes, seconds, and milliseconds must be in range
    @test_throws ArgumentError DatesPlus.Date(2013, 0, 1)
    @test_throws ArgumentError DatesPlus.Date(2013, 13, 1)
    @test_throws ArgumentError DatesPlus.Date(2013, 1, 0)
    @test_throws ArgumentError DatesPlus.Date(2013, 1, 32)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 0, 1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 13, 1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 0)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 32)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 25)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, -1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, -1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, 60)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, 0, -1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, 0, 60)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, 0, 0, -1)
    @test_throws ArgumentError DatesPlus.DateTime(2013, 1, 1, 0, 0, 0, 1000)
    @test_throws ArgumentError DatesPlus.Time(24)
    @test_throws ArgumentError DatesPlus.Time(-1)
    @test_throws ArgumentError DatesPlus.Time(0, -1)
    @test_throws ArgumentError DatesPlus.Time(0, 60)
    @test_throws ArgumentError DatesPlus.Time(0, 0, -1)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 60)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, -1)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, 1000)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, 0, -1)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, 0, 1000)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, 0, 0, -1)
    @test_throws ArgumentError DatesPlus.Time(0, 0, 0, 0, 0, 1000)
end
a = DatesPlus.DateTime(2000)
b = DatesPlus.Date(2000)
c = DatesPlus.Time(0)
@testset "DateTime traits" begin
    @test DatesPlus.calendar(a) == DatesPlus.ISOCalendar
    @test DatesPlus.calendar(b) == DatesPlus.ISOCalendar
    @test eps(DateTime) == DatesPlus.Millisecond(1)
    @test eps(Date) == DatesPlus.Day(1)
    @test eps(Time) == DatesPlus.Nanosecond(1)
    @test eps(a) == DatesPlus.Millisecond(1)
    @test eps(b) == DatesPlus.Day(1)
    @test eps(c) == DatesPlus.Nanosecond(1)
    @test zero(DateTime) == DatesPlus.Millisecond(0)
    @test zero(Date) == DatesPlus.Day(0)
    @test zero(Time) == DatesPlus.Nanosecond(0)
    @test zero(a) == DatesPlus.Millisecond(0)
    @test zero(b) == DatesPlus.Day(0)
    @test zero(c) == DatesPlus.Nanosecond(0)
    @test string(typemax(DatesPlus.DateTime)) == "146138512-12-31T23:59:59"
    @test string(typemin(DatesPlus.DateTime)) == "-146138511-01-01T00:00:00"
    @test typemax(DatesPlus.DateTime) - typemin(DatesPlus.DateTime) == DatesPlus.Millisecond(9223372017043199000)
    @test string(typemax(DatesPlus.Date)) == "252522163911149-12-31"
    @test string(typemin(DatesPlus.Date)) == "-252522163911150-01-01"
    @test string(typemax(DatesPlus.Time)) == "23:59:59.999999999"
    @test string(typemin(DatesPlus.Time)) == "00:00:00"
    @test isfinite(DatesPlus.Date)
    @test isfinite(DatesPlus.DateTime)
    @test isfinite(DatesPlus.Time)
    @test c == c
    @test c == (c + DatesPlus.Hour(24))
    @test hash(c) == hash(c + DatesPlus.Hour(24))
    @test hash(c + DatesPlus.Nanosecond(10)) == hash(c + DatesPlus.Hour(24) + DatesPlus.Nanosecond(10))
end
@testset "Date-DateTime conversion/promotion" begin
    global a, b, c, d
    @test DatesPlus.DateTime(a) == a
    @test DatesPlus.Date(a) == b
    @test DatesPlus.DateTime(b) == a
    @test DatesPlus.Date(b) == b
    @test a == b
    @test a == a
    @test b == a
    @test b == b
    @test !(a < b)
    @test !(b < a)
    c = DatesPlus.DateTime(2000)
    d = DatesPlus.Date(2000)
    @test ==(a, c)
    @test ==(c, a)
    @test ==(d, b)
    @test ==(b, d)
    @test ==(a, d)
    @test ==(d, a)
    @test ==(b, c)
    @test ==(c, b)
    b = DatesPlus.Date(2001)
    @test b > a
    @test a < b
    @test a != b
    @test DatesPlus.Date(DatesPlus.DateTime(DatesPlus.Date(2012, 7, 1))) == DatesPlus.Date(2012, 7, 1)
end

@testset "min and max" begin
    for (a, b) in [(DatesPlus.Date(2000), DatesPlus.Date(2001)),
                    (DatesPlus.Time(10), DatesPlus.Time(11)),
                    (DatesPlus.DateTime(3000), DatesPlus.DateTime(3001)),
                    (DatesPlus.Week(42), DatesPlus.Week(1972)),
                    (DatesPlus.Quarter(3), DatesPlus.Quarter(52))]
        @test min(a, b) == a
        @test min(b, a) == a
        @test min(a) == a
        @test max(a, b) == b
        @test max(b, a) == b
        @test max(b) == b
        @test minmax(a, b) == (a, b)
        @test minmax(b, a) == (a, b)
        @test minmax(a) == (a, a)
    end
end

@testset "issue #31524" begin
    dt1 = Libc.strptime("%Y-%M-%dT%H:%M:%SZ", "2018-11-16T10:26:14Z")
    dt2 = Libc.TmStruct(14, 30, 5, 10, 1, 99, 3, 40, 0)

    time = Time(dt1)
    @test typeof(time) == Time
    @test time == DatesPlus.Time(10, 26, 14)

    date = Date(dt2)
    @test typeof(date) == Date
    @test date == DatesPlus.Date(1999, 2, 10)

    datetime = DateTime(dt2)
    @test typeof(datetime) == DateTime
    @test datetime == DatesPlus.DateTime(1999, 2, 10, 5, 30, 14)

end

@testset "timedwait" begin
    @test timedwait(() -> false, Second(0); pollint=Millisecond(1)) === :timed_out
end

end
