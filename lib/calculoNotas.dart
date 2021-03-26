const MENUITENS_R = const {
  '/dashboard': '/dashboardClinic',
  '/nursery': '/nurseryScreen',
  '/pets': '/pets',
  '/employees': '/colaboratorsScreen',
  '/grooming-config': '/servicesScreen',
  '/sales-report': '/recordScreen',
};

const Map<String,Map<String,double>> CALCULO_NOTAS = const {
  'MODALIDADE':{
    'FOOTBALL': 1,
    'FUTSAL': 2,
    'SOCIETY': 1.5,
  },
  'SUB20':{
    'TOTALPASSE' : 90,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 5,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 10,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 20,
  },
  'SUB18':{
    'TOTALPASSE' : 85,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 5,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 9,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 18,
  },
  'SUB16':{
    'TOTALPASSE' : 80,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 4,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 9,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 16,
  },
  'SUB14':{
    'TOTALPASSE' : 75,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 4,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 8,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 14,
  },
  'SUB12':{
    'TOTALPASSE' : 70,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 3,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 8,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 14,
  },
  'SUB10':{
    'TOTALPASSE' : 60,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 3,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 7,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 12,
  },
  'SUB8':{
    'TOTALPASSE' : 50,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 2,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 7,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 12,
  },
  'SUB6':{
    'TOTALPASSE' : 40,
    'PASSECERTO' : 0.9,
    'ASSISTENCIA': 10,
    
    'CHUTE': 2,
    'CHUTEAOGOL': 0.4,
    'GOL': 10,

    'DRIBLES': 6,
    'DRIBLESCERTOS': 0.7,

    'DESARMES': 10,
  }

};