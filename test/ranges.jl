# This file is a part of Julia. License is MIT: https://julialang.org/license

module RangesTest

using Test
using Dates

using InteractiveUtils: subtypes

let
    for T in (DatesPlus.Date, DatesPlus.DateTime)
        f1 = T(2014); l1 = T(2013, 12, 31)
        f2 = T(2014); l2 = T(2014)
        f3 = T(-2000); l3 = T(2000)
        f4 = typemin(T); l4 = typemax(T)

        for P in subtypes(DatesPlus.DatePeriod)
            for pos_step in (P(1), P(2), P(50), P(2048), P(10000))
                # empty range
                dr = f1:pos_step:l1
                len = length(dr)
                @test len == 0
                @test isa(len, Int64)
                @test isempty(dr)
                @test first(dr) == f1
                @test last(dr) < f1
                @test length([i for i in dr]) == 0
                @test_throws ArgumentError minimum(dr)
                @test_throws ArgumentError maximum(dr)
                @test_throws BoundsError dr[1]
                @test findall(in(dr), dr) == Int64[]
                @test [dr;] == T[]
                @test isempty(reverse(dr))
                @test length(reverse(dr)) == 0
                @test first(reverse(dr)) < f1
                @test last(reverse(dr)) >= f1
                @test issorted(dr)
                @test sortperm(dr) === StepRange{Int64,Int}(1:1:0)
                @test !(f1 in dr)
                @test !(l1 in dr)
                @test !(f1 - pos_step in dr)
                @test !(l1 + pos_step in dr)
                @test dr == []
                @test hash(dr) == hash([])

                for (f, l) in ((f2, l2), (f3, l3), (f4, l4))
                    dr = f:pos_step:l
                    len = length(dr)
                    @test len > 0
                    @test isa(len, Int64)
                    @test !isempty(dr)
                    @test first(dr) == f
                    @test last(dr) <= l
                    @test minimum(dr) == first(dr)
                    @test maximum(dr) == last(dr)
                    @test dr[1] == f
                    @test dr[end] <= l
                    @test iterate(dr) == (first(dr), (length(dr), 1))

                    if len < 10000
                        dr1 = [i for i in dr]
                        @test length(dr1) == len
                        @test findall(in(dr), dr) == [1:len;]
                        @test length([dr;]) == len
                        @test dr == dr1
                        @test hash(dr) == hash(dr1)
                    end
                    @test !isempty(reverse(dr))
                    @test length(reverse(dr)) == len
                    @test last(reverse(dr)) == f
                    @test issorted(dr)
                    @test f in dr

                end
            end
            for neg_step in (P(-1), P(-2), P(-50), P(-2048), P(-10000))
                # empty range
                dr = l1:neg_step:f1
                len = length(dr)
                @test len == 0
                @test isa(len, Int64)
                @test isempty(dr)
                @test first(dr) == l1
                @test last(dr) > l1
                @test length([i for i in dr]) == 0
                @test_throws ArgumentError minimum(dr)
                @test_throws ArgumentError maximum(dr)
                @test_throws BoundsError dr[1]
                @test findall(in(dr), dr) == Int64[]
                @test [dr;] == T[]
                @test isempty(reverse(dr))
                @test length(reverse(dr)) == 0
                @test first(reverse(dr)) > l1
                @test last(reverse(dr)) <= l1
                @test issorted(dr)
                @test sortperm(dr) === StepRange{Int64,Int}(1:1:0)
                @test !(l1 in dr)
                @test !(l1 in dr)
                @test !(l1 - neg_step in dr)
                @test !(l1 + neg_step in dr)
                @test dr == []
                @test hash(dr) == hash([])

                for (f, l) in ((f2, l2), (f3, l3), (f4, l4))
                    dr = l:neg_step:f
                    len = length(dr)
                    @test len > 0
                    @test isa(len, Int64)
                    @test !isempty(dr)
                    @test first(dr) == l
                    @test last(dr) >= f
                    @test minimum(dr) == last(dr)
                    @test maximum(dr) == first(dr)
                    @test dr[1] == l
                    @test dr[end] >= f
                    @test iterate(dr) == (first(dr), (length(dr), 1))

                    if len < 10000
                        dr1 = [i for i in dr]
                        @test length(dr1) == len
                        @test findall(in(dr), dr) == [1:len;]
                        @test length([dr;]) == len
                        @test dr == dr1
                        @test hash(dr) == hash(dr1)
                    end
                    @test !isempty(reverse(dr))
                    @test length(reverse(dr)) == len
                    @test issorted(dr) == (len <= 1)
                    @test l in dr
                end
            end
        end
        if T == DatesPlus.DateTime
            for P in subtypes(DatesPlus.TimePeriod)
                P in (DatesPlus.Microsecond, DatesPlus.Nanosecond) && continue
                for pos_step in (P(1), P(2), P(50), P(2048), P(10000))
                    # empty range
                    dr = f1:pos_step:l1
                    len = length(dr)
                    @test len == 0
                    @test isa(len, Int64)
                    @test isempty(dr)
                    @test first(dr) == f1
                    @test last(dr) < f1
                    @test length([i for i in dr]) == 0
                    @test_throws ArgumentError minimum(dr)
                    @test_throws ArgumentError maximum(dr)
                    @test_throws BoundsError dr[1]
                    @test findall(in(dr), dr) == Int64[]
                    @test [dr;] == T[]
                    @test isempty(reverse(dr))
                    @test length(reverse(dr)) == 0
                    @test first(reverse(dr)) < f1
                    @test last(reverse(dr)) >= f1
                    @test issorted(dr)
                    @test sortperm(dr) === StepRange{Int64,Int}(1:1:0)
                    @test !(f1 in dr)
                    @test !(l1 in dr)
                    @test !(f1 - pos_step in dr)
                    @test !(l1 + pos_step in dr)
                    @test dr == []
                    @test hash(dr) == hash([])

                    for (f, l) in ((f2, l2), (f3, l3), (f4, l4))
                        dr = f:pos_step:l
                        len = length(dr)
                        @test len > 0
                        @test isa(len, Int64)
                        @test !isempty(dr)
                        @test first(dr) == f
                        @test last(dr) <= l
                        @test minimum(dr) == first(dr)
                        @test maximum(dr) == last(dr)
                        @test dr[1] == f
                        @test dr[end] <= l
                        @test iterate(dr) == (first(dr), (length(dr), 1))

                        if len < 10000
                            dr1 = [i for i in dr]
                            @test length(dr1) == len
                            @test findall(in(dr), dr) == [1:len;]
                            @test length([dr;]) == len
                            @test dr == dr1
                            @test hash(dr) == hash(dr1)
                        end
                        @test !isempty(reverse(dr))
                        @test length(reverse(dr)) == len
                        @test last(reverse(dr)) == f
                        @test issorted(dr)
                        @test f in dr

                    end
                end
                for neg_step in (P(-1), P(-2), P(-50), P(-2048), P(-10000))
                    # empty range
                    dr = l1:neg_step:f1
                    len = length(dr)
                    @test len == 0
                    @test isa(len, Int64)
                    @test isempty(dr)
                    @test first(dr) == l1
                    @test last(dr) > l1
                    @test length([i for i in dr]) == 0
                    @test_throws ArgumentError minimum(dr)
                    @test_throws ArgumentError maximum(dr)
                    @test_throws BoundsError dr[1]
                    @test findall(in(dr), dr) == Int64[]
                    @test [dr;] == T[]
                    @test isempty(reverse(dr))
                    @test length(reverse(dr)) == 0
                    @test first(reverse(dr)) > l1
                    @test last(reverse(dr)) <= l1
                    @test issorted(dr)
                    @test sortperm(dr) === StepRange{Int64,Int}(1:1:0)
                    @test !(l1 in dr)
                    @test !(l1 in dr)
                    @test !(l1 - neg_step in dr)
                    @test !(l1 + neg_step in dr)
                    @test dr == []
                    @test hash(dr) == hash([])

                    for (f, l) in ((f2, l2), (f3, l3), (f4, l4))
                        dr = l:neg_step:f
                        len = length(dr)
                        @test len > 0
                        @test isa(len, Int64)
                        @test !isempty(dr)
                        @test first(dr) == l
                        @test last(dr) >= f
                        @test minimum(dr) == last(dr)
                        @test maximum(dr) == first(dr)
                        @test dr[1] == l
                        @test dr[end] >= f
                        @test iterate(dr) == (first(dr), (length(dr), 1))

                        if len < 10000
                            dr1 = [i for i in dr]
                            @test length(dr1) == len
                            @test findall(in(dr), dr) == [1:len;]
                            @test length([dr;]) == len
                            @test dr == dr1
                            @test hash(dr) == hash(dr1)
                        end
                        @test !isempty(reverse(dr))
                        @test length(reverse(dr)) == len
                        @test last(reverse(dr)) >= l
                        @test issorted(dr) == (len <= 1)
                        @test l in dr

                    end
                end
            end
        end
    end
