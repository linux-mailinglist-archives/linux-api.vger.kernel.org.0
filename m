Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E722CDBFB
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgLCRLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgLCRLP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 12:11:15 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19CC061A52
        for <linux-api@vger.kernel.org>; Thu,  3 Dec 2020 09:10:35 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so1506497plo.0
        for <linux-api@vger.kernel.org>; Thu, 03 Dec 2020 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4wqJAr+3mpm/N6KJzqVQL+ect217rAtwLlAfBe3bNfU=;
        b=RUpr5VZUHli+Ntwv2HIrEYZtLYBEEv6FNALrE6RP7YH8Rp64IWqY/Vt5nTVO9/Iym8
         6UXCb8g35dfhhQFS8+DQ2eKMD8FGry9BPw9O3lYqILTj64tncHFMp5EcV8SaG6aFz49l
         byMvlQXxbusISO7b71ScAE29NClhYK7CA122Q4v/QVVsMt4NR12xG8+4gZ/emDJmzaix
         kFj4kUN38sJx0N5x4piMmqy3Yonk+pjZRyfppCtCkyz/ikxSHPNQYrE+RYDgsVSvQlaz
         DtCKsv6LIBK9eiWignxuAGpCEiTdoaRqh3MejdDxZ4Z536dfz3uJIM/ldSdwQsO2RNcd
         VaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4wqJAr+3mpm/N6KJzqVQL+ect217rAtwLlAfBe3bNfU=;
        b=bfNpnYrUDtCzyFAh5AKLemsTarHkfq91XsGuk4vFSj1H3ReOd/oxfH76XQtpphq4iY
         i8UuqV04zanJ4jr806d06oYl9wcedvwdGkbKevD49z6LN+I2Rh54ato+g46J8KUt2+zJ
         H/jdyyovBcloShlwGbzunMDAHOSpuf0YSgXZoQmlSV10QBGFkK6K0n0RvNuEJVMmU9bW
         ruoDRbQVduBzOYQi1hGr7Zcq0hCEdihlGV4yxXwmA6NHeyfWZghpNPyr7drdZ4m93xvV
         8Q8WLZPR/hMYXsYRWWT3a5eHR0A/D0aLIgeWWreGW89koZ2kYD7wIQ6xcmSfis/Wx175
         Wf1A==
X-Gm-Message-State: AOAM533rJQfZ0s17RKdqtVHaZjGB/JvPCpve44Luhod9sdeHCnhX1frm
        iOzrTs1oUL4QVrq72HW/wXbGKQ==
X-Google-Smtp-Source: ABdhPJzZH2GWI6Hb1FX9L3mqyG6e5XSBr1WrgxKkqVdZE4ZdV1mmD4gMFvPc+9loGtWXO9plcLzfHA==
X-Received: by 2002:a17:90b:117:: with SMTP id p23mr71511pjz.111.1607015434516;
        Thu, 03 Dec 2020 09:10:34 -0800 (PST)
Received: from ?IPv6:2600:1010:b02c:6432:59d6:b4ed:32aa:4315? ([2600:1010:b02c:6432:59d6:b4ed:32aa:4315])
        by smtp.gmail.com with ESMTPSA id n127sm2369930pfd.143.2020.12.03.09.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:10:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and stack
Date:   Thu, 3 Dec 2020 09:10:32 -0800
Message-Id: <05D72EA3-4862-4D80-82F5-9369834C3461@amacapital.net>
References: <e8c458fe-073b-2c4d-4d80-3637041c1485@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <e8c458fe-073b-2c4d-4d80-3637041c1485@gmail.com>
To:     Topi Miettinen <toiwoton@gmail.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Dec 3, 2020, at 4:06 AM, Topi Miettinen <toiwoton@gmail.com> wrote:
>=20
> =EF=BB=BFOn 3.12.2020 11.47, Florian Weimer wrote:
>> * Topi Miettinen:
>>> +3   Additionally enable full randomization of memory mappings created
>>> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
>>> +    mappings is random, but the mappings are created in predictable
>>> +    places within the VMA and in sequential order. With 3, new VMAs
>>> +    are created to fully randomize the mappings.
>>> +
>>> +    Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if
>>> +    not necessary and the location of stack and vdso are also
>>> +    randomized.
>>> +
>>> +    On 32 bit systems this may cause problems due to increased VM
>>> +    fragmentation if the address space gets crowded.
>> Isn't this a bit of an understatement?  I think you'll have to restrict
>> this randomization to a subregion of the entire address space, otherwise
>> the reduction in maximum mapping size due to fragmentation will be a
>> problem on 64-bit architectures as well (which generally do not support
>> the full 64 bits for user-space addresses).
>=20
> Restricting randomization would reduce the address space layout randomizat=
ion and make this less useful. There's 48 or 56 bits, which translate to 128=
TB and 64PB of VM for user applications. Is it really possible to build toda=
y (or in near future) a system, which would contain so much RAM that such fr=
agmentation could realistically happen? Perhaps also in a special case where=
 lots of 1GB huge pages are necessary? Maybe in those cases you shouldn't us=
e randomize_va_space=3D3. Or perhaps there could be randomize_va_space=3D3 w=
hich does something, and randomize_va_space=3D4 for those who want maximum r=
andomization.

If you want a 4GB allocation to succeed, you can only divide the address spa=
ce into 32k fragments.  Or, a little more precisely, if you want a randomly s=
elected 4GB region to be empty, any other allocation has a 1/32k chance of b=
eing in the way.  (Rough numbers =E2=80=94 I=E2=80=99m ignoring effects of t=
he beginning and end of the address space, and I=E2=80=99m ignoring the size=
 of a potential conflicting allocation.). This sounds good, except that a pr=
ogram could easily make a whole bunch of tiny allocations that get merged in=
 current kernels but wouldn=E2=80=99t with your scheme.

So maybe this is okay, but it=E2=80=99s not likely to be a good default.

>=20
>>> +    On all systems, it will reduce performance and increase memory
>>> +    usage due to less efficient use of page tables and inability to
>>> +    merge adjacent VMAs with compatible attributes. In the worst case,
>>> +    additional page table entries of up to 4 pages are created for
>>> +    each mapping, so with small mappings there's considerable penalty.
>> The number 4 is architecture-specific, right?
>=20
> Yes, I only know x86_64. Actually it could have 5 level page tables. I'll f=
ix this in next version.
>=20
> -Topi
