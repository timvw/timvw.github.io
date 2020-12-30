---
layout: page
---

<h2>Tags</h2>

<ul class="tags">
  {% for tag in site.tags %}
  {% assign t = tag | first %}
    <li class="tag"><a href="/{{ site.tag_page_dir }}/{{ t | slugify: 'pretty' }}/">{{ t }}</a></li>
  {% endfor %}
</ul>