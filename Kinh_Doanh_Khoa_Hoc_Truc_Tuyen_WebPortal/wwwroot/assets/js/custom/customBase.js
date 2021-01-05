var BaseAjax = function () {
    this.initialize = function () {
        registerEvents();
    }

    function registerEvents() {
        $("body").on("click", ".remove-product-in-cart", function (e) {
            e.preventDefault();
            var id = $(this).data("id");
            $.ajax({
                url: "/Cart/RemoveFromCart",
                type: "post",
                data: {
                    courseId: id
                },
                success: function () {
                    loadHeaderCart();
                    if (location.pathname === "/cart.html") {
                        location.reload(); 
                    }
                }
            });
        });

        $("body").on("click", ".add-product-in-cart", function (e) {
            e.preventDefault();
            //var auth = $("#hid_check_auth").val();
            //if (auth) {
            //    var id = parseInt($(this).data("id"));
            //    $.ajax({
            //        url: "/Cart/AddToCart",
            //        type: "post",
            //        data: {
            //            courseId: id
            //        },
            //        success: function (res) {
            //            var template = $("#template-modal-cart").html();
            //            var render = "";
            //            var valueZero = 0;
            //            var env = "https://localhost:44342";
            //            render += Mustache.render(template,
            //                {
            //                    checkPromotion: !res.promotionPrice ? false : true,
            //                    modalCartImage: env + res.courseViewModel.image,
            //                    modalCartName: res.courseViewModel.name,
            //                    modalOwnerUser: res.courseViewModel.createdName,
            //                    modalCartPrice: res.price.toLocaleString("vi", { style: "currency", currency: "VND" }),
            //                    modalCartPromotion: !res.promotionPrice ? valueZero.toLocaleString("vi", { style: "currency", currency: "VND" }) : res.promotionPrice.toLocaleString("vi", { style: "currency", currency: "VND" })
            //                });
            //            $("#modal-add-to-cart").html(render);

            //            loadHeaderCart();
            //        }
            //    });
            //} else {
            //    window.location.href = "/login.html";
            //}
            var id = parseInt($(this).data("id"));
            $.ajax({
                url: "/Cart/AddToCart",
                type: "post",
                data: {
                    courseId: id
                },
                success: function (res) {
                    var template = $("#template-modal-cart").html();
                    var render = "";
                    var valueZero = 0;
                    var env = "https://localhost:44342";
                    render += Mustache.render(template,
                        {
                            checkPromotion: !res.promotionPrice ? false : true,
                            modalCartImage: env + res.courseViewModel.image,
                            modalCartName: res.courseViewModel.name,
                            modalOwnerUser: res.courseViewModel.createdName,
                            modalCartPrice: res.price.toLocaleString("vi", { style: "currency", currency: "VND" }),
                            modalCartPromotion: !res.promotionPrice ? valueZero.toLocaleString("vi", { style: "currency", currency: "VND" }) : res.promotionPrice.toLocaleString("vi", { style: "currency", currency: "VND" })
                        });
                    $("#modal-add-to-cart").html(render);

                    loadHeaderCart();
                }
            });
        });

        $("#main-search").autocomplete({
            minLength: 0,
            source: function (request, response) {
                $.ajax({
                    url: "/Courses/GetCoursesByFilter",
                    type: "GET",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: {
                        filter: request.term
                    },
                    success: function (res) {
                        response(res);
                    }
                });
            },
            focus: function (event, ui) {
                $("#main-search").val(ui.item.label);
                return false;
            },
            select: function (event, ui) {
                $("#main-search").val(ui.item.label);
                return false;
            }
        });
    }


    function loadHeaderCart() {
        $("#headerCart").load("/Home/RefreshCart");
    }

}