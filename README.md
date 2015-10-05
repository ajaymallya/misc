# misc

```Ruby
2.1.2 :001 > require './factors_and_caching'
 => true 
2.1.2 :002 > fc = Factors.new([10, 5, 2, 20])
 => #<Factors:0x007fe6c2bab368 @input=[10, 5, 2, 20]> 
2.1.2 :003 > fc.factors
 => {10=>[5, 2], 5=>[], 2=>[], 20=>[10, 5, 2]} 
2.1.2 :004 > fc.reverse_factors
 => {10=>[20], 5=>[10, 20], 2=>[10, 20], 20=>[]} 
2.1.2 :005 > 
```