end

# Dates are physical units, and ranges should require an explicit step.
# See #19896 and https://discourse.julialang.org/t/type-restriction-on-unitrange/6557/12
if VERSION >= v"1.0.0"
    @test_throws MethodError DatesPlus.DateTime(2013, 1, 1):DatesPlus.DateTime(2013, 2, 1)
end

# All the range representations we want to test
# Date ranges
dr  = DatesPlus.DateTime(2013, 1, 1):DatesPlus.Day(1):DatesPlus.DateTime(2013, 2, 1)
dr1 = DatesPlus.DateTime(2013, 1, 1):DatesPlus.Day(1):DatesPlus.DateTime(2013, 1, 1)
dr2 = DatesPlus.DateTime(2013, 1, 1):DatesPlus.Day(1):DatesPlus.DateTime(2012, 2, 1) # empty range
dr3 = DatesPlus.DateTime(2013, 1, 1):DatesPlus.Day(-1):DatesPlus.DateTime(2012) # negative step
# Big ranges
dr4 = DatesPlus.DateTime(0):DatesPlus.Day(1):DatesPlus.DateTime(20000, 1, 1)
dr5 = DatesPlus.DateTime(0):DatesPlus.Day(1):DatesPlus.DateTime(200000, 1, 1)
dr6 = DatesPlus.DateTime(0):DatesPlus.Day(1):DatesPlus.DateTime(2000000, 1, 1)
dr7 = DatesPlus.DateTime(0):DatesPlus.Day(1):DatesPlus.DateTime(20000000, 1, 1)
dr8 = DatesPlus.DateTime(0):DatesPlus.Day(1):DatesPlus.DateTime(200000000, 1, 1)
dr9 = typemin(DatesPlus.DateTime):DatesPlus.Day(1):typemax(DatesPlus.DateTime)
# Other steps
dr10 = typemax(DatesPlus.DateTime):DatesPlus.Day(-1):typemin(DatesPlus.DateTime)
dr11 = typemin(DatesPlus.DateTime):DatesPlus.Week(1):typemax(DatesPlus.DateTime)

