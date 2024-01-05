Return-Path: <linux-api+bounces-458-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42EB825B5E
	for <lists+linux-api@lfdr.de>; Fri,  5 Jan 2024 21:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57607285ED5
	for <lists+linux-api@lfdr.de>; Fri,  5 Jan 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EE1E4AD;
	Fri,  5 Jan 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGXg2O4H"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737E35F1E;
	Fri,  5 Jan 2024 20:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A4C433C8;
	Fri,  5 Jan 2024 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704485263;
	bh=Oz6hEm57ispsaURM48oskOk88XCVK7oo7RknkpPk49E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGXg2O4HGR9FRbe83e4FG01Iji1PnS5LLdicyEntdFfLtiyP8WPVFv8wERJNLodzG
	 ab2Ly5DXQPzQix+cBaxJlKoA2RuoNF5RzB3si8rUkkGi67Uek2SyM0SnTxVD+jynC0
	 YBlyFRH4Pt682juLgXCs48YLqk1zpP7fAvObMWTpEeoy64pzox4yLIzaf7CD/hEpC2
	 wrJiceBy8QKRx/BDo5c+hOx3/lDGvIZlWBrYJNGBCvI/qfjpQ7vft8+MAtuWp0XWms
	 L04mfMfCKjNymvmA+dpolvCZ4Uhzw/g3dcWqjO4iFZmCDuQSv9MCaAqZ23AKpTo7kk
	 jtzoJYcn8NQtw==
Date: Fri, 5 Jan 2024 21:07:39 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] Documentation/ABI/README: convert to ReST
Message-ID: <20240105210739.20ae5f05@coco.lan>
In-Reply-To: <20240104160946.3450743-4-vegard.nossum@oracle.com>
References: <20240104160946.3450743-1-vegard.nossum@oracle.com>
	<20240104160946.3450743-4-vegard.nossum@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu,  4 Jan 2024 17:09:45 +0100
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

> This file is basically ReST syntax already -- with just a few tweaks we
> can include this in the rendered HTML documentation which currently has
> no introduction or explanation.
>=20
> References to this document were found and fixed with some variant of:
>=20
>   git grep -Pl 'ABI/README(?!\.rst)' | xargs sed -i 's|\(Documentation/AB=
I/README\)|\1\.rst|g'
>=20
> plus manual inspection and reflows where necessary.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/ABI/{README =3D> README.rst}      | 36 +++++++++----------
>  Documentation/Kconfig                         |  8 ++---
>  Documentation/filesystems/sysfs.rst           |  4 +--
>  Documentation/process/4.Coding.rst            |  4 +--
>  Documentation/process/submit-checklist.rst    |  2 +-
>  .../translations/it_IT/process/4.Coding.rst   |  4 +--
>  .../it_IT/process/submit-checklist.rst        |  2 +-
>  .../translations/ja_JP/SubmitChecklist        |  2 +-
>  .../sp_SP/process/submit-checklist.rst        |  2 +-
>  .../translations/zh_CN/filesystems/sysfs.txt  |  2 +-
>  .../translations/zh_CN/process/4.Coding.rst   |  2 +-
>  .../zh_CN/process/submit-checklist.rst        |  2 +-
>  .../translations/zh_TW/filesystems/sysfs.txt  |  2 +-
>  .../translations/zh_TW/process/4.Coding.rst   |  2 +-
>  .../zh_TW/process/submit-checklist.rst        |  2 +-
>  15 files changed, 38 insertions(+), 38 deletions(-)
>  rename Documentation/ABI/{README =3D> README.rst} (82%)
>=20
> diff --git a/Documentation/ABI/README b/Documentation/ABI/README.rst
> similarity index 82%
> rename from Documentation/ABI/README
> rename to Documentation/ABI/README.rst
> index 8bac9cb09a6d..04f5d05d6caa 100644
> --- a/Documentation/ABI/README
> +++ b/Documentation/ABI/README.rst
> @@ -41,24 +41,24 @@ The different levels of stability are:
>  	This directory contains a list of the old interfaces that have
>  	been removed from the kernel.
> =20
> -Every file in these directories will contain the following information:
> -
> -What:		Short description of the interface
> -Date:		Date created
> -KernelVersion:	Kernel version this feature first showed up in.
> -Contact:	Primary contact for this interface (may be a mailing list)
> -Description:	Long description of the interface and how to use it.
> -Users:		All users of this interface who wish to be notified when
> -		it changes.  This is very important for interfaces in
> -		the "testing" stage, so that kernel developers can work
> -		with userspace developers to ensure that things do not
> -		break in ways that are unacceptable.  It is also
> -		important to get feedback for these interfaces to make
> -		sure they are working in a proper way and do not need to
> -		be changed further.
> -
> -
> -Note:
> +Every file in these directories will contain the following information::
> +
> + What:		Short description of the interface
> + Date:		Date created
> + KernelVersion:	Kernel version this feature first showed up in.
> + Contact:	Primary contact for this interface (may be a mailing list)
> + Description:	Long description of the interface and how to use it.
> + Users:		All users of this interface who wish to be notified when
> + 		it changes.  This is very important for interfaces in
> + 		the "testing" stage, so that kernel developers can work
> + 		with userspace developers to ensure that things do not
> + 		break in ways that are unacceptable.  It is also
> + 		important to get feedback for these interfaces to make
> + 		sure they are working in a proper way and do not need to
> + 		be changed further.

