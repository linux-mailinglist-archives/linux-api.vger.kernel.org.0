Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA1552BA
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfFYPAg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Jun 2019 11:00:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44693 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfFYPAg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Jun 2019 11:00:36 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so3858416iob.11
        for <linux-api@vger.kernel.org>; Tue, 25 Jun 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCu2izc+AwFs8dxkBWfG0kU/xQQY4HsLibUm2/EhQEg=;
        b=XEkdwu9tbyxynV2UESVQpvwU3iwK3hOE1k9Q1V76kobtha4OFJg8EuxOwyr9iFmFCF
         03+IP8ze/+IkOWgqwTpYK3IA+caa2YfQYz/eo6KfpwPMDhq0+7/rvOJSrpLmt6w+CQny
         NEdRK0dC/Ou/b9ECjr3caBsF5fwJhkr+xfFWaaDRwrRWL3rhMeeWH8HFoBrAKmYGIkva
         h4nN/l3U6DtLZdNSOnQL9Ih7R4Vh9q25kWm87wwuDzJtxPiQd0g9nyeidql+/whr0yY8
         hRSCFlzTYLEpYV2kxsIbsi+thmD6DyDRJf9PwCSIWPW0GUf18A1wZrVKYFPGX3EEcJNl
         GGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCu2izc+AwFs8dxkBWfG0kU/xQQY4HsLibUm2/EhQEg=;
        b=lzfthVoC21pNZZ0VQAArga/J7u42Ini/UjiIyjWIpMdibzArsEGVpb9zVNT6yabLwV
         J5fXuLRg+Z7NyCKdRfeX2Ib8eNv8rmPeNfIQRcpmzj1G4JrYt7bjO7jcu6SOhGngrDGe
         TTavmsTNOVC0PJELW7yfP2gsNV28mtPuHk3JoaYP4KE0k/2s+O+ukpVU8bMbBnfyfzke
         AiUX8kaDqvkGiBlefcE4z3v0NO3gTyiV8ioWZM/gnRuItFSQxtbCEhFDR1Ptm/VwXofa
         zhUcSLhnTGycy4gb/Iw30B04Ac0J8yMZVwbdPNFUYcnOyI7XgP60SotpUzQx85p4faPQ
         h1ow==
X-Gm-Message-State: APjAAAUS6fIv41PHnoxCWYeja/g+p4hvJinfYEdTuSPy4MJWWk73J1pG
        8LRuA4mCbNVin0ut1GPsV6t+1u6bPZZYLUvKlsGjYA==
X-Google-Smtp-Source: APXvYqzeVOugDrWRv5GZLuCebGXK5dE6WckDZUY2y3Mwk6wopB+mgprQm2ZWsgT4yJQvT/jz99cbIBKpq58fNj+5zo0=
X-Received: by 2002:a02:c90d:: with SMTP id t13mr112928904jao.62.1561474835326;
 Tue, 25 Jun 2019 08:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-29-matthewgarrett@google.com>
In-Reply-To: <20190622000358.19895-29-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 17:00:24 +0200
Message-ID: <CAKv+Gu_0bSCdeUGQo=nnKU=mfHXu+-U+qXWqJpJGUd6dVZF61Q@mail.gmail.com>
Subject: Re: [PATCH V34 28/29] efi: Restrict efivar_ssdt_load when the kernel
 is locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 22 Jun 2019 at 02:05, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
> EFI variable, which gives arbitrary code execution in ring 0. Prevent
> that when the kernel is locked down.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/firmware/efi/efi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..9f92a013ab27 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -31,6 +31,7 @@
>  #include <linux/acpi.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
> +#include <linux/security.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
>  static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
>  static int __init efivar_ssdt_setup(char *str)
>  {
> +       int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> +
> +       if (ret)
> +               return ret;
> +
>         if (strlen(str) < sizeof(efivar_ssdt))
>                 memcpy(efivar_ssdt, str, strlen(str));
>         else
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
