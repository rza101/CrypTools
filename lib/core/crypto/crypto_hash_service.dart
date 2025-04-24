import 'dart:typed_data';

enum HashAlgorithms {
  blake2b('Blake2b'),
  md2('MD2'),
  md4('MD4'),
  md5('MD5'),
  ripemd128('RIPEMD-128'),
  ripemd160('RIPEMD-160'),
  ripemd256('RIPEMD-256'),
  ripemd320('RIPEMD-320'),
  sha1('SHA-1'),
  sha224('SHA-224'),
  sha256('SHA-256'),
  sha384('SHA-384'),
  sha512('SHA-512'),
  sha512_224('SHA-512/224'),
  sha512_256('SHA-512/256'),
  keccak224('Keccak/224'),
  keccak256('Keccak/256'),
  keccak384('Keccak/384'),
  keccak512('Keccak/512'),
  sha3_224('SHA3-224'),
  sha3_256('SHA3-256'),
  sha3_384('SHA3-384'),
  sha3_512('SHA3-512'),
  tiger('Tiger'),
  whirlpool('Whirlpool'),
  sm3('SM3');

  const HashAlgorithms(this.label);

  final String label;
}

abstract class CryptoHashService {
  Future<String> hashBytes(HashAlgorithms algorithm, Uint8List input);

  Future<String> hashByteStream(
    HashAlgorithms algorithm,
    Stream<Uint8List> stream,
  );
}
