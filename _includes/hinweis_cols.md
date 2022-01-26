<div class="card mb-3">
    <div class="card-header bg-green text-light">{{ include.title }}</div>
    <div class="card-body">
        <div class="row">
            <div class="col">
                {{ include.col1 | markdownify }}
            </div>
            <div class="col">
                {{ include.col2 | markdownify }}
            </div>
        </div>
    </div>
</div>