dr12 = typemin(DatesPlus.DateTime):DatesPlus.Month(1):typemax(DatesPlus.DateTime)
dr13 = typemin(DatesPlus.DateTime):DatesPlus.Year(1):typemax(DatesPlus.DateTime)

dr14 = typemin(DatesPlus.DateTime):DatesPlus.Week(10):typemax(DatesPlus.DateTime)
dr15 = typemin(DatesPlus.DateTime):DatesPlus.Month(100):typemax(DatesPlus.DateTime)
dr16 = typemin(DatesPlus.DateTime):DatesPlus.Year(1000):typemax(DatesPlus.DateTime)
dr17 = typemax(DatesPlus.DateTime):DatesPlus.Week(-10000):typemin(DatesPlus.DateTime)
dr18 = typemax(DatesPlus.DateTime):DatesPlus.Month(-100000):typemin(DatesPlus.DateTime)
dr19 = typemax(DatesPlus.DateTime):DatesPlus.Year(-1000000):typemin(DatesPlus.DateTime)
dr20 = typemin(DatesPlus.DateTime):DatesPlus.Day(2):typemax(DatesPlus.DateTime)

drs = Any[dr, dr1, dr2, dr3, dr4, dr5, dr6, dr7, dr8, dr9, dr10,
          dr11, dr12, dr13, dr14, dr15, dr16, dr17, dr18, dr19, dr20]
drs2 = map(x->DatesPlus.Date(first(x)):step(x):DatesPlus.Date(last(x)), drs)

