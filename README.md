## Quartier-Crawler

Collect all posts for a given user.

### Usage:
```
$ ruby crawler.rb "Frank McColbert" > results.txt
```
(or any other username)

Requires Ruby (presumably >= 1.9) and the Nokogiri gem

### Warnings:
- **Extremely slow** even for user with few posts (run overnight)
- Correctness not guaranteed (old links have a habit of not working correctly in the forum software)
- Very messy, rushed and may break on conditions I didn't expect - please report bugs

### Credits
- **Xhi** for the initial idea
- **Matz**, for Ruby
