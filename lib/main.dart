import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

const String kBaseUrl = 'http://localhost/api-test/public';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CvApp());
}

class Membre {
  final int? id;
  final String nom;
  final String postnom;
  final String prenom;
  final String lieuNaissance;
  final String dateNaissance;
  final String parente;
  final String? imageUrl;

  Membre({
    this.id,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.lieuNaissance,
    required this.dateNaissance,
    required this.parente,
    this.imageUrl,
  });

  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      id: json['id'],
      nom: json['nom'] ?? '',
      postnom: json['postnom'] ?? '',
      prenom: json['prenom'] ?? '',
      lieuNaissance: json['lieu_naissance'] ?? '',
      dateNaissance: json['date_naissance'] ?? '',
      parente: json['parente'] ?? '',
      imageUrl: json['image_url'],
    );
  }

  Map<String, String> toJson() {
    return {
      'nom': nom,
      'postnom': postnom,
      'prenom': prenom,
      'lieu_naissance': lieuNaissance,
      'date_naissance': dateNaissance,
      'parente': parente,
    };
  }
}

class ApiService {
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/accounts/login'),
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 200 && data['success'] == true) {
      return data;
    }
    throw Exception(data['message'] ?? 'Erreur de connexion');
  }

  static Future<List<Membre>> getMembres() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/famille-membres'),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final list = data['data'] as List;
      return list.map((e) => Membre.fromJson(e)).toList();
    }
    throw Exception('Erreur lors du chargement');
  }

  static String _parseError(http.Response res) {
    try {
      final data = jsonDecode(res.body);
      if (data['errors'] != null) {
        return (data['errors'] as Map).values.first.toString();
      }
      return data['message'] ?? 'Erreur inconnue';
    } catch (_) {
      return 'Erreur serveur (${res.statusCode})';
    }
  }

  static Future<void> addMembre(Membre m, {File? image}) async {
    try {
      if (image != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('$kBaseUrl/famille-membres'),
        );
        request.headers.addAll({'Accept': 'application/json'});
        request.fields.addAll(m.toJson());
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );

        final response = await request.send();
        final res = await http.Response.fromStream(response);
        if (res.statusCode != 201) throw Exception(_parseError(res));
      } else {
        final res = await http.post(
          Uri.parse('$kBaseUrl/famille-membres'),
          headers: _headers,
          body: jsonEncode(m.toJson()),
        );
        if (res.statusCode != 201) throw Exception(_parseError(res));
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  static Future<void> updateMembre(Membre m, {File? image}) async {
    try {
      if (image != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('$kBaseUrl/famille-membres/${m.id}'),
        );
        request.headers.addAll({'Accept': 'application/json'});
        request.fields.addAll(m.toJson());
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );

        final response = await request.send();
        final res = await http.Response.fromStream(response);
        if (res.statusCode != 200) throw Exception(_parseError(res));
      } else {
        final res = await http.put(
          Uri.parse('$kBaseUrl/famille-membres/${m.id}'),
          headers: _headers,
          body: jsonEncode(m.toJson()),
        );
        if (res.statusCode != 200) throw Exception(_parseError(res));
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  static Future<void> deleteMembre(int id) async {
    final res = await http.delete(
      Uri.parse('$kBaseUrl/famille-membres/$id'),
      headers: _headers,
    );
    if (res.statusCode != 200) throw Exception('Erreur lors de la suppression');
  }
}

class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> missions;
  const Experience(
    this.role,
    this.company,
    this.period,
    this.location,
    this.missions,
  );
}

class CompetenceGroupe {
  final String titre;
  final IconData icon;
  final List<String> items;
  const CompetenceGroupe(this.titre, this.icon, this.items);
}

class Donnees {
  static const nom = 'Dekens Ruzuba';
  static const titre = 'Développeur Fullstack & Créateur d\'Agents IA';
  static const photo = 'assets/images/dek.jpg';

  static const email = 'ruzubadekens@gmail.com';
  static const telephone = '+243 893 292 330';
  static const localisation = 'Goma, RDC';

  static const portfolio = 'https://portfoliodek.netlify.app/';
  static const github = 'https://github.com/dekensruz';
  static const linkedin = 'https://linkedin.com/in/dekens-ruzuba';

  static const profil =
      "Développeur fullstack polyvalent, je crée des applications web, desktop et mobiles. Maîtrisant aussi la création d'Agents IA, le design, la 3D et le montage vidéo, j'offre des solutions numériques complètes, performantes et sur mesure.";

