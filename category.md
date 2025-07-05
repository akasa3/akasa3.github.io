---
layout: page
title: "Category"
permalink: /category/
main_nav: true
---

{% for category in site.categories %}
  {% capture category_name %}{{ category | first }}{% endcapture %}
  <h2 id="{{ category_name }}">{{ category_name | capitalize }}</h2>
  <ul class="posts-list">
  {% for post in site.categories[category_name] %}
    <li>
      <strong>
        <a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
      </strong>
      <span class="post-date">- {{ post.date | date_to_long_string }}</span>
    </li>
  {% endfor %}
  </ul>
  {% if forloop.last == false %}<hr>{% endif %}
{% endfor %}
<br>
