---
layout: page
title: "Tags"
permalink: /tags/
main_nav: true
---

{% for tag in site.tags %}
  {% capture tag_name %}{{ tag | first }}{% endcapture %}
  <h2 id="{{ tag_name }}">{{ tag_name | capitalize }}</h2>
  <ul class="posts-list">
  {% for post in site.tags[tag_name] %}
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