My personal preference would be to use:

:What:

as this produces a better markup.

> +
> +.. note::
> +
>     The fields should be use a simple notation, compatible with ReST mark=
up.
>     Also, the file **should not** have a top-level index, like::
> =20
> diff --git a/Documentation/Kconfig b/Documentation/Kconfig
> index 3a0e7ac0c4e3..8e690a4f1a64 100644
> --- a/Documentation/Kconfig
> +++ b/Documentation/Kconfig
> @@ -16,10 +16,10 @@ config WARN_ABI_ERRORS
>  	bool "Warn if there are errors at ABI files"
>  	help
>  	  The files under Documentation/ABI should follow what's
> -	  described at Documentation/ABI/README. Yet, as they're manually
> -	  written, it would be possible that some of those files would
> -	  have errors that would break them for being parsed by
> -	  scripts/get_abi.pl. Add a check to verify them.
> +	  described at Documentation/ABI/README.rst. Yet, as they're
> +	  manually written, it would be possible that some of those
> +	  files would have errors that would break them for being parsed
> +	  by scripts/get_abi.pl. Add a check to verify them.
> =20
>  	  If unsure, select 'N'.
> =20
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesyst=
ems/sysfs.rst
> index c32993bc83c7..e30694706b15 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -418,5 +418,5 @@ Documentation
>  The sysfs directory structure and the attributes in each directory defin=
e an
>  ABI between the kernel and user space. As for any ABI, it is important t=
hat
>  this ABI is stable and properly documented. All new sysfs attributes mus=
t be
> -documented in Documentation/ABI. See also Documentation/ABI/README for m=
ore
> -information.
> +documented in Documentation/ABI. See also Documentation/ABI/README.rst f=
or
> +more information.
> diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4=
.Coding.rst
> index 1f0d81f44e14..120d126ee288 100644
> --- a/Documentation/process/4.Coding.rst
> +++ b/Documentation/process/4.Coding.rst
> @@ -347,8 +347,8 @@ information.
>  Any code which adds a new user-space interface - including new sysfs or
>  /proc files - should include documentation of that interface which enabl=
es
>  user-space developers to know what they are working with.  See
> -Documentation/ABI/README for a description of how this documentation sho=
uld
> -be formatted and what information needs to be provided.
> +Documentation/ABI/README.rst for a description of how this documentation
> +should be formatted and what information needs to be provided.
> =20
>  The file :ref:`Documentation/admin-guide/kernel-parameters.rst
>  <kernelparameters>` describes all of the kernel's boot-time parameters.
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/p=
rocess/submit-checklist.rst
> index b1bc2d37bd0a..7e6198ab368d 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -85,7 +85,7 @@ and elsewhere regarding submitting Linux kernel patches.
>  17) All new module parameters are documented with ``MODULE_PARM_DESC()``
> =20
>  18) All new userspace interfaces are documented in ``Documentation/ABI/`=
`.
> -    See ``Documentation/ABI/README`` for more information.
> +    See ``Documentation/ABI/README.rst`` for more information.

