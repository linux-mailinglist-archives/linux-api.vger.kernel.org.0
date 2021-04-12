Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826D35C60F
	for <lists+linux-api@lfdr.de>; Mon, 12 Apr 2021 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhDLMUJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Apr 2021 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhDLMUI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Apr 2021 08:20:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B293C061574;
        Mon, 12 Apr 2021 05:19:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f052100338fe73c52330fca.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2100:338f:e73c:5233:fca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B6F21EC036C;
        Mon, 12 Apr 2021 14:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618229989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kD7vbGhEK0qnsfsKWL7qZgyEpxDWyfq7hGq9uI0D3VU=;
        b=LCsmTk8jVRXuAL6SekTZ2EL8U88N5RFH2nN88t/2o6trKZZQV6z0gvUOXcuvFc8lC79kO3
        glnan1rZJ3fsG3HGVcgp9wNlUkDeqljeMENQn5hEelXJyV8F+Q3nE2MG8ucxfLownR9nwz
        jvCSbSM6J5G3OEk7eFe9hFmfyx1d8V8=
Date:   Mon, 12 Apr 2021 14:19:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20210412121947.GC24283@zn.tnic>
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
 <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
 <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
 <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
 <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Apr 11, 2021 at 03:07:29PM -0400, Len Brown wrote:
> If it is the program, how does it know that the library wants to use
> what instructions?
> 
> If it is the library, then you have just changed XCR0 at run-time and
> you expose breakage of the thread library that has computed XSAVE size.

So, when old programs which cannot possibly know about the arch_prctl()
extension we're proposing here, link against that library, then that
library should not be allowed to go use "fat" states.

Unless the library can "tell" the process which links to it, that it
has dynamically enlarged the save state. If it can and the process can
handle that, then all is fine, save state gets enlarged dynamically and
it all continues merrily.

Also, in order for the library to use fat states, it needs to ask the
kernel for such support - not CPUID - because the kernel is doing the
state handling for everybody and doing all the CR4.OSXSAVE setup etc.

Which also means that the kernel can help here by telling the library:

- No, you cannot use fat states with this process because it hasn't
called arch_prctl() so it cannot handle them properly.

- Yes, this process allowes me to handle fat states for it so you can
use those states and thus those instructions when doing operations for
it.

So the kernel becomes the arbiter in all this - as it should be - and
then all should work fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
