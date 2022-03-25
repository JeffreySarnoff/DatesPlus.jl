# This file is a part of Julia. License is MIT: https://julialang.org/license

module ConversionTests

using Test
using Dates

@testset "conversion to/from UNIX" begin
    # Test conversion to and from unix
    @test DatesPlus.unix2datetime(DatesPlus.datetime2unix(DateTime(2000, 1, 1))) == DateTime(2000, 1, 1)
    @test DatesPlus.value(DatesPlus.DateTime(1970)) == DatesPlus.UNIXEPOCH

    # Tests from here: https://en.wikipedia.org/wiki/Unix_time
    @test string(DatesPlus.unix2datetime(1095379198.75)) == string("2004-09-16T23:59:58.750")
    @test string(DatesPlus.unix2datetime(1095379199.00)) == string("2004-09-16T23:59:59")
    @test string(DatesPlus.unix2datetime(1095379199.25)) == string("2004-09-16T23:59:59.250")
    @test string(DatesPlus.unix2datetime(1095379199.50)) == string("2004-09-16T23:59:59.500")
    @test string(DatesPlus.unix2datetime(1095379199.75)) == string("2004-09-16T23:59:59.750")
    @test string(DatesPlus.unix2datetime(1095379200.00)) == string("2004-09-17T00:00:00")
    @test string(DatesPlus.unix2datetime(1095379200.25)) == string("2004-09-17T00:00:00.250")
    @test string(DatesPlus.unix2datetime(1095379200.50)) == string("2004-09-17T00:00:00.500")
    @test string(DatesPlus.unix2datetime(1095379200.75)) == string("2004-09-17T00:00:00.750")
    @test string(DatesPlus.unix2datetime(1095379201.00)) == string("2004-09-17T00:00:01")
    @test string(DatesPlus.unix2datetime(1095379201.25)) == string("2004-09-17T00:00:01.250")
    @test string(DatesPlus.unix2datetime(915148798.75)) == string("1998-12-31T23:59:58.750")
    @test string(DatesPlus.unix2datetime(915148799.00)) == string("1998-12-31T23:59:59")
    @test string(DatesPlus.unix2datetime(915148799.25)) == string("1998-12-31T23:59:59.250")
    @test string(DatesPlus.unix2datetime(915148799.50)) == string("1998-12-31T23:59:59.500")
    @test string(DatesPlus.unix2datetime(915148799.75)) == string("1998-12-31T23:59:59.750")
    @test string(DatesPlus.unix2datetime(915148800.00)) == string("1999-01-01T00:00:00")
    @test string(DatesPlus.unix2datetime(915148800.25)) == string("1999-01-01T00:00:00.250")
    @test string(DatesPlus.unix2datetime(915148800.50)) == string("1999-01-01T00:00:00.500")
    @test string(DatesPlus.unix2datetime(915148800.75)) == string("1999-01-01T00:00:00.750")
    @test string(DatesPlus.unix2datetime(915148801.00)) == string("1999-01-01T00:00:01")
    @test string(DatesPlus.unix2datetime(915148801.25)) == string("1999-01-01T00:00:01.250")
end

@testset "conversion to/from Rata Die" begin
    @test Date(DatesPlus.rata2datetime(734869)) == DatesPlus.Date(2013, 1, 1)
    @test DatesPlus.datetime2rata(DatesPlus.rata2datetime(734869)) == 734869
end

@testset "conversion to/from Julian calendar" begin
    # Tests from here: http://mysite.verizon.net/aesir_research/date/back.htm#JDN
    @test DatesPlus.julian2datetime(1721119.5) == DatesPlus.DateTime(0, 3, 1)
    @test DatesPlus.julian2datetime(1721424.5) == DatesPlus.DateTime(0, 12, 31)
    @test DatesPlus.julian2datetime(1721425.5) == DatesPlus.DateTime(1, 1, 1)
    @test DatesPlus.julian2datetime(2299149.5) == DatesPlus.DateTime(1582, 10, 4)
    @test DatesPlus.julian2datetime(2415020.5) == DatesPlus.DateTime(1900, 1, 1)
    @test DatesPlus.julian2datetime(2415385.5) == DatesPlus.DateTime(1901, 1, 1)
    @test DatesPlus.julian2datetime(2440587.5) == DatesPlus.DateTime(1970, 1, 1)
    @test DatesPlus.julian2datetime(2444239.5) == DatesPlus.DateTime(1980, 1, 1)
    @test DatesPlus.julian2datetime(2452695.625) == DatesPlus.DateTime(2003, 2, 25, 3)
    @test DatesPlus.datetime2julian(DatesPlus.DateTime(2013, 12, 3, 21)) == 2456630.375
