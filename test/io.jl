# This file is a part of Julia. License is MIT: https://julialang.org/license

module IOTests

using Test
using Dates

const BASE_TEST_PATH = joinpath(Sys.BINDIR, "..", "share", "julia", "test")
include(joinpath(BASE_TEST_PATH, "testhelpers", "withlocales.jl"))

@testset "string/show representation of Date" begin
    @test string(DatesPlus.Date(1, 1, 1)) == "0001-01-01" # January 1st, 1 AD/CE
    @test sprint(show, DatesPlus.Date(1, 1, 1)) == "DatesPlus.Date(\"0001-01-01\")"
    @test string(DatesPlus.Date(0, 12, 31)) == "0000-12-31" # December 31, 1 BC/BCE
    @test DatesPlus.Date(1, 1, 1) - DatesPlus.Date(0, 12, 31) == DatesPlus.Day(1)
    @test DatesPlus.Date(DatesPlus.UTD(-306)) == DatesPlus.Date(0, 2, 29)
    @test string(DatesPlus.Date(0, 1, 1)) == "0000-01-01" # January 1st, 1 BC/BCE
    @test string(DatesPlus.Date(-1, 1, 1)) == "-0001-01-01" # January 1st, 2 BC/BCE
    @test string(DatesPlus.Date(-1000000, 1, 1)) == "-1000000-01-01"
    @test string(DatesPlus.Date(1000000, 1, 1)) == "1000000-01-01"
    @test string(DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 1)) == "2000-01-01T00:00:00.001"
    @test sprint(show, DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 1)) == "DatesPlus.DateTime(\"2000-01-01T00:00:00.001\")"
    @test string(DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 2)) == "2000-01-01T00:00:00.002"
    @test string(DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 500)) == "2000-01-01T00:00:00.500"
    @test string(DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 998)) == "2000-01-01T00:00:00.998"
    @test string(DatesPlus.DateTime(2000, 1, 1, 0, 0, 0, 999)) == "2000-01-01T00:00:00.999"
end

@testset "string/show representation of Time" begin
    tests = [
        DatesPlus.Time(0) => ("00:00:00", "DatesPlus.Time(0)"),
        DatesPlus.Time(0, 1) => ("00:01:00", "DatesPlus.Time(0, 1)"),
        DatesPlus.Time(0, 1, 2) => ("00:01:02", "DatesPlus.Time(0, 1, 2)"),
        DatesPlus.Time(0, 1, 2, 3) => ("00:01:02.003", "DatesPlus.Time(0, 1, 2, 3)"),
        DatesPlus.Time(0, 1, 2, 3, 4) => ("00:01:02.003004", "DatesPlus.Time(0, 1, 2, 3, 4)"),
        DatesPlus.Time(0, 1, 2, 3, 4, 5) => ("00:01:02.003004005", "DatesPlus.Time(0, 1, 2, 3, 4, 5)"),
        DatesPlus.Time(0, 0, 0, 0, 0, 1) => ("00:00:00.000000001", "DatesPlus.Time(0, 0, 0, 0, 0, 1)"),
        DatesPlus.Time(0, 0, 0, 1) => ("00:00:00.001", "DatesPlus.Time(0, 0, 0, 1)"),
    ]

    for (t, (printed, shown)) in tests
        @test sprint(print, t) == printed
        @test string(t) == printed
        @test sprint(show, t) == shown
        @test repr(t) == shown
    end
end

@testset "DateTime parsing" begin
    # Useful reference for different locales: http://library.princeton.edu/departments/tsd/katmandu/reference/months.html

    # Allow parsing of strings which are not representable as a TimeType
    str = "02/15/1996 25:00"
    df = DatesPlus.DateFormat("mm/dd/yyyy HH:MM")
    parsed = Any[
        DatesPlus.Month(2), DatesPlus.Day(15), DatesPlus.Year(1996), DatesPlus.Hour(25), DatesPlus.Minute(0)
    ]
    @test DatesPlus.parse_components(str, df) == parsed
    @test_throws ArgumentError DatesPlus.parse(DateTime, str, df)
end

