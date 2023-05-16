class RegisterDto
{
  late String name;

  late String cpf;

  late String dateNasc;

  late String address;

  late String phone;

  late String email;

  late String password;

  late String confirmCodeEmail;

  getName()
  {
    return this.name;
  }
  setName(String name)
  {
    this.name = name;
  }

  getCpf()
  {
    return this.name;
  }

  setCpf(String cpf)
  {
    this.cpf = cpf;
  }

  getDateNasc()
  {
    return this.dateNasc;
  }

  setDateNasc(String dateNasc)
  {
    this.dateNasc = dateNasc;
  }

  getAddress()
  {
    return this.address;
  }

  setAdress(String address)
  {
    this.address = address;
  }

  getPhone()
  {
    return this.phone;
  }

  setPhone(String phone)
  {
    this.phone = phone;
  }

  getPassword()
  {
    return this.password;
  }

  setPassword(String password)
  {
    this.password = password;
  }

  getConfirmCodeEmail()
  {
    return this.confirmCodeEmail;
  }

  setConfirmCodeEmail(confirmCodeEmail)
  {
    this.confirmCodeEmail = confirmCodeEmail;
  }

  getEmail()
  {
    return this.email;
  }

  setEmail(String email)
  {
    this.email = email;
  }

  getJson()
  {
    Map<String,String> json = {
      "name": this.name,
      "email": this.email,
      "cpf": this.cpf,
      "password": this.password,
      "address": this.address,
      "confirmCodeEmail": this.confirmCodeEmail,
      "phone": this.phone,
      "dateNasc": this.dateNasc
    };

    return json;
  }
}