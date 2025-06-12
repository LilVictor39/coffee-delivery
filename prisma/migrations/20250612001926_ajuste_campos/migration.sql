/*
  Warnings:

  - The values [EM_PREPARO] on the enum `StatusEntrega` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `dataPrevistaEntrega` on the `Entrega` table. All the data in the column will be lost.
  - You are about to drop the column `enderecoEntrega` on the `Entrega` table. All the data in the column will be lost.
  - You are about to drop the column `precoUnitario` on the `ItemPedido` table. All the data in the column will be lost.
  - You are about to drop the column `dataPedido` on the `Pedido` table. All the data in the column will be lost.
  - You are about to drop the column `totalPedido` on the `Pedido` table. All the data in the column will be lost.
  - Made the column `telefone` on table `Cliente` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `dataPrevista` to the `Entrega` table without a default value. This is not possible if the table is not empty.
  - Added the required column `endereco` to the `Entrega` table without a default value. This is not possible if the table is not empty.
  - Added the required column `preco` to the `ItemPedido` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total` to the `Pedido` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "StatusEntrega_new" AS ENUM ('PENDENTE', 'EM_TRANSITO', 'ENTREGUE');
ALTER TABLE "Entrega" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Entrega" ALTER COLUMN "status" TYPE "StatusEntrega_new" USING ("status"::text::"StatusEntrega_new");
ALTER TYPE "StatusEntrega" RENAME TO "StatusEntrega_old";
ALTER TYPE "StatusEntrega_new" RENAME TO "StatusEntrega";
DROP TYPE "StatusEntrega_old";
COMMIT;

-- AlterTable
ALTER TABLE "Cliente" ALTER COLUMN "telefone" SET NOT NULL;

-- AlterTable
ALTER TABLE "Entrega" DROP COLUMN "dataPrevistaEntrega",
DROP COLUMN "enderecoEntrega",
ADD COLUMN     "dataPrevista" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "endereco" TEXT NOT NULL,
ALTER COLUMN "status" DROP DEFAULT;

-- AlterTable
ALTER TABLE "ItemPedido" DROP COLUMN "precoUnitario",
ADD COLUMN     "preco" DOUBLE PRECISION NOT NULL;

-- AlterTable
ALTER TABLE "Pedido" DROP COLUMN "dataPedido",
DROP COLUMN "totalPedido",
ADD COLUMN     "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "total" DOUBLE PRECISION NOT NULL;