If you're willing to convert to ReST, please remove ``, as this will
let automarkup.py to create cross-reference links. Same note for the
translations too.

>      Patches that change userspace interfaces should be CCed to
>      linux-api@vger.kernel.org.
> =20
> diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Docu=
mentation/translations/it_IT/process/4.Coding.rst
> index 54fd255b77d0..631d56ae56dc 100644
> --- a/Documentation/translations/it_IT/process/4.Coding.rst
> +++ b/Documentation/translations/it_IT/process/4.Coding.rst
> @@ -365,8 +365,8 @@ informazione.
>  Qualsiasi codice che aggiunge una nuova interfaccia in spazio utente - i=
nclusi
>  nuovi file in sysfs o /proc - dovrebbe includere la documentazione di ta=
le
>  interfaccia cos=C3=AC da permette agli sviluppatori dello spazio utente =
di sapere
> -con cosa stanno lavorando.  Consultate: Documentation/ABI/README per ave=
re una
> -descrizione di come questi documenti devono essere impostati e quali
> +con cosa stanno lavorando.  Consultate: Documentation/ABI/README.rst per=
 avere
> +una descrizione di come questi documenti devono essere impostati e quali
>  informazioni devono essere fornite.
> =20
>  Il file :ref:`Documentation/translations/it_IT/admin-guide/kernel-parame=
ters.rst <kernelparameters>`
> diff --git a/Documentation/translations/it_IT/process/submit-checklist.rs=
t b/Documentation/translations/it_IT/process/submit-checklist.rst
> index 2fc09cc1f0be..828c8f27d492 100644
> --- a/Documentation/translations/it_IT/process/submit-checklist.rst
> +++ b/Documentation/translations/it_IT/process/submit-checklist.rst
> @@ -94,7 +94,7 @@ sottomissione delle patch, in particolare
>  18) Tutti i nuovi parametri dei moduli sono documentati con ``MODULE_PAR=
M_DESC()``.
> =20
>  19) Tutte le nuove interfacce verso lo spazio utente sono documentate in
> -    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README`` per ma=
ggiori
> +    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README.rst`` pe=
r maggiori
>      informazioni.  Le patch che modificano le interfacce utente dovrebbe=
ro
>      essere inviate in copia anche a linux-api@vger.kernel.org.
> =20
> diff --git a/Documentation/translations/ja_JP/SubmitChecklist b/Documenta=
tion/translations/ja_JP/SubmitChecklist
> index 4429447b0965..87867c47bffd 100644
> --- a/Documentation/translations/ja_JP/SubmitChecklist
> +++ b/Documentation/translations/ja_JP/SubmitChecklist
> @@ -86,7 +86,7 @@ Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=91=E3=
=83=83=E3=83=81=E6=8A=95=E7=A8=BF=E8=80=85=E5=90=91=E3=81=91=E3=83=81=E3=82=
=A7=E3=83=83=E3=82=AF=E3=83=AA=E3=82=B9=E3=83=88
>      =E5=88=A9=E7=94=A8=E3=81=97=E3=81=A6=E5=BF=85=E3=81=9A=E3=81=9D=E3=
=81=AE=E8=AA=AC=E6=98=8E=E3=82=92=E8=A8=98=E8=BF=B0=E3=81=97=E3=81=A6=E3=81=
=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
> =20
>  18: =E6=96=B0=E3=81=97=E3=81=84userspace=E3=82=A4=E3=83=B3=E3=82=BF=E3=
=83=95=E3=82=A7=E3=83=BC=E3=82=B9=E3=82=92=E4=BD=9C=E6=88=90=E3=81=97=E3=81=
=9F=E5=A0=B4=E5=90=88=E3=81=AB=E3=81=AF=E3=80=81Documentation/ABI/ =E3=81=AB
> -    Documentation/ABI/README =E3=82=92=E5=8F=82=E8=80=83=E3=81=AB=E3=81=
=97=E3=81=A6=E5=BF=85=E3=81=9A=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=
=E3=83=88=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=
=81=95=E3=81=84=E3=80=82
> +    Documentation/ABI/README.rst =E3=82=92=E5=8F=82=E8=80=83=E3=81=AB=E3=
=81=97=E3=81=A6=E5=BF=85=E3=81=9A=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=
=B3=E3=83=88=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=
=E3=81=95=E3=81=84=E3=80=82
> =20
>  19: =E5=B0=91=E3=81=AA=E3=81=8F=E3=81=A8=E3=82=82slab=E3=82=A2=E3=83=AD=
=E3=82=B1=E3=83=BC=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=A8page=E3=82=A2=E3=83=
=AD=E3=82=B1=E3=83=BC=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=AB=E5=A4=B1=E6=95=97=
=E3=81=97=E3=81=9F=E5=A0=B4=E5=90=88=E3=81=AE
>      =E6=8C=99=E5=8B=95=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=E3=80=81fault=
-injection=E3=82=92=E5=88=A9=E7=94=A8=E3=81=97=E3=81=A6=E7=A2=BA=E8=AA=8D=
=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
> diff --git a/Documentation/translations/sp_SP/process/submit-checklist.rs=
t b/Documentation/translations/sp_SP/process/submit-checklist.rst
> index 0d6651f9d871..b8072be18532 100644
> --- a/Documentation/translations/sp_SP/process/submit-checklist.rst
> +++ b/Documentation/translations/sp_SP/process/submit-checklist.rst
> @@ -97,7 +97,7 @@ y en otros lugares con respecto al env=C3=ADo de parche=
s del kernel de Linux.
>      ``MODULE_PARM_DESC()``.
> =20
>  18) Todas las nuevas interfaces de espacio de usuario est=C3=A1n documen=
tadas
> -    en ``Documentation/ABI/``. Consulte ``Documentation/ABI/README`` para
> +    en ``Documentation/ABI/``. Consulte ``Documentation/ABI/README.rst``=
 para
