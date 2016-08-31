{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% set page.comments = false %}
{% block title %} {{ page.title }} | {{ config.title }} {% endblock %}

{% block page_class %}page-post-detail{% endblock %}
{% block header %}
{% include '_partials/head/slide.swig' %}
{% endblock %}
{% block content %}
  <div id="posts" class="posts-expand">

<!doctype html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js lt-ie9 lt-ie8" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
  <head>


  </head>

  <body>
    {{ page.content }}

    {% include '_scripts/slides/revel.swig' %}
  </body>
</html>

</div>
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}


{% block script_extra %}
  {% include '_scripts/pages/post-details.swig' %}
{% endblock %}
