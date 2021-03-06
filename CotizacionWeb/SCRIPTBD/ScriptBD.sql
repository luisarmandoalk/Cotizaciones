USE [COTIZACIONES]
GO
/****** Object:  StoredProcedure [dbo].[DetalleCotizacion]    Script Date: 12/11/2020 10:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DetalleCotizacion]
@id int
AS
select C.IDCOTIZACION,c.RUC, c.IDVENDEDOR, pev.NOMBREPERSONA as NombreVend, c.IDCLIENTE, pecl.NOMBREPERSONA as NombreCli,
p.IDPRODUCTO, p.NOMBREPRODUCTO, p.PRECIOPRODUCTO,
d.CANTIDADxPRODUCTOxDETALLE,
sum(CANTIDADxPRODUCTOxDETALLE * p.PRECIOPRODUCTO) as TOTAL
from COTIZACIONES c 
inner join DETALLES_COTIZACION d on d.IDCOTIZACION = c.IDCOTIZACION
inner join PRODUCTOS p on d.IDPRODUCTO = p.IDPRODUCTO
inner join CLIENTES cl on c.IDCLIENTE = cl.IDCLIENTE
inner join VENDEDORES v on c.IDVENDEDOR = v.ID_VENDEDOR
inner join PERSONAS pecl on cl.IDPERSONA = pecl.IDPERSONA
inner join PERSONAS pev on v.ID_PERSONA = pev.IDPERSONA
WHERE C.IDCOTIZACION = @id
group by C.IDCOTIZACION,c.RUC, c.IDVENDEDOR, pev.NOMBREPERSONA, c.IDCLIENTE, pecl.NOMBREPERSONA,
p.IDPRODUCTO, p.NOMBREPRODUCTO, p.PRECIOPRODUCTO,d.CANTIDADxPRODUCTOxDETALLE;
;

GO
/****** Object:  StoredProcedure [dbo].[GetAllCotizaciones]    Script Date: 12/11/2020 10:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCotizaciones]
AS
select C.IDCOTIZACION,c.RUC,c.IDCLIENTE, c.IDVENDEDOR, 
sum(CANTIDADxPRODUCTOxDETALLE * PRECIOPRODUCTO) as TOTAL
from COTIZACIONES c 
inner join DETALLES_COTIZACION d on d.IDCOTIZACION = c.IDCOTIZACION
inner join PRODUCTOS p on d.IDPRODUCTO = p.IDPRODUCTO
group by c.IDCOTIZACION,c.RUC, c.IDCLIENTE, c.IDVENDEDOR;
GO
/****** Object:  StoredProcedure [dbo].[GetAllPaquetes]    Script Date: 12/11/2020 10:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetAllPaquetes]
AS
select *
from PAQUETES
;

GO
/****** Object:  StoredProcedure [dbo].[GetAllproductos]    Script Date: 12/11/2020 10:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetAllproductos]
AS
select IDPRODUCTO, NOMBREPRODUCTO, DESCRIPCIONPRODUCTO, PRECIOPRODUCTO, STOCK, ID_TIPO
from PRODUCTOS
;
GO
/****** Object:  Table [dbo].[CARGOS]    Script Date: 12/11/2020 10:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGOS](
	[ID_CARGO] [int] IDENTITY(1,1) NOT NULL,
	[CONCEPTO_CARGO] [nvarchar](250) NOT NULL,
	[VALOR_CARGO] [float] NOT NULL,
	[ID_TIPO_CARGO] [int] NOT NULL,
 CONSTRAINT [PK_CARGOS] PRIMARY KEY CLUSTERED 
(
	[ID_CARGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CARGOSXPRODUCTO]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGOSXPRODUCTO](
	[IDPRODUCTO] [int] NOT NULL,
	[ID_CARGO] [int] NOT NULL,
 CONSTRAINT [PK_CARGOSXPRODUCTO] PRIMARY KEY CLUSTERED 
(
	[IDPRODUCTO] ASC,
	[ID_CARGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CLIENTES]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTES](
	[IDCLIENTE] [int] IDENTITY(1,1) NOT NULL,
	[IDPERSONA] [int] NOT NULL,
 CONSTRAINT [PK_CLIENTES] PRIMARY KEY CLUSTERED 
(
	[IDCLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COTIZACIONES]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COTIZACIONES](
	[IDCOTIZACION] [int] IDENTITY(1,1) NOT NULL,
	[RUC] [nvarchar](50) NOT NULL,
	[IDCLIENTE] [int] NOT NULL,
	[IDVENDEDOR] [int] NOT NULL,
 CONSTRAINT [PK_COTIZACIONES] PRIMARY KEY CLUSTERED 
(
	[IDCOTIZACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [RUC_COTIZACIONES] UNIQUE NONCLUSTERED 
(
	[RUC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DETALLES_COTIZACION]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLES_COTIZACION](
	[IDCOTIZACION] [int] NOT NULL,
	[IDPRODUCTO] [int] NOT NULL,
	[CANTIDADxPRODUCTOxDETALLE] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PAQUETES]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAQUETES](
	[ID_PAQUETE] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_PAQUETE] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_PAQUETES] PRIMARY KEY CLUSTERED 
(
	[ID_PAQUETE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PERSONAS]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERSONAS](
	[IDPERSONA] [int] IDENTITY(1,1) NOT NULL,
	[DOCUMENTOPERSONA] [nvarchar](50) NOT NULL,
	[NOMBREPERSONA] [nvarchar](100) NOT NULL,
	[TELEFONOPERSONA] [nvarchar](20) NULL,
 CONSTRAINT [PK_PERSONAS] PRIMARY KEY CLUSTERED 
(
	[IDPERSONA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DOCUMENTO_PERSONAS] UNIQUE NONCLUSTERED 
(
	[DOCUMENTOPERSONA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCTOS]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS](
	[IDPRODUCTO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBREPRODUCTO] [nvarchar](256) NOT NULL,
	[DESCRIPCIONPRODUCTO] [nvarchar](256) NULL,
	[PRECIOPRODUCTO] [float] NOT NULL,
	[STOCK] [int] NOT NULL,
	[ID_TIPO] [int] NOT NULL,
 CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[IDPRODUCTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCTOS_PAQUETES]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS_PAQUETES](
	[ID_PRODUCTO] [int] NOT NULL,
	[ID_PAQUETE] [int] NOT NULL,
	[CANTIDAD_PRODUCTO_PAQUETE] [int] NOT NULL,
 CONSTRAINT [PK_PRODUCTOS_PAQUETES] PRIMARY KEY CLUSTERED 
(
	[ID_PRODUCTO] ASC,
	[ID_PAQUETE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TIPOS_CARGO]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_CARGO](
	[ID_TIPO_CARGO] [int] IDENTITY(1,1) NOT NULL,
	[TIPO_CARGO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TIPOS_CARGO] PRIMARY KEY CLUSTERED 
(
	[ID_TIPO_CARGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TIPOS_PRODUCTO]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_PRODUCTO](
	[ID_TIPO] [int] IDENTITY(1,1) NOT NULL,
	[TIPO_PRODUCTO] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TIPOS_PRODUCTO] PRIMARY KEY CLUSTERED 
(
	[ID_TIPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VENDEDORES]    Script Date: 12/11/2020 10:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENDEDORES](
	[ID_VENDEDOR] [int] IDENTITY(1,1) NOT NULL,
	[ID_PERSONA] [int] NOT NULL,
 CONSTRAINT [PK_VENDEDORES] PRIMARY KEY CLUSTERED 
(
	[ID_VENDEDOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CARGOS]  WITH CHECK ADD  CONSTRAINT [FK_CARGOS_TIPOS_CARGO] FOREIGN KEY([ID_TIPO_CARGO])
REFERENCES [dbo].[TIPOS_CARGO] ([ID_TIPO_CARGO])
GO
ALTER TABLE [dbo].[CARGOS] CHECK CONSTRAINT [FK_CARGOS_TIPOS_CARGO]
GO
ALTER TABLE [dbo].[CARGOSXPRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_CARGOSXPRODUCTO_CARGOS] FOREIGN KEY([ID_CARGO])
REFERENCES [dbo].[CARGOS] ([ID_CARGO])
GO
ALTER TABLE [dbo].[CARGOSXPRODUCTO] CHECK CONSTRAINT [FK_CARGOSXPRODUCTO_CARGOS]
GO
ALTER TABLE [dbo].[CARGOSXPRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_CARGOSXPRODUCTO_PRODUCTOS] FOREIGN KEY([IDPRODUCTO])
REFERENCES [dbo].[PRODUCTOS] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[CARGOSXPRODUCTO] CHECK CONSTRAINT [FK_CARGOSXPRODUCTO_PRODUCTOS]
GO
ALTER TABLE [dbo].[CLIENTES]  WITH CHECK ADD  CONSTRAINT [FK_CLIENTES_PERSONAS] FOREIGN KEY([IDPERSONA])
REFERENCES [dbo].[PERSONAS] ([IDPERSONA])
GO
ALTER TABLE [dbo].[CLIENTES] CHECK CONSTRAINT [FK_CLIENTES_PERSONAS]
GO
ALTER TABLE [dbo].[COTIZACIONES]  WITH CHECK ADD  CONSTRAINT [FK_COTIZACIONES_CLIENTES] FOREIGN KEY([IDCLIENTE])
REFERENCES [dbo].[CLIENTES] ([IDCLIENTE])
GO
ALTER TABLE [dbo].[COTIZACIONES] CHECK CONSTRAINT [FK_COTIZACIONES_CLIENTES]
GO
ALTER TABLE [dbo].[COTIZACIONES]  WITH CHECK ADD  CONSTRAINT [FK_COTIZACIONES_VENDEDORES] FOREIGN KEY([IDVENDEDOR])
REFERENCES [dbo].[VENDEDORES] ([ID_VENDEDOR])
GO
ALTER TABLE [dbo].[COTIZACIONES] CHECK CONSTRAINT [FK_COTIZACIONES_VENDEDORES]
GO
ALTER TABLE [dbo].[DETALLES_COTIZACION]  WITH CHECK ADD  CONSTRAINT [FK_DETALLES_COTIZACION_COTIZACIONES] FOREIGN KEY([IDCOTIZACION])
REFERENCES [dbo].[COTIZACIONES] ([IDCOTIZACION])
GO
ALTER TABLE [dbo].[DETALLES_COTIZACION] CHECK CONSTRAINT [FK_DETALLES_COTIZACION_COTIZACIONES]
GO
ALTER TABLE [dbo].[DETALLES_COTIZACION]  WITH CHECK ADD  CONSTRAINT [FK_DETALLES_COTIZACION_PRODUCTOS] FOREIGN KEY([IDPRODUCTO])
REFERENCES [dbo].[PRODUCTOS] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[DETALLES_COTIZACION] CHECK CONSTRAINT [FK_DETALLES_COTIZACION_PRODUCTOS]
GO
ALTER TABLE [dbo].[PRODUCTOS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTOS_TIPOS_PRODUCTO] FOREIGN KEY([ID_TIPO])
REFERENCES [dbo].[TIPOS_PRODUCTO] ([ID_TIPO])
GO
ALTER TABLE [dbo].[PRODUCTOS] CHECK CONSTRAINT [FK_PRODUCTOS_TIPOS_PRODUCTO]
GO
ALTER TABLE [dbo].[PRODUCTOS_PAQUETES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTOS_PAQUETES_PAQUETES] FOREIGN KEY([ID_PAQUETE])
REFERENCES [dbo].[PAQUETES] ([ID_PAQUETE])
GO
ALTER TABLE [dbo].[PRODUCTOS_PAQUETES] CHECK CONSTRAINT [FK_PRODUCTOS_PAQUETES_PAQUETES]
GO
ALTER TABLE [dbo].[PRODUCTOS_PAQUETES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTOS_PAQUETES_PRODUCTOS] FOREIGN KEY([ID_PRODUCTO])
REFERENCES [dbo].[PRODUCTOS] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[PRODUCTOS_PAQUETES] CHECK CONSTRAINT [FK_PRODUCTOS_PAQUETES_PRODUCTOS]
GO
ALTER TABLE [dbo].[VENDEDORES]  WITH CHECK ADD  CONSTRAINT [FK_VENDEDORES_PERSONAS] FOREIGN KEY([ID_PERSONA])
REFERENCES [dbo].[PERSONAS] ([IDPERSONA])
GO
ALTER TABLE [dbo].[VENDEDORES] CHECK CONSTRAINT [FK_VENDEDORES_PERSONAS]
GO
ALTER TABLE [dbo].[VENDEDORES]  WITH CHECK ADD  CONSTRAINT [FK_VENDEDORES_PERSONAS1] FOREIGN KEY([ID_PERSONA])
REFERENCES [dbo].[PERSONAS] ([IDPERSONA])
GO
ALTER TABLE [dbo].[VENDEDORES] CHECK CONSTRAINT [FK_VENDEDORES_PERSONAS1]
GO