end
@testset "now, today, and UTC" begin
    @test typeof(DatesPlus.now()) <: DatesPlus.DateTime
    @test typeof(DatesPlus.today()) <: DatesPlus.Date
    @test typeof(DatesPlus.now(DatesPlus.UTC)) <: DatesPlus.DateTime

    if Sys.isapple()
        withenv("TZ" => "UTC") do
            @test abs(DatesPlus.now() - now(DatesPlus.UTC)) < DatesPlus.Second(1)
        end
    end
    @test abs(DatesPlus.now() - now(DatesPlus.UTC)) < DatesPlus.Hour(16)
end
@testset "Issue #9171, #9169" begin
    let t = DatesPlus.Period[DatesPlus.Week(2), DatesPlus.Day(14), DatesPlus.Hour(14 * 24), DatesPlus.Minute(14 * 24 * 60), DatesPlus.Second(14 * 24 * 60 * 60), DatesPlus.Millisecond(14 * 24 * 60 * 60 * 1000)]
        for i = 1:length(t)
            Pi = typeof(t[i])
            for j = 1:length(t)
                @test t[i] == t[j]
            end
            for j = i+1:length(t)
                Pj = typeof(t[j])
                tj1 = t[j] + Pj(1)
                @test t[i] < tj1
                @test_throws InexactError Pi(tj1)
                @test_throws InexactError Pj(Pi(typemax(Int64)))
                @test_throws InexactError Pj(Pi(typemin(Int64)))
            end
        end
    end
    @test DatesPlus.Year(3) == DatesPlus.Month(36)
    @test_throws MethodError Int(DatesPlus.Month(36))
    @test DatesPlus.Year(3) < DatesPlus.Month(37)
    @test_throws InexactError convert(DatesPlus.Year, DatesPlus.Month(37))
    @test_throws InexactError DatesPlus.Month(DatesPlus.Year(typemax(Int64)))
end

@testset "Conversions to/from numbers" begin
    # Ensure that conversion of 32-bit integers work
    let dt = DateTime(1915, 1, 1, 12)
        unix = Int32(DatesPlus.datetime2unix(dt))
        julian = Int32(DatesPlus.datetime2julian(dt))

        @test DatesPlus.unix2datetime(unix) == dt
        @test DatesPlus.julian2datetime(julian) == dt
    end

    a = DatesPlus.DateTime(2000)
    b = DatesPlus.Date(2000)
    @test DatesPlus.value(b) == 730120
    @test DatesPlus.value(a) == 63082368000000
    @test convert(DatesPlus.DateTime, DatesPlus.Millisecond(63082368000000)) == a
    @test convert(DatesPlus.Millisecond, a) == DatesPlus.Millisecond(63082368000000)
    @test DatesPlus.DateTime(DatesPlus.UTM(63082368000000)) == a
    @test DatesPlus.DateTime(DatesPlus.UTM(63082368000000.0)) == a
    @test convert(DatesPlus.Date, DatesPlus.Day(730120)) == b
    @test convert(DatesPlus.Day, b) == DatesPlus.Day(730120)
    @test DatesPlus.Date(DatesPlus.UTD(730120)) == b
    @test DatesPlus.Date(DatesPlus.UTD(730120.0)) == b
    @test DatesPlus.Date(DatesPlus.UTD(Int32(730120))) == b

    dt = DatesPlus.DateTime(2000, 1, 1, 23, 59, 59, 50)
    t = DatesPlus.Time(dt)
    @test DatesPlus.hour(t) == 23
    @test DatesPlus.minute(t) == 59
    @test DatesPlus.second(t) == 59
    @test DatesPlus.millisecond(t) == 50
    @test DatesPlus.microsecond(t) == 0
    @test DatesPlus.nanosecond(t) == 0
end

end
