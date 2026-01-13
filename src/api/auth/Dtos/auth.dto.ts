import { IsString, IsNumber, Min, Matches, IsIn, IsNotEmpty, IsEmail, IsEnum } from 'class-validator';
import { UserRole } from 'generated/prisma/enums';

export class registerUserDto{
    @IsNotEmpty()
    @IsEmail()
    email: string

    @IsNotEmpty()
    @IsEmail()
    password: string

    @IsEnum(UserRole)
    role: UserRole
}

export class loginUserDto{
    @IsNotEmpty()
    @IsEmail()
    email: string

    @IsNotEmpty()
    @IsEmail()
    password: string
}