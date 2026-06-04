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
        'La pazienza è la virtù dei forti.',
        'Ci riuscirai', 
        'Mettili da parte',
        '🚬🚫',

 
        'OooooOOOOOh.',
        'Daaaatte naaa maaaAAano.',
        'Figa ma lascia stare ste sigarette.',
        'Deh misà che ti conviene smettere.',
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
        'Recuérdalo: lo haces por una razón y por alguien.',
        '! Tírala',
        'Con ese mal aliento, ¿a quién quieres besar?',
        '¿A qué edad empezaste? ¿Y a qué edad quieres dejarlo?',
        'Un cigarrillo menos al día ayuda a tu salud.',
        '¿Te la ofrecieron? ¿Y aceptaste?',
        '¿Qué echas más de menos: el cigarrillo o a él/ella?',
        '¿Un cigarrillo después del sexo? No, gracias.',
        'La RESPONSABILIDAD es tuya.',
        '¿Un capricho o un vicio?',
        '¿Por amor de quién?',
        'Cuánto dinero tirado.',
        'Reacciona.',
        'En realidad, el cerebro no lo necesita.',
        '+++Salud +++Dinero',
        'Vaaamos...',
        'Las rosas son rojas, las violetas son azules, mejor que no fumes más.',
        'Aunque no lo sepas, todos son tus problemas.',
        'Ese viaje no se paga solo.',
        'La paciencia es la virtud de los fuertes.',
        'Lo conseguirás.',
        'Déjalos aparte.',
        '🚬🚫',
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
        'Rappelle-toi pourquoi et pour qui tu le fais.',
        '! Jette-la',
        'Avec cette odeur dans la bouche, qui veux-tu embrasser ?',
        'À quel âge as-tu commencé ? Et à quel âge veux-tu arrêter ?',
        'Une cigarette de moins par jour, c’est déjà mieux pour la santé.',
        'On te l’a proposée ? Et tu as accepté ?',
        'Qu’est-ce qui te manque le plus : la cigarette ou elle/lui ?',
        'Une cigarette après le sexe ? Non merci.',
        'La RESPONSABILITÉ t’appartient.',
        'Un caprice ou une dépendance ?',
        'Pour l’amour de qui ?',
        'Que d’argent gâché.',
        'Réagis.',
        'En réalité, le cerveau n’en a pas besoin.',
        '+++Santé +++Argent',
        'Allez...',
        'Les roses sont rouges, les violettes sont bleues, mieux vaut que tu ne fumes plus.',
        'Même si tu ne le sais pas, ce sont tous tes problèmes.',
        'Ces vacances ne se paient pas toutes seules.',
        'La patience est la vertu des forts.',
        'Tu y arriveras.',
        'Mets-les de côté.',
        '🚬🚫',
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
        'Erinnere dich daran, warum und für wen du das tust.',
        '! Wirf sie weg',
        'Mit diesem Mundgeruch: Wen willst du küssen?',
        'In welchem Alter hast du angefangen? Und mit welchem willst du aufhören?',
        'Eine Zigarette weniger am Tag ist schon gut für die Gesundheit.',
        'Hat man sie dir angeboten? Und hast du sie angenommen?',
        'Vermisst du eher die Zigarette oder ihn/sie?',
        'Eine Zigarette nach dem Sex? Nein, danke.',
        'Die VERANTWORTUNG liegt bei dir.',
        'Laune oder Sucht?',
        'Für wen denn?',
        'Wie viel Geld verschwendet.',
        'Reagiere.',
        'Eigentlich braucht das Gehirn das nicht.',
        '+++Gesundheit +++Geld',
        'Komm schon...',
        'Rosen sind rot, Veilchen sind blau, besser, du rauchst nicht mehr.',
        'Auch wenn du es nicht weißt, sind das alles deine Probleme.',
        'Dieser Urlaub bezahlt sich nicht von selbst.',
        'Geduld ist die Tugend der Starken.',
        'Du wirst es schaffen.',
        'Leg sie beiseite.',
        '🚬🚫',
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
        'Помни, почему и ради кого ты это делаешь.',
        'Выбрось её!',
        'С таким запахом изо рта кого ты хочешь поцеловать?',
        'В каком возрасте ты начал(а)? И в каком хочешь бросить?',
        'Одна сигарета в день меньше — уже лучше для здоровья.',
        'Её тебе предложили? И ты согласился(лась)?',
        'Чего тебе больше не хватает: сигареты или его/её?',
        'Сигарета после секса? Нет, спасибо.',
        'ОТВЕТСТВЕННОСТЬ — на тебе.',
        'Просто прихоть или зависимость?',
        'Ради кого?',
        'Сколько денег выброшено зря.',
        'Среагируй.',
        'На самом деле мозгу это не нужно.',
        '+++Здоровье +++Деньги',
        'Давай же...',
        'Розы красные, фиалки синие, лучше уж не кури.',
        'Даже если ты этого не знаешь, это всё твои проблемы.',
        'Этот отпуск сам себя не оплатит.',
        'Терпение — добродетель сильных.',
        'У тебя получится.',
        'Отложи их в сторону.',
        '🚬🚫',
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
        'Lembra-te do porquê e de quem estás a fazer isto.',
        '! Deita-a fora',
        'Com esse mau hálito, quem queres beijar?',
        'A que idade começaste? E a que idade queres parar?',
        'Um cigarro a menos por dia já faz bem à saúde.',
        'Ofereceram-to? E aceitaste?',
        'Falta-te mais o cigarro ou ela/ele?',
        'Cigarro depois do sexo? Não, obrigado.',
        'A RESPONSABILIDADE é tua.',
        'Capricho ou vício?',
        'Por amor de quem?',
        'Quanto dinheiro desperdiçado.',
        'Reage.',
        'Na verdade, o cérebro não precisa disso.',
        '+++Saúde +++Dinheiro',
        'Vá lá...',
        'As rosas são vermelhas, as violetas são azuis, é melhor que já não fumes mais.',
        'Mesmo que não saibas, são todos os teus problemas.',
        'Essas férias não se pagam sozinhas.',
        'A paciência é a virtude dos fortes.',
        'Tu consegues.',
        'Põe-nos de lado.',
        '🚬🚫',
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
        '왜, 그리고 누구를 위해 이걸 하는지 기억해.',
        '! 그냥 버려',
        '입 냄새가 이렇게 나는데 누구에게 키스하려고?',
        '몇 살에 시작했어? 그리고 몇 살에 그만둘 거야?',
        '하루에 담배 한 개비 덜 피우는 것만으로도 건강에 도움이 돼.',
        '누가 권했어? 그리고 받아들였어?',
        '담배가 더 그리워, 아니면 그 사람(그녀/그) 이 더 그리워?',
        '섹스 후에 담배 한 개비? 아니, 괜찮아.',
        '책임은 네 몫이야.',
        '그냥 버릇이야, 아니면 중독이야?',
        '누구를 위해서?',
        '돈을 얼마나 버렸는지.',
        '정신 차려.',
        '사실 뇌는 그걸 필요로 하지 않아.',
        '+++건강 +++돈',
        '제발...',
        '장미는 빨갛고, 제비꽃은 파랗고, 이제는 담배를 끊는 게 좋아.',
        '네가 몰라도, 결국 다 네 문제야.',
        '그 휴가는 저절로 결제되지 않아.',
        '인내는 강한 사람의 미덕이야.',
        '너는 해낼 수 있어.',
        '그것들을 따로 치워 둬.',
        '🚬🚫',
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
        'Remember why and for whom you are doing this.',
        '! Throw it away',
        'With that bad breath, who do you want to kiss?',
        'At what age did you start? And at what age do you want to quit?',
        'One less cigarette a day is already better for your health.',
        'Was it offered to you? And did you accept it?',
        'Do you miss the cigarette more, or him/her?',
        'A cigarette after sex? No, thanks.',
        'The RESPONSIBILITY is yours.',
        'Just a craving or an addiction?',
        'For whom?',
        'So much money wasted.',
        'React.',
        'Actually, the brain does not need it.',
        '+++Health +++Money',
        'Come on...',
        'Roses are red, violets are blue, it is better if you smoke no more.',
        'Even if you do not know it, they are all your troubles.',
        'That holiday will not pay for itself.',
        'Patience is the virtue of the strong.',
        'You will make it.',
        'Put them aside.',
        '🚬🚫',
      ];
  }
}