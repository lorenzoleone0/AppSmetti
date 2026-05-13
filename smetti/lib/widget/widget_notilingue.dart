String fraseReimposta(String? code) {
  switch (code) {
    case 'it':
      return 'Ripristina la frequenza';
    case 'es':
      return 'Reconfigura la frecuencia';
    case 'fr':
      return 'Réinitialise la fréquence';
    case 'de':
      return 'Frequenz neu einstellen';
    case 'ru':
      return 'Сбросьте частоту';
    case 'ko':
      return '빈도를 다시 설정하세요';
    case 'pt':
      return 'Redefina a frequência';
    default:
      return 'Reset the frequency';
  }
}

String titoloReimpostaFrequenza(String? code) {
  switch (code) {
    case 'it':
      return 'Reimposta frequenza';
    case 'es':
      return 'Reconfigura la frecuencia';
    case 'fr':
      return 'Réinitialise la fréquence';
    case 'de':
      return 'Frequenz neu einstellen';
    case 'ru':
      return 'Сбросьте частоту';
    case 'ko':
      return '빈도를 다시 설정하세요';
    case 'pt':
      return 'Redefina a frequência';
    default:
      return 'Reset frequency';
  }
}

String titoloReimpostaNotifica(String? code) {
  switch (code) {
    case 'it':
      return 'Reimposta notifica';
    case 'es':
      return 'Reconfigura la notificación';
    case 'fr':
      return 'Réinitialise la notification';
    case 'de':
      return 'Benachrichtigung neu einstellen';
    case 'ru':
      return 'Сбросьте уведомление';
    case 'ko':
      return '알림을 다시 설정하세요';
    case 'pt':
      return 'Redefina a notificação';
    default:
      return 'Reset notification';
  }
}

List<String> frasiPerLingua(String? code) {
  switch (code) {
    case 'it':
      return const [
        'Smetti ora.',
        'Ogni sigaretta in meno conta.',
        'Respira, non fumare.',
        'Stai facendo una scelta migliore.',
        'Il tuo obiettivo è più forte dell’abitudine.',
        'Stai investendo nella tua salute.',
        'Oggi smetto.',
        'Ricorda perché e per chi lo stai facendo.',
        '! Buttala.',
        'Con quella puzza in bocca a chi vuoi baciare?',
        'A quale età hai inziato? E a quale vuoi smettere?',
        'Una sigaretta in meno al giorno leva il medico di torno.',
        'Te l’hanno offerta? E hai accettato?',
        'Ti manca più la sigaretta o lei/lui?',
        'Sigaretta dopo il sesso? No, grazie.',
        'La RESPONSABILITÀ è tua.',
        'L’unico distributore a cui ti devi riferire è quello degli snack.',
        'Sfizio o vizio?',
        'Per l’amor di chi?',
        'Quanti soldi buttati.',
        'Reagisci.',
        'In realtà il cervello non ne ha bisogno.',
        '+++Salute +++Soldi',
        'Eddaaaiii.',
        'Le rose son rosse, le viole son blu, meglio che non fumi più.',
        'Anche se non lo sai, sono tutti i tuoi guai.',
        'Quella vacanza non si paga da sola.',
        

        'OooooOOOOOh',
        'Daaaatte naaa maaaAAano',
        'Figa ma lascia stare ste sigarette',
        'Deh misà che ti conviene smettere',
        'Nisi desistis, Santa Claus tibi dona non afferet.',
      ];
    case 'es':
      return const [
        'Deja de fumar ahora.',
        'Cada cigarrillo menos cuenta.',
        'Respira, no fumes.',
        'Estás tomando una mejor decisión.',
        'Tu objetivo es más fuerte que el hábito.',
        'Estás invirtiendo en tu salud.',
        'Hoy dejo de fumar.',
      ];
    case 'fr':
      return const [
        'Arrête de fumer maintenant.',
        'Chaque cigarette en moins compte.',
        'Respire, ne fume pas.',
        'Tu fais un meilleur choix.',
        'Ton objectif est plus fort que l’habitude.',
        'Tu investis dans ta santé.',
        'Aujourd’hui, j’arrête de fumer.',
      ];
    case 'de':
      return const [
        'Hör jetzt auf zu rauchen.',
        'Jede Zigarette weniger zählt.',
        'Atme durch, rauche nicht.',
        'Du triffst eine bessere Entscheidung.',
        'Dein Ziel ist stärker als die Gewohnheit.',
        'Du investierst in deine Gesundheit.',
        'Heute höre ich mit dem Rauchen auf.',
      ];
    case 'ru':
      return const [
        'Бросай курить прямо сейчас.',
        'Каждая сигарета меньше имеет значение.',
        'Дыши, не кури.',
        'Ты делаешь лучший выбор.',
        'Твоя цель сильнее привычки.',
        'Ты инвестируешь в своё здоровье.',
        'Сегодня я бросаю курить.',
      ];
    case 'pt':
      return const [
        'Pare de fumar agora.',
        'Cada cigarro a menos conta.',
        'Respire, não fume.',
        'Você está fazendo uma escolha melhor.',
        'Seu objetivo é mais forte que o hábito.',
        'Você está investindo na sua saúde.',
        'Hoje eu vou parar de fumar.',
      ];
    case 'ko':
      return const [
        '지금 담배를 끊으세요.',
        '담배 한 개비라도 줄이는 것은 중요합니다.',
        '숨을 고르고, 담배를 피우지 마세요.',
        '당신은 더 나은 선택을 하고 있습니다.',
        '당신의 목표는 습관보다 강합니다.',
        '당신은 자신의 건강에 투자하고 있습니다.',
        '오늘 나는 담배를 끊는다.',
      ];
    default:
      return const [
        'Stop now.',
        'Every cigarette less counts.',
        'Breathe, do not smoke.',
        'You are making a better choice.',
        'Your goal is stronger than the habit.',
        'You are investing in your health.',
        'Today I quit.',
      ];
  }
}