@testset "DateFormat printing" begin
    @test sprint(show, DateFormat("yyyzzxmmdd\\MHH:MM:SS\\P")) == "dateformat\"yyyzzxmmdd\\MHH:MM:SSP\""
    @test sprint(show, DateFormat("yyy").tokens[1]) == "DatePart(yyy)"
    @test sprint(show, DateFormat("mmzzdd").tokens[2]) == "Delim(zz)"
    @test sprint(show, DateFormat("ddxmm").tokens[2]) == "Delim(x)"
    @test sprint(show, DateFormat("xxmmxx").tokens[2]) == "DatePart(mm)"
end

@testset "Common Parsing Patterns" begin
    #'1996-January-15'
    dt = DatesPlus.DateTime(1996, 1, 15)
    f = "yy-mm-dd"
    a = "96-01-15"
    @test DateTime(a, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, f) == a
    a1 = "96-1-15"
    @test DatesPlus.DateTime(a1, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, "yy-m-dd") == a1
    a2 = "96-1-1"
    @test DatesPlus.DateTime(a2, f) + DatesPlus.Year(1900) + DatesPlus.Day(14) == dt
    @test DatesPlus.format(dt - DatesPlus.Day(14), "yy-m-d") == a2
    a3 = "1996-1-15"
    @test DatesPlus.DateTime(a3, f) == dt
    @test DatesPlus.format(dt, "yyyy-m-d") == a3
    a4 = "1996-Jan-15"
    @test_throws ArgumentError DatesPlus.DateTime(a4, f) # Trying to use month name, but specified only "mm"

    f = "yy/uuu/dd"
    b = "96/Feb/15"
    @test DatesPlus.DateTime(b, f) + DatesPlus.Year(1900) == dt + DatesPlus.Month(1)
    @test DatesPlus.format(dt + DatesPlus.Month(1), f) == b
    b1 = "1996/Feb/15"
    @test DatesPlus.DateTime(b1, f) == dt + DatesPlus.Month(1)
    @test DatesPlus.format(dt + DatesPlus.Month(1), "yyyy/uuu/dd") == b1
    b2 = "96/Feb/1"
    @test DatesPlus.DateTime(b2, f) + DatesPlus.Year(1900) + DatesPlus.Day(14) == dt + DatesPlus.Month(1)
    @test DatesPlus.format(dt + DatesPlus.Month(1) - DatesPlus.Day(14), "yy/uuu/d") == b2
    # Here we've specified a text month name, but given a number
    b3 = "96/2/15"
    @test_throws ArgumentError DatesPlus.DateTime(b3, f)
    try
        DatesPlus.parse(DateTime, "2012/2/20T9:9:31.25i90", dateformat"yyyy/mm/ddTHH:MM:SS.s")
        @test false
    catch err
        @test isa(err, ArgumentError)
        @test err.msg == "Found extra characters at the end of date time string"
    end
    try
        DatesPlus.parse(DateTime, "2012/2/20T9:9:3i90", dateformat"yyyy/mm/ddTHH:MM:SS.s")
        @test false
    catch err
        @test isa(err, ArgumentError)
        @test err.msg == "Unable to parse date time. Expected directive Delim(.) at char 16"
    end

    f = "yy:dd:mm"
    c = "96:15:01"
    @test DatesPlus.DateTime(c, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, f) == c
    c1 = "1996:15:01"
    @test DatesPlus.DateTime(c1, f) == dt
    @test DatesPlus.format(dt, "yyyy:dd:mm") == c1
    c2 = "96:15:1"
    @test DatesPlus.DateTime(c2, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, "yy:dd:m") == c2
    c3 = "96:1:01"
    @test DatesPlus.DateTime(c3, f) + DatesPlus.Year(1900) + DatesPlus.Day(14) == dt
    @test DatesPlus.format(dt - DatesPlus.Day(14), "yy:m:dd") == c3
    c4 = "1996:15:01 # random comment"
    @test_throws ArgumentError DatesPlus.DateTime(c4, f)

    f = "yyyy, uuu, dd"
    d = "1996, Jan, 15"
    @test DatesPlus.DateTime(d, f) == dt
    @test DatesPlus.format(dt, f) == d
    d1 = "96, Jan, 15"
    @test DatesPlus.DateTime(d1, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, "yy, uuu, dd") == d1
    d2 = "1996, Jan, 1"
    @test DatesPlus.DateTime(d2, f) + DatesPlus.Day(14) == dt
    @test DatesPlus.format(dt - DatesPlus.Day(14), "yyyy, uuu, d") == d2
    d3 = "1996, 2, 15"
    @test_throws ArgumentError DatesPlus.DateTime(d3, f)

    f = "yyyy.U.dd"
    e = "1996.January.15"
    @test DatesPlus.DateTime(e, f) == dt
    @test DatesPlus.format(dt, f) == e
    e1 = "96.January.15"
    @test DatesPlus.DateTime(e1, f) + DatesPlus.Year(1900) == dt
    @test DatesPlus.format(dt, "yy.U.dd") == e1

    fo = "yyyy m dd"
    f = "1996 1 15"
    @test DatesPlus.DateTime(f, fo) == dt
    @test DatesPlus.format(dt, fo) == f
    f1 = "1996 01 15"
    @test DatesPlus.DateTime(f1, fo) == dt
    @test DatesPlus.format(dt, "yyyy mm dd") == f1
    f2 = "1996 1 1"
    @test DatesPlus.DateTime(f2, fo) + DatesPlus.Day(14) == dt
    @test DatesPlus.format(dt - DatesPlus.Day(14), "yyyy m d") == f2

    j = "1996-01-15"
    f = "yyyy-mm-dd zzz"
    @test DatesPlus.DateTime(j, f) == dt
    @test DatesPlus.format(dt, f) == j * " zzz"
    k = "1996-01-15 10:00:00"
    f = "yyyy-mm-dd HH:MM:SS zzz"
    @test DatesPlus.DateTime(k, f) == dt + DatesPlus.Hour(10)
    @test DatesPlus.format(dt + DatesPlus.Hour(10), f) == k * " zzz"
    l = "1996-01-15 10:10:10.25"
    f = "yyyy-mm-dd HH:MM:SS.ss zzz"
    @test DatesPlus.DateTime(l, f) == dt + DatesPlus.Hour(10) + DatesPlus.Minute(10) + DatesPlus.Second(10) + DatesPlus.Millisecond(250)
    @test DatesPlus.format(dt + DatesPlus.Hour(10) + DatesPlus.Minute(10) + DatesPlus.Second(10) + DatesPlus.Millisecond(250), f) == l * " zzz"

    r = "1/15/1996" # Excel
    f = "m/dd/yyyy"
    @test DatesPlus.DateTime(r, f) == dt
    @test DatesPlus.format(dt, f) == r
    s = "19960115"
    f = "yyyymmdd"
    @test DatesPlus.DateTime(s, f) == dt
    @test DatesPlus.format(dt, f) == s
    v = "1996-01-15 10:00:00"
    f = "yyyy-mm-dd HH:MM:SS"
    @test DatesPlus.DateTime(v, f) == dt + DatesPlus.Hour(10)
    @test DatesPlus.format(dt + DatesPlus.Hour(10), f) == v
    w = "1996-01-15T10:00:00"
    f = "yyyy-mm-ddTHH:MM:SS zzz"
    @test DatesPlus.DateTime(w, f) == dt + DatesPlus.Hour(10)
    @test DatesPlus.format(dt + DatesPlus.Hour(10), f) == w * " zzz"

    f = "yyyy/m"
    y = "1996/1"
    @test DatesPlus.DateTime(y, f) == dt - DatesPlus.Day(14)
    @test DatesPlus.format(dt, f) == y
    y1 = "1996/1/15"
    @test_throws ArgumentError DatesPlus.DateTime(y1, f)
    y2 = "96/1"
    @test DatesPlus.DateTime(y2, f) + DatesPlus.Year(1900) == dt - DatesPlus.Day(14)
    @test DatesPlus.format(dt, "yy/m") == y2

    f = "yyyy"
    z = "1996"
    @test DatesPlus.DateTime(z, f) == dt - DatesPlus.Day(14)
    @test DatesPlus.format(dt, f) == z
    z1 = "1996-3"
    @test_throws ArgumentError DatesPlus.DateTime(z1, f)
    z2 = "1996-3-1"
    @test_throws ArgumentError DatesPlus.DateTime(z2, f)

    aa = "1/5/1996"
    f = "m/d/yyyy"
    @test DatesPlus.DateTime(aa, f) == dt - DatesPlus.Day(10)
    @test DatesPlus.format(dt - DatesPlus.Day(10), f) == aa
    bb = "5/1/1996"
    f = "d/m/yyyy"
    @test DatesPlus.DateTime(bb, f) == dt - DatesPlus.Day(10)
    @test DatesPlus.format(dt - DatesPlus.Day(10), f) == bb
    cc = "01151996"
    f = "mmddyyyy"
    @test DatesPlus.DateTime(cc, f) == dt
    @test DatesPlus.format(dt, f) == cc
    dd = "15011996"
    f = "ddmmyyyy"
    @test DatesPlus.DateTime(dd, f) == dt
    @test DatesPlus.format(dt, f) == dd
    ee = "01199615"
    f = "mmyyyydd"
    @test DatesPlus.DateTime(ee, f) == dt
    @test DatesPlus.format(dt, f) == ee
    ff = "1996-15-Jan"
    f = "yyyy-dd-uuu"
    @test DatesPlus.DateTime(ff, f) == dt
    @test DatesPlus.format(dt, f) == ff
    gg = "Jan-1996-15"
    f = "uuu-yyyy-dd"
    @test DatesPlus.DateTime(gg, f) == dt
    @test DatesPlus.format(dt, f) == gg
    hh = "1996#1#15"
    f = "yyyy#m#d"
    @test DatesPlus.DateTime(hh, f) == dt
    @test DatesPlus.format(dt, f) == hh

    f = "ymd"
    @test DatesPlus.Date("111", f) == DatesPlus.Date(1)
    @test DatesPlus.Date("1", f) == DatesPlus.Date(1)

    @test DatesPlus.DateTime("20140529 120000", "yyyymmdd HHMMSS") == DatesPlus.DateTime(2014, 5, 29, 12)

    @test DatesPlus.Date(string(DatesPlus.Date(dt))) == DatesPlus.Date(dt)
    @test DatesPlus.DateTime(string(dt)) == dt
