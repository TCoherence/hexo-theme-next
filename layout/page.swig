{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}
  {%- set page_title_suffix = ' | ' + title %}

  {%- if page.type === 'categories' and not page.title %}
    {{- __('title.category') + page_title_suffix }}
  {%- elif page.type === 'tags' and not page.title %}
    {{- __('title.tag') + page_title_suffix }}
  {%- elif page.type === 'schedule' and not page.title %}
    {{- __('title.schedule') + page_title_suffix }}
  {%- else %}
    {{- page.title + page_title_suffix }}
  {%- endif %}
{% endblock %}

{% block class %}page posts-expand{% endblock %}

{% block content %}

    {##################}
    {### PAGE BLOCK ###}
    {##################}
    <div class="post-block" lang="{{ page.lang or config.language }}">
      {% include '_partials/page/page-header.swig' %}
      {#################}
      {### PAGE BODY ###}
      {#################}
      <div class="post-body{%- if page.direction and page.direction.toLowerCase() === 'rtl' %} rtl{%- endif %}">
        {%- if page.type === 'tags' %}
          <div class="tag-cloud">
            <div class="tag-cloud-title">
              {{ _p('counter.tag_cloud', site.tags.length) }}
            </div>
            <div class="tag-cloud-tags">
              {{ tagcloud({
                min_font   : theme.tagcloud.min,
                max_font   : theme.tagcloud.max,
                amount     : theme.tagcloud.amount,
                color      : true,
                start_color: theme.tagcloud.start,
                end_color  : theme.tagcloud.end})
              }}
            </div>
          </div>
        {% elif page.type === 'categories' %}
          <div class="category-all-page">
            <div class="category-all-title">
              {{ _p('counter.categories', site.categories.length) }}
            </div>
            <div class="category-all">
              {{ list_categories() }}
            </div>
          </div>
        {% elif page.type === 'schedule' %}
          <div class="event-list">
          </div>
          {% include '_scripts/pages/schedule.swig' %}
        {% elif page.type === 'reports' %}
          <div class="reports-hub-intro">
            {{ page.content }}
          </div>
          {% set latest = reports_latest() %}
          {% if latest.items.length > 0 %}
            <div class="reports-today">
              <div class="reports-today-header">
                <i class="fa fa-bolt"></i>
                <span>最新更新 · {{ latest.date }}</span>
              </div>
              <ul class="reports-today-list">
                {% for it in latest.items %}
                  <li>
                    <span class="reports-today-tag">{{ it.topic_label }}</span>
                    <a href="{{ url_for(it.url) }}">{{ it.title }}</a>
                    {% if it.extra_count > 0 %}
                      <a class="reports-today-more" href="{{ url_for(it.extra_url) }}">+{{ it.extra_count }} 个其他</a>
                    {% endif %}
                  </li>
                {% endfor %}
              </ul>
            </div>
          {% endif %}
          <div class="reports-hub-grid">
            {% for t in reports_topics() %}
              <a class="reports-card" href="{{ url_for(t.url) }}">
                <div class="reports-card-icon"><i class="{{ t.icon }}"></i></div>
                <div class="reports-card-title">{{ t.label }}</div>
                <div class="reports-card-meta">{{ t.freq }} · {{ t.count }} 篇</div>
                <div class="reports-card-latest">{% if t.latest_date %}最新 {{ t.latest_date }}{% else %}尚无报告{% endif %}</div>
                <div class="reports-card-desc">{{ t.desc }}</div>
              </a>
            {% endfor %}
          </div>
        {% else %}
          {{ page.content }}
        {%- endif %}
      </div>
      {#####################}
      {### END PAGE BODY ###}
      {#####################}
    </div>
    {% include '_partials/page/breadcrumb.swig' %}
    {######################}
    {### END PAGE BLOCK ###}
    {######################}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}
