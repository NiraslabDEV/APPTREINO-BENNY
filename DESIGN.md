<!-- Home Aluno -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Início Aluno</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&amp;family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-error-container": "#ffd2c8",
                        "outline": "#767575",
                        "inverse-surface": "#fcf9f8",
                        "error": "#ff7351",
                        "surface-container-lowest": "#000000",
                        "inverse-on-surface": "#565555",
                        "on-secondary": "#004d57",
                        "outline-variant": "#484847",
                        "surface-container-low": "#131313",
                        "on-tertiary-fixed-variant": "#685700",
                        "on-background": "#ffffff",
                        "surface-container": "#1a1a1a",
                        "surface-dim": "#0e0e0e",
                        "primary-container": "#d4fb00",
                        "tertiary-fixed": "#fddb42",
                        "on-error": "#450900",
                        "background": "#0e0e0e",
                        "on-surface-variant": "#adaaaa",
                        "secondary-dim": "#00d4ec",
                        "secondary-container": "#006875",
                        "on-tertiary-fixed": "#473b00",
                        "on-secondary-fixed": "#003a42",
                        "on-surface": "#ffffff",
                        "tertiary": "#ffeba0",
                        "surface-bright": "#2c2c2c",
                        "primary-fixed": "#d4fb00",
                        "surface-container-highest": "#262626",
                        "tertiary-container": "#fddb42",
                        "primary": "#f5ffc5",
                        "on-secondary-container": "#e8fbff",
                        "inverse-primary": "#556600",
                        "secondary-fixed": "#26e6ff",
                        "surface-container-high": "#20201f",
                        "secondary-fixed-dim": "#00d7f0",
                        "error-container": "#b92902",
                        "surface": "#0e0e0e",
                        "surface-variant": "#262626",
                        "on-tertiary": "#665600",
                        "primary-fixed-dim": "#c7ec00",
                        "on-primary": "#556600",
                        "tertiary-fixed-dim": "#eecd34",
                        "primary-dim": "#c9ef00",
                        "on-tertiary-container": "#5c4d00",
                        "on-secondary-fixed-variant": "#005964",
                        "tertiary-dim": "#eecd34",
                        "on-primary-fixed": "#3d4a00",
                        "error-dim": "#d53d18",
                        "on-primary-container": "#4d5d00",
                        "surface-tint": "#f5ffc5",
                        "secondary": "#00e3fd",
                        "on-primary-fixed-variant": "#566800"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Lexend"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0e0e0e;
            color: #ffffff;
        }
        .text-headline { font-family: 'Lexend', sans-serif; }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-[#0e0e0e]/80 backdrop-blur-xl flex justify-between items-center px-6 py-4">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary-container">
<img alt="User Profile" class="w-full h-full object-cover" data-alt="Close up portrait of a fit athlete with determined expression in a dark gym setting with dramatic lime lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBH1pv3TxX9rzmC4N2P5q4l4fqCFLt4BvpNRvCrZwm32dk6Qo29SpVUHVwpCCahpEo8h806EHfO6MIFok2H79mMf4Cc9hwLc9zIAkGRRgE_-Pdbw9aEYMWwUjjG7KybFR6qhsIxNmvLXUreifPYYxXJRxqcFFQH-to704sqXnF2tH9GZW9o9wnEsXXSAGrUr1rXDqd9hlb61-smQEG6LBUHsfY7fAKRuPCSm4N0su7LR_L4sEgRAZBtoH7DIBYYnv0SZ-0E5cCurL8"/>
</div>
<span class="text-2xl font-black text-[#d7ff00] italic font-['Lexend'] tracking-tighter uppercase">KINETIC</span>
</div>
<button class="text-[#d7ff00] hover:opacity-80 transition-opacity active:scale-95 duration-200">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<main class="pt-24 pb-32 px-6 max-w-5xl mx-auto space-y-8">
<!-- Greeting & Personalization -->
<section class="space-y-1">
<h2 class="text-on-surface-variant font-label text-sm uppercase tracking-widest">BEM-VINDO DE VOLTA</h2>
<h1 class="text-5xl font-black font-headline tracking-tighter italic">Hi, Alex!</h1>
</section>
<!-- Bento Grid Layout -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
<!-- Today's Workout Card (Large Hero) -->
<div class="md:col-span-2 relative group overflow-hidden rounded-lg bg-surface-container h-[400px]">
<div class="absolute inset-0 z-0">
<img alt="Leg Day Focus" class="w-full h-full object-cover opacity-40 group-hover:scale-105 transition-transform duration-700" data-alt="Muscular legs performing a heavy barbell squat in a dark industrial gym with glowing lime green neon accents" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCZSd3WJhW5pqTvrNPFBvYonED7V-fFoD7dEiV-twGHZZhK-6DfKIszYJ3eyMaun-dYV4OI5wzDN7fgat7Zu8X9YIm31HujMfhwusax1DCbOpU5dmnhNA-_-7CI1-limyukIA1WYRFRQVW7ZFEmzI4vWs_nVMshVl04Kr5_C6Qs6R72_bu4fMhqWlH9awP3kQ0a_JtikNtvMYpBpMQGmhYcZJ506HIThZ3WrPsm1U_62TSeAPdCbw_AbRD75V_7f1Pt0ONnKQBr8zg"/>
<div class="absolute inset-0 bg-gradient-to-t from-surface via-surface/40 to-transparent"></div>
</div>
<div class="relative z-10 h-full flex flex-col justify-end p-8 space-y-4">
<div>
<span class="bg-primary-container text-on-primary-container px-3 py-1 rounded-full text-xs font-bold font-label tracking-widest uppercase">Sessão de Hoje</span>
<h3 class="text-4xl font-black font-headline mt-2 leading-none uppercase italic">TREINO DE PERNAS - FOCO PESADO</h3>
<p class="text-on-surface-variant font-body mt-2">60 Min • Alta Intensidade • 480 kcal</p>
</div>
<button class="w-fit bg-primary-container text-on-primary font-black font-headline px-8 py-4 rounded-full flex items-center gap-3 active:scale-95 transition-all shadow-[0_0_20px_rgba(215,255,0,0.3)]"><span class="material-symbols-outlined" data-icon="play_arrow" style="font-variation-settings: 'FILL' 1;">play_arrow</span> INICIAR TREINO</button>
</div>
</div>
<!-- Recent PRs Card -->
<div class="bg-surface-container rounded-lg p-6 flex flex-col justify-between border-l-4 border-secondary shadow-lg">
<div>
<div class="flex justify-between items-center mb-6">
<span class="font-label text-xs uppercase tracking-widest text-on-surface-variant">RECORDES RECENTES</span>
<span class="material-symbols-outlined text-secondary" data-icon="military_tech">military_tech</span>
</div>
<div class="space-y-6">
<div>
<p class="text-on-surface-variant text-xs uppercase font-label">Guia de nutrição pré-treino pronto</p>
<div class="flex items-baseline gap-2">
<span class="text-3xl font-black font-headline">185</span>
<span class="text-on-surface-variant text-sm font-label">KG</span>
</div>
</div>
<div>
<p class="text-on-surface-variant text-xs uppercase font-label">Guia de nutrição pré-treino pronto</p>
<div class="flex items-baseline gap-2">
<span class="text-3xl font-black font-headline">120</span>
<span class="text-on-surface-variant text-sm font-label">KG</span>
</div>
</div>
</div>
</div>
<div class="mt-4 pt-4 border-t border-outline-variant/20">
<button class="text-secondary font-label text-xs uppercase tracking-widest font-bold flex items-center gap-2">VER RECORDES <span class="material-symbols-outlined text-sm" data-icon="arrow_forward">arrow_forward</span></button>
</div>
</div>
<!-- Weekly Progress Summary -->
<div class="md:col-span-2 bg-surface-container-low rounded-lg p-8">
<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
<div>
<h4 class="text-2xl font-black font-headline italic uppercase">RITMO SEMANAL</h4>
<p class="text-on-surface-variant font-body">4 de 5 treinos concluídos esta semana</p>
</div>
<div class="flex gap-2">
<!-- Progress Dots -->
<div class="w-10 h-10 rounded-full bg-primary-container text-on-primary flex items-center justify-center font-black font-headline">M</div>
<div class="w-10 h-10 rounded-full bg-primary-container text-on-primary flex items-center justify-center font-black font-headline">T</div>
<div class="w-10 h-10 rounded-full bg-surface-container-highest text-on-surface-variant flex items-center justify-center font-black font-headline">W</div>
<div class="w-10 h-10 rounded-full bg-primary-container text-on-primary flex items-center justify-center font-black font-headline">T</div>
<div class="w-10 h-10 rounded-full bg-primary-container text-on-primary flex items-center justify-center font-black font-headline">F</div>
<div class="w-10 h-10 rounded-full bg-surface-container-highest text-on-surface-variant flex items-center justify-center font-black font-headline opacity-50">S</div>
<div class="w-10 h-10 rounded-full bg-surface-container-highest text-on-surface-variant flex items-center justify-center font-black font-headline opacity-50">S</div>
</div>
</div>
<!-- Pulse Bar -->
<div class="relative h-4 bg-surface-container-highest rounded-full overflow-hidden">
<div class="absolute top-0 left-0 h-full w-4/5 bg-gradient-to-r from-primary-container to-secondary rounded-full"></div>
</div>
<div class="flex justify-between mt-3 text-[10px] font-bold uppercase tracking-widest text-on-surface-variant">
<span>Sequência Ativa: 12 Dias</span>
<span>80% da Meta Atingida</span>
</div>
</div>
<!-- Body Weight Stat -->
<div class="bg-surface-container rounded-lg p-6 flex flex-col justify-center text-center">
<span class="font-label text-xs uppercase tracking-widest text-on-surface-variant mb-2">PESO CORPORAL</span>
<div class="flex flex-col items-center">
<span class="text-5xl font-black font-headline text-primary-container">82.4</span>
<span class="text-on-surface-variant text-sm font-label uppercase">QUILOGRAMAS</span>
</div>
<div class="mt-4 flex items-center justify-center gap-2 text-error text-xs font-bold"><span class="material-symbols-outlined text-sm" data-icon="trending_down">trending_down</span> -0.5 KG DESDE A SEMANA PASSADA</div>
</div>
</div>
<!-- Quick Action Suggestion -->
<div class="bg-surface-container-highest rounded-lg p-6 flex items-center justify-between">
<div class="flex items-center gap-4">
<div class="bg-secondary-container/30 p-3 rounded-full">
<span class="material-symbols-outlined text-secondary" data-icon="restaurant">restaurant</span>
</div>
<div>
<h5 class="font-bold font-headline text-sm uppercase">ABASTEÇA SEU TREINO</h5>
<p class="text-xs text-on-surface-variant">Guia de nutrição pré-treino pronto</p>
</div>
</div>
<button class="bg-surface-variant hover:bg-outline-variant transition-colors p-2 rounded-full">
<span class="material-symbols-outlined" data-icon="chevron_right">chevron_right</span>
</button>
</div>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full flex justify-around items-center px-4 pb-6 pt-3 bg-[#0e0e0e]/90 backdrop-blur-2xl z-50 rounded-t-[2rem] border-t border-[#d7ff00]/15 shadow-[0_-8px_32px_rgba(215,255,0,0.08)]">
<!-- Home (Active) -->
<a class="flex flex-col items-center justify-center bg-[#d7ff00] text-[#0e0e0e] rounded-full px-5 py-2 active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="fitness_center" style="font-variation-settings: 'FILL' 1;">fitness_center</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-0.5">INÍCIO</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="list_alt">list_alt</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-0.5">TREINOS</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="insights">insights</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-0.5">PROGRESSO</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="person">person</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-0.5">PERFIL</span>
</a>
</nav>
</body></html>

<!-- Executando Treino -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;600;700;800;900&amp;family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-error-container": "#ffd2c8",
                    "outline": "#767575",
                    "inverse-surface": "#fcf9f8",
                    "error": "#ff7351",
                    "surface-container-lowest": "#000000",
                    "inverse-on-surface": "#565555",
                    "on-secondary": "#004d57",
                    "outline-variant": "#484847",
                    "surface-container-low": "#131313",
                    "on-tertiary-fixed-variant": "#685700",
                    "on-background": "#ffffff",
                    "surface-container": "#1a1a1a",
                    "surface-dim": "#0e0e0e",
                    "primary-container": "#d4fb00",
                    "tertiary-fixed": "#fddb42",
                    "on-error": "#450900",
                    "background": "#0e0e0e",
                    "on-surface-variant": "#adaaaa",
                    "secondary-dim": "#00d4ec",
                    "secondary-container": "#006875",
                    "on-tertiary-fixed": "#473b00",
                    "on-secondary-fixed": "#003a42",
                    "on-surface": "#ffffff",
                    "tertiary": "#ffeba0",
                    "surface-bright": "#2c2c2c",
                    "primary-fixed": "#d4fb00",
                    "surface-container-highest": "#262626",
                    "tertiary-container": "#fddb42",
                    "primary": "#f5ffc5",
                    "on-secondary-container": "#e8fbff",
                    "inverse-primary": "#556600",
                    "secondary-fixed": "#26e6ff",
                    "surface-container-high": "#20201f",
                    "secondary-fixed-dim": "#00d7f0",
                    "error-container": "#b92902",
                    "surface": "#0e0e0e",
                    "surface-variant": "#262626",
                    "on-tertiary": "#665600",
                    "primary-fixed-dim": "#c7ec00",
                    "on-primary": "#556600",
                    "tertiary-fixed-dim": "#eecd34",
                    "primary-dim": "#c9ef00",
                    "on-tertiary-container": "#5c4d00",
                    "on-secondary-fixed-variant": "#005964",
                    "tertiary-dim": "#eecd34",
                    "on-primary-fixed": "#3d4a00",
                    "error-dim": "#d53d18",
                    "on-primary-container": "#4d5d00",
                    "surface-tint": "#f5ffc5",
                    "secondary": "#00e3fd",
                    "on-primary-fixed-variant": "#566800"
            },
            "borderRadius": {
                    "DEFAULT": "1rem",
                    "lg": "2rem",
                    "xl": "3rem",
                    "full": "9999px"
            },
            "fontFamily": {
                    "headline": ["Lexend"],
                    "body": ["Inter"],
                    "label": ["Inter"]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .active-pill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background text-on-surface font-body selection:bg-primary-container selection:text-on-primary-container">
<!-- TopAppBar (From JSON) -->
<header class="fixed top-0 w-full z-50 bg-[#0e0e0e]/80 backdrop-blur-xl flex justify-between items-center px-6 py-4 w-full">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden bg-surface-container">
<img alt="User Profile" class="w-full h-full object-cover" data-alt="close up profile portrait of a focused athlete in a dark gym setting with dramatic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD9Bq4jO8dPkHYVcZDHAQOHq3wPTAe4DXlIrs7RzOVm46viwIm9ltkBbLHWu4SVQIcwVHDkD-wJrHPOqS1wBlLFtO9qdfvuGm0qE5ZdaEKaQMFQvpBDzHA3_0Fh1aQvCh6zSB0N-40H9wbGJjknFf2qnuO2jys8aFhVbhG0L_48oHKrK4ueF-NjuS-VTZiTUNXSutDIQeHxaVxbqr9VY0Kt64ABuFG6sdbtuDXudOhokZGJpGGVt6em9wdFVn4y0KbOK-tvZE6KrmY"/>
</div>
<span class="font-headline tracking-tighter uppercase text-2xl font-black text-[#d7ff00] italic">KINETIC</span>
</div>
<button class="text-neutral-500 hover:opacity-80 transition-opacity active:scale-95 duration-200">
<span class="material-symbols-outlined text-2xl">notifications</span>
</button>
</header>
<main class="pt-24 pb-32 px-4 max-w-2xl mx-auto space-y-8">
<!-- Active Workout Header -->
<section class="space-y-4">
<div class="flex justify-between items-end">
<div>
<span class="text-primary-container font-headline font-bold text-sm tracking-[0.2em] uppercase">Sessão Atual</span>
<h1 class="text-4xl font-headline font-black tracking-tight leading-none mt-1">DIA DE EMPURRAR A</h1>
</div>
<div class="text-right">
<span class="text-on-surface-variant font-label text-xs uppercase tracking-widest block">Duração</span>
<span class="text-xl font-headline font-medium tabular-nums">00:42:15</span>
</div>
</div>
<!-- Rest Timer Component (The "Pulse") -->
<div class="bg-surface-container-low rounded-lg p-6 flex items-center justify-between group">
<div class="space-y-1">
<h3 class="font-headline font-bold text-lg leading-tight uppercase italic text-primary-container">Timer de Descanso</h3>
<p class="text-on-surface-variant font-label text-sm">Meta: 90 segundos</p>
</div>
<div class="relative flex items-center justify-center">
<!-- Progress Circle -->
<svg class="w-24 h-24 -rotate-90">
<circle class="text-surface-container-highest" cx="48" cy="48" fill="transparent" r="40" stroke="currentColor" stroke-width="8"></circle>
<circle cx="48" cy="48" fill="transparent" r="40" stroke="url(#timer-gradient)" stroke-dasharray="251.2" stroke-dashoffset="80" stroke-linecap="round" stroke-width="8"></circle>
<defs>
<lineargradient id="timer-gradient" x1="0%" x2="100%" y1="0%" y2="0%">
<stop offset="0%" stop-color="#f5ffc5"></stop>
<stop offset="100%" stop-color="#d4fb00"></stop>
</lineargradient>
</defs>
</svg>
<span class="absolute text-2xl font-headline font-black italic tracking-tighter">01:12</span>
</div>
</div>
</section>
<!-- Exercise List -->
<div class="space-y-10">
<!-- Exercise Card 1: Bench Press -->
<article class="space-y-6">
<!-- Header & Visual -->
<div class="flex gap-4 items-start">
<div class="w-32 h-32 rounded-md overflow-hidden bg-surface-container-high shrink-0">
<img alt="Bench Press" class="w-full h-full object-cover grayscale opacity-80" data-alt="monochrome cinematic shot of a person performing a heavy barbell bench press in a dark gritty gym" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYgQ7JfE7359DQ9IDhfc3EYKWe0ab_MwzxCQ9flqHz7uq7aKp21IQLl9dmUaGZ964Q63zfC8r69lm8b45Wqwo8gm1midtt4PXSD-8ehdPuMZp5OFpHNkEMwkfcsk0uJBSEBaDLfsio0egKDmI7OQOkpMO9PB3PgUrMPsNOz14yKJY8OP3vifanadhCIhYjMBVqQNjyY6uYnfum_D4EQ9HjrwWIj3Z_ZdCEaYLtF22EcBtgpq_64pdrYBqTy-BMzqNYDe41V_7zGvo"/>
</div>
<div class="pt-2">
<h2 class="text-3xl font-headline font-bold tracking-tighter uppercase italic leading-none">Supino com Barra</h2>
<div class="flex gap-2 mt-2">
<span class="bg-secondary-container/30 text-secondary-dim text-[10px] font-bold uppercase tracking-widest px-2 py-0.5 rounded-full">Peito</span>
<span class="bg-surface-container-highest text-on-surface-variant text-[10px] font-bold uppercase tracking-widest px-2 py-0.5 rounded-full">Composto</span>
</div>
</div>
</div>
<!-- Logging Table -->
<div class="bg-surface-container rounded-lg overflow-hidden">
<div class="grid grid-cols-4 px-6 py-3 bg-surface-container-high/50 font-label text-[10px] font-black uppercase tracking-widest text-on-surface-variant">
<span>Série</span>
<span>Anterior</span>
<span class="text-center">KG</span>
<span class="text-center">Reps</span>
</div>
<div class="divide-y divide-outline-variant/10">
<!-- Set 1 (Completed) -->
<div class="grid grid-cols-4 px-6 py-5 items-center bg-primary-container/5">
<span class="font-headline font-bold italic text-primary-container">01</span>
<span class="text-on-surface-variant text-sm font-medium">80 x 10</span>
<div class="px-2">
<input class="w-full bg-surface-container-highest border-none rounded-md text-center font-headline font-bold text-lg py-2 focus:ring-1 focus:ring-primary-container" type="number" value="85"/>
</div>
<div class="px-2">
<input class="w-full bg-surface-container-highest border-none rounded-md text-center font-headline font-bold text-lg py-2 focus:ring-1 focus:ring-primary-container" type="number" value="10"/>
</div>
</div>
<!-- Set 2 (Active) -->
<div class="grid grid-cols-4 px-6 py-5 items-center bg-surface-container">
<span class="font-headline font-bold italic text-on-surface-variant">02</span>
<span class="text-on-surface-variant text-sm font-medium">80 x 10</span>
<div class="px-2">
<input class="w-full bg-surface-container-high border-none rounded-md text-center font-headline font-bold text-lg py-2 focus:ring-1 focus:ring-primary-container" placeholder="--" type="number"/>
</div>
<div class="px-2">
<input class="w-full bg-surface-container-high border-none rounded-md text-center font-headline font-bold text-lg py-2 focus:ring-1 focus:ring-primary-container" placeholder="--" type="number"/>
</div>
</div>
</div>
<div class="p-4 grid grid-cols-2 gap-3">
<button class="bg-surface-container-highest hover:bg-surface-bright text-on-surface font-headline font-bold uppercase py-4 rounded-full transition-all active:scale-95 duration-200 flex items-center justify-center gap-2"><span class="material-symbols-outlined">add</span> Série </button>
<button class="bg-primary-container text-on-primary font-headline font-black uppercase py-4 rounded-full transition-all active:scale-95 duration-200 flex items-center justify-center gap-2">Finalizar Série</button>
</div>
</div>
</article>
<!-- Exercise Card 2: Shoulder Press (Inactive/Next) -->
<article class="opacity-50 space-y-6">
<div class="flex gap-4 items-start">
<div class="w-32 h-32 rounded-md overflow-hidden bg-surface-container-high shrink-0">
<img alt="Shoulder Press" class="w-full h-full object-cover grayscale" data-alt="athlete in heavy shadow performing overhead shoulder press with dumbbells in a minimalist gym setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDknbSGps8aHlS1ykhGfv5sIf4tHGlLq5t7XpKJltROh64zPS6drnoITjmKMt5isVgTT7ZGkEfK9fZj6fwiAsOdDpwI-kwLblnrWH3bdbOaqQFdXJ-6zsoc0i7ukQO9VNE80zg2ZWcTLqRHS9_5JiRMhE7wZ5fLvz55bcPacO0fa4PwcMleIrekcK5ykgrt_NlYBM3ys71a02CkBpqgzCl8B6UsNSERpxlMD_Po2yzgfIOZnta3uYPZOiQlZ09_uAsiYsAdck4ojRE"/>
</div>
<div class="pt-2">
<h2 class="text-3xl font-headline font-bold tracking-tighter uppercase italic leading-none">Desenvolvimento com Halteres</h2>
<div class="flex gap-2 mt-2">
<span class="bg-surface-container-highest text-on-surface-variant text-[10px] font-bold uppercase tracking-widest px-2 py-0.5 rounded-full">Ombros</span>
</div>
</div>
</div>
</article>
</div>
<!-- Global Action -->
<div class="pt-8 pb-12">
<button class="w-full border-2 border-primary-container text-primary-container font-headline font-black uppercase text-xl py-6 rounded-lg tracking-widest hover:bg-primary-container hover:text-on-primary transition-all active:scale-95">Próximo Exercício</button>
</div>
</main>
<!-- BottomNavBar (From JSON) -->
<nav class="fixed bottom-0 w-full z-50 rounded-t-[2rem] bg-[#0e0e0e]/90 backdrop-blur-2xl border-t border-[#d7ff00]/15 shadow-[0_-8px_32px_rgba(215,255,0,0.08)] px-4 pb-6 pt-3 flex justify-around items-center">
<!-- Home -->
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Início</span>
</a>
<!-- Workouts (Active) -->
<a class="flex flex-col items-center justify-center bg-[#d7ff00] text-[#0e0e0e] rounded-full px-5 py-2 active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined active-pill">list_alt</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Treinos</span>
</a>
<!-- Progress -->
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined">insights</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Progresso</span>
</a>
<!-- Profile -->
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined">person</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Perfil</span>
</a>
</nav>
</body></html>

<!-- Meus Treinos -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&amp;family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-error-container": "#ffd2c8",
                    "outline": "#767575",
                    "inverse-surface": "#fcf9f8",
                    "error": "#ff7351",
                    "surface-container-lowest": "#000000",
                    "inverse-on-surface": "#565555",
                    "on-secondary": "#004d57",
                    "outline-variant": "#484847",
                    "surface-container-low": "#131313",
                    "on-tertiary-fixed-variant": "#685700",
                    "on-background": "#ffffff",
                    "surface-container": "#1a1a1a",
                    "surface-dim": "#0e0e0e",
                    "primary-container": "#d4fb00",
                    "tertiary-fixed": "#fddb42",
                    "on-error": "#450900",
                    "background": "#0e0e0e",
                    "on-surface-variant": "#adaaaa",
                    "secondary-dim": "#00d4ec",
                    "secondary-container": "#006875",
                    "on-tertiary-fixed": "#473b00",
                    "on-secondary-fixed": "#003a42",
                    "on-surface": "#ffffff",
                    "tertiary": "#ffeba0",
                    "surface-bright": "#2c2c2c",
                    "primary-fixed": "#d4fb00",
                    "surface-container-highest": "#262626",
                    "tertiary-container": "#fddb42",
                    "primary": "#f5ffc5",
                    "on-secondary-container": "#e8fbff",
                    "inverse-primary": "#556600",
                    "secondary-fixed": "#26e6ff",
                    "surface-container-high": "#20201f",
                    "secondary-fixed-dim": "#00d7f0",
                    "error-container": "#b92902",
                    "surface": "#0e0e0e",
                    "surface-variant": "#262626",
                    "on-tertiary": "#665600",
                    "primary-fixed-dim": "#c7ec00",
                    "on-primary": "#556600",
                    "tertiary-fixed-dim": "#eecd34",
                    "primary-dim": "#c9ef00",
                    "on-tertiary-container": "#5c4d00",
                    "on-secondary-fixed-variant": "#005964",
                    "tertiary-dim": "#eecd34",
                    "on-primary-fixed": "#3d4a00",
                    "error-dim": "#d53d18",
                    "on-primary-container": "#4d5d00",
                    "surface-tint": "#f5ffc5",
                    "secondary": "#00e3fd",
                    "on-primary-fixed-variant": "#566800"
            },
            "borderRadius": {
                    "DEFAULT": "1rem",
                    "lg": "2rem",
                    "xl": "3rem",
                    "full": "9999px"
            },
            "fontFamily": {
                    "headline": ["Lexend"],
                    "body": ["Inter"],
                    "label": ["Inter"]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Inter', sans-serif; }
        h1, h2, h3 { font-family: 'Lexend', sans-serif; }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface min-h-screen pb-32">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-[#0e0e0e]/80 backdrop-blur-xl flex justify-between items-center px-6 py-4 w-full">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden bg-surface-container">
<img alt="user profile picture" data-alt="professional male athlete headshot with focused expression in high contrast cinematic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAS1jVWddhkt2mZuPfVs5i3jNIm69_MnYBu8kX0TtjnnU3hBUZnZU7uhrhkNiibOwiwmypNkP0QDUwmTcbvG2wl6LXssAJIeic-Uvkr0WILCcU9GW6E5ZxRfP7rkKrdo_h3YSf__FHshK6Ek-V4fgT01eWJYjAhAr99jG8wQbtngjg2f-SfozLfMTIpPx9D5GLqgNbmbfTIZA5bmDxzw0BQgjZ0qS9L3Q8rk8pDIu9HJlU351IjiOGcQE-gynGiSvz_vpwhufOaGYo"/>
</div>
<span class="text-2xl font-black text-[#d7ff00] italic font-['Lexend'] tracking-tighter uppercase">KINETIC</span>
</div>
<button class="text-[#d7ff00] hover:opacity-80 transition-opacity active:scale-95 duration-200">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<main class="pt-24 px-6 max-w-4xl mx-auto">
<!-- Page Headline -->
<div class="mb-8">
<h1 class="text-5xl font-black tracking-tight mb-2 text-on-surface opacity-90 uppercase">TREINOS</h1>
<p class="text-on-surface-variant font-medium">4 ROTINAS ATRIBUÍDAS ESTA SEMANA</p>
</div>
<!-- Filter Tags - Asymmetric Layout -->
<div class="flex gap-3 mb-10 overflow-x-auto pb-2 no-scrollbar">
<button class="px-8 py-3 bg-primary-container text-on-primary rounded-full font-bold text-sm tracking-widest uppercase active:scale-95 transition-all">Ativos</button>
<button class="px-8 py-3 bg-surface-container text-on-surface-variant rounded-full font-bold text-sm tracking-widest uppercase hover:bg-surface-container-high active:scale-95 transition-all">Anteriores</button>
</div>
<!-- Bento Grid Styled List -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<!-- Workout Card 1: Pending (Hero Style) -->
<div class="md:col-span-2 group relative overflow-hidden rounded-lg bg-surface-container-low p-1">
<div class="relative flex flex-col md:flex-row bg-surface-container rounded-lg overflow-hidden min-h-[300px]">
<div class="md:w-1/2 relative h-64 md:h-auto">
<img class="absolute inset-0 w-full h-full object-cover grayscale opacity-60 group-hover:grayscale-0 transition-all duration-700" data-alt="dramatic wide shot of professional powerlifter preparing for heavy barbell back squat in a dark industrial gym setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD-U5dddosV2ChxXlI7BoAyWm5HOe2JwdjEjYc7I-EcjMn9ZTvcGBILKbAot1rgw9HFlKRoUUAUDh2oiQ2fKcsLNhng-6tIc4vQzKWlrBJE6-tAv1KAnub6bhGjv6JyrAtHCpm4yYfQmIIMXWkprBP12ZuEDXVSUiNHjSMkBenFFHi9Ylvt-2PJjTaj63zQUR_3pH7LigiPJMMIQZcuEu1Gi8D7MUyv2cZmda5zgvCZj7I3LHGbV79WayVbASje-Qi_qzjYsW12tWE"/>
<div class="absolute inset-0 bg-gradient-to-t from-surface-container via-transparent to-transparent"></div>
<div class="absolute top-6 left-6">
<span class="bg-primary-container text-on-primary px-4 py-1.5 rounded-full text-xs font-black tracking-tighter uppercase">Next Up</span>
</div>
</div>
<div class="md:w-1/2 p-8 flex flex-col justify-between">
<div>
<h2 class="text-4xl font-black italic tracking-tighter uppercase mb-4 text-primary leading-none">Dia de Empurrar</h2>
<div class="flex items-center gap-6 text-on-surface-variant mb-6">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-secondary" data-icon="timer">timer</span>
<span class="text-sm font-bold uppercase tracking-wider">75 Min</span>
</div>
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-secondary" data-icon="fitness_center">fitness_center</span>
<span class="text-sm font-bold uppercase tracking-wider">Hipertrofia</span>
</div>
</div>
<p class="text-on-surface-variant text-sm leading-relaxed max-w-xs">Foco em volume de alta intensidade para peito, ombros e tríceps com movimentos excêntricos explosivos.</p>
</div>
<div class="mt-8">
<button class="w-full py-4 bg-primary-container text-on-primary rounded-full font-black text-lg tracking-widest uppercase hover:opacity-90 active:scale-[0.98] transition-all">Iniciar Treino</button>
</div>
</div>
</div>
</div>
<!-- Workout Card 2: Completed -->
<div class="bg-surface-container-low p-6 rounded-lg flex flex-col justify-between border-l-4 border-primary-container/20 group hover:bg-surface-container transition-colors">
<div class="flex justify-between items-start mb-12">
<div>
<h3 class="text-2xl font-bold uppercase tracking-tighter mb-2">Dia de Puxar</h3>
<div class="flex items-center gap-2 text-on-surface-variant">
<span class="material-symbols-outlined text-sm" data-icon="schedule">schedule</span>
<span class="text-xs font-bold tracking-widest uppercase">60 Min</span>
</div>
</div>
<div class="flex flex-col items-end">
<span class="bg-surface-container-highest text-primary-container p-2 rounded-full mb-2">
<span class="material-symbols-outlined" data-icon="check_circle" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</span>
<span class="text-[10px] font-black uppercase tracking-[0.2em] text-primary-container">Completed</span>
</div>
</div>
<div class="flex justify-between items-end">
<div class="flex -space-x-2">
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container flex items-center justify-center overflow-hidden">
<img alt="avatar" data-alt="close up of gym equipment handle with chalk dust" src="https://lh3.googleusercontent.com/aida-public/AB6AXuABVOfYoWwBLzOVQbl1VgcLDU2bIshAIiB7PTBYZFkzQHzBEzR4aKjOxrQK-TiK34ro34qjoNUewYhOz5a9NyMplhWp_I1VwpuMoGT1O5iqpfgHAHDSN8JhKPgMbFXetULV2Zn3Qw-1PJ94X7R4X1LWyuesBXNZ4nGNfdhglwxsahoJWHqDUZ3XhAKGAoiCRomDvDEWqV4mTrDBahnROFTetzLV0PEFk3S_XjI3ozMhwburO9cydRxJVwaeENNhtixbc2NWI6OUgBc"/>
</div>
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container flex items-center justify-center overflow-hidden">
<img alt="avatar" data-alt="close up of weight plates stacked in a gym" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCty_catCIu7qsEqByXpkNEqNUCqHKmTb3mIzZFfEFmjmT_ELhlkV1C3OlxcakXUgVmU3UmKlWZLvjKu0zmeFHWr_Ac15XmdcG6lR5U7MvG6KKLQy_by_Gi6nQuTnBPs_38GmCFkYRAAjctCqxyPXebjSIhTEWnGD9fCULX-Vu0CvtPqUkI0XhfqoS6XZx-S5vYfvaaMh2yX8V4tSwm78hxMlW6qzQeoBnlWJGfNfXuodSiEOxFyqsIhOYqclMXZe0gRyZzRZINP1A"/>
</div>
</div>
<button class="text-primary-container font-black text-xs uppercase tracking-widest group-hover:translate-x-1 transition-transform flex items-center gap-1">
                        View Summary <span class="material-symbols-outlined text-sm" data-icon="chevron_right">chevron_right</span>
</button>
</div>
</div>
<!-- Workout Card 3: Pending -->
<div class="bg-surface-container-low p-6 rounded-lg flex flex-col justify-between group hover:bg-surface-container transition-colors">
<div class="flex justify-between items-start mb-12">
<div>
<h3 class="text-2xl font-bold uppercase tracking-tighter mb-2">Dia de Pernas A</h3>
<div class="flex items-center gap-2 text-on-surface-variant">
<span class="material-symbols-outlined text-sm" data-icon="schedule">schedule</span>
<span class="text-xs font-bold tracking-widest uppercase">90 Min</span>
</div>
</div>
<div class="flex flex-col items-end">
<span class="bg-surface-container-highest text-on-surface-variant p-2 rounded-full mb-2">
<span class="material-symbols-outlined" data-icon="pending">pending</span>
</span>
<span class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface-variant">Pending</span>
</div>
</div>
<div class="flex justify-between items-end">
<div class="flex flex-col">
<span class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">Scheduled</span>
<span class="text-sm font-black uppercase italic">Tomorrow, 08:00 AM</span>
</div>
<button class="bg-surface-container-high text-on-surface px-4 py-2 rounded-full font-bold text-[10px] uppercase tracking-widest active:scale-95 transition-all">Details</button>
</div>
</div>
<!-- Workout Card 4: Past / Mobility -->
<div class="md:col-span-1 bg-surface-container-low p-6 rounded-lg flex flex-col justify-between border-l-4 border-secondary/20 group hover:bg-surface-container transition-colors">
<div class="flex justify-between items-start mb-12">
<div>
<h3 class="text-2xl font-bold uppercase tracking-tighter mb-2 text-secondary-dim">Fluxo de Mobilidade</h3>
<div class="flex items-center gap-2 text-on-surface-variant">
<span class="material-symbols-outlined text-sm" data-icon="schedule">schedule</span>
<span class="text-xs font-bold tracking-widest uppercase">20 Min</span>
</div>
</div>
<div class="flex flex-col items-end">
<span class="bg-surface-container-highest text-secondary p-2 rounded-full mb-2">
<span class="material-symbols-outlined" data-icon="restore">restore</span>
</span>
<span class="text-[10px] font-black uppercase tracking-[0.2em] text-secondary">Recuperação Ativa</span>
</div>
</div>
<button class="w-full py-3 border border-outline-variant rounded-full text-on-surface font-bold text-xs uppercase tracking-widest hover:border-secondary transition-colors">Iniciar Fluxo</button>
</div>
<!-- Empty Slot / Suggestion -->
<div class="md:col-span-1 border-2 border-dashed border-outline-variant/30 rounded-lg p-6 flex flex-col items-center justify-center text-center opacity-60 hover:opacity-100 transition-opacity">
<span class="material-symbols-outlined text-4xl mb-4 text-on-surface-variant" data-icon="add_circle">add_circle</span>
<p class="text-xs font-bold uppercase tracking-widest text-on-surface-variant">Adicionar Sessão Personalizada</p>
</div>
</div>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full flex justify-around items-center px-4 pb-6 pt-3 bg-[#0e0e0e]/90 backdrop-blur-2xl z-50 rounded-t-[2rem] border-t border-[#d7ff00]/15 shadow-[0_-8px_32px_rgba(215,255,0,0.08)]">
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined mb-1" data-icon="fitness_center">fitness_center</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest">Início</span>
</a>
<a class="flex flex-col items-center justify-center bg-[#d7ff00] text-[#0e0e0e] rounded-full px-5 py-2 active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined mb-0.5" data-icon="list_alt">list_alt</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest">Treinos</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined mb-1" data-icon="insights">insights</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest">Progresso</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined mb-1" data-icon="person">person</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest">Perfil</span>
</a>
</nav>
</body></html>

<!-- Dashboard do Personal -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>KINETIC NOIR | Painel</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@400;500;600;700;800;900&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#1a1a1a",
                        "secondary": "#00e3fd",
                        "primary-dim": "#c9ef00",
                        "surface-container-highest": "#262626",
                        "on-surface": "#ffffff",
                        "surface": "#0e0e0e",
                        "on-secondary": "#004d57",
                        "on-tertiary-container": "#5c4d00",
                        "on-secondary-fixed-variant": "#005964",
                        "surface-container-low": "#131313",
                        "secondary-fixed-dim": "#00d7f0",
                        "surface-variant": "#262626",
                        "inverse-surface": "#fcf9f8",
                        "primary-fixed-dim": "#c7ec00",
                        "on-tertiary-fixed-variant": "#685700",
                        "secondary-dim": "#00d4ec",
                        "on-primary": "#556600",
                        "tertiary-container": "#fddb42",
                        "on-secondary-container": "#e8fbff",
                        "on-error": "#450900",
                        "tertiary": "#ffeba0",
                        "surface-tint": "#f5ffc5",
                        "outline-variant": "#484847",
                        "tertiary-fixed": "#fddb42",
                        "secondary-fixed": "#26e6ff",
                        "inverse-on-surface": "#565555",
                        "on-tertiary-fixed": "#473b00",
                        "on-primary-fixed": "#3d4a00",
                        "primary": "#f5ffc5",
                        "surface-container-lowest": "#000000",
                        "on-tertiary": "#665600",
                        "on-surface-variant": "#adaaaa",
                        "on-background": "#ffffff",
                        "inverse-primary": "#556600",
                        "on-secondary-fixed": "#003a42",
                        "secondary-container": "#006875",
                        "surface-dim": "#0e0e0e",
                        "on-primary-fixed-variant": "#566800",
                        "primary-container": "#d4fb00",
                        "tertiary-fixed-dim": "#eecd34",
                        "surface-container-high": "#20201f",
                        "on-error-container": "#ffd2c8",
                        "tertiary-dim": "#eecd34",
                        "primary-fixed": "#d4fb00",
                        "error-container": "#b92902",
                        "outline": "#767575",
                        "on-primary-container": "#4d5d00",
                        "error": "#ff7351",
                        "surface-bright": "#2c2c2c",
                        "error-dim": "#d53d18",
                        "background": "#0e0e0e"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Lexend"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Inter', sans-serif; }
        h1, h2, h3, .headline { font-family: 'Lexend', sans-serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface min-h-screen pb-32">
<!-- TopAppBar -->
<header class="docked full-width top-0 sticky z-50 bg-[#0e0e0e] bg-opacity-90 backdrop-blur-xl">
<div class="flex justify-between items-center w-full px-6 py-4">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary-container">
<img alt="Trainer Profile Picture" class="w-full h-full object-cover" data-alt="Professional fitness trainer portrait with dramatic lighting in a modern dark gym setting, sharp focus" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDPdRWc7dB3ID79waohLpkWyY0Avo59RRHRWXonudwdUtKO3-CJG16EsYsRyHL0Un893Pcf6DfxAVcgzoIThsSV_Jq4jWLpI8mrQ0E1OT9qzX5NyYj2Y50M4HfS7p55Irnrd96zmaTmyZaOs-E5QAUHSN80gnMF8337EPEI_vIpOpVWf5fhtCKWOityKsJY2j5ipg8KiC0_qQX-xR4sazWcdIexSz3KZlYpQdd-jaS6_Vs_qiJCHMfpnLdzFf5ommkLJ7IUMLEQEww"/>
</div>
<span class="text-2xl font-black italic tracking-tighter text-[#d4fb00] font-['Lexend']">KINETIC NOIR</span>
</div>
<button class="text-[#d4fb00] hover:bg-[#20201f] transition-colors p-2 rounded-full active:scale-95 duration-150">
<span class="material-symbols-outlined" data-icon="settings">settings</span>
</button>
</div>
</header>
<main class="px-6 mt-8 max-w-7xl mx-auto space-y-12">
<!-- Hero Title Section -->
<section class="relative">
<h1 class="text-6xl md:text-8xl font-black tracking-tighter leading-none opacity-90 select-none pointer-events-none absolute -top-12 -left-4 text-surface-container-high z-0">PAINEL</h1>
<div class="relative z-10 pt-4">
<p class="text-primary font-bold tracking-widest uppercase text-sm mb-2">Centro de Controle do Treinador</p>
<h2 class="text-4xl font-extrabold tracking-tight">Desempenho Diário</h2>
</div>
</section>
<!-- Bento Grid Metrics -->
<section class="grid grid-cols-1 md:grid-cols-3 gap-6">
<!-- Metric 1: Active Students -->
<div class="bg-surface-container-low p-8 rounded-lg flex flex-col justify-between min-h-[220px] group transition-all hover:bg-surface-container border-l-4 border-primary-container">
<div>
<span class="material-symbols-outlined text-primary text-3xl mb-4" data-icon="group">group</span>
<p class="text-on-surface-variant font-medium tracking-wide text-xs uppercase">Total de Alunos Ativos</p>
</div>
<div class="flex items-baseline gap-2">
<span class="text-6xl font-black font-headline">24</span>
<span class="text-primary-dim font-bold text-sm">+2 esta semana</span>
</div>
</div>
<!-- Metric 2: Trained Today -->
<div class="bg-surface-container-low p-8 rounded-lg flex flex-col justify-between min-h-[220px] group transition-all hover:bg-surface-container relative overflow-hidden">
<div class="absolute right-0 top-0 w-32 h-32 bg-primary-container/5 rounded-full -mr-16 -mt-16"></div>
<div>
<span class="material-symbols-outlined text-secondary text-3xl mb-4" data-icon="bolt">bolt</span>
<p class="text-on-surface-variant font-medium tracking-wide text-xs uppercase">Treinaram Hoje</p>
</div>
<div class="flex items-baseline gap-2">
<span class="text-6xl font-black font-headline">18</span>
<div class="w-16 h-2 bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full bg-gradient-to-r from-primary to-secondary w-3/4"></div>
</div>
</div>
</div>
<!-- Metric 3: Alerts (Inactive) -->
<div class="bg-surface-container-low p-8 rounded-lg flex flex-col justify-between min-h-[220px] group transition-all hover:bg-surface-container border-l-4 border-error">
<div>
<span class="material-symbols-outlined text-error text-3xl mb-4" data-icon="warning" style="font-variation-settings: 'FILL' 1;">warning</span>
<p class="text-on-surface-variant font-medium tracking-wide text-xs uppercase">Inativos &gt; 3 Dias</p>
</div>
<div class="flex items-baseline gap-4">
<span class="text-6xl font-black font-headline text-error">3</span>
<button class="bg-error-container text-on-error-container px-4 py-2 rounded-full text-xs font-bold uppercase tracking-widest active:scale-95 transition-transform">Notificar Todos</button>
</div>
</div>
</section>
<!-- Secondary Layout: Activity & Quick Actions -->
<section class="grid grid-cols-1 lg:grid-cols-12 gap-8">
<!-- Activity Feed (8 cols) -->
<div class="lg:col-span-8 space-y-6">
<div class="flex justify-between items-end mb-4">
<h3 class="text-2xl font-bold tracking-tight">Feed de Atividades Recentes</h3>
<span class="text-primary text-sm font-semibold cursor-pointer hover:underline">Ver Todos os Logs</span>
</div>
<div class="space-y-4">
<!-- Activity Item 1 -->
<div class="bg-surface-container p-6 rounded-md flex items-center justify-between group hover:bg-surface-container-high transition-colors">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-surface-container-highest flex items-center justify-center border border-outline-variant/20">
<span class="material-symbols-outlined text-primary" data-icon="person">person</span>
</div>
<div>
<h4 class="font-bold text-lg">Marcus Thorne</h4>
<p class="text-on-surface-variant text-sm">Completou <span class="text-on-surface font-medium">Fluxo de Mobilidade &amp; Core</span></p>
</div>
</div>
<div class="text-right">
<p class="text-primary-dim font-black text-xl">842 <span class="text-[10px] uppercase text-on-surface-variant">kcal</span></p>
<p class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest">45 minutos atrás</p>
</div>
</div>
<!-- Activity Item 2 -->
<div class="bg-surface-container p-6 rounded-md flex items-center justify-between group hover:bg-surface-container-high transition-colors">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-surface-container-highest flex items-center justify-center border border-outline-variant/20">
<span class="material-symbols-outlined text-secondary" data-icon="person">person</span>
</div>
<div>
<h4 class="font-bold text-lg">Elena Rodriguez</h4>
<p class="text-on-surface-variant text-sm">Completou <span class="text-on-surface font-medium">Fluxo de Mobilidade &amp; Core</span></p>
</div>
</div>
<div class="text-right">
<p class="text-primary-dim font-black text-xl">310 <span class="text-[10px] uppercase text-on-surface-variant">kcal</span></p>
<p class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest">45 minutos atrás</p>
</div>
</div>
<!-- Activity Item 3 -->
<div class="bg-surface-container p-6 rounded-md flex items-center justify-between group hover:bg-surface-container-high transition-colors">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-surface-container-highest flex items-center justify-center border border-outline-variant/20">
<span class="material-symbols-outlined text-on-surface" data-icon="person">person</span>
</div>
<div>
<h4 class="font-bold text-lg">David Chen</h4>
<p class="text-on-surface-variant text-sm">Completou <span class="text-on-surface font-medium">Dia de Tração Pesada</span></p>
</div>
</div>
<div class="text-right">
<p class="text-primary-dim font-black text-xl">1,120 <span class="text-[10px] uppercase text-on-surface-variant">kcal</span></p>
<p class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest">2 horas atrás</p>
</div>
</div>
</div>
</div>
<!-- Side Rail (4 cols) -->
<div class="lg:col-span-4 space-y-6">
<div class="bg-primary-container p-8 rounded-lg text-on-primary h-full flex flex-col justify-between">
<div>
<h3 class="text-3xl font-black italic tracking-tighter leading-none mb-4">TREINE COMO UMA MÁQUINA.</h3>
<p class="font-medium text-sm leading-relaxed opacity-90 mb-8">Pronto para arquitetar novos protocolos? Crie treinos personalizados ou verifique o progresso dos alunos.</p>
</div>
<div class="space-y-3">
<button class="w-full bg-on-primary text-primary-container font-bold py-4 rounded-full active:scale-95 transition-transform flex items-center justify-center gap-2"><span class="material-symbols-outlined" data-icon="add">add</span> NOVO TREINO</button>
<button class="w-full border-2 border-on-primary/30 text-on-primary font-bold py-4 rounded-full active:scale-95 transition-transform">LISTA DE ALUNOS</button>
</div>
</div>
</div>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 left-0 w-full flex justify-around items-center px-4 py-3 pb-8 bg-[#0e0e0e]/80 backdrop-blur-md z-50 shadow-[0_-8px_32px_rgba(215,255,0,0.08)]">
<!-- Dashboard Active -->
<a class="flex flex-col items-center justify-center text-[#d4fb00] bg-[#d4fb00]/10 rounded-full px-5 py-2 active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined" data-icon="dashboard" style="font-variation-settings: 'FILL' 1;">dashboard</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">PAINEL</span>
</a>
<!-- Students Inactive -->
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined" data-icon="group">group</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">ALUNOS</span>
</a>
<!-- Builder Inactive -->
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined" data-icon="fitness_center">fitness_center</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">TREINOS</span>
</a>
<!-- History Inactive -->
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined" data-icon="history_toggle_off">history_toggle_off</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">HISTÓRICO</span>
</a>
</nav>
<!-- Contextual FAB -->
<button class="fixed bottom-28 right-6 w-16 h-16 bg-primary-container text-on-primary-container rounded-full shadow-2xl flex items-center justify-center active:scale-90 transition-transform duration-200 z-40">
<span class="material-symbols-outlined text-3xl" data-icon="bolt" style="font-variation-settings: 'FILL' 1;">bolt</span>
</button>
</body></html>

<!-- Progresso e Histórico -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>KINETIC - Progresso &amp; Histórico</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&amp;family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-error-container": "#ffd2c8",
                    "outline": "#767575",
                    "inverse-surface": "#fcf9f8",
                    "error": "#ff7351",
                    "surface-container-lowest": "#000000",
                    "inverse-on-surface": "#565555",
                    "on-secondary": "#004d57",
                    "outline-variant": "#484847",
                    "surface-container-low": "#131313",
                    "on-tertiary-fixed-variant": "#685700",
                    "on-background": "#ffffff",
                    "surface-container": "#1a1a1a",
                    "surface-dim": "#0e0e0e",
                    "primary-container": "#d4fb00",
                    "tertiary-fixed": "#fddb42",
                    "on-error": "#450900",
                    "background": "#0e0e0e",
                    "on-surface-variant": "#adaaaa",
                    "secondary-dim": "#00d4ec",
                    "secondary-container": "#006875",
                    "on-tertiary-fixed": "#473b00",
                    "on-secondary-fixed": "#003a42",
                    "on-surface": "#ffffff",
                    "tertiary": "#ffeba0",
                    "surface-bright": "#2c2c2c",
                    "primary-fixed": "#d4fb00",
                    "surface-container-highest": "#262626",
                    "tertiary-container": "#fddb42",
                    "primary": "#f5ffc5",
                    "on-secondary-container": "#e8fbff",
                    "inverse-primary": "#556600",
                    "secondary-fixed": "#26e6ff",
                    "surface-container-high": "#20201f",
                    "secondary-fixed-dim": "#00d7f0",
                    "error-container": "#b92902",
                    "surface": "#0e0e0e",
                    "surface-variant": "#262626",
                    "on-tertiary": "#665600",
                    "primary-fixed-dim": "#c7ec00",
                    "on-primary": "#556600",
                    "tertiary-fixed-dim": "#eecd34",
                    "primary-dim": "#c9ef00",
                    "on-tertiary-container": "#5c4d00",
                    "on-secondary-fixed-variant": "#005964",
                    "tertiary-dim": "#eecd34",
                    "on-primary-fixed": "#3d4a00",
                    "error-dim": "#d53d18",
                    "on-primary-container": "#4d5d00",
                    "surface-tint": "#f5ffc5",
                    "secondary": "#00e3fd",
                    "on-primary-fixed-variant": "#566800"
            },
            "borderRadius": {
                    "DEFAULT": "1rem",
                    "lg": "2rem",
                    "xl": "3rem",
                    "full": "9999px"
            },
            "fontFamily": {
                    "headline": ["Lexend"],
                    "body": ["Inter"],
                    "label": ["Inter"]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Inter', sans-serif; }
        h1, h2, h3 { font-family: 'Lexend', sans-serif; }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface min-h-screen pb-32">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-[#0e0e0e]/80 backdrop-blur-xl flex justify-between items-center px-6 py-4 w-full">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden bg-surface-container">
<img alt="Profile" class="w-full h-full object-cover" data-alt="Close up portrait of a fit athlete with dramatic lighting in a dark gym environment, high contrast noir style" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAcMjQegbt9xfER_3n_A46THgbB_MyBv-y5EFUoxs_PKnvsVGtDQWrUXYeymLgm9VR1WScEUIkktOUuKJ_eLDHjduvlLsFLWeZlLpQ5xbw1QeZKg95-AkToY81OMpNA9m8mgWMEdbV8GCacXYQRgywAGkI8rfGZFE5Z8zOAqppDXbh-B8pg0W22ke82g7nBhGHp8CTqZFusgpQSbkzgMiiRQCMgVJaumBkI_n9Ol9U7v--wp4VfXW7_K-J1_VVqS4b91JtVcplZQZU"/>
</div>
<span class="font-['Lexend'] tracking-tighter uppercase text-2xl font-black text-[#d7ff00] italic">KINETIC</span>
</div>
<button class="text-[#d7ff00] hover:opacity-80 transition-opacity active:scale-95 duration-200">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<main class="pt-24 px-6 max-w-4xl mx-auto space-y-8">
<!-- Monthly Calendar Section -->
<section class="space-y-4">
<div class="flex justify-between items-end">
<h2 class="text-display-md text-3xl font-bold tracking-tight opacity-90">OUTUBRO</h2>
<p class="text-on-surface-variant font-label text-sm uppercase tracking-widest">14 SESSÕES</p>
</div>
<div class="bg-surface-container-low p-6 rounded-lg">
<div class="grid grid-cols-7 gap-2 mb-4">
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Seg</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Ter</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Qua</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Qui</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Sex</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Sáb</div>
<div class="text-center text-on-surface-variant text-[10px] font-bold uppercase">Dom</div>
</div>
<div class="grid grid-cols-7 gap-y-6 gap-x-2">
<!-- Example Calendar Days -->
<div class="flex flex-col items-center gap-1 opacity-20">Seg</div>
<div class="flex flex-col items-center gap-1 opacity-20">Ter</div>
<div class="flex flex-col items-center gap-1 opacity-20">Qua</div>
<div class="flex flex-col items-center gap-1">Qui</div>
<div class="flex flex-col items-center gap-1">Sex</div>
<div class="flex flex-col items-center gap-1">Sáb</div>
<div class="flex flex-col items-center gap-1">Dom</div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">5</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">6</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">7</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">8</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">9</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">10</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">11</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">12</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">13</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm font-bold text-primary-container">14</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">15</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">16</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">17</span></div>
<div class="flex flex-col items-center gap-1"><span class="text-sm">18</span><div class="w-1.5 h-1.5 bg-primary-container rounded-full">Ter</div></div>
</div>
</div>
</section>
<!-- Charts Bento Grid -->
<section class="grid grid-cols-1 md:grid-cols-2 gap-4">
<!-- Body Weight Evolution -->
<div class="bg-surface-container p-6 rounded-lg space-y-4">
<div>
<h3 class="text-on-surface-variant font-label text-xs uppercase tracking-widest mb-1">Peso Corporal</h3>
<p class="text-2xl font-bold">84.2 <span class="text-sm font-normal text-on-surface-variant">KG</span></p>
</div>
<div class="h-32 flex items-end justify-between gap-1">
<div class="w-full bg-surface-container-highest rounded-t-full h-[60%]"></div>
<div class="w-full bg-surface-container-highest rounded-t-full h-[55%]"></div>
<div class="w-full bg-surface-container-highest rounded-t-full h-[58%]"></div>
<div class="w-full bg-primary-container rounded-t-full h-[50%]"></div>
<div class="w-full bg-surface-container-highest rounded-t-full h-[48%]"></div>
<div class="w-full bg-surface-container-highest rounded-t-full h-[45%]"></div>
<div class="w-full bg-secondary-container rounded-t-full h-[42%]"></div>
</div>
<div class="flex justify-between text-[10px] text-on-surface-variant uppercase font-bold">
<span>20 Set</span>
<span>14 Out</span>
</div>
</div>
<!-- Volume per Muscle Group -->
<div class="bg-surface-container p-6 rounded-lg space-y-4">
<h3 class="text-on-surface-variant font-label text-xs uppercase tracking-widest">Volume de Treino</h3>
<div class="space-y-3">
<div class="space-y-1">
<div class="flex justify-between text-[10px] uppercase font-bold">
<span>20 Set</span>
<span>14 Out</span>
</div>
<div class="w-full h-2 bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full bg-primary-container rounded-full w-[42%]"></div>
</div>
</div>
<div class="space-y-1">
<div class="flex justify-between text-[10px] uppercase font-bold">
<span>20 Set</span>
<span>14 Out</span>
</div>
<div class="w-full h-2 bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full bg-secondary-fixed rounded-full w-[35%]"></div>
</div>
</div>
<div class="space-y-1">
<div class="flex justify-between text-[10px] uppercase font-bold">
<span>20 Set</span>
<span>14 Out</span>
</div>
<div class="w-full h-2 bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full bg-primary rounded-full w-[23%]"></div>
</div>
</div>
</div>
</div>
</section>
<!-- Personal Records Section -->
<section class="space-y-6">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[#d7ff00]" style="font-variation-settings: 'FILL' 1;">workspace_premium</span>
<h2 class="text-xl font-bold uppercase tracking-tight">Recordes Recentes</h2>
</div>
<div class="space-y-3">
<!-- PR Card 1 -->
<div class="bg-surface-container flex items-center p-5 rounded-lg border-l-4 border-primary-container">
<div class="flex-1">
<h4 class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest mb-1">Supino</h4>
<p class="text-lg font-bold">120 KG <span class="text-primary-container text-xs ml-2">+5KG</span></p>
</div>
<div class="text-right">
<span class="text-[10px] text-on-surface-variant block mb-1">Oct 12, 2023</span>
<span class="material-symbols-outlined text-primary-container text-lg" data-icon="trending_up">trending_up</span>
</div>
</div>
<!-- PR Card 2 -->
<div class="bg-surface-container flex items-center p-5 rounded-lg border-l-4 border-secondary-fixed">
<div class="flex-1">
<h4 class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest mb-1">Levantamento Terra</h4>
<p class="text-lg font-bold">185 KG <span class="text-secondary-fixed text-xs ml-2">+10KG</span></p>
</div>
<div class="text-right">
<span class="text-[10px] text-on-surface-variant block mb-1">Oct 08, 2023</span>
<span class="material-symbols-outlined text-secondary-fixed text-lg" data-icon="trending_up">trending_up</span>
</div>
</div>
<!-- PR Card 3 -->
<div class="bg-surface-container flex items-center p-5 rounded-lg border-l-4 border-primary">
<div class="flex-1">
<h4 class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest mb-1">Barra Fixa com Carga</h4>
<p class="text-lg font-bold">35 KG <span class="text-primary text-xs ml-2">+2.5KG</span></p>
</div>
<div class="text-right">
<span class="text-[10px] text-on-surface-variant block mb-1">Oct 05, 2023</span>
<span class="material-symbols-outlined text-primary text-lg" data-icon="trending_up">trending_up</span>
</div>
</div>
</div>
</section>
<!-- History Preview (Extra Value Add) -->
<section class="space-y-4">
<h2 class="text-xl font-bold uppercase tracking-tight">Atividade Recente</h2>
<div class="grid grid-cols-1 gap-2">
<div class="bg-surface-container-low p-4 rounded-lg flex items-center gap-4">
<div class="bg-surface-container-highest w-12 h-12 rounded-full flex items-center justify-center">
<span class="material-symbols-outlined text-primary-container" data-icon="fitness_center">fitness_center</span>
</div>
<div>
<p class="font-bold">Treino de Empurrar Pesado</p>
<p class="text-xs text-on-surface-variant">Ontem • 1h 12m • 345 kcal</p>
</div>
</div>
</div>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full flex justify-around items-center px-4 pb-6 pt-3 bg-[#0e0e0e]/90 backdrop-blur-2xl z-50 rounded-t-[2rem] border-t border-[#d7ff00]/15 shadow-[0_-8px_32px_rgba(215,255,0,0.08)]">
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="fitness_center">fitness_center</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Início</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="list_alt">list_alt</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Treinos</span>
</a>
<!-- Active Item: Progress -->
<a class="flex flex-col items-center justify-center bg-[#d7ff00] text-[#0e0e0e] rounded-full px-5 py-2 active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="insights" style="font-variation-settings: 'FILL' 1;">insights</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest">Progresso</span>
</a>
<a class="flex flex-col items-center justify-center text-neutral-400 p-2 hover:text-[#d7ff00] transition-colors active:scale-90 duration-300 ease-out" href="#">
<span class="material-symbols-outlined" data-icon="person">person</span>
<span class="font-['Lexend'] text-[10px] font-bold uppercase tracking-widest mt-1">Perfil</span>
</a>
</nav>
</body></html>

<!-- Meus Alunos -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800;900&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#1a1a1a",
                        "secondary": "#00e3fd",
                        "primary-dim": "#c9ef00",
                        "surface-container-highest": "#262626",
                        "on-surface": "#ffffff",
                        "surface": "#0e0e0e",
                        "on-secondary": "#004d57",
                        "on-tertiary-container": "#5c4d00",
                        "on-secondary-fixed-variant": "#005964",
                        "surface-container-low": "#131313",
                        "secondary-fixed-dim": "#00d7f0",
                        "surface-variant": "#262626",
                        "inverse-surface": "#fcf9f8",
                        "primary-fixed-dim": "#c7ec00",
                        "on-tertiary-fixed-variant": "#685700",
                        "secondary-dim": "#00d4ec",
                        "on-primary": "#556600",
                        "tertiary-container": "#fddb42",
                        "on-secondary-container": "#e8fbff",
                        "on-error": "#450900",
                        "tertiary": "#ffeba0",
                        "surface-tint": "#f5ffc5",
                        "outline-variant": "#484847",
                        "tertiary-fixed": "#fddb42",
                        "secondary-fixed": "#26e6ff",
                        "inverse-on-surface": "#565555",
                        "on-tertiary-fixed": "#473b00",
                        "on-primary-fixed": "#3d4a00",
                        "primary": "#f5ffc5",
                        "surface-container-lowest": "#000000",
                        "on-tertiary": "#665600",
                        "on-surface-variant": "#adaaaa",
                        "on-background": "#ffffff",
                        "inverse-primary": "#556600",
                        "on-secondary-fixed": "#003a42",
                        "secondary-container": "#006875",
                        "surface-dim": "#0e0e0e",
                        "on-primary-fixed-variant": "#566800",
                        "primary-container": "#d4fb00",
                        "tertiary-fixed-dim": "#eecd34",
                        "surface-container-high": "#20201f",
                        "on-error-container": "#ffd2c8",
                        "tertiary-dim": "#eecd34",
                        "primary-fixed": "#d4fb00",
                        "error-container": "#b92902",
                        "outline": "#767575",
                        "on-primary-container": "#4d5d00",
                        "error": "#ff7351",
                        "surface-bright": "#2c2c2c",
                        "error-dim": "#d53d18",
                        "background": "#0e0e0e"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Lexend"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
<style>
        body { font-family: 'Inter', sans-serif; }
        h1, h2, h3, .headline { font-family: 'Lexend', sans-serif; }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface min-h-screen pb-32">
<!-- TopAppBar -->
<header class="bg-[#0e0e0e] text-[#d4fb00] font-['Lexend'] font-bold tracking-tight docked full-width top-0 sticky z-50 bg-[#131313] flat no shadows flex justify-between items-center w-full px-6 py-4 bg-opacity-90 backdrop-blur-xl">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full overflow-hidden bg-surface-container-highest ring-2 ring-primary-container/20">
<img alt="Trainer Profile Picture" class="w-full h-full object-cover" data-alt="Close up portrait of a professional athletic trainer with a determined expression in a dark moody gym setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDiy7WRcZBzencR26wYYh29bTyVygmpCfnDXZHJ120GzAOGkhNLpAjp6ULGxNIqoF5uid83vWzOXtXQ9HzDkxzMScpl8mkTIdGpRQOqUhTAevqJZWL863jgYP0H-VQyv1s8NertXhgdCkwbOshzSkDCUB_Jgu0L4sJfYnyBJt3Bc_7hI3jMfNW5gRnOqS-s8eZL4jnhfEPNugMBUi4YjEa4clM8_TiDIsP36cuDE-oDbhjQ7saQCa7eLHSv6uT-RIdJLPgULgIkmw4"/>
</div>
<span class="text-2xl font-black italic tracking-tighter text-[#d4fb00]">KINETIC NOIR</span>
</div>
<button class="hover:bg-[#20201f] transition-colors active:scale-95 duration-150 p-2 rounded-full">
<span class="material-symbols-outlined text-[#d4fb00]">settings</span>
</button>
</header>
<main class="px-6 pt-8 max-w-5xl mx-auto">
<!-- Hero Section & Search -->
<div class="mb-12">
<h1 class="text-5xl font-black tracking-tighter headline mb-6 text-on-surface">Meus Alunos</h1>
<div class="relative group">
<div class="absolute inset-y-0 left-5 flex items-center pointer-events-none">
<span class="material-symbols-outlined text-on-surface-variant">search</span>
</div>
<input class="w-full bg-surface-container border-none rounded-full py-5 pl-14 pr-6 text-on-surface placeholder:text-on-surface-variant focus:ring-2 focus:ring-primary-container/30 transition-all font-label text-sm tracking-widest uppercase" placeholder="BUSCAR NOME OU OBJETIVO..." type="text"/>
</div>
</div>
<!-- Student Grid -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<!-- Student Card 1 -->
<div class="bg-surface-container-low p-6 rounded-lg relative overflow-hidden group hover:bg-surface-container-high transition-all duration-300">
<div class="flex items-start justify-between relative z-10">
<div class="flex gap-4">
<div class="w-16 h-16 rounded-full overflow-hidden bg-surface-container-highest">
<img alt="Student 1" class="w-full h-full object-cover" data-alt="Portrait of a young woman with athletic gear looking confident in a high-end fitness studio" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCGtFREAPZMP3Q7mnkpQXiCuHq1oJojPfLVmd85qqFvZzM3VJFNeO38LrupVWRMcO8nJnyNBlrKRw8hj803sRDsz7LrVmUFqkIYvuNgxDfWYmCGmGd4UXYtbUQMfuQKO_o0XeHAhdC2d3fR1R_4yoT7044VEydjfALWMQYN6DH4ybUNqPgVYGzKyxrfLkXkbwo40QQrZ-KivGvUdF8XSqBxwIYzljYa73pskgEF2LdugKWqt0a9xM3U8UklGWikP5rEDz9udJwC3iY"/>
</div>
<div>
<h3 class="text-xl font-bold headline mb-1 uppercase tracking-tight">Marcus Vinicius</h3>
<div class="flex items-center gap-2 mb-3">
<span class="bg-primary-container text-on-primary px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-tighter">Hipertrofia</span>
</div>
<div class="flex flex-col gap-1">
<span class="text-[10px] text-on-surface-variant uppercase font-bold tracking-widest">Último Treino</span>
<span class="text-sm font-medium">Hoje, 08:30</span>
</div>
</div>
</div>
<!-- Adherence Ring -->
<div class="relative w-20 h-20 flex items-center justify-center">
<svg class="w-full h-full -rotate-90">
<circle class="text-surface-container-highest" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-width="6"></circle>
<circle class="text-primary-container" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-dasharray="201" stroke-dashoffset="20" stroke-width="6"></circle>
</svg>
<div class="absolute flex flex-col items-center">
<span class="text-xs font-black headline text-primary">90%</span>
<span class="text-[8px] text-on-surface-variant uppercase font-bold">ADR</span>
</div>
</div>
</div>
<!-- Asymmetric background accent -->
<div class="absolute top-0 right-0 w-32 h-32 bg-primary-container/5 rounded-full -mr-16 -mt-16 blur-2xl"></div>
</div>
<!-- Student Card 2 -->
<div class="bg-surface-container-low p-6 rounded-lg relative overflow-hidden group hover:bg-surface-container-high transition-all duration-300">
<div class="flex items-start justify-between relative z-10">
<div class="flex gap-4">
<div class="w-16 h-16 rounded-full overflow-hidden bg-surface-container-highest">
<img alt="Student 2" class="w-full h-full object-cover" data-alt="Portrait of a fit middle aged man smiling in a professional gym environment" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAgExaBQ6ZoxRG9jaeL_zAFKwSY470Anf-GDmx6P4HpMqXFOtpOy91rvMjqiGnxZKFXZ0vvJaEyVnAzOT-r52PEwmd1dBczIs5c3G7rU5OXrl1XrqhVqq3Gzb4J-1TPFUX9arqme2AWgihCMyUKR6XizV-snflcTvCfuZwY0G3Rl6chWC2ZUVvQKoFGXaWI4L0obSAHUk6L2Rv0qpQXnapALUTjnn4O16ggDoti5YoAeVDcMb3_dKfw1DgiJtPcxOpNHFmygY9MeNU"/>
</div>
<div>
<h3 class="text-xl font-bold headline mb-1 uppercase tracking-tight">Julia Santos</h3>
<div class="flex items-center gap-2 mb-3">
<span class="bg-secondary-container text-on-secondary-container px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-tighter">Performance</span>
</div>
<div class="flex flex-col gap-1">
<span class="text-[10px] text-on-surface-variant uppercase font-bold tracking-widest">Último Treino</span>
<span class="text-sm font-medium">Ontem, 19:45</span>
</div>
</div>
</div>
<div class="relative w-20 h-20 flex items-center justify-center">
<svg class="w-full h-full -rotate-90">
<circle class="text-surface-container-highest" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-width="6"></circle>
<circle class="text-secondary" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-dasharray="201" stroke-dashoffset="80" stroke-width="6"></circle>
</svg>
<div class="absolute flex flex-col items-center">
<span class="text-xs font-black headline text-secondary">62%</span>
<span class="text-[8px] text-on-surface-variant uppercase font-bold">ADR</span>
</div>
</div>
</div>
</div>
<!-- Student Card 3 -->
<div class="bg-surface-container-low p-6 rounded-lg relative overflow-hidden group hover:bg-surface-container-high transition-all duration-300">
<div class="flex items-start justify-between relative z-10">
<div class="flex gap-4">
<div class="w-16 h-16 rounded-full overflow-hidden bg-surface-container-highest">
<img alt="Student 3" class="w-full h-full object-cover" data-alt="Close up profile of a focused athlete with sweat on skin in a dark gym" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDhFaC6wkyck-m0Q3lGkTo0ys-yA_WJZ3BOZtfXYXgqzWdRoW0fowaRCcypJxYSH9rm7feBVeJ1AkCZnBsE6ZIld0bAfgZouqIskKhZ18ac_pYNBNUqqByyLeDU9WTCKOBYSNDez7SrJW-q3Qa3z7TBrTihPd5vaURhc5oRRDZdB17TvcLCyraQONfyVHt32vZ4srw98K2x7J5ZMNzNB3IINA9-ea9LS4b8SgcDLXm31ybJ3DtqnC_g6WV4diouHGRUYW2YmMAFmbI"/>
</div>
<div>
<h3 class="text-xl font-bold headline mb-1 uppercase tracking-tight">Roberto Lima</h3>
<div class="flex items-center gap-2 mb-3">
<span class="bg-primary-container text-on-primary px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-tighter">Hipertrofia</span>
</div>
<div class="flex flex-col gap-1">
<span class="text-[10px] text-on-surface-variant uppercase font-bold tracking-widest">Último Treino</span>
<span class="text-sm font-medium">3 dias atrás</span>
</div>
</div>
</div>
<div class="relative w-20 h-20 flex items-center justify-center">
<svg class="w-full h-full -rotate-90">
<circle class="text-surface-container-highest" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-width="6"></circle>
<circle class="text-primary-container" cx="40" cy="40" fill="transparent" r="32" stroke="currentColor" stroke-dasharray="201" stroke-dashoffset="110" stroke-width="6"></circle>
</svg>
<div class="absolute flex flex-col items-center">
<span class="text-xs font-black headline text-primary">45%</span>
<span class="text-[8px] text-on-surface-variant uppercase font-bold">ADR</span>
</div>
</div>
</div>
</div>
<!-- Add Student CTA Card -->
<button class="border-2 border-dashed border-outline-variant hover:border-primary-container/50 hover:bg-primary-container/5 transition-all p-6 rounded-lg flex flex-col items-center justify-center gap-3 text-on-surface-variant hover:text-primary-container group active:scale-95 duration-200">
<div class="w-12 h-12 rounded-full bg-surface-container-highest flex items-center justify-center group-hover:bg-primary-container group-hover:text-on-primary transition-colors">
<span class="material-symbols-outlined text-3xl">add</span>
</div>
<span class="font-black uppercase tracking-[0.2em] text-xs">ADICIONAR NOVO ALUNO</span>
</button>
</div>
</main>
<!-- Floating Action Button (As per guidance, only if it aligns perfectly) -->
<button class="fixed right-6 bottom-32 w-16 h-16 bg-primary-container text-on-primary rounded-full shadow-[0_8px_32px_rgba(215,255,0,0.3)] flex items-center justify-center active:scale-90 transition-transform duration-200 z-[60]">
<span class="material-symbols-outlined text-3xl">person_add</span>
</button>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 backdrop-blur-md bg-[#0e0e0e]/80 shadow-[0_-8px_32px_rgba(215,255,0,0.08)] fixed bottom-0 left-0 w-full flex justify-around items-center px-4 py-3 pb-8">
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined">dashboard</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">PAINEL</span>
</a>
<a class="flex flex-col items-center justify-center text-[#d4fb00] bg-[#d4fb00]/10 rounded-full px-5 py-2 active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">group</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">ALUNOS</span>
</a>
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">TREINOS</span>
</a>
<a class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200" href="#">
<span class="material-symbols-outlined">history_toggle_off</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest mt-1">HISTÓRICO</span>
</a>
</nav>
</body></html>

<!-- Perfil do Aluno (Vista Personal) -->
<!DOCTYPE html>

<html class="dark" lang="pt-br"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;700;800;900&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#1a1a1a",
                        "secondary": "#00e3fd",
                        "primary-dim": "#c9ef00",
                        "surface-container-highest": "#262626",
                        "on-surface": "#ffffff",
                        "surface": "#0e0e0e",
                        "on-secondary": "#004d57",
                        "on-tertiary-container": "#5c4d00",
                        "on-secondary-fixed-variant": "#005964",
                        "surface-container-low": "#131313",
                        "secondary-fixed-dim": "#00d7f0",
                        "surface-variant": "#262626",
                        "inverse-surface": "#fcf9f8",
                        "primary-fixed-dim": "#c7ec00",
                        "on-tertiary-fixed-variant": "#685700",
                        "secondary-dim": "#00d4ec",
                        "on-primary": "#556600",
                        "tertiary-container": "#fddb42",
                        "on-secondary-container": "#e8fbff",
                        "on-error": "#450900",
                        "tertiary": "#ffeba0",
                        "surface-tint": "#f5ffc5",
                        "outline-variant": "#484847",
                        "tertiary-fixed": "#fddb42",
                        "secondary-fixed": "#26e6ff",
                        "inverse-on-surface": "#565555",
                        "on-tertiary-fixed": "#473b00",
                        "on-primary-fixed": "#3d4a00",
                        "primary": "#f5ffc5",
                        "surface-container-lowest": "#000000",
                        "on-tertiary": "#665600",
                        "on-surface-variant": "#adaaaa",
                        "on-background": "#ffffff",
                        "inverse-primary": "#556600",
                        "on-secondary-fixed": "#003a42",
                        "secondary-container": "#006875",
                        "surface-dim": "#0e0e0e",
                        "on-primary-fixed-variant": "#566800",
                        "primary-container": "#d4fb00",
                        "tertiary-fixed-dim": "#eecd34",
                        "surface-container-high": "#20201f",
                        "on-error-container": "#ffd2c8",
                        "tertiary-dim": "#eecd34",
                        "primary-fixed": "#d4fb00",
                        "error-container": "#b92902",
                        "outline": "#767575",
                        "on-primary-container": "#4d5d00",
                        "error": "#ff7351",
                        "surface-bright": "#2c2c2c",
                        "error-dim": "#d53d18",
                        "background": "#0e0e0e"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Lexend"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
<style>
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .text-glow { text-shadow: 0 0 15px rgba(212, 251, 0, 0.4); }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface font-body selection:bg-primary-container selection:text-on-primary-container">
<!-- TopAppBar Execution -->
<nav class="bg-[#0e0e0e] bg-opacity-90 backdrop-blur-xl flex justify-between items-center w-full px-6 py-4 docked full-width top-0 sticky z-50">
<div class="flex items-center gap-4">
<div class="w-10 h-10 rounded-full bg-surface-container-high flex items-center justify-center overflow-hidden border-2 border-primary-container">
<img alt="Trainer Profile Picture" class="w-full h-full object-cover" data-alt="Close-up portrait of a fit professional fitness trainer in a dark gym setting with dramatic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBxRtYYhyylv-OijULDAqDE81jD7ig1LeJaslhU-J-3i082-D3N8KyS7ObLAkuTN2Z6PY3Pq2B4SrwGTvGGnov6vZLJzigBrR79CDSFnMDD7aB6nJZvcahKe_Ll2_HOQwoSp43JlU4vsLjCUvfOFsvt4T0pWHwOCAy41BEUkwPtfKy5kekKd877Dsj8DwbTh8bo09c1sK541TqiH-2ngGo-cWQQ1ZZSKJOtPNtBptVusYhJoyBj5LGfZSWrO6UsKkpvQFCl7YwqcuU"/>
</div>
<h1 class="text-2xl font-black italic tracking-tighter text-[#d4fb00] font-['Lexend']">KINETIC NOIR</h1>
</div>
<button class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-[#20201f] transition-colors active:scale-95 duration-150 text-[#d4fb00]">
<span class="material-symbols-outlined">settings</span>
</button>
</nav>
<main class="pb-32 max-w-7xl mx-auto px-6 space-y-8">
<!-- Profile Header Section -->
<header class="pt-8">
<div class="flex flex-col md:flex-row md:items-end gap-6">
<div class="relative">
<div class="w-32 h-32 md:w-48 md:h-48 rounded-lg overflow-hidden bg-surface-container">
<img alt="Student Portrait" class="w-full h-full object-cover grayscale hover:grayscale-0 transition-all duration-500" data-alt="Athletic young man Alex Silva training in a high-end fitness studio, focused expression, dark moody background" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAHmdun2vbDMJDUNioaFFDzHU2k9DTo6Di1vUnQ34Acmm4iofy8HJRIsrcsXE39ckSOrWYxoWUEgyhqnh3thjxmuMZaKJMWoU2SPFtHFohoKk8id3jWnR9VAJh8SEslA3GJLyBZYzhT9WLA_THwQHZRiSqIlJ0dtB16Y9W-XRXE6JCK7_TKVPv-SN13BhYcjtIlg2HYqdXW5kn1WYaY8EtlRQNGUfRXgOOHLmCV1sqEazz8cLjf-Z58PMdZE_exTtR9l8fcnQ-EaB8"/>
</div>
<div class="absolute -bottom-2 -right-2 bg-primary-container text-on-primary px-3 py-1 text-xs font-black italic tracking-tighter rounded-full">
                        PRO ELITE
                    </div>
</div>
<div class="flex-1 space-y-2">
<span class="text-primary font-headline font-bold tracking-widest text-sm uppercase opacity-60">PERFIL DO ALUNO</span>
<h2 class="text-6xl md:text-8xl font-headline font-black tracking-tighter leading-none">Alex Silva</h2>
<div class="flex flex-wrap gap-4 pt-4">
<div class="bg-surface-container-low px-4 py-2 rounded-full border border-outline-variant/15">
<span class="text-on-surface-variant text-xs uppercase font-bold tracking-widest block">Objetivo</span>
<span class="text-on-surface font-medium">Hipertrofia &amp; Força</span>
</div>
<div class="bg-surface-container-low px-4 py-2 rounded-full border border-outline-variant/15">
<span class="text-on-surface-variant text-xs uppercase font-bold tracking-widest block">Última Visita</span>
<span class="text-on-surface font-medium">Hoje, 08:45</span>
</div>
</div>
</div>
</div>
</header>
<!-- Bento Grid Metrics -->
<section class="grid grid-cols-1 md:grid-cols-3 gap-6">
<!-- Volume Chart -->
<div class="md:col-span-2 bg-surface-container-low p-8 rounded-lg border border-outline-variant/10 relative overflow-hidden">
<div class="relative z-10">
<div class="flex justify-between items-start mb-8">
<div>
<h3 class="font-headline font-bold text-2xl text-on-surface">Volume Semanal</h3>
<p class="text-on-surface-variant text-sm">Tonelagem total em exercícios compostos</p>
</div>
<div class="text-right">
<span class="text-3xl font-headline font-black text-primary">+12.4%</span>
</div>
</div>
<!-- Mock Chart Visualization -->
<div class="h-48 flex items-end gap-3 px-2">
<div class="flex-1 bg-surface-container h-[40%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
<div class="flex-1 bg-surface-container h-[55%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
<div class="flex-1 bg-surface-container h-[45%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
<div class="flex-1 bg-surface-container h-[70%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
<div class="flex-1 bg-surface-container h-[65%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
<div class="flex-1 bg-primary-container h-[85%] rounded-t-md shadow-[0_0_20px_rgba(212,251,0,0.3)]"></div>
<div class="flex-1 bg-surface-container h-[75%] rounded-t-md hover:bg-primary-container/20 transition-all"></div>
</div>
<div class="flex justify-between mt-4 px-2 text-[10px] font-bold tracking-widest text-on-surface-variant uppercase"><span>Seg</span><span>Ter</span><span>Qua</span><span>Qui</span><span>Sex</span><span>Sáb</span><span>Dom</span></div>
</div>
</div>
<!-- Body Weight Evolution -->
<div class="bg-surface-container-low p-8 rounded-lg border border-outline-variant/10 flex flex-col justify-between">
<div>
<h3 class="font-headline font-bold text-2xl text-on-surface mb-1">Peso Corporal</h3>
<p class="text-on-surface-variant text-sm mb-6">Atual: 84,2kg</p>
<div class="space-y-4">
<div class="flex justify-between items-center text-xs font-bold tracking-widest uppercase">
<span class="text-on-surface-variant">% de Gordura</span>
<span class="text-primary">12.2%</span>
</div>
<div class="w-full bg-surface-container-highest h-3 rounded-full overflow-hidden">
<div class="bg-gradient-to-r from-primary to-secondary h-full w-[12.2%]"></div>
</div>
<div class="flex justify-between items-center text-xs font-bold tracking-widest uppercase mt-4">
<span class="text-on-surface-variant">Massa Magra</span>
<span class="text-secondary">71.8kg</span>
</div>
<div class="w-full bg-surface-container-highest h-3 rounded-full overflow-hidden">
<div class="bg-secondary h-full w-[85%]"></div>
</div>
</div>
</div>
<div class="mt-8 pt-8 border-t border-outline-variant/10">
<div class="flex items-center gap-2 text-on-surface-variant">
<span class="material-symbols-outlined text-sm">trending_up</span>
<span class="text-xs font-bold tracking-widest uppercase">Fase de Ganho Estável</span>
</div>
</div>
</div>
</section>
<!-- Workout Logs -->
<section class="space-y-6">
<div class="flex items-center justify-between">
<h3 class="font-headline font-bold text-3xl tracking-tight">Registros de Treino Recentes</h3>
<button class="text-primary text-xs font-bold tracking-widest uppercase hover:underline">Ver Histórico Completo</button>
</div>
<div class="space-y-4">
<!-- Log Entry 1 -->
<div class="bg-surface-container p-6 rounded-lg flex items-center justify-between group hover:bg-surface-container-high transition-all">
<div class="flex items-center gap-6">
<div class="w-16 h-16 bg-surface-container-highest rounded-lg flex flex-col items-center justify-center border border-outline-variant/20">
<span class="text-xs font-black text-on-surface-variant uppercase">OUT</span>
<span class="text-2xl font-black font-headline text-on-surface">24</span>
</div>
<div>
<h4 class="font-headline font-bold text-xl">Dia de Perna: Foco em Força</h4>
<p class="text-on-surface-variant text-sm">4 Exercícios • 72m Duração • 12.400kg Vol</p>
</div>
</div>
<div class="flex items-center gap-8">
<div class="hidden md:block text-right">
<span class="text-xs font-bold tracking-widest text-on-surface-variant uppercase block">Intensidade</span>
<div class="flex gap-1 mt-1">
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-surface-container-highest rounded-full"></div>
</div>
</div>
<span class="material-symbols-outlined text-on-surface-variant group-hover:text-primary transition-colors">chevron_right</span>
</div>
</div>
<!-- Log Entry 2 -->
<div class="bg-surface-container p-6 rounded-lg flex items-center justify-between group hover:bg-surface-container-high transition-all">
<div class="flex items-center gap-6">
<div class="w-16 h-16 bg-surface-container-highest rounded-lg flex flex-col items-center justify-center border border-outline-variant/20">
<span class="text-xs font-black text-on-surface-variant uppercase">OUT</span>
<span class="text-2xl font-black font-headline text-on-surface">22</span>
</div>
<div>
<h4 class="font-headline font-bold text-xl">Membro Superior: Empurre A</h4>
<p class="text-on-surface-variant text-sm">6 Exercícios • 58m Duração • 8.900kg Vol</p>
</div>
</div>
<div class="flex items-center gap-8">
<div class="hidden md:block text-right">
<span class="text-xs font-bold tracking-widest text-on-surface-variant uppercase block">Intensidade</span>
<div class="flex gap-1 mt-1">
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-surface-container-highest rounded-full"></div>
<div class="w-4 h-1 bg-surface-container-highest rounded-full"></div>
</div>
</div>
<span class="material-symbols-outlined text-on-surface-variant group-hover:text-primary transition-colors">chevron_right</span>
</div>
</div>
<!-- Log Entry 3 -->
<div class="bg-surface-container p-6 rounded-lg flex items-center justify-between group hover:bg-surface-container-high transition-all">
<div class="flex items-center gap-6">
<div class="w-16 h-16 bg-surface-container-highest rounded-lg flex flex-col items-center justify-center border border-outline-variant/20">
<span class="text-xs font-black text-on-surface-variant uppercase">OUT</span>
<span class="text-2xl font-black font-headline text-on-surface">21</span>
</div>
<div>
<h4 class="font-headline font-bold text-xl">Puxada: Foco Vertical</h4>
<p class="text-on-surface-variant text-sm">5 Exercícios • 64m Duração • 9.200kg Vol</p>
</div>
</div>
<div class="flex items-center gap-8">
<div class="hidden md:block text-right">
<span class="text-xs font-bold tracking-widest text-on-surface-variant uppercase block">Intensidade</span>
<div class="flex gap-1 mt-1">
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
<div class="w-4 h-1 bg-primary rounded-full"></div>
</div>
</div>
<span class="material-symbols-outlined text-on-surface-variant group-hover:text-primary transition-colors">chevron_right</span>
</div>
</div>
</div>
</section>
</main>
<!-- Floating Action Button -->
<button class="fixed bottom-24 right-6 bg-primary-container text-on-primary font-headline font-black italic tracking-tighter text-lg px-8 py-4 rounded-full shadow-[0_0_32px_rgba(212,251,0,0.4)] flex items-center gap-3 hover:scale-105 active:scale-95 transition-all z-[60]"><span class="material-symbols-outlined">add_task</span> ATRIBUIR TREINO</button>
<!-- BottomNavBar Execution -->
<footer class="fixed bottom-0 left-0 w-full flex justify-around items-center px-4 py-3 pb-8 bg-[#0e0e0e]/80 backdrop-blur-md z-50 shadow-[0_-8px_32px_rgba(215,255,0,0.08)]">
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined">dashboard</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest">PAINEL</span>
</div>
<div class="flex flex-col items-center justify-center text-[#d4fb00] bg-[#d4fb00]/10 rounded-full px-5 py-2 active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">group</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest">ALUNOS</span>
</div>
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined">fitness_center</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest">TREINOS</span>
</div>
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined">history_toggle_off</span>
<span class="font-['Lexend'] font-medium text-[10px] uppercase tracking-widest">HISTÓRICO</span>
</div>
</footer>
</body></html>

<!-- Criar/Editar Treino -->
<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Criar Treino - Kinetic Noir</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800;900&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#1a1a1a",
                        "secondary": "#00e3fd",
                        "primary-dim": "#c9ef00",
                        "surface-container-highest": "#262626",
                        "on-surface": "#ffffff",
                        "surface": "#0e0e0e",
                        "on-secondary": "#004d57",
                        "on-tertiary-container": "#5c4d00",
                        "on-secondary-fixed-variant": "#005964",
                        "surface-container-low": "#131313",
                        "secondary-fixed-dim": "#00d7f0",
                        "surface-variant": "#262626",
                        "inverse-surface": "#fcf9f8",
                        "primary-fixed-dim": "#c7ec00",
                        "on-tertiary-fixed-variant": "#685700",
                        "secondary-dim": "#00d4ec",
                        "on-primary": "#556600",
                        "tertiary-container": "#fddb42",
                        "on-secondary-container": "#e8fbff",
                        "on-error": "#450900",
                        "tertiary": "#ffeba0",
                        "surface-tint": "#f5ffc5",
                        "outline-variant": "#484847",
                        "tertiary-fixed": "#fddb42",
                        "secondary-fixed": "#26e6ff",
                        "inverse-on-surface": "#565555",
                        "on-tertiary-fixed": "#473b00",
                        "on-primary-fixed": "#3d4a00",
                        "primary": "#f5ffc5",
                        "surface-container-lowest": "#000000",
                        "on-tertiary": "#665600",
                        "on-surface-variant": "#adaaaa",
                        "on-background": "#ffffff",
                        "inverse-primary": "#556600",
                        "on-secondary-fixed": "#003a42",
                        "secondary-container": "#006875",
                        "surface-dim": "#0e0e0e",
                        "on-primary-fixed-variant": "#566800",
                        "primary-container": "#d4fb00",
                        "tertiary-fixed-dim": "#eecd34",
                        "surface-container-high": "#20201f",
                        "on-error-container": "#ffd2c8",
                        "tertiary-dim": "#eecd34",
                        "primary-fixed": "#d4fb00",
                        "error-container": "#b92902",
                        "outline": "#767575",
                        "on-primary-container": "#4d5d00",
                        "error": "#ff7351",
                        "surface-bright": "#2c2c2c",
                        "error-dim": "#d53d18",
                        "background": "#0e0e0e"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Lexend"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Inter', sans-serif; background-color: #0e0e0e; color: #ffffff; }
        h1, h2, h3 { font-family: 'Lexend', sans-serif; }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-surface text-on-surface min-h-screen pb-32">
<!-- TopAppBar Shell -->
<header class="bg-[#0e0e0e] text-[#d4fb00] font-['Lexend'] font-bold tracking-tight docked full-width top-0 sticky z-50 bg-[#131313] flat no shadows flex justify-between items-center w-full px-6 py-4 bg-opacity-90 backdrop-blur-xl">
<div class="flex items-center gap-4">
<div class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary-container">
<img class="w-full h-full object-cover" data-alt="Close-up portrait of a professional athletic trainer in a dark high-performance gym environment with dramatic rim lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBJv5bAQCxM-sRV6VFigUp8EC_mSwHEBjrZLKGc_yuCMWn-qZpHGDZW86gMkxk4RpHj6JzX4LR1cHDB34b2QiqDFXehY3NvrKH0EEwR3JZPeVHeLEkKl7nO_C33i3geVVFKG2VVUcSr-HBtmdEFyMxmvPk_2D3Z1WdEyYEs3U1xIVS7fMOJAcTCjWXZk1TOg20gKvEmWZZebIexAsulaJ6sTXKzkNwGFONQux-lRMy-744vwUE6Z_G-TBJeqfTUQ6D9xT9VEhqEhIE"/>
</div>
<span class="text-2xl font-black italic tracking-tighter text-[#d4fb00]">KINETIC NOIR</span>
</div>
<button class="material-symbols-outlined text-2xl hover:bg-[#20201f] transition-colors p-2 rounded-full active:scale-95 duration-150" data-icon="settings">settings</button>
</header>
<main class="max-w-5xl mx-auto px-6 pt-10">
<!-- Title & Form Anchor -->
<div class="mb-12">
<div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
<div class="flex-1">
<h1 class="text-5xl md:text-7xl font-headline font-black italic uppercase tracking-tighter leading-none mb-6 opacity-90">Criar <span class="text-primary-container">Treino</span></h1>
<div class="bg-surface-container-low p-8 rounded-lg">
<label class="block text-[10px] font-label font-bold uppercase tracking-[0.2em] text-on-surface-variant mb-3">NOME DO TREINO</label>
<input class="w-full bg-surface-container-high border-none text-2xl font-headline font-bold text-primary focus:ring-2 focus:ring-primary-container/20 rounded-md p-4 transition-all" placeholder="e.g., Push Day A" type="text"/>
</div>
</div>
<div class="hidden md:flex gap-4 mb-2">
<button class="bg-surface-container-high text-on-surface px-8 py-4 rounded-full font-label font-bold tracking-widest uppercase text-xs border border-outline-variant/20 hover:bg-surface-container-highest transition-colors">Atribuir ao Aluno</button>
<button class="bg-primary-container text-on-primary px-8 py-4 rounded-full font-label font-bold tracking-widest uppercase text-xs active:scale-95 transition-transform">Salvar Modelo</button>
</div>
</div>
</div>
<!-- Exercises List -->
<div class="space-y-6">
<h2 class="text-xs font-label font-bold uppercase tracking-[0.3em] text-on-surface-variant flex items-center gap-4">Estrutura do Treino <span class="flex-1 h-px bg-surface-container-highest"></span></h2>
<!-- Exercise Card 01 -->
<div class="group bg-surface-container rounded-lg overflow-hidden flex flex-col md:flex-row">
<div class="w-full md:w-48 h-48 md:h-auto relative overflow-hidden">
<img class="w-full h-full object-cover grayscale opacity-60 group-hover:grayscale-0 group-hover:opacity-100 transition-all duration-700 scale-110" data-alt="Professional athlete performing heavy barbell bench press in a dark gritty garage gym setting with moody cinematic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBgHy8X4ZyYvRcHaDwKjJ51tshd9fapfjZI4RZbB3-Vn1iEyqDjXimRthEUJZiWVs6DPCZa96LITQ5Hypmn-gYR5g1OCgwIETxNgTCdG9NoI8H3_Fdxqy0gPFHQmMdoTM5ysMoBvknME4MBmbBvGkdKX7GfI-GiiCknbl51pDNWtRyl0QYYkoroCUeLLEJgCVL8-3LZdO0JaZQDjZszGK1pBqmBbHPmw_fLKH9XDw3C0oGdExfAeOcjpc5DhDyXNPVYDdCBiLkVJLs"/>
<div class="absolute inset-0 bg-gradient-to-t from-surface-container via-transparent to-transparent md:bg-gradient-to-r"></div>
<div class="absolute top-4 left-4 bg-primary-container text-on-primary w-8 h-8 flex items-center justify-center rounded-full font-headline font-black italic">1</div>
</div>
<div class="flex-1 p-8 flex flex-col justify-between">
<div class="flex justify-between items-start mb-6">
<div>
<h3 class="text-2xl font-headline font-bold text-on-surface">Barbell Bench Press</h3>
<span class="text-[10px] font-label font-medium uppercase tracking-widest text-secondary">PEITO / COMPOSTO</span>
</div>
<button class="text-on-surface-variant hover:text-error transition-colors">
<span class="material-symbols-outlined">delete</span>
</button>
</div>
<div class="grid grid-cols-2 lg:grid-cols-4 gap-6">
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">SÉRIES</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" type="text" value="4"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">REPS</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" type="text" value="8-10"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">DESCANSO (S)</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" type="text" value="120"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">RPE</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" type="text" value="8"/>
</div>
</div>
</div>
</div>
<!-- Exercise Card 02 -->
<div class="group bg-surface-container rounded-lg overflow-hidden flex flex-col md:flex-row">
<div class="w-full md:w-48 h-48 md:h-auto relative overflow-hidden">
<img class="w-full h-full object-cover grayscale opacity-60 group-hover:grayscale-0 group-hover:opacity-100 transition-all duration-700 scale-110" data-alt="Muscular male performing heavy overhead dumbbell press in a dimly lit crossfit box with blue ambient lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDV_fVcRjqQor31OLTCTMJrVlmbIbMx4Da4yw7UuDkMF27ueumf8Cuavdhw3wu6LzvwybEhaaeh3VaA_ZCNJzrSpQnTSCS1P_tXyyZ5migqJdfq5Q_Y9WBwoZk4sgxdmqNcd52TfRFx7ae3EHbozPTWRDADF_ZB9jlo92PxylgWUGiDmeGf4Mn5BDy_k7GkqkTgt2YuX37u8OCvDiRAy7ldTAXRz3uXyElU-PIg6qKjHQfesPNd5X0SckWCnLzybeiOW3MWkZU5I_c"/>
<div class="absolute inset-0 bg-gradient-to-t from-surface-container via-transparent to-transparent md:bg-gradient-to-r"></div>
<div class="absolute top-4 left-4 bg-primary-container text-on-primary w-8 h-8 flex items-center justify-center rounded-full font-headline font-black italic">2</div>
</div>
<div class="flex-1 p-8 flex flex-col justify-between">
<div class="flex justify-between items-start mb-6">
<div>
<h3 class="text-2xl font-headline font-bold text-on-surface">Dumbbell Shoulder Press</h3>
<span class="text-[10px] font-label font-medium uppercase tracking-widest text-secondary">OMBROS / FORÇA</span>
</div>
<button class="text-on-surface-variant hover:text-error transition-colors">
<span class="material-symbols-outlined">delete</span>
</button>
</div>
<div class="grid grid-cols-2 lg:grid-cols-4 gap-6">
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">SÉRIES</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" placeholder="0" type="text"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">REPS</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" placeholder="0" type="text"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">DESCANSO (S)</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" placeholder="0" type="text"/>
</div>
<div>
<label class="block text-[10px] font-label font-bold uppercase tracking-widest text-on-surface-variant mb-2">RPE</label>
<input class="w-full bg-surface-container-high border-none rounded-md text-xl font-headline font-bold text-on-surface p-3 text-center focus:ring-1 focus:ring-secondary/30" placeholder="0" type="text"/>
</div>
</div>
</div>
</div>
<!-- Add Exercise Action -->
<button class="w-full py-10 rounded-lg border-2 border-dashed border-surface-container-highest hover:bg-surface-container-low hover:border-primary-container/30 transition-all group flex flex-col items-center justify-center gap-4">
<div class="w-16 h-16 rounded-full bg-surface-container-highest flex items-center justify-center group-hover:bg-primary-container group-hover:text-on-primary transition-colors">
<span class="material-symbols-outlined text-3xl">add</span>
</div>
<span class="font-label font-bold tracking-[0.2em] text-on-surface-variant text-xs group-hover:text-on-surface uppercase">Adicionar exercício da biblioteca</span>
</button>
</div>
<!-- Mobile Sticky Actions -->
<div class="md:hidden mt-12 space-y-4">
<button class="w-full bg-primary-container text-on-primary p-5 rounded-full font-headline font-bold tracking-wider uppercase text-sm">Salvar Modelo</button>
<button class="w-full bg-surface-container-high text-on-surface p-5 rounded-full font-headline font-bold tracking-wider uppercase text-sm border border-outline-variant/20">Atribuir ao Aluno</button>
</div>
</main>
<!-- BottomNavBar Shell -->
<nav class="fixed bottom-0 w-full z-50 backdrop-blur-md bg-[#0e0e0e]/80 text-[#d4fb00] font-['Lexend'] font-medium text-[10px] uppercase tracking-widest shadow-[0_-8px_32px_rgba(215,255,0,0.08)] fixed bottom-0 left-0 w-full flex justify-around items-center px-4 py-3 pb-8">
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined mb-1" data-icon="dashboard">dashboard</span>
<span>PAINEL</span>
</div>
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined mb-1" data-icon="group">group</span>
<span>ALUNOS</span>
</div>
<div class="flex flex-col items-center justify-center text-[#d4fb00] bg-[#d4fb00]/10 rounded-full px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined mb-1" data-icon="fitness_center" style="font-variation-settings: 'FILL' 1;">fitness_center</span>
<span>CONSTRUTOR</span>
</div>
<div class="flex flex-col items-center justify-center text-[#a1a1aa] px-5 py-2 hover:text-[#f5ffc5] active:scale-90 transition-transform duration-200">
<span class="material-symbols-outlined mb-1" data-icon="history_toggle_off">history_toggle_off</span>
<span>HISTÓRICO</span>
</div>
</nav>
</body></html>