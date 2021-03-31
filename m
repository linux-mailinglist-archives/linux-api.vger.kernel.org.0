Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B237350A7A
	for <lists+linux-api@lfdr.de>; Thu,  1 Apr 2021 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCaWyi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 18:54:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhCaWyf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 31 Mar 2021 18:54:35 -0400
Received: from zn.tnic (p2e5843c9.dip0.t-ipconnect.de [46.88.67.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0574A1EC0501;
        Thu,  1 Apr 2021 00:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617231274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hoe9AIKHKgxfG0tjxl+YBDiimA0tiLOXlYvEpnWzDSk=;
        b=Ki5JTPUA6emD4e6Zf0F5f7dTbRwCXrgPZO1j/suFxJMSiAFYCrchdTMUUvHIR0Sy+Uz2Ff
        fnSa675iZJALC1U+RXEyyhpsF8pvsv075YzKqgleNcylwrxQKPlxhC95RwjaovhTFtjkDT
        X0OgLiu9zmxXeWDgGnnwIQDezQIR4G4=
Date:   Thu, 1 Apr 2021 00:52:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210331225226.GC11673@zn.tnic>
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
 <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 06:28:27PM -0400, Len Brown wrote:
> dynamic XCR0 breaks the installed base, I thought we had established
> that.

We should do a clear cut and have legacy stuff which has its legacy
expectations on the XSTATE layout and not touch those at all.

And then all new apps which will use these new APIs can go and request
whatever fancy new state constellations we support. Including how they
want their signals handled, etc.

Fat states like avx512, amx etc will be off by default and apps
explicitly requesting those, can get them.

That's it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
