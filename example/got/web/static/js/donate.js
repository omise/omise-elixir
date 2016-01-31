$(document).on("ready", function () {
  $("#donate").submit(function () {
    var form = $(this);

    // Disable the submit button to avoid repeated click.
    form.find("input[type=submit]").prop("disabled", true);

    // // Serialize the form fields into a valid card object.
    var card = {
      "name": form.find("#name").val(),
      "number": form.find("#number").val(),
      "expiration_month": form.find("#expiration_month").val(),
      "expiration_year": form.find("#expiration_year").val(),
      "security_code": form.find("#cvv").val()
    };

    // Send a request to create a token then trigger the callback function once
    // a response is received from Omise.
    //
    // Note that the response could be an error and this needs to be handled within
    // the callback.
    Omise.createToken("card", card, function (statusCode, response) {
      if (response.object == "error") {
        // Display an error message.
        $("#errors").html('<div class="alert alert-danger">' + response.message + '</div>');

        // Re-enable the submit button.
        form.find("input[type=submit]").prop("disabled", false);
      } else {
        // Then fill the omise_token.
        form.find("[name=omise_token]").val(response.id);

        // Remove card number from form before submiting to server.
        form.find("#number").val("");
        form.find("#cvv").val("");

        // submit token to server.
        form.get(0).submit();
      };
    });

    // Prevent the form from being submitted;
    return false;

  });
});