end

@testset "prefix." begin
    s = "/1996/1/15"
    f = "/yyyy/m/d"
    dt = DatesPlus.DateTime(1996, 1, 15)
    @test DatesPlus.DateTime(s, f) == dt
    @test DatesPlus.format(dt, f) == s
    @test_throws ArgumentError DatesPlus.DateTime("1996/1/15", f)
end

@testset "French and Chinese" begin
    # from Jiahao
    @test DatesPlus.Date("2009年12月01日", "yyyy年mm月dd日") == DatesPlus.Date(2009, 12, 1)
    @test DatesPlus.format(DatesPlus.Date(2009, 12, 1), "yyyy年mm月dd日") == "2009年12月01日"
    @test DatesPlus.Date("2009-12-01", "yyyy-mm-dd") == DatesPlus.Date(2009, 12, 1)

    # French: from Milan
    f = "dd/mm/yyyy"
    f2 = "dd/mm/yy"
    @test DatesPlus.Date("28/05/2014", f) == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.Date("28/05/14", f2) + DatesPlus.Year(2000) == DatesPlus.Date(2014, 5, 28)
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

    f = "dd uuuuu yyyy"
    @test DatesPlus.Date("28 mai 2014", f; locale="french") == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.format(DatesPlus.Date(2014, 5, 28), f; locale="french") == "28 mai 2014"
    @test DatesPlus.Date("28 févr 2014", f; locale="french") == DatesPlus.Date(2014, 2, 28)
    @test DatesPlus.format(DatesPlus.Date(2014, 2, 28), f; locale="french") == "28 févr 2014"
    @test DatesPlus.Date("28 août 2014", f; locale="french") == DatesPlus.Date(2014, 8, 28)
    @test DatesPlus.format(DatesPlus.Date(2014, 8, 28), f; locale="french") == "28 août 2014"
    @test DatesPlus.Date("28 avril 2014", f; locale="french") == DatesPlus.Date(2014, 4, 28)
    @test DatesPlus.format(DatesPlus.Date(2014, 4, 28), f; locale="french") == "28 avril 2014"

    f = "dd u yyyy"
    @test DatesPlus.Date("28 avril 2014", f; locale="french") == DatesPlus.Date(2014, 4, 28)
    f = "dduuuuyyyy"
    # parses 3 and 4 character month names
    @test DatesPlus.Date("28mai2014", f; locale="french") == DatesPlus.Date(2014, 5, 28)
    @test DatesPlus.Date("28août2014", f; locale="french") == DatesPlus.Date(2014, 8, 28)
    # doesn't parse month name greater than 4 chars
    @test_throws ArgumentError DatesPlus.Date("28avril2014", f; locale="french")