@test map(length, drs) == map(x->size(x)[1], drs)
@test map(length, drs) == map(x->length(DatesPlus.Date(first(x)):step(x):DatesPlus.Date(last(x))), drs)
@test map(length, drs) == map(x->length(reverse(x)), drs)
@test all(x->findall(in(x), x)==[1:length(x);], drs[1:4])
@test isempty(dr2)
@test all(x->reverse(x) == range(last(x), step=-step(x), length=length(x)), drs)
@test all(x->minimum(x) == (step(x) < zero(step(x)) ? last(x) : first(x)), drs[4:end])
@test all(x->maximum(x) == (step(x) < zero(step(x)) ? first(x) : last(x)), drs[4:end])
@test all(drs[1:3]) do dd
    for (i, d) in enumerate(dd)
        @test d == (first(dd) + DatesPlus.Day(i - 1))
    end
    true
end
@test_throws MethodError dr .+ 1
a = DatesPlus.DateTime(2013, 1, 1)
b = DatesPlus.DateTime(2013, 2, 1)
@test map!(x->x + DatesPlus.Day(1), Vector{DatesPlus.DateTime}(undef, 32), dr) == [(a + DatesPlus.Day(1)):DatesPlus.Day(1):(b + DatesPlus.Day(1));]
@test map(x->x + DatesPlus.Day(1), dr) == [(a + DatesPlus.Day(1)):DatesPlus.Day(1):(b + DatesPlus.Day(1));]

@test map(x->a in x, drs[1:4]) == [true, true, false, true]
@test a in dr
@test b in dr
@test DatesPlus.DateTime(2013, 1, 3) in dr
@test DatesPlus.DateTime(2013, 1, 15) in dr
@test DatesPlus.DateTime(2013, 1, 26) in dr
@test !(DatesPlus.DateTime(2012, 1, 1) in dr)

@test all(x->sort(x) == (step(x) < zero(step(x)) ? reverse(x) : x), drs)
@test all(x->step(x) < zero(step(x)) ? issorted(reverse(x)) : issorted(x), drs)

