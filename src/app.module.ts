import { MiddlewareConsumer, Module, NestModule, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthMiddleware } from './common/middlewares/auth.middleware';
import { SessionModule } from './common/core/sessions/session.module';
import { UserModule } from './api/user/user.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './api/auth/auth.module';

@Module({
 imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    SessionModule,
    UserModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude(
        { path: '/auth/login', method: RequestMethod.POST },
        { path: '/auth/register', method: RequestMethod.POST },
        { path: '/auth/refresh', method: RequestMethod.POST }
      )
      .forRoutes('*')
  }
}