end

@testset "year digits parsing" begin
    # From Tony Fong
    f = "dduuuyy"
    @test DatesPlus.Date("01Dec09", f) + DatesPlus.Year(2000) == DatesPlus.Date(2009, 12, 1)
    @test DatesPlus.format(DatesPlus.Date(2009, 12, 1), f) == "01Dec09"
    f = "dduuuyyyy"
    @test DatesPlus.Date("01Dec2009", f) == DatesPlus.Date(2009, 12, 1)
    @test DatesPlus.format(DatesPlus.Date(2009, 12, 1), f) == "01Dec2009"
    f = "duy"
    globex = ["f", "g", "h", "j", "k", "m", "n", "q", "u", "v", "x", "z"]
    locale = DatesPlus.DateLocale(globex, map(uppercase, globex), globex[1:7], globex[1:7])
    @test DatesPlus.Date("1F4", f; locale=locale) + DatesPlus.Year(2010) == DatesPlus.Date(2014, 1, 1)
    @test DatesPlus.format(DatesPlus.Date(2014, 1, 1), f; locale=locale) == "1F4"

    # From Matt Bauman
    f = "yyyy-mm-ddTHH:MM:SS"
    @test DatesPlus.DateTime("2014-05-28T16:46:04", f) == DatesPlus.DateTime(2014, 5, 28, 16, 46, 04)
