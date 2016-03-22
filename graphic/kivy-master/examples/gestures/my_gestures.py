#!/usr/bin/env python
from kivy.gesture import GestureDatabase

gdb = GestureDatabase()

cross = gdb.str_to_gesture(
    'eNq1l9tu3DYQhu/1It6bLjicE+cFtrcF/ACBYwv2Iqkt7G7a5u1DDqlT0lZ7I2Mxsj5JP2f4kxR1OH85//X9+Npfb98uffd7Ow6hO7wM0D0+vD/92T90Q8z/5gN218eH6+3y8aW/5lPqDl8H7g7/KvLot3WDFCnNzw8f5/dbeSyVx+w/Hvuj3NUNUDMoKXzPj0DsTuGIGiRJGCOVbP4pV7E7/RaORJZMwhS1u35++v9WyFvh7rU2ENEMJI1RuLu+NnEEgyhpjEG2xb1y0H3Ek4vbKA6kEmyKEWdxWPaJsaVN8eidH2Ef8ejiOIqHdbeQLvolaLTFLxlty7ulsVlaNBKChCnmEpp+uRSSIozRBLbl3dSoe8m7rdF2kkc3FmGSB1FVphYT6qSejY2sOsXtyYRuLOIkHgEtGrZIKJP4Spk13ZG524qzrXFWLlHmfok/9UvcFndTUe8Rz8OVA7RIYXtAoluKdke3hJU42j0dQ24pwV7ybiptm1oGE+Rz4ilu9w25q8R3qQtnZ2WKd+TutpLeox4pZmt1jHlh3VR3X8nuUceFdIm4qc5uKy9mapCY339jXKb+08tjewlmN5VxH3H3lBcLcASZfzGv4osFPiVk5SnmCb6p766y7qbvvvL0Zg2GKtHGCDjPJ2FKicfI2wuNuKsCu2i7qYLzdiP3BXGLYIs1DEAo0hh1eyaJeyq8i7b7KdM26ddNXpPO7SCSTnHbSnErxXaQVndSJyeJGQOMMe+RJm1aLrk5bku7kYp7SLuPOvlI6/FHs4+87hH2Fats/p8vff8+beVVyl5etTucMA/a7kSE+XAbNHVPmcGK2ZKBsxSciTPUyqAwUmdRKouFCToDqgwLU3MWQmVUmDnD1O7jwsCfOuXFt0JxGKNDaS1rhVwhV5gqpBW0CnEJLaw0G4QKwwrGmlJaQaxw1bp5QRBsBb2iZMvczQtSWjGvx09m5uXwmnk1tNKDEGYbZli94TX0aqg1nRrE5Z3WoFdDtWyFBr0aqR2URljLqa1bbNDrsToywth69QfqGIrcaDVoPSoBqkNtbDE1Wi3iqsAtV6gesSdL0vKCalLNdqa5rjpB3vrz69utfJTmz8qTFclM/z6/3N4cSteSyvT28bW/PL0/935Ffdsd1n9Q7muT+dNw+Xj59lzFU+6WY5L8ug5qwTR/PFH5bDz+AM/6Dqo=')