  static const competences = <CompetenceGroupe>[
    CompetenceGroupe('Développement & Frameworks', Icons.code_rounded, [
      'C#',
      '.NET',
      'Blazor',
      'React',
      'Node.js',
      'Next.js',
      'Flutter',
      'HTML5 / CSS3',
      'SQL Server',
      'Git',
    ]),
    CompetenceGroupe(
      'Intelligence Artificielle & Automatisation',
      Icons.psychology_rounded,
      ['Création d\'Agents IA', 'Intégration IA', 'n8n', 'Outils d\'IA'],
    ),
    CompetenceGroupe('Design & Création', Icons.design_services_rounded, [
      'UI/UX Design',
      'Figma',
      'Photoshop',
      'Illustrator',
      'Blender (3D)',
      'Premiere Pro (Vidéo)',
    ]),
    CompetenceGroupe('Bureautique & Gestion', Icons.workspace_premium_rounded, [
      'Google Workspace',
      'Suite Office',
    ]),
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
        'Contribution à la mise en place d\'un logiciel de gestion complète automatisant les processus clés.',
      ],
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
        'Accompagnement technique et conseil auprès des équipes et clients.',
      ],
    ),
    Experience(
      'Développeur & Créateur d\'Agents IA',
      'Getdjukey (Freelance)',
      'Juillet 2025 - Aujourd\'hui',
      'Minnesota, USA (À distance)',
      [
        'Création d\'agents IA, d\'applications web et mobile.',
        'Formation en ligne des agents de l\'entreprise sur la programmation et l\'IA.',
      ],
    ),
    Experience(
      'Formateur',
      'CFPI (ISIG)',
      'Avril 2026 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Animation de formations sur l\'intelligence artificielle et la conception d\'agents IA.',
        'Formation sur le Web Design.',
      ],
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
        'Formation sur Photoshop.',
      ],
    ),
    Experience(
      'Développeur & Créateur d\'Agents IA',
      'Leka Company (Remote)',
      'Juillet 2026 - Aujourd\'hui',
      'Bukavu, RDC',
      [
        'Développement d\'applications web, mobiles et Desktop.',
        'Conception et intégration de solutions d\'Intelligence Artificielle.',
      ],
    ),
    Experience(
      'Consultant Créateur d\'Agents IA',
      'LeoKongo (Freelance)',
      'Juin 2024 - Aujourd\'hui',
      'Goma, RDC',
      [
        'Créations d\'Agents IA.',
        'Intégration de l\'Intelligence Artificielle dans l\'application MyAfya.',
      ],
    ),
  ];

  static const formations = [
    [
      'Licence en Sciences Informatiques, Génie Logiciel',
      'ISIG Goma',
      '2023 - 2027',
    ],
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
    'Écriture',
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
}) => GoogleFonts.plusJakartaSans(
  fontSize: size,
  fontWeight: w,
  color: c,
  height: h,
  letterSpacing: ls,
);

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
        ).copyWith(primary: kAccent, surface: kSurface, onSurface: kInk),
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

class Photo extends StatelessWidget {
  final String? asset;
  final String? networkUrl;
  final String nom;
  final double size;
  final double radius;
  final bool circle;
  final Color? borderColor;
  final double borderWidth;

  const Photo({
    super.key,
    this.asset,
    this.networkUrl,
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
      child: PhotoFill(
        asset: asset,
        networkUrl: networkUrl,
        nom: nom,
        fontSize: size * 0.4,
      ),
    );
  }
}

