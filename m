Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7445318FA3
	for <lists+linux-api@lfdr.de>; Thu, 11 Feb 2021 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBKQN3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Feb 2021 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBKQLZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Feb 2021 11:11:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34701C061756
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 08:10:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gb24so3653709pjb.4
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s8VcXJZ0nXd+5HiJ0KBL3oqJGDIkbb8WLLcD0RM+IXY=;
        b=GGRGCGp2LJnH4P4u+hfLsG4OyM6r0Zok2JwTQllDKuYK79fd2ymvsYWpZWXCKk/t/D
         47s4KlAApn4b4gYQTlXb9Ltoyzi+lvva0wQGJEL2cHFTbp6txEEDchk4dNZNFaI6Akr3
         apTdkQDke5bgG8+WekGZtr+F0oqZ4DvswuNwnIL0DuXUHJc9mn8x3EH46mF1ioqAb1wJ
         J2oZ0avJ8Oo329WG1fNel7DkVa+WHyNpz5lNHJsGySr0nKN9sv6YSYTYR7bkv7s2zMJ2
         +nepmxBNZ4iLIedOCaSjEpDl8OQkPVqFiBKs4kGL+K6DsiMnyljwKGj5UNjOZxMyMxqy
         CpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s8VcXJZ0nXd+5HiJ0KBL3oqJGDIkbb8WLLcD0RM+IXY=;
        b=E1pegRmx7MxcBUjPPimZpADjBMoHLxbiqPPrfcqA3CnDUAWWWQ5hb5y0diGYX1Alo/
         65jGKKyAhHMKlAn4wDF7AnzQZZ7OoAqRu8Tpt4VwXa9y/CsqnyUf3pEB6Z13FCMmBn5W
         oS1aVcccYk7QtdBLirP7wafnG+2QeZN811rrjOnEEntAibJrBu6yBHpW4QXgafyGlvHP
         uHV+RpOpIVqweKvbeUhChPDwR5caZCIqMRDjukwrYzB7/TXEMmR79r+JAOHTF7+PFlIk
         LacmlvbNUmMXDsgPYI45zllbwVcK40//re2wszFbgSP7tOSTtdSD1up+l2GiJZ3kfGsl
         vsMQ==
X-Gm-Message-State: AOAM532Cl9McC1B6HM1fjtGmnIDjrQuHEB2/6Ac4qkzvmHTpRAQEiHYA
        1ShRnw8dKTQqQc888dbItAjSTygiMqbP2YZo
X-Google-Smtp-Source: ABdhPJzj8fUqmXpElF1L8hTI2g1o0UhBoKLnzLQTBKnguOoEW+f/1L5ndwLQKr0pdNV99npweb0q+A==
X-Received: by 2002:a17:902:d4c3:b029:e2:bd29:7e6e with SMTP id o3-20020a170902d4c3b02900e2bd297e6emr8185825plg.66.1613059844568;
        Thu, 11 Feb 2021 08:10:44 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:b847:ef6e:681b:6624? ([2601:646:c200:1ef2:b847:ef6e:681b:6624])
        by smtp.gmail.com with ESMTPSA id 17sm6316073pgy.53.2021.02.11.08.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 08:10:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Are vDSO addresses special?
Date:   Thu, 11 Feb 2021 08:10:42 -0800
Message-Id: <442A16C0-AE5A-4A44-B261-FE6F817EAF3C@amacapital.net>
References: <87zh0bq62r.fsf@oldenburg.str.redhat.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
In-Reply-To: <87zh0bq62r.fsf@oldenburg.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Feb 11, 2021, at 2:05 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> =EF=BB=BFIn glibc, we have some code that copies the DT_SONAME string of t=
he
> kernel vDSO into the heap, commented this way:
>=20
>             /* Work around a kernel problem.  The kernel cannot handle
>                addresses in the vsyscall DSO pages in writev() calls.  */
>=20
> Is this really a problem anymore?  vDSO addresses are ordinary userspace
> addresses, I think.  (The vsyscall stuff is very different, of course,
> and maybe the vDSO started out the same way.)

I don=E2=80=99t think it was ever a problem, and it certainly haven=E2=80=99=
t been a problem for a long, long time. vDSO addresses are regular user addr=
esses.  The *vsyscall* addresses are not, and most syscalls will not accept t=
hem, but that shouldn=E2=80=99t matter especially since modern kernels, by d=
efault, won=E2=80=99t let you read those addresses from user code either.

Saying =E2=80=9Cvsyscall DSO=E2=80=9D is odd. There=E2=80=99s no such thing.=


=E2=80=94Andy=20

>=20
> We only care about Linux 3.2 or later in glibc.
>=20
> Thanks,
> Florian
> --=20
> Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
> Commercial register: Amtsgericht Muenchen, HRB 153243,
> Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'=
Neill
>=20
