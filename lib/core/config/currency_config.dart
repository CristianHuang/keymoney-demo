import 'package:money2/money2.dart';

class CurrencyConfig {
  static final Currency usd = Currency.create(
    'USD',
    2,
    symbol: r'$',
    pattern: r'S###,###.00',
  );

  static final Currency ars = Currency.create(
    'ARS',
    2,
    symbol: r'$',
    pattern: r'S###,###.00',
  );

  static final Currency bob = Currency.create(
    'BOB',
    2,
    symbol: r'Bs',
    pattern: r'S###,###.00',
  );

  static final Currency brl = Currency.create(
    'BRL',
    2,
    symbol: r'R$',
    pattern: r'S###,###.00',
  );

  static final Currency clp = Currency.create(
    'CLP',
    0,
    symbol: r'$',
    pattern: r'S###,###',
  );

  static final Currency cop = Currency.create(
    'COP',
    0,
    symbol: r'$',
    pattern: r'S###,###',
  );

  static final Currency crc = Currency.create(
    'CRC',
    2,
    symbol: r'₡',
    pattern: r'S###,###.00',
  );

  static final Currency dop = Currency.create(
    'DOP',
    2,
    symbol: r'RD$',
    pattern: r'S###,###.00',
  );

  static final Currency gtq = Currency.create(
    'GTQ',
    2,
    symbol: r'Q',
    pattern: r'S###,###.00',
  );

  static final Currency hnl = Currency.create(
    'HNL',
    2,
    symbol: r'L',
    pattern: r'S###,###.00',
  );

  static final Currency mxn = Currency.create(
    'MXN',
    2,
    symbol: r'$',
    pattern: r'S###,###.00',
  );

  static final Currency nio = Currency.create(
    'NIO',
    2,
    symbol: r'C$',
    pattern: r'S###,###.00',
  );

  static final Currency pab = Currency.create(
    'PAB',
    2,
    symbol: r'B/.',
    pattern: r'S###,###.00',
  );

  static final Currency pen = Currency.create(
    'PEN',
    2,
    symbol: r'S/',
    pattern: r'S###,###.00',
  );

  static final Currency pyg = Currency.create(
    'PYG',
    0,
    symbol: r'₲',
    pattern: r'S###,###',
  );

  static final Currency uyu = Currency.create(
    'UYU',
    2,
    symbol: r'$U',
    pattern: r'S###,###.00',
  );

  static final Currency ves = Currency.create(
    'VES',
    2,
    symbol: r'Bs',
    pattern: r'S###,###.00',
  );

  static final Currency bzd = Currency.create(
    'BZD',
    2,
    symbol: r'BZ$',
    pattern: r'S###,###.00',
  );

  static final Currency jmd = Currency.create(
    'JMD',
    2,
    symbol: r'J$',
    pattern: r'S###,###.00',
  );

  static final Currency ttd = Currency.create(
    'TTD',
    2,
    symbol: r'TT$',
    pattern: r'S###,###.00',
  );

  static final Currency gyd = Currency.create(
    'GYD',
    2,
    symbol: r'G$',
    pattern: r'S###,###.00',
  );

  static final Currency srd = Currency.create(
    'SRD',
    2,
    symbol: r'Sr$',
    pattern: r'S###,###.00',
  );

  static final Currency htg = Currency.create(
    'HTG',
    2,
    symbol: r'G',
    pattern: r'S###,###.00',
  );

  static final List<Currency> allCurrencies = [
    usd,
    ars,
    bob,
    brl,
    clp,
    cop,
    crc,
    dop,
    gtq,
    hnl,
    mxn,
    nio,
    pab,
    pen,
    pyg,
    uyu,
    ves,
    bzd,
    jmd,
    ttd,
    gyd,
    srd,
    htg,
  ];

  static void init() {
    Currencies().register(usd);
    Currencies().register(cop);
  }
}
