function copyToClipboard() {
  /* Get the text field */
  var copyText = document.getElementById("equationToCopy");

  /* Select the text field */
  copyText.select();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Equation copied to clipboard.");
}