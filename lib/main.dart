import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CvApp());
}

class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> missions;
  const Experience(this.role, this.company, this.period, this.location, this.missions);
}

class CompetenceGroupe {
  final String titre;
  final IconData icon;
  final List<String> items;
  const CompetenceGroupe(this.titre, this.icon, this.items);
}

class Donnees {
  static const identifiant = 'dekens';
  static const motDePasse = 'dekens2026';

  static const nom = 'Dekens Ruzuba';
  static const titre = 'Développeur Fullstack & Créateur d\'Agents IA';
  static const photo = 'assets/images/dek.jpg';
  
  static const email = 'ruzubadekens@gmail.com';
  static const telephone = '+243 893 292 330';
  static const localisation = 'Goma, RDC';
  
  static const portfolio = 'https://portfoliodek.netlify.app/';
  static const github = 'https://github.com/dekensruz';
  static const linkedin = 'https://linkedin.com/in/dekens-ruzuba';

  static const profil = "Développeur fullstack polyvalent, je crée des applications web, desktop et mobiles. Maîtrisant aussi la création d'Agents IA, le design, la 3D et le montage vidéo, j'offre des solutions numériques complètes, performantes et sur mesure.";

  static const competences = <CompetenceGroupe>[
    CompetenceGroupe('Développement & Frameworks', Icons.code_rounded, [
      'C#', '.NET', 'Blazor', 'React', 'Node.js', 'Next.js', 'Flutter', 'HTML5 / CSS3', 'SQL Server', 'Git'
    ]),
    CompetenceGroupe('Intelligence Artificielle & Automatisation', Icons.psychology_rounded, [
      'Création d\'Agents IA', 'Intégration IA', 'n8n', 'Outils d\'IA'
    ]),
    CompetenceGroupe('Design & Création', Icons.design_services_rounded, [
      'UI/UX Design', 'Figma', 'Photoshop', 'Illustrator', 'Blender (3D)', 'Premiere Pro (Vidéo)'
    ]),
    CompetenceGroupe('Bureautique & Gestion', Icons.workspace_premium_rounded, [
      'Google Workspace', 'Suite Office'
    ])
  ];