@test length(b:DatesPlus.Day(-1):a) == 32
@test length(b:DatesPlus.Day(1):a) == 0
@test length(b:DatesPlus.Day(1):a) == 0
@test length(a:DatesPlus.Day(2):b) == 16
@test last(a:DatesPlus.Day(2):b) == DatesPlus.DateTime(2013, 1, 31)
@test length(a:DatesPlus.Day(7):b) == 5
@test last(a:DatesPlus.Day(7):b) == DatesPlus.DateTime(2013, 1, 29)
@test length(a:DatesPlus.Day(32):b) == 1
@test last(a:DatesPlus.Day(32):b) == DatesPlus.DateTime(2013, 1, 1)
@test (a:DatesPlus.Day(1):b)[1] == DatesPlus.DateTime(2013, 1, 1)
@test (a:DatesPlus.Day(1):b)[2] == DatesPlus.DateTime(2013, 1, 2)
@test (a:DatesPlus.Day(1):b)[7] == DatesPlus.DateTime(2013, 1, 7)
@test (a:DatesPlus.Day(1):b)[end] == b
@test first(a:DatesPlus.Day(1):DatesPlus.DateTime(20000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.DateTime(200000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.DateTime(2000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.DateTime(20000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.DateTime(200000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):typemax(DatesPlus.DateTime)) == a
@test first(typemin(DatesPlus.DateTime):DatesPlus.Day(1):typemax(DatesPlus.DateTime)) == typemin(DatesPlus.DateTime)

# Date ranges
dr  = DatesPlus.Date(2013, 1, 1):DatesPlus.Day(1):DatesPlus.Date(2013, 2, 1)
dr1 = DatesPlus.Date(2013, 1, 1):DatesPlus.Day(1):DatesPlus.Date(2013, 1, 1)
dr2 = DatesPlus.Date(2013, 1, 1):DatesPlus.Day(1):DatesPlus.Date(2012, 2, 1) # empty range
dr3 = DatesPlus.Date(2013, 1, 1):DatesPlus.Day(-1):DatesPlus.Date(2012, 1, 1) # negative step
# Big ranges
dr4 = DatesPlus.Date(0):DatesPlus.Day(1):DatesPlus.Date(20000, 1, 1)
dr5 = DatesPlus.Date(0):DatesPlus.Day(1):DatesPlus.Date(200000, 1, 1)
dr6 = DatesPlus.Date(0):DatesPlus.Day(1):DatesPlus.Date(2000000, 1, 1)
dr7 = DatesPlus.Date(0):DatesPlus.Day(1):DatesPlus.Date(20000000, 1, 1)
dr8 = DatesPlus.Date(0):DatesPlus.Day(1):DatesPlus.Date(200000000, 1, 1)
dr9 = typemin(DatesPlus.Date):DatesPlus.Day(1):typemax(DatesPlus.Date)
# Other steps
dr10 = typemax(DatesPlus.Date):DatesPlus.Day(-1):typemin(DatesPlus.Date)
dr11 = typemin(DatesPlus.Date):DatesPlus.Week(1):typemax(DatesPlus.Date)
dr12 = typemin(DatesPlus.Date):DatesPlus.Month(1):typemax(DatesPlus.Date)
dr13 = typemin(DatesPlus.Date):DatesPlus.Year(1):typemax(DatesPlus.Date)
dr14 = typemin(DatesPlus.Date):DatesPlus.Week(10):typemax(DatesPlus.Date)
dr15 = typemin(DatesPlus.Date):DatesPlus.Month(100):typemax(DatesPlus.Date)
dr16 = typemin(DatesPlus.Date):DatesPlus.Year(1000):typemax(DatesPlus.Date)
dr17 = typemax(DatesPlus.Date):DatesPlus.Week(-10000):typemin(DatesPlus.Date)
dr18 = typemax(DatesPlus.Date):DatesPlus.Month(-100000):typemin(DatesPlus.Date)
dr19 = typemax(DatesPlus.Date):DatesPlus.Year(-1000000):typemin(DatesPlus.Date)
dr20 = typemin(DatesPlus.Date):DatesPlus.Day(2):typemax(DatesPlus.Date)

drs = Any[dr, dr1, dr2, dr3, dr4, dr5, dr6, dr7, dr8, dr9, dr10,
          dr11, dr12, dr13, dr14, dr15, dr16, dr17, dr18, dr19, dr20]

@test map(length, drs) == map(x->size(x)[1], drs)
@test all(x->findall(in(x), x) == [1:length(x);], drs[1:4])
@test isempty(dr2)
@test all(x->reverse(x) == last(x): - step(x):first(x), drs)
@test all(x->minimum(x) == (step(x) < zero(step(x)) ? last(x) : first(x)), drs[4:end])
@test all(x->maximum(x) == (step(x) < zero(step(x)) ? first(x) : last(x)), drs[4:end])
@test all(drs[1:3]) do dd
    for (i, d) in enumerate(dd)
        @test d == (first(dd) + DatesPlus.Day(i - 1))
    end
    true
end
@test_throws MethodError dr .+ 1
a = DatesPlus.Date(2013, 1, 1)
b = DatesPlus.Date(2013, 2, 1)
@test map!(x->x + DatesPlus.Day(1), Vector{DatesPlus.Date}(undef, 32), dr) == [(a + DatesPlus.Day(1)):DatesPlus.Day(1):(b + DatesPlus.Day(1));]
@test map(x->x + DatesPlus.Day(1), dr) == [(a + DatesPlus.Day(1)):DatesPlus.Day(1):(b + DatesPlus.Day(1));]

@test map(x->a in x, drs[1:4]) == [true, true, false, true]
@test a in dr
@test b in dr
@test DatesPlus.Date(2013, 1, 3) in dr
@test DatesPlus.Date(2013, 1, 15) in dr
@test DatesPlus.Date(2013, 1, 26) in dr
@test !(DatesPlus.Date(2012, 1, 1) in dr)

@test all(x->sort(x) == (step(x) < zero(step(x)) ? reverse(x) : x), drs)
@test all(x->step(x) < zero(step(x)) ? issorted(reverse(x)) : issorted(x), drs)

@test length(b:DatesPlus.Day(-1):a) == 32
@test length(b:DatesPlus.Day(1):a) == 0
@test length(a:DatesPlus.Day(2):b) == 16
@test last(a:DatesPlus.Day(2):b) == DatesPlus.Date(2013, 1, 31)
@test length(a:DatesPlus.Day(7):b) == 5
@test last(a:DatesPlus.Day(7):b) == DatesPlus.Date(2013, 1, 29)
@test length(a:DatesPlus.Day(32):b) == 1
@test last(a:DatesPlus.Day(32):b) == DatesPlus.Date(2013, 1, 1)
@test (a:DatesPlus.Day(1):b)[1] == DatesPlus.Date(2013, 1, 1)
@test (a:DatesPlus.Day(1):b)[2] == DatesPlus.Date(2013, 1, 2)
@test (a:DatesPlus.Day(1):b)[7] == DatesPlus.Date(2013, 1, 7)
@test (a:DatesPlus.Day(1):b)[end] == b
@test first(a:DatesPlus.Day(1):DatesPlus.Date(20000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.Date(200000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.Date(2000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.Date(20000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):DatesPlus.Date(200000000, 1, 1)) == a
@test first(a:DatesPlus.Day(1):typemax(DatesPlus.Date)) == a
@test first(typemin(DatesPlus.Date):DatesPlus.Day(1):typemax(DatesPlus.Date)) == typemin(DatesPlus.Date)

@test length(typemin(DatesPlus.Date):DatesPlus.Week(1):typemax(DatesPlus.Date)) == 26351950414948059
# Big Month/Year ranges
@test length(typemin(DatesPlus.Date):DatesPlus.Month(1):typemax(DatesPlus.Date)) == 6060531933867600
@test length(typemin(DatesPlus.Date):DatesPlus.Year(1):typemax(DatesPlus.Date)) == 505044327822300
@test length(typemin(DatesPlus.DateTime):DatesPlus.Month(1):typemax(DatesPlus.DateTime)) == 3507324288
@test length(typemin(DatesPlus.DateTime):DatesPlus.Year(1):typemax(DatesPlus.DateTime)) == 292277024

@test length(typemin(DatesPlus.DateTime):DatesPlus.Week(1):typemax(DatesPlus.DateTime)) == 15250284420
@test length(typemin(DatesPlus.DateTime):DatesPlus.Day(1):typemax(DatesPlus.DateTime)) == 106751990938
@test length(typemin(DatesPlus.DateTime):DatesPlus.Hour(1):typemax(DatesPlus.DateTime)) == 2562047782512
@test length(typemin(DatesPlus.DateTime):DatesPlus.Minute(1):typemax(DatesPlus.DateTime)) == 153722866950720
@test length(typemin(DatesPlus.DateTime):DatesPlus.Second(1):typemax(DatesPlus.DateTime)) == 9223372017043200
@test length(typemin(DateTime):DatesPlus.Millisecond(1):typemax(DateTime)) == 9223372017043199001

c = DatesPlus.Date(2013, 6, 1)
@test length(a:DatesPlus.Month(1):c) == 6
@test [a:DatesPlus.Month(1):c;] == [a + DatesPlus.Month(1)*i for i in 0:5]
@test [a:DatesPlus.Month(2):DatesPlus.Date(2013, 1, 2);] == [a]
@test [c:DatesPlus.Month(-1):a;] == reverse([a:DatesPlus.Month(1):c;])

@test length(range(Date(2000), step=DatesPlus.Day(1), length=366)) == 366
let n = 100000
    local a = DatesPlus.Date(2000)
    for i = 1:n
        @test length(range(a, step=DatesPlus.Day(1), length=i)) == i
    end
    return a + DatesPlus.Day(n)
end

@test typeof(step(DatesPlus.DateTime(2000):DatesPlus.Day(1):DatesPlus.DateTime(2001))) == DatesPlus.Day

a = DatesPlus.Date(2013, 1, 1)
b = DatesPlus.Date(2013, 2, 1)
d = DatesPlus.Date(2020, 1, 1)
@test length(a:DatesPlus.Year(1):d) == 8
@test first(a:DatesPlus.Year(1):d) == a
@test last(a:DatesPlus.Year(1):d) == d
@test length(a:DatesPlus.Month(12):d) == 8
@test first(a:DatesPlus.Month(12):d) == a
@test last(a:DatesPlus.Month(12):d) == d
@test length(a:DatesPlus.Week(52):d) == 8
@test first(a:DatesPlus.Week(52):d) == a
@test last(a:DatesPlus.Week(52):d) == DatesPlus.Date(2019, 12, 24)
@test length(a:DatesPlus.Day(365):d) == 8
@test first(a:DatesPlus.Day(365):d) == a
@test last(a:DatesPlus.Day(365):d) == DatesPlus.Date(2019, 12, 31)

a = DatesPlus.Date(2013, 1, 1)
b = DatesPlus.Date(2013, 2, 1)
@test length(a:DatesPlus.Year(1):DatesPlus.Date(2020, 2, 1)) == 8
@test length(a:DatesPlus.Year(1):DatesPlus.Date(2020, 6, 1)) == 8
@test length(a:DatesPlus.Year(1):DatesPlus.Date(2020, 11, 1)) == 8
@test length(a:DatesPlus.Year(1):DatesPlus.Date(2020, 12, 31)) == 8
@test length(a:DatesPlus.Year(1):DatesPlus.Date(2021, 1, 1)) == 9
@test length(DatesPlus.Date(2000):DatesPlus.Year(-10):DatesPlus.Date(1900)) == 11
@test length(DatesPlus.Date(2000, 6, 23):DatesPlus.Year(-10):DatesPlus.Date(1900, 2, 28)) == 11
@test length(DatesPlus.Date(2000, 1, 1):DatesPlus.Year(1):DatesPlus.Date(2000, 2, 1)) == 1

let n = 100000
    local a, b
    a= b = DatesPlus.Date(0)
    for i = 1:n
        @test length(a:DatesPlus.Year(1):b) == i
        b += DatesPlus.Year(1)
    end
end

let n = 10000,
    a = DatesPlus.Date(1985, 12, 5),
    b = DatesPlus.Date(1986, 12, 27),
    c = DatesPlus.DateTime(1985, 12, 5),
    d = DatesPlus.DateTime(1986, 12, 27)
    for i = 1:n
        @test length(a:DatesPlus.Month(1):b) == 13
        @test length(a:DatesPlus.Year(1):b) == 2
        @test length(c:DatesPlus.Month(1):d) == 13
        @test length(c:DatesPlus.Year(1):d) == 2
        a += DatesPlus.Day(1)
        b += DatesPlus.Day(1)
    end
end

let n = 100000
    local a, b
    a = b = DatesPlus.Date(2000)
    for i = 1:n
        @test length(a:DatesPlus.Month(1):b) == i
        b += DatesPlus.Month(1)
    end
end

@test length(DatesPlus.Year(1):DatesPlus.Year(1):DatesPlus.Year(10)) == 10
@test length(DatesPlus.Year(10):DatesPlus.Year(-1):DatesPlus.Year(1)) == 10
@test length(DatesPlus.Year(10):DatesPlus.Year(-2):DatesPlus.Year(1)) == 5
@test length(typemin(DatesPlus.Year):DatesPlus.Year(1):typemax(DatesPlus.Year)) == 0 # overflow
@test_throws MethodError DatesPlus.Date(0):DatesPlus.DateTime(2000)
@test_throws MethodError DatesPlus.Date(0):DatesPlus.Year(10)
@test length(range(DatesPlus.Date(2000), step=DatesPlus.Day(1), length=366)) == 366
@test last(range(DatesPlus.Date(2000), step=DatesPlus.Day(1), length=366)) == DatesPlus.Date(2000, 12, 31)
@test last(range(DatesPlus.Date(2001), step=DatesPlus.Day(1), length=365)) == DatesPlus.Date(2001, 12, 31)
@test last(range(DatesPlus.Date(2000), step=DatesPlus.Day(1), length=367)) == last(range(DatesPlus.Date(2000), step=DatesPlus.Month(12), length=2)) == last(range(DatesPlus.Date(2000), step=DatesPlus.Year(1), length=2))
@test last(range(DatesPlus.DateTime(2000), step=DatesPlus.Day(366), length=2)) == last(range(DatesPlus.DateTime(2000), step=DatesPlus.Hour(8784), length=2))

# Issue 5
lastdaysofmonth = [DatesPlus.Date(2014, i, DatesPlus.daysinmonth(2014, i)) for i=1:12]
@test [Date(2014, 1, 31):DatesPlus.Month(1):Date(2015);] == lastdaysofmonth

# Range addition/subtraction:
let d = DatesPlus.Day(1)
    @test (DatesPlus.Date(2000):d:DatesPlus.Date(2001)) + d == (DatesPlus.Date(2000) + d:d:DatesPlus.Date(2001) + d)
    @test (DatesPlus.Date(2000):d:DatesPlus.Date(2001)) - d == (DatesPlus.Date(2000) - d:d:DatesPlus.Date(2001) - d)
end

# Time ranges
dr  = DatesPlus.Time(23, 1, 1):DatesPlus.Second(1):DatesPlus.Time(23, 2, 1)
dr1 = DatesPlus.Time(23, 1, 1):DatesPlus.Second(1):DatesPlus.Time(23, 1, 1)
dr2 = DatesPlus.Time(23, 1, 1):DatesPlus.Second(1):DatesPlus.Time(22, 2, 1) # empty range
dr3 = DatesPlus.Time(23, 1, 1):DatesPlus.Minute(-1):DatesPlus.Time(22, 1, 1) # negative step
# Big ranges
dr8 = typemin(DatesPlus.Time):DatesPlus.Second(1):typemax(DatesPlus.Time)
dr9 = typemin(DatesPlus.Time):DatesPlus.Nanosecond(1):typemax(DatesPlus.Time)
# Other steps
dr10 = typemax(DatesPlus.Time):DatesPlus.Microsecond(-1):typemin(DatesPlus.Time)
dr11 = typemin(DatesPlus.Time):DatesPlus.Millisecond(1):typemax(DatesPlus.Time)
dr12 = typemin(DatesPlus.Time):DatesPlus.Minute(1):typemax(DatesPlus.Time)
dr13 = typemin(DatesPlus.Time):DatesPlus.Hour(1):typemax(DatesPlus.Time)
dr14 = typemin(DatesPlus.Time):DatesPlus.Millisecond(10):typemax(DatesPlus.Time)
dr15 = typemin(DatesPlus.Time):DatesPlus.Minute(100):typemax(DatesPlus.Time)
dr16 = typemin(DatesPlus.Time):DatesPlus.Hour(1000):typemax(DatesPlus.Time)
dr17 = typemax(DatesPlus.Time):DatesPlus.Millisecond(-10000):typemin(DatesPlus.Time)
dr18 = typemax(DatesPlus.Time):DatesPlus.Minute(-100):typemin(DatesPlus.Time)
dr19 = typemax(DatesPlus.Time):DatesPlus.Hour(-10):typemin(DatesPlus.Time)
dr20 = typemin(DatesPlus.Time):DatesPlus.Microsecond(2):typemax(DatesPlus.Time)

drs = Any[dr, dr1, dr2, dr3, dr8, dr9, dr10,
          dr11, dr12, dr13, dr14, dr15, dr16, dr17, dr18, dr19, dr20]

@test map(length, drs) == map(x->size(x)[1], drs)
@test all(x->findall(in(x), x) == [1:length(x);], drs[1:4])
@test isempty(dr2)
@test all(x->reverse(x) == last(x): - step(x):first(x), drs)
@test all(x->minimum(x) == (step(x) < zero(step(x)) ? last(x) : first(x)), drs[4:end])
@test all(x->maximum(x) == (step(x) < zero(step(x)) ? first(x) : last(x)), drs[4:end])
@test_throws MethodError dr .+ 1

a = DatesPlus.Time(23, 1, 1)
@test map(x->a in x, drs[1:4]) == [true, true, false, true]
@test a in dr

@test all(x->sort(x) == (step(x) < zero(step(x)) ? reverse(x) : x), drs)
@test all(x->step(x) < zero(step(x)) ? issorted(reverse(x)) : issorted(x), drs)

@test !(1 in Date(2017, 01, 01):DatesPlus.Day(1):Date(2017, 01, 05))
@test !(Complex(1, 0) in Date(2017, 01, 01):DatesPlus.Day(1):Date(2017, 01, 05))
@test !(π in Date(2017, 01, 01):DatesPlus.Day(1):Date(2017, 01, 05))
@test !("a" in Date(2017, 01, 01):DatesPlus.Day(1):Date(2017, 01, 05))

@test hash(Any[Date("2018-1-03"), Date("2018-1-04"), Date("2018-1-05")]) ==
      hash([Date("2018-1-03"), Date("2018-1-04"), Date("2018-1-05")]) ==
      hash(Date("2018-1-03"):Day(1):Date("2018-1-05"))

@testset "range overflow" begin
    # DateTime ranges interactions with overflow. If not handled correctly `DatesPlus.len` could
    # infinite loop
    @test length(DateTime(0):typemax(Millisecond):DateTime(0)) == 1
    @test length(typemax(DateTime):typemax(Millisecond):typemax(DateTime)) == 1

    # Overflow interaction is easier to comprehend with using UTM extremes
    utm_typemin = DateTime(DatesPlus.UTM(typemin(Int64)))
    utm_typemax = DateTime(DatesPlus.UTM(typemax(Int64)))

    @test length(utm_typemax:Millisecond(1):utm_typemax) == 1
    @test length(utm_typemin:-Millisecond(1):utm_typemin) == 1
end

end  # RangesTest module
