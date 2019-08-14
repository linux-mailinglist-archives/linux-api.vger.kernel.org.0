Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63B8DC25
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfHNRqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 13:46:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfHNRqs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Aug 2019 13:46:48 -0400
Received: from zn.tnic (p200300EC2F0BD0003850D0C8BF1AA1C5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:3850:d0c8:bf1a:a1c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE7B31EC0260;
        Wed, 14 Aug 2019 19:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565804807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2SA+6786MPKxV9jdAfB9Q+F1WSWbXybqiA3c/b/Fyek=;
        b=HRoKkCMGX9XffldZ1bdQh77Ucsh/dkiDimF3tNgLqjK4pzSo/87R66h1SJtgSp22UDqUVe
        9ystX6lvzqfB/NilBoEtGEhi5N1uAoID2eMpKHUszFuHLpwxwk21JMPBW91lBfiSyzHmC+
        5xV1UL/PqMyGU66c8NTryZSdeBhaTYY=
Date:   Wed, 14 Aug 2019 19:47:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
Message-ID: <20190814174732.GD1841@zn.tnic>
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com>
 <20190814072602.GA27836@zn.tnic>
 <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 14, 2019 at 10:14:54AM -0700, Matthew Garrett wrote:
> We explicitly don't want to pay attention to the acpi_rsdp kernel
> parameter in early boot except for the case of finding the SRAT table,
> and we only need that if CONFIG_RANDOMIZE_BASE and
> CONFIG_MEMORY_HOTREMOVE are set. However, we *do* want to tell the
> actual kernel where the RSDP is if we found it via some other means,
> so we can't just clear the boot parameters value.

Ok.

> The kernel proper will parse the command line again and will then (if
> lockdown isn't enabled) override the actual value we passed up in boot
> params.

Yeah, ok, I see what you're doing there. AFAICT, you do that in

setup_arch->acpi_boot_table_init-> ... -> acpi_os_get_root_pointer()

I hope nothing needs it earlier because then we'll have to restructure
again...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
