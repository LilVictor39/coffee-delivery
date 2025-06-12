import {
  IsString,
  IsNumber,
  IsArray,
  ArrayNotEmpty,
  Min,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';

export class CreateCoffeeDto {
  @IsString()
  @IsNotEmpty()
  nome: string;

  @IsString()
  @IsNotEmpty()
  tipo: string;

  @IsNumber()
  @Min(0)
  preco: number;

  @IsString()
  @IsNotEmpty()
  descricao: string;

  @IsArray()
  @ArrayNotEmpty()
  @IsString({ each: true })
  tags: string[];

  @IsOptional()
  @IsNumber()
  @Min(0)
  quantidade?: number;
}