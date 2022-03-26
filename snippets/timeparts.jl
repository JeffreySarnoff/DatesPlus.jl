
const NanosPerNanosecond  = 1
const NanosPerMicrosecond = 1000
const NanosPerMillisecond = 1000*1000
const NanosPerSecond      = 1000*1000*1000
const NanosPerMinute      = 1000*1000*1000*60
const NanosPerHour        = 1000*1000*1000*60*60

const NanosPer = (NanosPerHour, NanosPerMinute, NanosPerSecond, NanosPerMillisecond, NanosPerMicrosecond, NanosPerNanosecond)
(3600000000000, 60000000000, 1000000000, 1000000, 1000, 1)

const TimeInParts = NamedTuple{(:hours, :minutes, :seconds, :millis, :micros, :nanos)}

struct TimeParts <: Function
end

TimeParts(x::Vector) = TimeInParts(x...)

function timeparts(nanos::Int128, parts::Vector{Int128})
    ns = nanos

    for (idx, unit_in_nanos) in enumerate(NanosPer)
        units = fld(ns, unit_in_nanos)
        ns -= units * unit_in_nanos
        parts[idx] = units
    end

    parts
end


function timeparts(nanos::Int128)
    ns = nanos
    result = zeros(Int128, length(NanosPer))

    for (idx, unit_in_nanos) in enumerate(NanosPer)
        units = fld(ns, unit_in_nanos)
        ns -= units * unit_in_nanos
        result[idx] = units
    end

    result
end

#=

julia> tm = Time(now()); tmv = tm.instant.value;

julia> string(tm), tm, tmv
("21:05:38.181", Time(21, 5, 38, 181), 75938181000000)

julia> timeparts(tmv)
6-element Vector{Int128}:
  21
   5
  38
 181
   0
   0

julia> forparts = zeros(Int128,6);

julia> timeparts(tmv, forparts)
6-element Vector{Int128}:
  21
   5
  38
 181
   0
   0

julia> TimeInParts(timeparts(tmv, forparts))
(hours = 21, minutes = 5, seconds = 38, millis = 181, micros = 0, nanos = 0)
=#

function timeparts(nanos::S) where {S<:Signed}
    ns = nanos%Int128
    hr = fld(ns, NanosPerHour)
    ns -= hr * NanosPerHour
    mn = fld(ns, NanosPerMinute)
    ns -= mn * NanosPerMinute
    sc = fld(ns, NanosPerSecond)
    ns -= sc * NanosPerSecond
    ms = fld(ns, NanosPerMillisecond)
    ns -= ms * NanosPerMillisecond
    us = fld(ns, NanosPerMicrosecond)
    ns -= us * NanosPerMicrosecond
    (hr, mn, sc, ms, us, ns)
end
