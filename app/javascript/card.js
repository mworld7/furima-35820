const pay = () => {
  Payjp.setPublicKey("pk_test_b8b4a8092130bed3c636b3fb");
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("purchaser_address[number]"),
      exp_month: formData.get("purchaser_address[exp_month]"),
      exp_year: `20${formData.get("purchaser_address[exp_year]")}`,
      cvc: formData.get("purchaser_address[cvc]"),
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
    });
  });
};

window.addEventListener("load", pay);