  static const experiences = <Experience>[
    Experience(
      'Développeur web & Desktop',
      'Progressive Medical Systems',
      'Avril 2026 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Conception et développement d\'applications d\'entreprise (.NET / Blazor) et du site web officiel.',
        'Modélisation et optimisation de bases de données SQL (données médicales et administratives).',
        'Contribution à la mise en place d\'un logiciel de gestion complète automatisant les processus clés.'
      ]
    ),
    Experience(
      'Consultant',
      'Afrix Global',
      'Août - Aujourd\'hui',
      'Goma, RDC',
      [
        'Conception et développement de sites et applications web, desktop et mobile.',
        'Conception et intégration d\'agents IA et solutions intelligentes.',
        'Animation de formations et conférences sur les technologies et l\'IA.',
        'Accompagnement technique et conseil auprès des équipes et clients.'
      ]
    ),
    Experience(
      'Développeur & Créateur d\'Agents IA',
      'Getdjukey (Freelance)',
      'Juillet 2025 - Aujourd\'hui',
      'Minnesota, USA (À distance)',
      [
        'Création d\'agents IA, d\'applications web et mobile.',
        'Formation en ligne des agents de l\'entreprise sur la programmation et l\'IA.'
      ]
    ),
    Experience(
      'Formateur',
      'CFPI (ISIG)',
      'Avril 2026 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Animation de formations sur l\'intelligence artificielle et la conception d\'agents IA.',
        'Formation sur le Web Design.'
      ]
    ),
    Experience(
      'Formateur',
      'DevCreed',
      'Mars 2024 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Formation sur les bases de la programmation web avec HTML, CSS & CSS3.',
        'Formation sur la bureautique (Suite office et Google Workspace).',
        'Formation sur la programmation mobile avec Flutter.',
        'Formation sur l\'initiation à l\'Intelligence Artificielle et la création des agents IA.',
        'Formation sur Photoshop.'
      ]
    ),
    Experience(
      'Développeur & Créateur d\'Agents IA',
      'Leka Company (Remote)',
      'Juillet 2026 - Aujourd\'hui',
      'Bukavu, RDC',
      [
        'Développement d\'applications web, mobiles et Desktop.',
        'Conception et intégration de solutions d\'Intelligence Artificielle.'
      ]
    ),
    Experience(
      'Consultant Créateur d\'Agents IA',
      'LeoKongo (Freelance)',
      'Juin 2024 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Créations d\'Agents IA.',
        'Intégration de l\'Intelligence Artificielle dans l\'application MyAfya.'
      ]
    ),
  ];

  static const formations = [
    ['Licence en Sciences Informatiques, Génie Logiciel', 'ISIG Goma', '2023 - 2027'],
    ['Diplôme d\'État Scientifique', 'Lycée Madre Elena', '2018 - 2023'],
  ];

  static const langues = [
    ['Français', 'Avancé'],
    ['Anglais', 'Intermédiaire'],
    ['Kiswahili', 'Intermédiaire'],
  ];

  static const interets = [
    'Nouvelles Technologies',
    'Échecs',
    'Création de Contenus',
    'Lecture',
    'Écriture'
  ];

  static const famille = [
    {'nom': 'Furaha Katengura', 'role': 'Mère', 'photo': 'assets/images/mom.jpg'},
    {'nom': 'Bisimwa Ruzuba Aimé', 'role': 'Père', 'photo': ''},
    {'nom': 'Philippe', 'role': 'Frère', 'photo': 'assets/images/philippe.jpg'},
    {'nom': 'Filene', 'role': 'Frère/Sœur', 'photo': 'assets/images/filene.jpg'},
    {'nom': 'Hans', 'role': 'Frère', 'photo': 'assets/images/hans.jpg'},
    {'nom': 'Marc', 'role': 'Frère', 'photo': ''},
    {'nom': 'Daniella', 'role': 'Sœur', 'photo': 'assets/images/daniella.jpg'},
    {'nom': 'Luc', 'role': 'Frère', 'photo': 'assets/images/luc.jpg'},
    {'nom': 'Dankon', 'role': 'Frère', 'photo': 'assets/images/dankon.jpg'},
    {'nom': 'Grâce', 'role': 'Sœur', 'photo': 'assets/images/grace.jpg'},
  ];
}

const kBg = Color(0xFFF8FAFC);
const kSurface = Color(0xFFFFFFFF);
const kInk = Color(0xFF0F172A);
const kInk2 = Color(0xFF475569);
const kInk3 = Color(0xFF94A3B8);
const kBorder = Color(0xFFE2E8F0);
const kAccent = Color(0xFF2563EB);
const kAccentSoft = Color(0xFFEFF6FF);
const kDanger = Color(0xFFEF4444);
const kGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8), Color(0xFF3B82F6)],
);

TextStyle font(
  double size, {
  FontWeight w = FontWeight.w400,
  Color c = kInk,
  double? h,
  double? ls,
}) =>
    GoogleFonts.plusJakartaSans(
        fontSize: size, fontWeight: w, color: c, height: h, letterSpacing: ls);

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Dekens Ruzuba',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAccent,
          brightness: Brightness.light,
        ).copyWith(
          primary: kAccent,
          surface: kSurface,
          onSurface: kInk,
        ),
        scaffoldBackgroundColor: kBg,
        splashFactory: InkSparkle.splashFactory,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kAccent,
          selectionColor: kAccent.withValues(alpha: 0.2),
          selectionHandleColor: kAccent,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets communs
// ---------------------------------------------------------------------------

/// Photo carrée/ronde de taille fixe, avec initiale si l'image est absente.
class Photo extends StatelessWidget {
  final String asset;
  final String nom;
  final double size;
  final double radius;
  final bool circle;
  final Color? borderColor;
  final double borderWidth;