circle = gdb.str_to_gesture(
    'eNq1WNtyGzcMfd8fiV+iIS4EyB9QXzuTD+g4icbxpLU1ttI2f18QoHa5jpy12qlGAyUw9hA4ByQh3dx/vf/z++7u8Hz69nSYfumfxzTdfD7C9OHdw+0fh3fTEe2f9kHT84d3z6enx6+HZ/svTze/H/N0cxHkg4dNR2lQas8fH+8fTu2x0h6rrzz2a4uajhAZtBS+2yOA0z7tCDMkqjk1y0W1pfN3+zNN+/dpl0pGqmdLJcv0/PH25+uwr5Onu74EMxErVLeGMT3fNXQDT4C1kopbLVBhG92LB91Gh6RJinRb5A2ZF8euM/aP5JyxhVVShbBiJW9ho7OPcMZG1YTzWzTP2LgAm8XyBmx0bJqxsfSkm8UqMzaRluVduW5ju5o4qwkKmFWruM28cGLNcW3eriXOWi5kv8zbNK7GcwmbabtP0LXEWcuB7MY3pSVxVuRMiGFJaBOcXEzqYrZtwglLEsluBdOSen7R5LiN7nISzehAwsQZwC3yfwJ3PSnP4FZ31fnNrZX/PS8uKOkCvpBiFkfSF2Sz3PpoC9wVpTqDExXKmkvYmoc274S8nRZ2RXlR1B5u5xGG1bKcK7a5rtz77ILyIihVSVzL2bb8zuB4LefsgnJ+AzjQtTuUXVBeBCVRTKSMbq1HA/u9b7DMohpWSLbPFnZFuf4/6NklzYOki57N1rzAQ8YV/HY3Ztc0L5piXR0BMqAj1GItLmELb/OeXdQ87FKB8QhIOKDXOXGzOb2BGVc1D9sUaNxJNiPM6LQkbpbS9lbKrmpeVAXluRtTTloXdDs2B95z3UYXV1UWVe2aPydutqAO6HIt7+KqCm0f7A2+Fk1JkNyiTQ+b8C6rzJdpyrkoQUlhUx6IZ61XEi8uqyzXKSODTSphAcsAjnBlz4irKvN9CjVxsXEwu2UZ9iopXcmLuqgKWwOMb2JJNoh2y284B9Q11WU6En2NFuRrFVVXVJdhN71QdDhjBIe3a/3xtg3/n54Oh4d5lFdps7zNmjd7Rt2laY9ad3V88XQ6apluW0TxiAL2Yc7qTkqjs6RwSjgxnOBOhpUTw6krJ7kz06up2D3iETUiNB7L7pT+WLZhf3hJi5CIiLyU4zENZ5SlPYWoVSNZTeGMWv25vWnqzhq1amBKYNaotcTjuUdGrSXy8+rMGbWW7E6u66SpRUStJRbgvGZDW0QUXqICjgqqjE6q4dSVM19Yrawi4MJqwUIJyTBqg5TGOpC6F1be9ON6ttdGVkB+XNA2ZYREjwFfCgmSNJKC8/JBjMbyAN0bzLjS5k3dG9RoLJJK95axY9K52KBAohGShBeCAgncdIFcABj79nJI8JHzT0L6/kg/CQk+mFd5Q/BBtKoRZNzXZz4g+MC0YhSCD+hqXWhGgCAn1dcFxWAqdV0uND1gMJWCTIyeBnRy7CtZeLl7KbxRLPaykMObXu1k+1rpIb2VL20Hm9siJFKlTiTqylu7t4SXx31o35ZW3p4zpZVXLyxNsAq5xBIFH/1syH1FCj76Hs69PSn4KHU8k2w+D5aCZ+lbhKLqGvVJF5+i6hp0yRk3WiLFWSedfepdQOMBCtyFl/GsBe5a9xO4r8axESCNh7UNo+GFVw95YB57VHuaHL0Pebwy7DYPb79IevLcex/W3n7/0dobhWI+X1buzVEoytprhcYN/OVwf/fl1H70sql+ry83CbbfxP66/3z64iF2m9sJZxjmPT3+fni6ffh08L9w/IixfkGL68PDb8enx8/fPsVSedrnnc05diDYoIA2CpbUvu7t/gFuoPx3')

check = gdb.str_to_gesture(
    'eNq1l0tuI0cMhvd9EXsTofgmL6BsA/gAgcYWbGMmtmBpksztwyY1kgZI0rNpbdr+u+pjkX+9+v718+uf3zbP++Pp68d++vX8PIzp/ukA08Pd2+6P/d10wPwzHzQdH+6Op4/3z/tj/svT/ZeDTPf/CnmoZtNBZ5Rl/8P769tp7uZzt/iPbr/NraYD9AjmIXzLLoDTdmxgBLsSMMIw5OHzcP6eX9O0/WVsCMFGmCuaGgjBdPy0+/8wXGFkeu4Ig7LzgISbMw/j6fh8hmMMBDIkdBYPimV4pQ7W8EQMUA4LMhMzCyW5watKgJoOHhxsuIz3wscVb8ExhpIxDoIgvcEzhoaiZ1geA20Rj+UAwlp4LDxd8OkqO4KHYXLI4oYOwEai4oPRmHiZXr6iXOiY9mXBFUNYacAVDm4uIOCiaXws24plK9oq7PIUr56iOqsyg+acyOrezJicpTCI3YYy5HtapFNZSldLCcRgCCk4hqniDZ2dHZjCMf1EXh47laNEN2MfEjkzJFgtK3BLHwEAGTcnlSu7LNPLUbo6+n2m5GbAuVzUr/ShYQzoSBSWi5iXJwyVqWRr4ctX+om1mq+GR7ibAA8dJuHLfC5nGVbjl7dMS/tk1g3tB3OXZyWXsyyrsMtWtlXY5SnHGmwpPwW+s3M15h5CkVvM8FyWcWH3Uce5io00A/8Eu7wUWoVdXoqswi4v5eIlseTWl6e9Cqh6+IUt6OoUwAJD88KwjC4rJVZAazmpsAa6jFRaA10+qqyBLht1DRu1bNQ1bLSy0S425mWFOc9khtxcnRwuaEW6PZnH8sFp5aPRKuwy0i5GMnsmHJE32dz73a5oG3nJgLyemqDgXKtPu/m2//ix379d7u6m8+XdbLrf5jg2Y9picD5OB/NpN4vQIrYYLWKJHiX6aJFblBahRSvRvEUsETuQjRapxe6uHSjPsBK7u0CL0mKUyLKJ25/NLbRaUI+PzwGsRWrxzOr0qKNy5+ydHnVUzsftj7JFdK7cAUSrW3SugrdpReeqdluV6Fxdu6hdv6hcCeYabQl7KFG5ElWpiM6itqgtWovWorXYlU6/d234y/71+eWUVud1dRvz2xT/en06vcwfWiP7QFU51dP7l/3H7u1xX2+gP9F+/MHc7jw1fz98vD99fTxV65yN6YfP81jE8nDMa8j81bD5B2R9zCo=')

