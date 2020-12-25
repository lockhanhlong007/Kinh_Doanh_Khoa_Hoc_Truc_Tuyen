var LessonJquery = function () {
    this.initialize = function () {
        registerEvents();
    }

    function registerEvents() {
        $("body").on("change", "#sort-review", function (e) {
            e.preventDefault();
            var courseId = $(this).data("id");
            var lessonId = $(this).data("lesson");
            var sortType = $("#sort-review").val();
            window.location.href = "/lessons-with-courses-" + courseId + ".html?id=" + courseId +  "&lessonId=" + lessonId + "&sortBy=" + sortType;
        });
    }
}