class PhotoFill extends StatelessWidget {
  final String? asset;
  final String? networkUrl;
  final String nom;
  final double fontSize;
  const PhotoFill({
    super.key,
    this.asset,
    this.networkUrl,
    required this.nom,
    this.fontSize = 36,
  });

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
      child: Text(
        initiale,
        style: font(fontSize, w: FontWeight.w800, c: kAccent),
      ),
    );

    if (networkUrl != null && networkUrl!.isNotEmpty) {
      return Image.network(
        networkUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }
    if (asset != null && asset!.isNotEmpty) {
      return Image.asset(
        asset!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }
    return placeholder;
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

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

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
                Text(
                  title,
                  style: font(
                    26,
                    w: FontWeight.w800,
                    c: Colors.white,
                    ls: -0.6,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: font(
                    13.5,
                    c: Colors.white.withValues(alpha: 0.85),
                    h: 1.4,
                  ),
                ),
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

void toast(BuildContext context, String msg, {bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: font(13, w: FontWeight.w500, c: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        backgroundColor: isError ? kDanger : kInk,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
}

Future<void> ouvrir(BuildContext context, Uri uri) async {
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) toast(context, 'Impossible d\'ouvrir ce lien.');
}

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

    try {
      await ApiService.login(_idCtrl.text.trim(), _mdpCtrl.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => const MainShell(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _loading = false);
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
            Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(36),
                ),
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
                          Text(
                            'Bienvenue',
                            style: font(
                              38,
                              w: FontWeight.w800,
                              c: Colors.white,
                              h: 1.1,
                              ls: -1.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Connectez-vous pour découvrir\nmon CV, ma famille et mes contacts.',
                            style: font(
                              15,
                              c: Colors.white.withValues(alpha: 0.88),
                              h: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -56),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CardBox(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Connexion',
                        style: font(20, w: FontWeight.w800, ls: -0.3),
                      ),
                      const SizedBox(height: 22),
                      _buildField(
                        label: 'Identifiant (Email)',
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
                          icon: Icon(
                            _hide
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: kInk3,
                          ),
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
                              const Icon(
                                Icons.error_outline,
                                size: 18,
                                color: kDanger,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: font(
                                    13,
                                    w: FontWeight.w500,
                                    c: kDanger,
                                  ),
                                ),
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
          child: Text(
            label,
            style: font(13, w: FontWeight.w600, c: kInk2),
          ),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: Icon(icon, color: kInk3, size: 20),
            suffixIcon: suffix,
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: kAccent, width: 1.5),
            ),
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
  const _GradientButton({
    required this.loading,
    required this.label,
    this.onTap,
  });

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
            BoxShadow(
              color: kAccent.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
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
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: font(16, w: FontWeight.w700, c: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
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
            labelTextStyle: WidgetStateProperty.resolveWith(
              (s) => font(
                12,
                w: s.contains(WidgetState.selected)
                    ? FontWeight.w700
                    : FontWeight.w500,
                c: s.contains(WidgetState.selected) ? kAccent : kInk3,
              ),
            ),
            iconTheme: WidgetStateProperty.resolveWith(
              (s) => IconThemeData(
                size: 24,
                color: s.contains(WidgetState.selected) ? kAccent : kInk3,
              ),
            ),
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
                label: 'Accueil',
              ),
              NavigationDestination(
                icon: Icon(Icons.work_outline_rounded),
                selectedIcon: Icon(Icons.work_rounded),
                label: 'Parcours',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(Icons.people_rounded),
                label: 'Famille',
              ),
              NavigationDestination(
                icon: Icon(Icons.mail_outline_rounded),
                selectedIcon: Icon(Icons.mail_rounded),
                label: 'Contact',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            Container(
              padding: const EdgeInsets.fromLTRB(22, 18, 18, 24),
              decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: kAccent.withValues(alpha: 0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mon CV',
                        style: font(
                          14,
                          w: FontWeight.w600,
                          c: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      Material(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onLogout,
                          child: const Padding(
                            padding: EdgeInsets.all(9),
                            child: Icon(
                              Icons.logout_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
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
                            Text(
                              Donnees.nom,
                              style: font(
                                24,
                                w: FontWeight.w800,
                                c: Colors.white,
                                ls: -0.5,
                                h: 1.15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              Donnees.titre,
                              style: font(
                                13,
                                w: FontWeight.w500,
                                c: Colors.white.withValues(alpha: 0.9),
                                h: 1.4,
                              ),
                            ),
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
                      _chipBlanc(
                        Icons.location_on_rounded,
                        Donnees.localisation,
                      ),
                      _chipBlanc(Icons.school_rounded, 'ISIG Goma'),
                    ],
                  ),
                ],
              ),
            ),

            const SectionTitle('À propos', icon: Icons.person_rounded),
            CardBox(
              child: Text(Donnees.profil, style: font(14, c: kInk2, h: 1.65)),
            ),

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
                            child: const Icon(
                              Icons.school_outlined,
                              size: 18,
                              color: kAccent,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Donnees.formations[i][0],
                                  style: font(14.5, w: FontWeight.w700, h: 1.3),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  Donnees.formations[i][1],
                                  style: font(13, c: kInk2),
                                ),
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

            const SectionTitle(
              'Compétences techniques',
              icon: Icons.bolt_rounded,
            ),
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
                          Expanded(
                            child: Text(
                              comp.titre,
                              style: font(14, w: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: comp.items
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: kBg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: kBorder),
                                ),
                                child: Text(
                                  e,
                                  style: font(12, w: FontWeight.w600, c: kInk2),
                                ),
                              ),
                            )
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
                      padding: EdgeInsets.only(
                        bottom: i == Donnees.langues.length - 1 ? 0 : 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Donnees.langues[i][0],
                                style: font(14, w: FontWeight.w700),
                              ),
                              Text(
                                Donnees.langues[i][1],
                                style: font(
                                  12.5,
                                  w: FontWeight.w600,
                                  c: kAccent,
                                ),
                              ),
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

            const SectionTitle(
              'Centres d\'intérêt',
              icon: Icons.favorite_rounded,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: Donnees.interets
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: kAccentSoft,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: kAccent.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text(
                        e,
                        style: font(12.5, w: FontWeight.w700, c: kAccent),
                      ),
                    ),
                  )
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
        Text(
          text,
          style: font(12, w: FontWeight.w600, c: Colors.white),
        ),
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
      Text(
        text,
        style: font(11, w: FontWeight.w600, c: kInk2),
      ),
    ],
  ),
);

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
            subtitle:
                '${xp.length} expériences : emplois, missions freelance et formations.',
            icon: Icons.work_rounded,
          ),
          const SizedBox(height: 24),
          for (int i = 0; i < xp.length; i++)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                            color: i == xp.length - 1
                                ? Colors.transparent
                                : kAccent.withValues(alpha: 0.18),
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
                            Text(
                              xp[i].role,
                              style: font(15.5, w: FontWeight.w800, h: 1.3),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              xp[i].company,
                              style: font(13.5, w: FontWeight.w700, c: kAccent),
                            ),
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
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                      color: kInk3,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      xp[i].location,
                                      style: font(11.5, c: kInk3),
                                    ),
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
                                      padding: EdgeInsets.only(
                                        top: 3,
                                        right: 8,
                                      ),
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: 14,
                                        color: kAccent,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        m,
                                        style: font(13, c: kInk2, h: 1.5),
                                      ),
                                    ),
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

class FamillePage extends StatefulWidget {
  const FamillePage({super.key});
  @override
  State<FamillePage> createState() => _FamillePageState();
}

class _FamillePageState extends State<FamillePage> {
  List<Membre> _membres = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      _membres = await ApiService.getMembres();
    } catch (e) {
      if (mounted) toast(context, 'Erreur: $e', isError: true);
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showForm({Membre? membre}) {
    final nomCtrl = TextEditingController(text: membre?.nom ?? '');
    final postnomCtrl = TextEditingController(text: membre?.postnom ?? '');
    final prenomCtrl = TextEditingController(text: membre?.prenom ?? '');
    final lieuCtrl = TextEditingController(text: membre?.lieuNaissance ?? '');
    final dateCtrl = TextEditingController(text: membre?.dateNaissance ?? '');
    final parenteCtrl = TextEditingController(text: membre?.parente ?? '');
    File? image;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: kBorder,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      membre == null
                          ? 'Ajouter un membre'
                          : 'Modifier le membre',
                      style: font(20, w: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField('Nom', nomCtrl, required: true),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            'Postnom',
                            postnomCtrl,
                            required: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildField('Prénom', prenomCtrl, required: true),
                    const SizedBox(height: 12),
                    _buildField('Lieu de naissance', lieuCtrl, required: true),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: dateCtrl,
                      readOnly: true,
                      style: font(14, w: FontWeight.w500),
                      decoration: _inputDeco(
                        'Date de naissance',
                        suffix: const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: kInk3,
                        ),
                      ),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setSheetState(() {
                            dateCtrl.text = DateFormat('yyyy-MM-dd')
                                .format(picked);
                          });
                        }
                      },
                      validator: (v) => v!.isEmpty ? 'Requis' : null,
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      'Lien de parenté (ex: Père)',
                      parenteCtrl,
                      required: true,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picked != null)
                          setSheetState(() => image = File(picked.path));
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kBorder),
                        foregroundColor: kAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.image_outlined),
                      label: Text(
                        image == null
                            ? 'Choisir une photo (Optionnel)'
                            : 'Photo sélectionnée',
                        style: font(13, w: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;

                          final m = Membre(
                            id: membre?.id,
                            nom: nomCtrl.text,
                            postnom: postnomCtrl.text,
                            prenom: prenomCtrl.text,
                            lieuNaissance: lieuCtrl.text,
                            dateNaissance: dateCtrl.text,
                            parente: parenteCtrl.text,
                          );

                          try {
                            if (membre == null) {
                              await ApiService.addMembre(m, image: image);
                            } else {
                              await ApiService.updateMembre(m, image: image);
                            }
                            if (ctx.mounted) Navigator.pop(ctx);
                            _load();
                          } catch (e) {
                            if (ctx.mounted)
                              toast(ctx, 'Erreur: $e', isError: true);
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: kAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Enregistrer',
                          style: font(15, w: FontWeight.w700, c: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl, {
    bool required = false,
  }) {
    return TextFormField(
      controller: ctrl,
      style: font(14, w: FontWeight.w500),
      decoration: _inputDeco(label),
      validator: (v) => (required && v!.isEmpty) ? 'Requis' : null,
    );
  }

  InputDecoration _inputDeco(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: font(13, c: kInk2),
      suffixIcon: suffix,
      filled: true,
      fillColor: kBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kAccent, width: 1.5),
      ),
    );
  }

  void _delete(Membre m) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Supprimer', style: font(18, w: FontWeight.bold)),
        content: Text('Voulez-vous supprimer ${m.nom} ?', style: font(14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Annuler', style: font(14, c: kInk2)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: kDanger),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ApiService.deleteMembre(m.id!);
                _load();
              } catch (e) {
                if (context.mounted) toast(context, '$e', isError: true);
              }
            },
            child: Text('Supprimer', style: font(14, c: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parents = _membres
        .where((e) => e.parente == 'Père' || e.parente == 'Mère')
        .toList();
    final fratrie = _membres
        .where((e) => e.parente != 'Père' && e.parente != 'Mère')
        .toList();

    return Scaffold(
      backgroundColor: kBg,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        backgroundColor: kAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        bottom: false,
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: kAccent))
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PageHeader(
                      title: 'Ma Famille',
                      subtitle:
                          '${_membres.length} personnes qui m\'accompagnent au quotidien.',
                      icon: Icons.family_restroom_rounded,
                    ),

                    if (parents.isNotEmpty) ...[
                      const SectionTitle(
                        'Parents',
                        icon: Icons.favorite_rounded,
                      ),
                      for (var p in parents)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CardBox(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Photo(
                                  networkUrl: p.imageUrl,
                                  nom: p.nom,
                                  size: 60,
                                  circle: true,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${p.nom} ${p.prenom}',
                                        style: font(16, w: FontWeight.w700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      _lien(p.parente),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: kInk3,
                                  ),
                                  onSelected: (v) {
                                    if (v == 'edit') _showForm(membre: p);
                                    if (v == 'delete') _delete(p);
                                  },
                                  itemBuilder: (c) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Modifier'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Supprimer',
                                        style: TextStyle(color: kDanger),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],

                    if (fratrie.isNotEmpty) ...[
                      const SectionTitle(
                        'Frères & Sœurs',
                        icon: Icons.people_rounded,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    child: PhotoFill(
                                      networkUrl: f.imageUrl,
                                      nom: f.nom,
                                      fontSize: 44,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    6,
                                    10,
                                    6,
                                    4,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${f.nom} ${f.prenom}',
                                              style: font(
                                                15,
                                                w: FontWeight.w700,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            _lien(f.parente),
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: kInk3,
                                          size: 18,
                                        ),
                                        onSelected: (v) {
                                          if (v == 'edit') _showForm(membre: f);
                                          if (v == 'delete') _delete(f);
                                        },
                                        itemBuilder: (c) => [
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Modifier'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text(
                                              'Supprimer',
                                              style: TextStyle(color: kDanger),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
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
    child: Text(
      role,
      style: font(11.5, w: FontWeight.w700, c: kAccent),
    ),
  );
}

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
              subtitle:
                  'Touchez un élément pour appeler, écrire ou ouvrir le lien.',
              icon: Icons.mail_rounded,
            ),

            const SectionTitle(
              'Coordonnées',
              icon: Icons.contact_phone_rounded,
            ),
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
              uri: Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(Donnees.localisation)}',
              ),
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
                  Text(
                    label,
                    style: font(12, w: FontWeight.w600, c: kInk3),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    valeur,
                    style: font(14.5, w: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
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