end

@testset "Error handling" begin
    # Specified mm/dd, but date string has day/mm
    @test_throws ArgumentError DatesPlus.DateTime("18/05/2009", "mm/dd/yyyy")
    @test_throws ArgumentError DatesPlus.DateTime("18/05/2009 16", "mm/dd/yyyy hh")
    # Used "mm" for months AND minutes
    @test_throws ArgumentError DatesPlus.DateTime("18/05/2009 16:12", "mm/dd/yyyy hh:mm")
    # Date string has different delimiters than format string
    @test_throws ArgumentError DatesPlus.DateTime("18:05:2009", "mm/dd/yyyy")

    f = "y m d"
    @test DatesPlus.Date("1 1 1", f) == DatesPlus.Date(1)
    @test DatesPlus.Date("10000000000 1 1", f) == DatesPlus.Date(10000000000)
    @test_throws ArgumentError DatesPlus.Date("1 13 1", f)
    @test_throws ArgumentError DatesPlus.Date("1 1 32", f)
    @test_throws ArgumentError DatesPlus.Date(" 1 1 32", f)
    @test_throws ArgumentError DatesPlus.Date("# 1 1 32", f)
    @test DatesPlus.Date("1", f) == DatesPlus.Date(1)
    @test DatesPlus.Date("1 ", f) == DatesPlus.Date(1)
    @test DatesPlus.Date("1 2", f) == DatesPlus.Date(1, 2)
    # can't find space delimiter (finds '/'), so fails
    @test_throws ArgumentError DatesPlus.Date("2000/1", f)
end

@testset "formerly vectorized Date/DateTime/format methods" begin
    dr = ["2000-01-01", "2000-01-02", "2000-01-03", "2000-01-04", "2000-01-05",
          "2000-01-06", "2000-01-07", "2000-01-08", "2000-01-09", "2000-01-10"]
    dr2 = [DatesPlus.Date(2000) : DatesPlus.Day(1) : DatesPlus.Date(2000, 1, 10);]
    @test DatesPlus.Date.(dr) == dr2
    @test DatesPlus.Date.(dr, dateformat"yyyy-mm-dd") == dr2
    @test DatesPlus.DateTime.(dr) == DatesPlus.DateTime.(dr2)
    @test DatesPlus.DateTime.(dr, dateformat"yyyy-mm-dd") == DatesPlus.DateTime.(dr2)

    @test DatesPlus.format.(dr2, "yyyy-mm-dd") == dr

    @test typeof(DatesPlus.Date.(dr)) == Array{Date, 1}
end