>      obtener m=C3=A1s informaci=C3=B3n. Los parches que cambian las inter=
faces del
>      espacio de usuario deben ser CCed a linux-api@vger.kernel.org.
> =20
> diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Doc=
umentation/translations/zh_CN/filesystems/sysfs.txt
> index 547062759e60..871fc60aeeca 100644
> --- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> @@ -370,4 +370,4 @@ void driver_remove_file(struct device_driver *, const=
 struct driver_attribute *)
> =20
>  sysfs =E7=9B=AE=E5=BD=95=E7=BB=93=E6=9E=84=E4=BB=A5=E5=8F=8A=E5=85=B6=E4=
=B8=AD=E5=8C=85=E5=90=AB=E7=9A=84=E5=B1=9E=E6=80=A7=E5=AE=9A=E4=B9=89=E4=BA=
=86=E4=B8=80=E4=B8=AA=E5=86=85=E6=A0=B8=E4=B8=8E=E7=94=A8=E6=88=B7=E7=A9=BA=
=E9=97=B4=E4=B9=8B=E9=97=B4=E7=9A=84 ABI=E3=80=82
>  =E5=AF=B9=E4=BA=8E=E4=BB=BB=E4=BD=95 ABI=EF=BC=8C=E5=85=B6=E8=87=AA=E8=
=BA=AB=E7=9A=84=E7=A8=B3=E5=AE=9A=E5=92=8C=E9=80=82=E5=BD=93=E7=9A=84=E6=96=
=87=E6=A1=A3=E6=98=AF=E9=9D=9E=E5=B8=B8=E9=87=8D=E8=A6=81=E7=9A=84=E3=80=82=
=E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84 sysfs
> -=E5=B1=9E=E6=80=A7=E5=BF=85=E9=A1=BB=E5=9C=A8 Documentation/ABI =E4=B8=
=AD=E6=9C=89=E6=96=87=E6=A1=A3=E3=80=82=E8=AF=A6=E8=A7=81 Documentation/ABI=
/README=E3=80=82
> +=E5=B1=9E=E6=80=A7=E5=BF=85=E9=A1=BB=E5=9C=A8 Documentation/ABI =E4=B8=
=AD=E6=9C=89=E6=96=87=E6=A1=A3=E3=80=82=E8=AF=A6=E8=A7=81 Documentation/ABI=
/README.rst=E3=80=82
> diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Docu=
mentation/translations/zh_CN/process/4.Coding.rst
> index 7cac9424f5d5..1b752b3bdc8c 100644
> --- a/Documentation/translations/zh_CN/process/4.Coding.rst
> +++ b/Documentation/translations/zh_CN/process/4.Coding.rst
> @@ -244,7 +244,7 @@ scripts/coccinelle=E7=9B=AE=E5=BD=95=E4=B8=8B=E5=B7=
=B2=E7=BB=8F=E6=89=93=E5=8C=85=E4=BA=86=E7=9B=B8=E5=BD=93=E5=A4=9A=E7=9A=84=
=E5=86=85=E6=A0=B8=E2=80=9C=E8=AF=AD=E4=B9=89=E8=A1=A5=E4=B8=81=E2=80=9D
> =20
>  =E4=BB=BB=E4=BD=95=E6=B7=BB=E5=8A=A0=E6=96=B0=E7=94=A8=E6=88=B7=E7=A9=BA=
=E9=97=B4=E6=8E=A5=E5=8F=A3=E7=9A=84=E4=BB=A3=E7=A0=81=E2=80=94=E2=80=94=E5=
=8C=85=E6=8B=AC=E6=96=B0=E7=9A=84sysfs=E6=88=96/proc=E6=96=87=E4=BB=B6=E2=
=80=94=E2=80=94=E9=83=BD=E5=BA=94=E8=AF=A5=E5=8C=85=E5=90=AB=E8=AF=A5=E6=8E=
=A5=E5=8F=A3
>  =E7=9A=84=E6=96=87=E6=A1=A3=EF=BC=8C=E8=AF=A5=E6=96=87=E6=A1=A3=E4=BD=BF=
=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E5=BC=80=E5=8F=91=E4=BA=BA=E5=91=98=E8=
=83=BD=E5=A4=9F=E7=9F=A5=E9=81=93=E4=BB=96=E4=BB=AC=E5=9C=A8=E4=BD=BF=E7=94=
=A8=E4=BB=80=E4=B9=88=E3=80=82=E8=AF=B7=E5=8F=82=E9=98=85
> -Documentation/ABI/README=EF=BC=8C=E4=BA=86=E8=A7=A3=E5=A6=82=E4=BD=95=E6=
=AD=A4=E6=96=87=E6=A1=A3=E6=A0=BC=E5=BC=8F=E4=BB=A5=E5=8F=8A=E9=9C=80=E8=A6=
=81=E6=8F=90=E4=BE=9B=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=E3=80=82
> +Documentation/ABI/README.rst=EF=BC=8C=E4=BA=86=E8=A7=A3=E5=A6=82=E4=BD=
=95=E6=AD=A4=E6=96=87=E6=A1=A3=E6=A0=BC=E5=BC=8F=E4=BB=A5=E5=8F=8A=E9=9C=80=
=E8=A6=81=E6=8F=90=E4=BE=9B=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=E3=80=82
> =20
>  =E6=96=87=E6=A1=A3 :ref:`Documentation/admin-guide/kernel-parameters.rst=
 <kernelparameters>`
