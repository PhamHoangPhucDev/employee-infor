/// Failure mapping sang tầng domain
abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