@testset "Issue 13" begin
    t = DatesPlus.DateTime(1, 1, 1, 14, 51, 0, 118)
    @test DatesPlus.DateTime("[14:51:00.118]", "[HH:MM:SS.sss]") == t
    @test DatesPlus.DateTime("14:51:00.118", "HH:MM:SS.sss") == t
    @test DatesPlus.DateTime("[14:51:00.118?", "[HH:MM:SS.sss?") == t
    @test DatesPlus.DateTime("?14:51:00.118?", "?HH:MM:SS.sss?") == t
    @test DatesPlus.DateTime("x14:51:00.118", "xHH:MM:SS.sss") == t
    @test DatesPlus.DateTime("14:51:00.118]", "HH:MM:SS.sss]") == t
end

@testset "RFC1123Format" begin
    dt = DatesPlus.DateTime(2014, 8, 23, 17, 22, 15)
    @test DatesPlus.format(dt, DatesPlus.RFC1123Format) == "Sat, 23 Aug 2014 17:22:15"
    @test DatesPlus.DateTime(DatesPlus.format(dt, DatesPlus.RFC1123Format), DatesPlus.RFC1123Format) == dt
    @test DatesPlus.format(dt, "yyyy-mm-ddTHH:MM:SS E") == "2014-08-23T17:22:15 Saturday"
    @test DatesPlus.format(dt, "yyyy-mm-ddTHH:MM:SS e") == "2014-08-23T17:22:15 Sat"
    @test DatesPlus.format(dt, "yyyy-mm-dd E") == "2014-08-23 Saturday"
    @test DatesPlus.format(dt, "yyyy-mm-dd e") == "2014-08-23 Sat"
    @test DatesPlus.format(dt, "yyyy-e-mm-dd") == "2014-Sat-08-23"

    @test DatesPlus.format(DatesPlus.DateTime(2014, 1, 2, 0, 0, 0, 999), DatesPlus.RFC1123Format) == "Thu, 02 Jan 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 2, 18, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Tue, 18 Feb 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 3, 8, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sat, 08 Mar 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 4, 28, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Mon, 28 Apr 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 5, 10, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sat, 10 May 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 6, 4, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Wed, 04 Jun 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 7, 13, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sun, 13 Jul 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 8, 17, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sun, 17 Aug 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 9, 20, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sat, 20 Sep 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 10, 31, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Fri, 31 Oct 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 11, 2, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Sun, 02 Nov 2014 00:00:00"
    @test DatesPlus.format(DatesPlus.DateTime(2014, 12, 5, 0, 0, 0, 9), DatesPlus.RFC1123Format) == "Fri, 05 Dec 2014 00:00:00"

    dt = DatesPlus.DateTime(2016, 11, 12, 7, 45, 36)
    @test parse(DatesPlus.DateTime, "Sat, 12 Nov 2016 07:45:36", DatesPlus.RFC1123Format) == dt
    @test parse(DatesPlus.DateTime, "Mon, 12 Nov 2016 07:45:36", DatesPlus.RFC1123Format) == dt  # Wrong day of week
    @test_throws ArgumentError parse(Date, "Foo, 12 Nov 2016 07:45:36", DatesPlus.RFC1123Format)
end

@testset "Issue 15195" begin
    f = "YY"
    @test DatesPlus.format(DatesPlus.Date(1999), f) == "1999"
    @test DatesPlus.format(DatesPlus.Date(9), f) == "09"
    @test DatesPlus.format(typemax(DatesPlus.Date), f) == "252522163911149"
end

@testset "TimeZones.jl Issue #19" begin
    Zulu = String

    function DatesPlus.tryparsenext(d::DatesPlus.DatePart{'Z'}, str, i, len)
        return DatesPlus.tryparsenext_word(str, i, len, DatesPlus.min_width(d), DatesPlus.max_width(d))
    end

    str = "2015-07-24T05:38:19.591Z"
    dt = DatesPlus.DateTime(2015, 7, 24, 5, 38, 19, 591)
    parsed = Any[
        DatesPlus.Year(2015), DatesPlus.Month(7), DatesPlus.Day(24),
        DatesPlus.Hour(5), DatesPlus.Minute(38), DatesPlus.Second(19), DatesPlus.Millisecond(591)
    ]

    format = "yyyy-mm-ddTHH:MM:SS.sssZ"
    escaped_format = "yyyy-mm-dd\\THH:MM:SS.sss\\Z"

    # Typically 'Z' isn't treated as a specifier so it doesn't have to be escaped
    @test DatesPlus.parse_components(str, DatesPlus.DateFormat(format)) == parsed
    @test DatesPlus.parse_components(str, DatesPlus.DateFormat(escaped_format)) == parsed

    try
        # Make 'Z' into a specifier
        DatesPlus.CONVERSION_SPECIFIERS['Z'] = Zulu
        DatesPlus.CONVERSION_DEFAULTS[Zulu] = ""

        @test DatesPlus.parse_components(str, DatesPlus.DateFormat(format)) == [parsed; Zulu("Z")]
        @test DatesPlus.parse_components(str, DatesPlus.DateFormat(escaped_format)) == parsed
    finally
        delete!(DatesPlus.CONVERSION_SPECIFIERS, 'Z')
        delete!(DatesPlus.CONVERSION_DEFAULTS, Zulu)
    end

    # Ensure that the default behaviour has been restored
    @test DatesPlus.parse_components(str, DatesPlus.DateFormat(format)) == parsed
    @test DatesPlus.parse_components(str, DatesPlus.DateFormat(escaped_format)) == parsed
