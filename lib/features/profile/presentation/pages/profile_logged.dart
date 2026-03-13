import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/core/util/bottom_sheet.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:keymoneydemo/features/profile/presentation/bloc/profile_state_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_event.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';
import 'package:keymoneydemo/injection.dart';
import 'package:keymoneydemo/core/database/database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:intl/intl.dart';
import 'package:keymoneydemo/core/util/bottom_sheet_scroll.dart';
import 'package:keymoneydemo/core/config/currency_config.dart';

class ProfileLogged extends StatefulWidget {
  const ProfileLogged({super.key});

  @override
  State<ProfileLogged> createState() => _ProfileLoggedState();
}

class _ProfileLoggedState extends State<ProfileLogged> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      final email = authState.user.email;
      _emailController.text = email;

      final database = getIt<AppDatabase>();
      _profile = await (database.select(
        database.profiles,
      )..where((t) => t.email.equals(email))).getSingleOrNull();

      if (_profile != null) {
        setState(() {
          _nameController.text = _profile!.name ?? '';
          _countryController.text = _profile!.country ?? '';
          if (_profile!.birthday != null) {
            _birthdayController.text = _dateFormat.format(_profile!.birthday!);
          }
        });
      }

      // Load settings (currency)
      final setting = await (database.select(
        database.settings,
      )..where((t) => t.id.equals(0))).getSingleOrNull();

      if (setting != null) {
        setState(() {
          _currencyController.text = setting.currency;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    if (_profile == null) return;

    final database = getIt<AppDatabase>();
    DateTime? birthday;
    try {
      if (_birthdayController.text.isNotEmpty) {
        birthday = _dateFormat.parse(_birthdayController.text);
      }
    } catch (e) {
      DelightToastBar(
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.background2,
          leading: Icon(Symbols.error, color: AppColors.red),
          title: Text(
            "Formato de fecha inválido (dd/mm/yyyy)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ).show(context);
      return;
    }

    await (database.update(
      database.profiles,
    )..where((t) => t.id.equals(_profile!.id))).write(
      ProfilesCompanion(
        name: Value(_nameController.text),
        country: Value(_countryController.text),
        birthday: Value(birthday),
      ),
    );

    // Update settings (currency)
    await (database.update(database.settings)..where((t) => t.id.equals(0)))
        .write(SettingsCompanion(currency: Value(_currencyController.text)));

    if (mounted) {
      DelightToastBar(
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.background2,
          leading: Icon(Symbols.check_circle, color: AppColors.green),
          title: Text(
            "Cambios guardados",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ).show(context);
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  void _showCurrencyPicker() {
    customBottomSheetScroll(
      context,
      scrollableContent: CurrencyConfig.allCurrencies.map((currency) {
        return ListTile(
          onTap: () {
            setState(() {
              _currencyController.text = currency.isoCode;
            });
            Navigator.pop(context);
          },
          leading: Text(
            currency.symbol,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            currency.isoCode,
            style: const TextStyle(color: AppColors.white),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _countryController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileStateBloc()..add(ProfileStateStarted()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.background,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => customBottomSheet(
                  context,
                  () {},
                  () {},
                  Symbols.delete_outline,
                  AppColors.red,
                  "¿Quieres eliminar tu cuenta?",
                  "Eliminar tu cuenta implica perder todos tus datos y analíticas",
                  "Cancelar",
                  "Eliminar cuenta",
                  AppColors.accent,
                  AppColors.red,
                ),
                icon: Icon(Symbols.delete_outline, color: AppColors.red),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nombre",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppColors.background3,
                        ),
                      ),
                      hintText: "Nombre",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    controller: _nameController,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Correo electrónico",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: TextField(
                    readOnly: true,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textInactive,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppColors.background3,
                        ),
                      ),
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fecha de nacimiento",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: AppColors.background3,
                                  ),
                                ),
                                hintText: "dd/mm/yyyy",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                              controller: _birthdayController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Moneda",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: _showCurrencyPicker,
                            child: AbsorbPointer(
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.white,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Symbols.arrow_drop_down,
                                      color: AppColors.text,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: AppColors.background3,
                                      ),
                                    ),
                                    hintText: "Seleccionar moneda",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                  ),
                                  controller: _currencyController,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  "País de residencia",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 45,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppColors.background3,
                        ),
                      ),
                      hintText: "País",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    controller: _countryController,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 65),
                  ),
                  child: const Text(
                    'Actualizar datos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    customBottomSheet(
                      context,
                      () {},
                      () {
                        context.read<AuthBloc>().add(
                          const AuthSignOutRequested(),
                        );
                      },
                      Symbols.logout,
                      AppColors.red,
                      "¿Quieres cerrar sesión?",
                      "Para volver acceder a tu cuenta, vuelve a iniciar sesión.",
                      "Cancelar",
                      "Cerrar sesión",
                      AppColors.accent,
                      AppColors.red,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 65),
                  ),
                  child: const Text(
                    'Cerrar sesión',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Desarrollado por ",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Cristian Huang",
                            style: TextStyle(
                              color: AppColors.textInactive2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _launchUrl(
                          Uri.parse(
                            'https://www.linkedin.com/in/cristianhuang/',
                          ),
                        );
                      },
                      child: const Text(
                        "Contacto",
                        style: TextStyle(
                          color: AppColors.textInactive3,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "© 2026 KeyMoney. Todos los derechos reservados.",
                      style: const TextStyle(
                        color: AppColors.background3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
