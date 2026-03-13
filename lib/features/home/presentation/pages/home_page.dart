import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';
import 'package:keymoneydemo/features/home/presentation/bloc/home_state_bloc.dart';
import 'package:keymoneydemo/features/home/presentation/bloc/home_state_state.dart';
import 'package:keymoneydemo/features/home/presentation/widgets/account_card.dart';
import 'package:keymoneydemo/features/home/presentation/widgets/budget_card.dart';
import 'package:keymoneydemo/features/home/presentation/widgets/history_card.dart';
import 'package:money2/money2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeStateBloc()..add(HomeStarted()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.background,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeStateBloc, HomeState>(
                builder: (context, state) {
                  return Text(
                    state.greeting,
                    style: TextStyle(
                      color: AppColors.textInactive,
                      fontSize: 14,
                    ),
                  );
                },
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String name = "";
                  if (state is AuthSuccess) {
                    name = state.user.email.split('@')[0];
                  }
                  return Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
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
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment(0.8, -1.0),
                      end: Alignment(-0.8, 1.0),
                      colors: [Color(0xFF6B0ACC), Color(0xFF533B6A)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PATRIMONIO TOTAL",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Money.fromInt(1000, isoCode: 'USD').toString(),
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "+2.3% este mes",
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Añadir fondos",
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cuentas conectadas",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 135,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == accounts.length - 1 ? 10 : 10,
                            ),
                            child: accounts[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gastos mensuales",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    BudgetCard(
                      spent: Money.fromInt(2200, isoCode: 'USD'),
                      limit: Money.fromInt(6500, isoCode: 'USD'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Actividad reciente",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Ver todo",
                            style: TextStyle(
                              color: AppColors.textInactive2,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: history.reversed.take(4).map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: item,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<AccountCard> accounts = [
  AccountCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/bankIc.svg",
      colorFilter: ColorFilter.mode(const Color(0xFFA214A9), BlendMode.srcIn),
    ),
    accountName: "Banco Guayaquil",
    accountType: "Cuenta de ahorro",
    balance: Money.fromInt(0, isoCode: 'USD'),
  ),
  AccountCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/bankIc.svg",
      colorFilter: ColorFilter.mode(const Color(0xFFE1C40C), BlendMode.srcIn),
    ),
    accountName: "Banco Pichincha",
    accountType: "Cuenta corriente",
    balance: Money.fromInt(0, isoCode: 'USD'),
  ),
  AccountCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/money.svg",
      colorFilter: ColorFilter.mode(const Color(0xFF017A07), BlendMode.srcIn),
    ),
    accountName: "Efectivo",
    accountType: "",
    balance: Money.fromInt(100, isoCode: 'USD'),
  ),
];

List<HistoryCard> history = [
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 minutos",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "income",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 horas",
    type: "expense",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
  HistoryCard(
    bankIcon: SvgPicture.asset(
      "assets/icons/coffee.svg",
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    title: "Café en Juan Valdez",
    category: "Comida y bebida",
    time: "2 minutos",
    type: "income",
    amount: Money.fromInt(100, isoCode: 'USD'),
  ),
];
