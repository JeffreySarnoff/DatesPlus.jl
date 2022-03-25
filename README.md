# DatesPlus.jl
**Experimental version of the `Dates` stdlib designed with support for TimesDates.jl v2**

----

## Differences from Dates.jl


### source file modifications

- Dates.jl
    -- renamed DatesPlus.jl (to match module name)

- io.jl

  * augment `CONVERSION_SPECIFIERS`
    * 'n' => Nanosecond
    * '_' => Subsecond
 
  * augment `CONVERSION_DEFAULTS`
    * Subsecond => Int128(0)
 
  * augment `CONVERSION_TRANSLATIONS`
    * TimeDate => (Year, Month, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond, AMPM)

- periods.jl

  * introduce `otherperiod_conversions` like `fixedperiod_conversions`
 
    * `const otherperiod_conversions = [(:Year, 4), (:Quarter, 3), (:Month, 1)]`
    * `for i = 1:length(otherperiod_conversions) _`


----


#### unmodified source files

- accessors.jl
- adjusters.jl
- arithmetic.jl
- conversions.jl
- deprecated.jl
- parse.jl
- ranges.jl
- rounding.jl
- types.jl


