class CorRobo {

  int id;
  String nome;
  String hex;

  CorRobo({
    this.id,
    this.nome,
    this.hex
  });

  static getCores() {
    List<CorRobo> cores = new List<CorRobo>();
    cores.add(new CorRobo(id: 1, nome: 'VERMELHO', hex: '#FF0000'));
    cores.add(new CorRobo(id: 2, nome: 'AMARELO', hex: '#FFFF00'));
    cores.add(new CorRobo(id: 3, nome: 'MARROM', hex: '#808000'));
    cores.add(new CorRobo(id: 4, nome: 'VERDE', hex: '#00FF00'));
    cores.add(new CorRobo(id: 5, nome: 'CINZA', hex: '#C0C0C0'));
    cores.add(new CorRobo(id: 6, nome: 'AZUL', hex: '#0000FF'));

    return cores;
  }

  static getColorById(int id) {
    return getCores().firstWhere((CorRobo cor) => cor.id == id);
  }
}

