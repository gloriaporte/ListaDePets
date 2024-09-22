class Pet {
  int? _id;
  String _nome;
  String _sexo;
  String _tipo;
  int? _idade;
  int _anoAdotado;
  bool _vacinado;
  bool _castrado;

  Pet(this._nome, this._sexo, this._tipo, this._anoAdotado, this._vacinado, this._castrado, [this._idade]);

  Pet.withId(this._id, this._nome, this._sexo, this._tipo, this._anoAdotado, this._vacinado, this._castrado, [this._idade]);

  // Getters
  int? get id => _id;
  String get nome => _nome;
  String get sexo => _sexo;
  String get tipo => _tipo;
  int? get idade => _idade;
  int get anoAdotado => _anoAdotado;
  bool get vacinado => _vacinado;
  bool get castrado => _castrado;

  // Setters
  set nome(String novoNome) {
    if (novoNome.length <= 255) {
      this._nome = novoNome;
    }
  }

  set sexo(String novoSexo) {
    if (novoSexo.length <= 255) {
      this._sexo = novoSexo;
    }
  }

  set tipo(String novoTipo) {
    if (novoTipo.length <= 255) {
      this._tipo = novoTipo;
    }
  }

  set idade(int? novaIdade) {
    if (novaIdade != null && (novaIdade > 0 && novaIdade < 30)) {
      this._idade = novaIdade;
    }
  }

  set anoAdotado(int novoAnoAdotado) {
    if (novoAnoAdotado > 0 && novoAnoAdotado < 2024) {
      this._anoAdotado = novoAnoAdotado;
    }
  }

  set vacinado(bool novoVacinado) {
    this._vacinado = novoVacinado;
  }

  set castrado(bool novoCastrado) {
    this._castrado = novoCastrado;
  }

  // Retornar map com os dados dos pets
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['sexo'] = _sexo;
    map['tipo'] = _tipo;
    map['idade'] = _idade;
    map['anoAdotado'] = _anoAdotado;
    map['vacinado'] = _vacinado ? 1 : 0;
    map['castrado'] = _castrado ? 1 : 0;

    return map;
  }

  // Criar um objeto PET do Map
  Pet.fromMap(dynamic o)
      : _id = o['id'],
        _nome = o['nome'],
        _sexo = o['sexo'],
        _tipo = o['tipo'],
        _idade = o['idade'],
        _anoAdotado = o['anoAdotado'],
        _vacinado = o['vacinado'] == 1,
        _castrado = o['castrado'] == 1;
}