>  =E6=8F=8F=E8=BF=B0=E4=BA=86=E5=86=85=E6=A0=B8=E7=9A=84=E6=89=80=E6=9C=89=
=E5=BC=95=E5=AF=BC=E6=97=B6=E9=97=B4=E5=8F=82=E6=95=B0=E3=80=82=E4=BB=BB=E4=
=BD=95=E6=B7=BB=E5=8A=A0=E6=96=B0=E5=8F=82=E6=95=B0=E7=9A=84=E8=A1=A5=E4=B8=
=81=E9=83=BD=E5=BA=94=E8=AF=A5=E5=90=91=E8=AF=A5=E6=96=87=E6=A1=A3=E6=B7=BB=
=E5=8A=A0=E9=80=82=E5=BD=93=E7=9A=84
> diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rs=
t b/Documentation/translations/zh_CN/process/submit-checklist.rst
> index 3d6ee21c74ae..0942021202a3 100644
> --- a/Documentation/translations/zh_CN/process/submit-checklist.rst
> +++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
> @@ -83,7 +83,7 @@ Linux=E5=86=85=E6=A0=B8=E8=A1=A5=E4=B8=81=E6=8F=90=E4=
=BA=A4=E6=A3=80=E6=9F=A5=E5=8D=95
>  17) =E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84=E6=A8=A1=E5=9D=97=E5=8F=82=E6=
=95=B0=E9=83=BD=E8=AE=B0=E5=BD=95=E5=9C=A8 ``MODULE_PARM_DESC()``
> =20
>  18) =E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84=E7=94=A8=E6=88=B7=E7=A9=BA=E9=
=97=B4=E6=8E=A5=E5=8F=A3=E9=83=BD=E8=AE=B0=E5=BD=95=E5=9C=A8 ``Documentatio=
n/ABI/`` =E4=B8=AD=E3=80=82=E6=9C=89=E5=85=B3=E8=AF=A6=E7=BB=86=E4=BF=A1=E6=
=81=AF=EF=BC=8C
> -    =E8=AF=B7=E5=8F=82=E9=98=85 ``Documentation/ABI/README`` =E3=80=82=
=E6=9B=B4=E6=94=B9=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E6=8E=A5=E5=8F=A3=E7=
=9A=84=E8=A1=A5=E4=B8=81=E5=BA=94=E8=AF=A5=E6=8A=84=E9=80=81
> +    =E8=AF=B7=E5=8F=82=E9=98=85 ``Documentation/ABI/README.rst`` =E3=80=
=82=E6=9B=B4=E6=94=B9=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E6=8E=A5=E5=8F=A3=
=E7=9A=84=E8=A1=A5=E4=B8=81=E5=BA=94=E8=AF=A5=E6=8A=84=E9=80=81
>      linux-api@vger.kernel.org=E3=80=82
> =20
>  19) =E5=B7=B2=E9=80=9A=E8=BF=87=E8=87=B3=E5=B0=91=E6=B3=A8=E5=85=A5slab=
=E5=92=8Cpage=E5=88=86=E9=85=8D=E5=A4=B1=E8=B4=A5=E8=BF=9B=E8=A1=8C=E6=A3=
=80=E6=9F=A5=E3=80=82=E8=AF=B7=E5=8F=82=E9=98=85 ``Documentation/fault-inje=
ction/`` =E3=80=82
> diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Doc=
umentation/translations/zh_TW/filesystems/sysfs.txt
> index 978462d5fe14..a94e83dcb814 100644
> --- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
> @@ -373,5 +373,5 @@ void driver_remove_file(struct device_driver *, const=
 struct driver_attribute *)
