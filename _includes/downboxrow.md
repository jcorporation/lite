<div class="row row-cols-1 row-cols-sm-2 row-cols-xl-2 g-4 mb-3">
    <div class="col">
        <div class="card bg-blue text-light">
            <div class="card-header">{{ include.title }}</div>
            <div class="card-body">
                <img class="border border-white float-start me-4" src="{{ site.baseurl }}/assets/images{{ include.image }}" width="100" height="140">
                <p>{{ include.body | markdownify }}</p>
                <p>&raquo; <a class="text-light" href="{{ site.baseurl }}{{ include.link }}">Herunterladen</a></p>
            </div>
        </div>
    </div>
</div>
