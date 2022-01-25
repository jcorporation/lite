<a class="breadcrumb-item" href='{{ site.baseurl }}/'>Lite</a>
{% assign crumbs = page.url | split: '/' %}
{% for crumb in crumbs offset: 1 %}
  {% if forloop.last %}
    {%if crumb != "index" %}
      <span>&nbsp;&nbsp;&rsaquo;&nbsp;&nbsp;</span>
        <a>{{ crumb | replace:'_',' '}}</a>
    {% endif %}
  {% else %}
  <span>&nbsp;&nbsp;&rsaquo;&nbsp;&nbsp;</span>
    <a class="breadcrumb-item" href="{% assign crumb_limit = forloop.index | plus: 1 %}{{site.baseurl}}{% for crumb in crumbs limit: crumb_limit %}{{ crumb | append: '/' }}{% endfor %}">{{ crumb | replace:'_',' '}}</a>
  {% endif %}
{% endfor %}