> =20
>  sysfs =E7=9B=AE=E9=8C=84=E7=B5=90=E6=A7=8B=E4=BB=A5=E5=8F=8A=E5=85=B6=E4=
=B8=AD=E5=8C=85=E5=90=AB=E7=9A=84=E5=B1=AC=E6=80=A7=E5=AE=9A=E7=BE=A9=E4=BA=
=86=E4=B8=80=E5=80=8B=E5=85=A7=E6=A0=B8=E8=88=87=E7=94=A8=E6=88=B6=E7=A9=BA=
=E9=96=93=E4=B9=8B=E9=96=93=E7=9A=84 ABI=E3=80=82
>  =E5=B0=8D=E6=96=BC=E4=BB=BB=E4=BD=95 ABI=EF=BC=8C=E5=85=B6=E8=87=AA=E8=
=BA=AB=E7=9A=84=E7=A9=A9=E5=AE=9A=E5=92=8C=E9=81=A9=E7=95=B6=E7=9A=84=E6=96=
=87=E6=AA=94=E6=98=AF=E9=9D=9E=E5=B8=B8=E9=87=8D=E8=A6=81=E7=9A=84=E3=80=82=
=E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84 sysfs
> -=E5=B1=AC=E6=80=A7=E5=BF=85=E9=A0=88=E5=9C=A8 Documentation/ABI =E4=B8=
=AD=E6=9C=89=E6=96=87=E6=AA=94=E3=80=82=E8=A9=B3=E8=A6=8B Documentation/ABI=
/README=E3=80=82
> +=E5=B1=AC=E6=80=A7=E5=BF=85=E9=A0=88=E5=9C=A8 Documentation/ABI =E4=B8=
=AD=E6=9C=89=E6=96=87=E6=AA=94=E3=80=82=E8=A9=B3=E8=A6=8B Documentation/ABI=
/README.rst=E3=80=82
> =20
> diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Docu=
mentation/translations/zh_TW/process/4.Coding.rst
> index bdd2abe4daf4..541e09ae1440 100644
> --- a/Documentation/translations/zh_TW/process/4.Coding.rst
> +++ b/Documentation/translations/zh_TW/process/4.Coding.rst
> @@ -247,7 +247,7 @@ scripts/coccinelle=E7=9B=AE=E9=8C=84=E4=B8=8B=E5=B7=
=B2=E7=B6=93=E6=89=93=E5=8C=85=E4=BA=86=E7=9B=B8=E7=95=B6=E5=A4=9A=E7=9A=84=
=E5=85=A7=E6=A0=B8=E2=80=9C=E8=AA=9E=E7=BE=A9=E8=A3=9C=E4=B8=81=E2=80=9D
> =20
>  =E4=BB=BB=E4=BD=95=E6=B7=BB=E5=8A=A0=E6=96=B0=E7=94=A8=E6=88=B6=E7=A9=BA=
=E9=96=93=E6=8E=A5=E5=8F=A3=E7=9A=84=E4=BB=A3=E7=A2=BC=E2=80=94=E2=80=94=E5=
=8C=85=E6=8B=AC=E6=96=B0=E7=9A=84sysfs=E6=88=96/proc=E6=96=87=E4=BB=B6=E2=
=80=94=E2=80=94=E9=83=BD=E6=87=89=E8=A9=B2=E5=8C=85=E5=90=AB=E8=A9=B2=E6=8E=
=A5=E5=8F=A3
>  =E7=9A=84=E6=96=87=E6=AA=94=EF=BC=8C=E8=A9=B2=E6=96=87=E6=AA=94=E4=BD=BF=
=E7=94=A8=E6=88=B6=E7=A9=BA=E9=96=93=E9=96=8B=E7=99=BC=E4=BA=BA=E5=93=A1=E8=
=83=BD=E5=A4=A0=E7=9F=A5=E9=81=93=E4=BB=96=E5=80=91=E5=9C=A8=E4=BD=BF=E7=94=
=A8=E4=BB=80=E9=BA=BC=E3=80=82=E8=AB=8B=E5=8F=83=E9=96=B1
> -Documentation/ABI/README=EF=BC=8C=E7=9E=AD=E8=A7=A3=E5=A6=82=E4=BD=95=E6=
=AD=A4=E6=96=87=E6=AA=94=E6=A0=BC=E5=BC=8F=E4=BB=A5=E5=8F=8A=E9=9C=80=E8=A6=
=81=E6=8F=90=E4=BE=9B=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=E3=80=82
> +Documentation/ABI/README.rst=EF=BC=8C=E7=9E=AD=E8=A7=A3=E5=A6=82=E4=BD=
=95=E6=AD=A4=E6=96=87=E6=AA=94=E6=A0=BC=E5=BC=8F=E4=BB=A5=E5=8F=8A=E9=9C=80=
=E8=A6=81=E6=8F=90=E4=BE=9B=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=E3=80=82
> =20
>  =E6=96=87=E6=AA=94 :ref:`Documentation/admin-guide/kernel-parameters.rst=
 <kernelparameters>`