square = gdb.str_to_gesture(
    'eNq1mEluIzcYRvd1EXsT4Z+HC6i3AXyAwG0LttEdW7DUSfr2YZHVEgk4KQGCtZH8RD4OH4eSb1++vfz1c/O0Oxx/vO+mL8v7Hqbbxz1Odzev93/ubqY9lY/ljafD3c3h+P72bXcof8p0+32v0+2HkrtabNrbrPJSf//28nqcq8VcLf+j2u9zqWmPrQdzF36WKkjTFjasKZKMaJwqGTp355/5a562v8FGREAVLIINymebDl/v/78Zqc3o9LS04EgogK6ECeSlhadFTomIHElsKqoS6/I6dPQL5JiWaSTKYMZEuS6PKs8L5DD03DB11U51+gnX7EVuGOQUgqDIxHGBnKqc1+XkJXLMyAyXUFkPlGqgpJ/irnmSr7s5kThBIhAB5RJ3jZPOcYpbiIG6elkc81Je3DL222TVzTVMPoVJggFESoEGBIJndyirWWpYRonyAnfNkk9ZQkQYghuLSlnI7tfIa5i8hDmvZFBSUwdH5ixDgKv6XvNkP+mxbDxgo1S2JIhr3DVPzpOb0IGQ3DTVhTPP8nEH+bpcaqCCJzkHOjlqpISFAp/lZMqMZqIBLnCBvCYqfJKLEqNyCgkFFNlZjt0qJaD1rS81UTknKuEGqYgRGUZdnsxlnapilrkiKafjurzmKec8Sy12KTPvTmWn5lle9mS/B2z9MJcaqOSqvC7TflRlkZZ7bM2vNVPFT/PXWJUv8ZO5hkiAQVkz5Wpat9dcVT/JXoNVv8Quoz3Wl43WZDU/x241V1vfq+UrRTFhLicyAxpecG1YTdXOqVLXP4XSRmcHCg/NIPGAcnOs22uqdk4Vx777dfaaqp2uU+jPWGdkvcpeU7X8HLvXVP10pWJKOdSFksIMSgNXyWuofrpTyyUKaewgxuCJeJW8ZuqnB6TxIATspkXGJ16r8vkHwMP7bvd6epx3m5/ny0V/uy1X4wamLaWVt+PeY7qfoQ8wG8wGvcKACjMGiDMsj/EDpApRB8gV0lhdKpSxulaoI7QKDQfoDfIAY4Cyyf4lc4lsJaSV4FotYYDzCd69bC6BfYloU5XUQ88GeYBLA9JD+6BfqX0J1VZtGThVKD72i+cS3k+NUKvWZkFbhMwfVMu+BOXYHy8lENqcaMuM2vyWp+WB2kJpoLrQNhOqI21Toa3HJAttw5c2fOKFtvGzjrSNmWikbdAAI11WMw8U23L2HCkOdBkxUk8/msyyCVsj0IeAKAP9aI5R+yJ1+mZqPXVYqPc0fjUSA82FZk9zmWNqo45hG5WfSB1lWOaCqDMwLDkTD/SXoQy0nTzPu5en52P9f4BO25jbLfTvl8fjc4VWoDZ4fPu+e79/fdjVL7we0jC+cC63nJJ/7N/fHn88NHdM29xw+VUXOp+Mzm7FcPi6+ReGcFi7')