end

@testset "Issue 10817" begin
    @test DatesPlus.Date("Apr 01 2014", "uuu dd yyyy") == DatesPlus.Date(2014, 4, 1)
    @test_throws ArgumentError DatesPlus.Date("Apr 01 xx 2014", "uuu dd zz yyyy")
    @test_throws ArgumentError DatesPlus.Date("Apr 01 xx 2014", "uuu dd    yyyy")
end

@testset "Issue 21001" begin
    for (ms, str) in zip([0, 1, 20, 300, 450, 678], ["0", "001", "02", "3", "45", "678"])
        local dt = DateTime(2000, 1, 1, 0, 0, 0, ms)
        @test DatesPlus.format(dt, "s") == str
        @test DatesPlus.format(dt, "ss") == rpad(str, 2, '0')
        @test DatesPlus.format(dt, "sss") == rpad(str, 3, '0')
        @test DatesPlus.format(dt, "ssss") == rpad(str, 4, '0')
    end
end

# Issue #21504
@test tryparse(DatesPlus.Date, "0-1000") === nothing

# Issue #44003
@test tryparse(DatesPlus.Date, "2017", DatesPlus.DateFormat(".s")) === nothing

@testset "parse milliseconds, Issue #22100" begin
    @test DatesPlus.DateTime("2017-Mar-17 00:00:00.0000", "y-u-d H:M:S.s") == DatesPlus.DateTime(2017, 3, 17)
    @test DatesPlus.parse_components(".1", DatesPlus.DateFormat(".s")) == [DatesPlus.Millisecond(100)]
    @test DatesPlus.parse_components(".12", DatesPlus.DateFormat(".s")) == [DatesPlus.Millisecond(120)]
    @test DatesPlus.parse_components(".123", DatesPlus.DateFormat(".s")) == [DatesPlus.Millisecond(123)]
    @test DatesPlus.parse_components(".1230", DatesPlus.DateFormat(".s")) == [DatesPlus.Millisecond(123)]
    # Issue #44003
    @test_throws ArgumentError DatesPlus.parse_components(".1234", DatesPlus.DateFormat(".s"))

    # Ensure that no overflow occurs when using Int32 literals: Int32(10)^10
    @test DatesPlus.parse_components("." * rpad(999, 10, '0'), DatesPlus.DateFormat(".s")) == [DatesPlus.Millisecond(999)]
end