  const Photo({
    super.key,
    required this.asset,
    required this.nom,
    this.size = 56,
    this.radius = 16,
    this.circle = false,
    this.borderColor,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: circle ? null : BorderRadius.circular(radius),
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        color: kAccentSoft,
        border: Border.all(color: borderColor ?? kBorder, width: borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      child: PhotoFill(asset: asset, nom: nom, fontSize: size * 0.4),
    );
  }
}

/// Image qui remplit son parent, ou initiale sur fond dégradé doux.
class PhotoFill extends StatelessWidget {
  final String asset;
  final String nom;
  final double fontSize;
  const PhotoFill({super.key, required this.asset, required this.nom, this.fontSize = 36});

  @override
  Widget build(BuildContext context) {
    final initiale = nom.trim().isNotEmpty ? nom.trim()[0].toUpperCase() : '?';
    final placeholder = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDBEAFE), Color(0xFFE0F2FE)],
        ),
      ),
      alignment: Alignment.center,
      child: Text(initiale, style: font(fontSize, w: FontWeight.w800, c: kAccent)),
    );
    if (asset.isEmpty) return placeholder;
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  const SectionTitle(this.text, {super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 14),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 12),
          ],
          Text(text, style: font(18, w: FontWeight.w800, ls: -0.3)),
        ],
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const CardBox({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: kSurface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kBorder.withValues(alpha: 0.7)),
            ),
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// En-tête en dégradé utilisé en haut des pages internes.
class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const PageHeader({super.key, required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: kGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kAccent.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: font(26, w: FontWeight.w800, c: Colors.white, ls: -0.6)),
                const SizedBox(height: 6),
                Text(subtitle, style: font(13.5, c: Colors.white.withValues(alpha: 0.85), h: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}

void toast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(msg, style: font(13, w: FontWeight.w500, c: Colors.white)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      backgroundColor: kInk,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
}

Future<void> ouvrir(BuildContext context, Uri uri) async {
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) toast(context, 'Impossible d\'ouvrir ce lien.');
}

// ---------------------------------------------------------------------------
// Page 1 : Connexion
// ---------------------------------------------------------------------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idCtrl = TextEditingController();
  final _mdpCtrl = TextEditingController();
  bool _hide = true;
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _error = null;
      _loading = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    if (_idCtrl.text.trim().toLowerCase() == Donnees.identifiant &&
        _mdpCtrl.text == Donnees.motDePasse) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => const MainShell(),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
      );
    } else {
      setState(() {
        _loading = false;
        _error = 'Identifiant ou mot de passe incorrect.';
      });
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _mdpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bandeau en dégradé
            Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
              ),
              child: Stack(
                children: [
                  Positioned(top: -60, right: -40, child: _bulle(180)),
                  Positioned(bottom: 30, left: -50, child: _bulle(120)),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 56, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bienvenue',
                              style: font(38, w: FontWeight.w800, c: Colors.white, h: 1.1, ls: -1.0)),
                          const SizedBox(height: 10),
                          Text('Connectez-vous pour découvrir\nmon CV, ma famille et mes contacts.',
                              style: font(15, c: Colors.white.withValues(alpha: 0.88), h: 1.5)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Carte du formulaire, qui chevauche le bandeau
            Transform.translate(
              offset: const Offset(0, -56),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CardBox(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Connexion', style: font(20, w: FontWeight.w800, ls: -0.3)),
                      const SizedBox(height: 22),
                      _buildField(
                        label: 'Identifiant',
                        icon: Icons.person_outline_rounded,
                        ctrl: _idCtrl,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 18),
                      _buildField(
                        label: 'Mot de passe',
                        icon: Icons.lock_outline_rounded,
                        ctrl: _mdpCtrl,
                        obscure: _hide,
                        onSubmitted: (_) => _submit(),
                        suffix: IconButton(
                          iconSize: 20,
                          icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: kInk3),
                          onPressed: () => setState(() => _hide = !_hide),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: kDanger.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, size: 18, color: kDanger),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(_error!, style: font(13, w: FontWeight.w500, c: kDanger)),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      _GradientButton(
                        loading: _loading,
                        label: 'Se connecter',
                        onTap: _loading ? null : _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bulle(double s) => Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.08),
        ),
      );

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextEditingController ctrl,
    bool obscure = false,
    Widget? suffix,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kBorder),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: font(13, w: FontWeight.w600, c: kInk2)),
        ),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          cursorColor: kAccent,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          style: font(15, w: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: kBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            prefixIcon: Icon(icon, color: kInk3, size: 20),
            suffixIcon: suffix,
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(borderSide: const BorderSide(color: kAccent, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  final bool loading;
  final String label;
  final VoidCallback? onTap;
  const _GradientButton({required this.loading, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null && !loading ? 0.5 : 1,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: kGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: kAccent.withValues(alpha: 0.35), blurRadius: 18, offset: const Offset(0, 8)),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Center(
              child: loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(label, style: font(16, w: FontWeight.w700, c: Colors.white)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Navigation principale
// ---------------------------------------------------------------------------

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;

  void _logout() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProfilPage(onLogout: _logout),
      const ExperiencePage(),
      const FamillePage(),
      const ContactPage(),
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(_i), child: pages[_i]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kSurface,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith((s) => font(
                  12,
                  w: s.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
                  c: s.contains(WidgetState.selected) ? kAccent : kInk3,
                )),
            iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
                  size: 24,
                  color: s.contains(WidgetState.selected) ? kAccent : kInk3,
                )),
          ),
          child: NavigationBar(
            height: 70,
            backgroundColor: kSurface,
            surfaceTintColor: Colors.transparent,
            indicatorColor: kAccentSoft,
            selectedIndex: _i,
            onDestinationSelected: (v) => setState(() => _i = v),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Accueil'),
              NavigationDestination(
                  icon: Icon(Icons.work_outline_rounded),
                  selectedIcon: Icon(Icons.work_rounded),
                  label: 'Parcours'),
              NavigationDestination(
                  icon: Icon(Icons.people_outline_rounded),
                  selectedIcon: Icon(Icons.people_rounded),
                  label: 'Famille'),
              NavigationDestination(
                  icon: Icon(Icons.mail_outline_rounded),
                  selectedIcon: Icon(Icons.mail_rounded),
                  label: 'Contact'),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 2 : Accueil (CV)
// ---------------------------------------------------------------------------

class ProfilPage extends StatelessWidget {
  final VoidCallback? onLogout;
  const ProfilPage({super.key, this.onLogout});

  static double _niveau(String n) => switch (n) {
        'Natif' || 'Maternelle' => 1.0,
        'Avancé' || 'Courant' => 0.85,
        'Intermédiaire' => 0.6,
        _ => 0.35,
      };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carte d'identité en dégradé
            Container(
              padding: const EdgeInsets.fromLTRB(22, 18, 18, 24),
              decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(color: kAccent.withValues(alpha: 0.25), blurRadius: 28, offset: const Offset(0, 12)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mon CV', style: font(14, w: FontWeight.w600, c: Colors.white.withValues(alpha: 0.85))),
                      Material(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onLogout,
                          child: const Padding(
                            padding: EdgeInsets.all(9),
                            child: Icon(Icons.logout_rounded, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Photo(
                        asset: Donnees.photo,
                        nom: Donnees.nom,
                        size: 92,
                        circle: true,
                        borderColor: Colors.white,
                        borderWidth: 3,
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Donnees.nom,
                                style: font(24, w: FontWeight.w800, c: Colors.white, ls: -0.5, h: 1.15)),
                            const SizedBox(height: 6),
                            Text(Donnees.titre,
                                style: font(13, w: FontWeight.w500, c: Colors.white.withValues(alpha: 0.9), h: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chipBlanc(Icons.location_on_rounded, Donnees.localisation),
                      _chipBlanc(Icons.school_rounded, 'ISIG Goma'),
                    ],
                  ),
                ],
              ),
            ),

            const SectionTitle('À propos', icon: Icons.person_rounded),
            CardBox(child: Text(Donnees.profil, style: font(14, c: kInk2, h: 1.65))),

            const SectionTitle('Formation', icon: Icons.school_rounded),
            CardBox(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (int i = 0; i < Donnees.formations.length; i++) ...[
                    if (i > 0) const Divider(color: kBorder, height: 1),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kAccentSoft,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.school_outlined, size: 18, color: kAccent),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Donnees.formations[i][0], style: font(14.5, w: FontWeight.w700, h: 1.3)),
                                const SizedBox(height: 4),
                                Text(Donnees.formations[i][1], style: font(13, c: kInk2)),
                                const SizedBox(height: 8),
                                _pastille(Donnees.formations[i][2]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SectionTitle('Compétences techniques', icon: Icons.bolt_rounded),
            for (var comp in Donnees.competences)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: CardBox(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(comp.icon, size: 18, color: kAccent),
                          const SizedBox(width: 8),
                          Expanded(child: Text(comp.titre, style: font(14, w: FontWeight.w700))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: comp.items
                            .map((e) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: kBg,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: kBorder),
                                  ),
                                  child: Text(e, style: font(12, w: FontWeight.w600, c: kInk2)),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

            const SectionTitle('Langues', icon: Icons.translate_rounded),
            CardBox(
              child: Column(
                children: [
                  for (int i = 0; i < Donnees.langues.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: i == Donnees.langues.length - 1 ? 0 : 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Donnees.langues[i][0], style: font(14, w: FontWeight.w700)),
                              Text(Donnees.langues[i][1], style: font(12.5, w: FontWeight.w600, c: kAccent)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: _niveau(Donnees.langues[i][1]),
                              minHeight: 7,
                              backgroundColor: kAccentSoft,
                              color: kAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SectionTitle('Centres d\'intérêt', icon: Icons.favorite_rounded),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: Donnees.interets
                  .map((e) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: kAccentSoft,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: kAccent.withValues(alpha: 0.15)),
                        ),
                        child: Text(e, style: font(12.5, w: FontWeight.w700, c: kAccent)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipBlanc(IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 5),
            Text(text, style: font(12, w: FontWeight.w600, c: Colors.white)),
          ],
        ),
      );
}

Widget _pastille(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today_rounded, size: 11, color: kInk3),
          const SizedBox(width: 5),
          Text(text, style: font(11, w: FontWeight.w600, c: kInk2)),
        ],
      ),
    );

// ---------------------------------------------------------------------------
// Parcours (expériences) – frise chronologique
// ---------------------------------------------------------------------------

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final xp = Donnees.experiences;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          PageHeader(
            title: 'Mon Parcours',
            subtitle: '${xp.length} expériences : emplois, missions freelance et formations.',
            icon: Icons.work_rounded,
          ),
          const SizedBox(height: 24),
          for (int i = 0; i < xp.length; i++)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Frise
                  SizedBox(
                    width: 22,
                    child: Column(
                      children: [
                        const SizedBox(height: 22),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            gradient: kGradient,
                            shape: BoxShape.circle,
                            border: Border.all(color: kAccentSoft, width: 3),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: i == xp.length - 1 ? Colors.transparent : kAccent.withValues(alpha: 0.18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CardBox(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(xp[i].role, style: font(15.5, w: FontWeight.w800, h: 1.3)),
                            const SizedBox(height: 4),
                            Text(xp[i].company, style: font(13.5, w: FontWeight.w700, c: kAccent)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                _pastille(xp[i].period),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 14, color: kInk3),
                                    const SizedBox(width: 2),
                                    Text(xp[i].location, style: font(11.5, c: kInk3)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            for (var m in xp[i].missions)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 3, right: 8),
                                      child: Icon(Icons.check_circle_rounded, size: 14, color: kAccent),
                                    ),
                                    Expanded(child: Text(m, style: font(13, c: kInk2, h: 1.5))),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 3 : Famille
// ---------------------------------------------------------------------------

class FamillePage extends StatelessWidget {
  const FamillePage({super.key});

  @override
  Widget build(BuildContext context) {
    final parents = Donnees.famille.where((e) => e['role'] == 'Père' || e['role'] == 'Mère').toList();
    final fratrie = Donnees.famille.where((e) => e['role'] != 'Père' && e['role'] != 'Mère').toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: 'Ma Famille',
              subtitle: '${Donnees.famille.length} personnes qui m\'accompagnent au quotidien.',
              icon: Icons.family_restroom_rounded,
            ),

            const SectionTitle('Parents', icon: Icons.favorite_rounded),
            for (var p in parents)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CardBox(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Photo(asset: p['photo']!, nom: p['nom']!, size: 60, circle: true),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['nom']!, style: font(16, w: FontWeight.w700)),
                            const SizedBox(height: 6),
                            _lien(p['role']!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SectionTitle('Frères & Sœurs', icon: Icons.people_rounded),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.74,
              ),
              itemCount: fratrie.length,
              itemBuilder: (context, index) {
                final f = fratrie[index];
                return CardBox(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: PhotoFill(asset: f['photo']!, nom: f['nom']!, fontSize: 44),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 10, 6, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f['nom']!, style: font(15, w: FontWeight.w700), overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 5),
                            _lien(f['role']!),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _lien(String role) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(
          color: kAccentSoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(role, style: font(11.5, w: FontWeight.w700, c: kAccent)),
      );
}

// ---------------------------------------------------------------------------
// Page 4 : Contact
// ---------------------------------------------------------------------------

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PageHeader(
              title: 'Contact',
              subtitle: 'Touchez un élément pour appeler, écrire ou ouvrir le lien.',
              icon: Icons.mail_rounded,
            ),

            const SectionTitle('Coordonnées', icon: Icons.contact_phone_rounded),
            _tuile(
              context,
              icon: Icons.phone_rounded,
              couleur: const Color(0xFF16A34A),
              label: 'Téléphone',
              valeur: Donnees.telephone,
              action: Icons.call_rounded,
              uri: Uri.parse('tel:${Donnees.telephone.replaceAll(' ', '')}'),
            ),
            _tuile(
              context,
              icon: Icons.email_rounded,
              couleur: const Color(0xFFDC2626),
              label: 'E-mail',
              valeur: Donnees.email,
              action: Icons.send_rounded,
              uri: Uri.parse('mailto:${Donnees.email}'),
            ),
            _tuile(
              context,
              icon: Icons.location_on_rounded,
              couleur: const Color(0xFFEA580C),
              label: 'Adresse',
              valeur: Donnees.localisation,
              action: Icons.map_rounded,
              uri: Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(Donnees.localisation)}'),
            ),

            const SectionTitle('Réseaux sociaux', icon: Icons.public_rounded),
            _tuile(
              context,
              icon: Icons.business_center_rounded,
              couleur: const Color(0xFF0A66C2),
              label: 'LinkedIn',
              valeur: 'linkedin.com/in/dekens-ruzuba',
              action: Icons.open_in_new_rounded,
              uri: Uri.parse(Donnees.linkedin),
            ),
            _tuile(
              context,
              icon: Icons.code_rounded,
              couleur: const Color(0xFF111827),
              label: 'GitHub',
              valeur: 'github.com/dekensruz',
              action: Icons.open_in_new_rounded,
              uri: Uri.parse(Donnees.github),
            ),
            _tuile(
              context,
              icon: Icons.language_rounded,
              couleur: const Color(0xFF0EA5E9),
              label: 'Portfolio',
              valeur: 'portfoliodek.netlify.app',
              action: Icons.open_in_new_rounded,
              uri: Uri.parse(Donnees.portfolio),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tuile(
    BuildContext context, {
    required IconData icon,
    required Color couleur,
    required String label,
    required String valeur,
    required IconData action,
    required Uri uri,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CardBox(
        padding: const EdgeInsets.all(14),
        onTap: () => ouvrir(context, uri),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: couleur.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: couleur, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: font(12, w: FontWeight.w600, c: kInk3)),
                  const SizedBox(height: 3),
                  Text(valeur, style: font(14.5, w: FontWeight.w700), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(action, size: 18, color: kInk2),
            ),
          ],
        ),
      ),
    );
  }
}
