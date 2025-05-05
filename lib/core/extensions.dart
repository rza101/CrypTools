import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:pointycastle/pointycastle.dart';

extension ScreenSizeUtil on BuildContext {
  bool isWideScreen() => MediaQuery.sizeOf(this).width >= 600;
}

extension BytesConverter on Uint8List {
  String toHexString() =>
      map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

// based on https://pub.dev/packages/crypton
extension RSAPublicKeyFormatter on RSAPublicKey {
  String toPEM() {
    final algorithmAsn1Obj = ASN1Object.fromBytes(
      Uint8List.fromList([
        0x6,
        0x9,
        0x2a,
        0x86,
        0x48,
        0x86,
        0xf7,
        0xd,
        0x1,
        0x1,
        0x1,
      ]),
    );
    final paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));

    final algorithmSeq =
        ASN1Sequence()
          ..add(algorithmAsn1Obj)
          ..add(paramsAsn1Obj);

    final publicKeySeq =
        ASN1Sequence()
          ..add(ASN1Integer(modulus))
          ..add(ASN1Integer(exponent));

    final publicKeySeqBitString = ASN1BitString(
      stringValues: publicKeySeq.encode(),
    );

    final topLevelSeq = ASN1Sequence();
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqBitString);

    final base = base64.encode(topLevelSeq.encode());
    var formatted = '';

    for (var i = 0; i < base.length; i++) {
      if (i % 64 == 0 && i != 0) {
        formatted += '\n';
      }
      formatted += base[i];
    }

    return '-----BEGIN PUBLIC KEY-----\n$formatted\n-----END PUBLIC KEY-----';
  }
}

extension RSAPrivateKeyFormatter on RSAPrivateKey {
  String toPEM() {
    final version = ASN1Integer(BigInt.from(0));

    final algorithmAsn1Obj = ASN1Object.fromBytes(
      Uint8List.fromList([
        0x6,
        0x9,
        0x2a,
        0x86,
        0x48,
        0x86,
        0xf7,
        0xd,
        0x1,
        0x1,
        0x1,
      ]),
    );
    final paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));

    final algorithmSeq =
        ASN1Sequence()
          ..add(algorithmAsn1Obj)
          ..add(paramsAsn1Obj);

    final modulus = ASN1Integer(n);
    final publicExponent = ASN1Integer(BigInt.parse('65537'));
    final privateExponent = ASN1Integer(this.privateExponent);
    final p = ASN1Integer(this.p);
    final q = ASN1Integer(this.q);
    final dP = this.privateExponent! % (this.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = this.privateExponent! % (this.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = this.q!.modInverse(this.p!);
    final co = ASN1Integer(iQ);

    final privateKeySeq =
        ASN1Sequence()
          ..add(version)
          ..add(modulus)
          ..add(publicExponent)
          ..add(privateExponent)
          ..add(p)
          ..add(q)
          ..add(exp1)
          ..add(exp2)
          ..add(co);

    final publicKeySeqOctetString = ASN1OctetString(
      octets: privateKeySeq.encode(),
    );

    final topLevelSeq = ASN1Sequence();
    topLevelSeq.add(version);
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqOctetString);

    final base = base64.encode(topLevelSeq.encode());
    var formatted = '';

    for (var i = 0; i < base.length; i++) {
      if (i % 64 == 0 && i != 0) {
        formatted += '\n';
      }
      formatted += base[i];
    }

    return '-----BEGIN RSA PRIVATE KEY-----\n$formatted\n-----END RSA PRIVATE KEY-----';
  }
}