@testset "Time Parsing" begin
    let t
        time_tuple(t::DatesPlus.Time) = (
            DatesPlus.hour(t), DatesPlus.minute(t), DatesPlus.second(t),
            DatesPlus.millisecond(t), DatesPlus.microsecond(t), DatesPlus.nanosecond(t)
        )

        ## default ISOTimeFormat
        t = DatesPlus.Time("01")
        @test time_tuple(t) == (1, 0, 0, 0, 0, 0)
        t = DatesPlus.Time("01:23")
        @test time_tuple(t) == (1, 23, 0, 0, 0, 0)
        t = DatesPlus.Time("01:23:45")
        @test time_tuple(t) == (1, 23, 45, 0, 0, 0)
        t = DatesPlus.Time("01:23:45.678")
        @test time_tuple(t) == (1, 23, 45, 678, 0, 0)

        ## string format
        t = DatesPlus.Time("23:56:12.1", "HH:MM:SS.s")
        @test time_tuple(t) == (23, 56, 12, 100, 0, 0)

        ## precomputed DateFormat
        t = DatesPlus.Time("04:09:45.012", DateFormat("HH:MM:SS.s"))
        @test time_tuple(t) == (4, 9, 45, 12, 0, 0)
        t = DatesPlus.Time("21 07", DateFormat("HH MM"))
        @test time_tuple(t) == (21, 7, 0, 0, 0, 0)
        t = DatesPlus.Time("4.02", DateFormat("H.MM"))
        @test time_tuple(t) == (4, 2, 0, 0, 0, 0)
        t = DatesPlus.Time("1725", DateFormat("HHMM"))
        @test time_tuple(t) == (17, 25, 0, 0, 0, 0)

        ## exceptions
        @test_throws ArgumentError DatesPlus.Time("24:00")  # invalid hours
        @test_throws ArgumentError DatesPlus.Time("00:60")  # invalid minutes
        @test_throws ArgumentError DatesPlus.Time("00:00:60")  # invalid seconds
        @test_throws ArgumentError DatesPlus.Time("20:03:20", DateFormat("HH:MM"))  # too much precision
        @test_throws ArgumentError DatesPlus.Time("10:33:51", DateFormat("YYYY-MM-DD HH:MM:SS"))  # Time can't hold year/month/day
    end
end

@testset "midnight" begin
    # issue #28203: 24:00 is a valid ISO 8601 time
    @test DateTime("2018-01-01 24:00", "yyyy-mm-dd HH:MM") ==
          DateTime("2018-01-02T00:00:00") ==
          DateTime(2018, 1, 1, 24) ==
          DateTime(2018, 1, 2)
    @test_throws ArgumentError DateTime("2018-01-01 24:01", "yyyy-mm-dd HH:MM")
    @test_throws ArgumentError DateTime(2018, 1, 1, 24, 0, 1)
    @test_throws ArgumentError DateTime(2018, 1, 1, 24, 0, 0, 1)
end

@testset "AM/PM" begin
    for (t12, t24) in (
        ("12:00am", "00:00"),
        ("12:07am", "00:07"),
        ("01:24AM", "01:24"),
        ("12:00pm", "12:00"),
        ("12:15pm", "12:15"),
        ("11:59PM", "23:59"),
    )
        d = DateTime("2018-01-01T$t24:00")
        t = Time("$t24:00")
        for HH in ("HH", "II")
            @test DateTime("2018-01-01 $t12", "yyyy-mm-dd $HH:MMp") == d
            @test Time("$t12", "$HH:MMp") == t
        end
        local tmstruct, strftime
        withlocales(["C"]) do
            # test am/pm comparison handling
            tmstruct = Libc.strptime("%I:%M%p", t12)
            strftime = Libc.strftime("%I:%M%p", tmstruct)
            nothing
        end
        @test Time(tmstruct) == t
        @test uppercase(t12) ==
              DatesPlus.format(t, "II:MMp") ==
              DatesPlus.format(d, "II:MMp") ==
              strftime
    end
    for bad in ("00:24am", "00:24pm", "13:24pm", "2pm", "12:24p.m.", "12:24 pm", "12:24pµ")
        @test_throws ArgumentError Time(bad, "II:MMp")
    end
    # if am/pm is missing, defaults to 24-hour clock
    @test Time("13:24", "II:MMp") == Time("13:24", "HH:MM")
end

@testset "Issue #10561, two-digit year parsing ambiguities" begin
    # All two-digit dates (whether full or resulting from truncation, e.g. 2010 -> 10)
    # encoded in two digit year format YY are parsed as year 00YY

    for test_year in ("00", "01", "99", "2021")
        @test Date(test_year, dateformat"yy") == Date(parse(Int, test_year))
    end
end

@testset "inference with dynamic dateformat string" begin
    datetime = DateTime(2020, 4, 7)
    f1() = DateTime("2020-04-07", "yyyy-mm-dd")
    f2() = DateTime("2020-04-07", DateFormat("yyyy-mm-dd"))
    f3() = parse(DateTime, "2020-04-07", DateFormat("yyyy-mm-dd"))
    @test (@inferred f1()) == (@inferred f2()) == (@inferred f3()) == datetime
    g() = tryparse(DateTime, "2020-04-07", DateFormat("yyyy-mm-dd"))
    @test (@inferred Nothing g()) == datetime
end

end