>  =E6=8F=8F=E8=BF=B0=E4=BA=86=E5=85=A7=E6=A0=B8=E7=9A=84=E6=89=80=E6=9C=89=
=E5=BC=95=E5=B0=8E=E6=99=82=E9=96=93=E5=8F=83=E6=95=B8=E3=80=82=E4=BB=BB=E4=
=BD=95=E6=B7=BB=E5=8A=A0=E6=96=B0=E5=8F=83=E6=95=B8=E7=9A=84=E8=A3=9C=E4=B8=
=81=E9=83=BD=E6=87=89=E8=A9=B2=E5=90=91=E8=A9=B2=E6=96=87=E6=AA=94=E6=B7=BB=
=E5=8A=A0=E9=81=A9=E7=95=B6=E7=9A=84
> diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rs=
t b/Documentation/translations/zh_TW/process/submit-checklist.rst
> index e57ef0f99e0c..efece58cb5b2 100644
> --- a/Documentation/translations/zh_TW/process/submit-checklist.rst
> +++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
> @@ -86,7 +86,7 @@ Linux=E5=85=A7=E6=A0=B8=E8=A3=9C=E4=B8=81=E6=8F=90=E4=
=BA=A4=E6=AA=A2=E6=9F=A5=E5=96=AE
>  17) =E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84=E6=A8=A1=E5=A1=8A=E5=8F=83=E6=
=95=B8=E9=83=BD=E8=A8=98=E9=8C=84=E5=9C=A8 ``MODULE_PARM_DESC()``
> =20
>  18) =E6=89=80=E6=9C=89=E6=96=B0=E7=9A=84=E7=94=A8=E6=88=B6=E7=A9=BA=E9=
=96=93=E6=8E=A5=E5=8F=A3=E9=83=BD=E8=A8=98=E9=8C=84=E5=9C=A8 ``Documentatio=
n/ABI/`` =E4=B8=AD=E3=80=82=E6=9C=89=E9=97=9C=E8=A9=B3=E7=B4=B0=E4=BF=A1=E6=
=81=AF=EF=BC=8C
> -    =E8=AB=8B=E5=8F=83=E9=96=B1 ``Documentation/ABI/README`` =E3=80=82=
=E6=9B=B4=E6=94=B9=E7=94=A8=E6=88=B6=E7=A9=BA=E9=96=93=E6=8E=A5=E5=8F=A3=E7=
=9A=84=E8=A3=9C=E4=B8=81=E6=87=89=E8=A9=B2=E6=8A=84=E9=80=81
> +    =E8=AB=8B=E5=8F=83=E9=96=B1 ``Documentation/ABI/README.rst`` =E3=80=
=82=E6=9B=B4=E6=94=B9=E7=94=A8=E6=88=B6=E7=A9=BA=E9=96=93=E6=8E=A5=E5=8F=A3=
=E7=9A=84=E8=A3=9C=E4=B8=81=E6=87=89=E8=A9=B2=E6=8A=84=E9=80=81
>      linux-api@vger.kernel.org=E3=80=82
> =20
>  19) =E5=B7=B2=E9=80=9A=E9=81=8E=E8=87=B3=E5=B0=91=E6=B3=A8=E5=85=A5slab=
=E5=92=8Cpage=E5=88=86=E9=85=8D=E5=A4=B1=E6=95=97=E9=80=B2=E8=A1=8C=E6=AA=
=A2=E6=9F=A5=E3=80=82=E8=AB=8B=E5=8F=83=E9=96=B1 ``Documentation/fault-inje=
ction/`` =E3=80=82



Thanks,
Mauro

