Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B119056D85
	for <lists+linux-api@lfdr.de>; Wed, 26 Jun 2019 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfFZPVI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 11:21:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41345 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfFZPVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Jun 2019 11:21:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so1618519pls.8
        for <linux-api@vger.kernel.org>; Wed, 26 Jun 2019 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cKkdMkj6I/DdZ06dL/lw28dVMlILlB8aQ8Zk+4qZukk=;
        b=E6tOyEpUJtT9bsBRqjmm4swXIq2Tmj1zHNduQ7AvCpJ66mVCh7SLRIW0v67jE8tpkf
         70LPPrTiSKM3VizjOa9kEBRzGvToUhNltbKL9EXS0y/TSGMK9bOIyCdmBotLqYjERbld
         aByysWxWC0Z4SbfsDjgcPgI+hhCCUZxaEODOFmR5yhQ20tIanr/Qu+ROvPbfqPmjU31h
         njBu/S5Z4bZQJoqZSKR5TTyelyM1HifmU4ymUOOewL7e0lpd/NIN1CH/Fb7pzAS0Xvoq
         efcQPkqTQIplTmWzvUBcg7C1PmjoqyUCxoqeIT0Uz9Rbezzs5+PC1rXvAmySL3uqtzLj
         UeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cKkdMkj6I/DdZ06dL/lw28dVMlILlB8aQ8Zk+4qZukk=;
        b=uesKQqKiAJHUnB3d4OOzFiB5YoVyvXwMHIKG4QAnbM461fwfBDXU89LBnCxULnThmt
         aE+D4M/zT6M6dLdhYDeJ+ZYbD/OvqpmKr7qSdUo6hWOmk9wJHNonDG3mU0hL/YDU4Znn
         M4B8Dj4luZ7s0mc2USyuVM9Cw5+tdsAC4X6xk2Ssl6T6sqwoq4GeDQn2ROMSxG5pG5Q0
         Ks56/0YZBqsdlNcJU/cujU7NDBM6qK12zBIPZ48ybHB2d61JCKoxhhmbuIht1RgWOkDJ
         e+l8dRaJ0byxL1YyJhweappZUH+5/ayMSK9Bo0ivtcO7fczg3rxNNnyjXUnsAPogKbjh
         iKhA==
X-Gm-Message-State: APjAAAXYM6kD2rlFJkMcGx6J4blq5upQf83XzT97B/yjCPfWs+qy6oTf
        +kGQg+IttlfIlS25c+i0RGCXnw==
X-Google-Smtp-Source: APXvYqxaRUw/tJQ7ebMVrUGEt329aWj0HyECbt1bpTaqtxT9Am1UrCaDNv+W8eqCYJJ5BbN8o6BlAw==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr5912284ply.247.1561562467144;
        Wed, 26 Jun 2019 08:21:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:24c0:50b2:a105:f479? ([2601:646:c200:1ef2:24c0:50b2:a105:f479])
        by smtp.gmail.com with ESMTPSA id h18sm13824813pfr.75.2019.06.26.08.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 08:21:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Detecting the availability of VSYSCALL
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <87r27gjss3.fsf@oldenburg2.str.redhat.com>
Date:   Wed, 26 Jun 2019 08:21:05 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <534B9F63-E949-4CF5-ACAC-71381190846F@amacapital.net>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de> <87lfxpy614.fsf@oldenburg2.str.redhat.com> <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com> <87a7e5v1d9.fsf@oldenburg2.str.redhat.com> <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com> <87o92kmtp5.fsf@oldenburg2.str.redhat.com> <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net> <87r27gjss3.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 26, 2019, at 8:00 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> * Andy Lutomirski:
>=20
>> I didn=E2=80=99t add a flag because the vsyscall page was thoroughly obso=
lete
>> when all this happened, and I wanted to encourage all new code to just
>> parse the vDSO instead of piling on the hacks.
>=20
> It turned out that the thorny cases just switched to system calls
> instead.  I think we finally completed the transition in glibc upstream
> in 2018 (for x86).
>=20
>> Anyway, you may be the right person to ask: is there some credible way
>> that the kernel could detect new binaries that don=E2=80=99t need vsyscal=
ls?
>> Maybe a new ELF note on a static binary or on the ELF interpreter? We
>> can dynamically switch it in principle.
>=20
> For this kind of change, markup similar to PT_GNU_STACK would have been
> appropriate, I think: Old kernels and loaders would have ignored the
> program header and loaded the program anyway, but the vsyscall page
> still existed, so that would have been fine. The kernel would have
> needed to check the program interpreter or the main executable (without
> a program interpreter, i.e., the statically linked case).  Due the way
> the vsyscalls are concentrated in glibc, a dynamically linked executable
> would not have needed checking (or re-linking).  I don't think we would
> have implemented the full late enablement after dlopen we did for
> executable stacks.  In theory, any code could have jumped to the
> vsyscall area, but in practice, it's just dynamically linked glibc and
> static binaries.
>=20
> But nowadays, unmarked glibcs which do not depend on vsyscall vastly
> outnumber unmarked glibcs which requrie it.  Therefore, markup of
> binaries does not seem to be reasonable to day.  I could imagine a
> personality flag you can set (if yoy have CAP_SYS_ADMIN) that re-enables
> vsyscall support for new subprocesses.  And a container runtime would do
> this based on metadata found in the image.  This way, the container host
> itself could be protected, and you could still run legacy images which
> require vsyscall.
>=20
> For the non-container case, if you know that you'll run legacy
> workloads, you'd still have the boot parameter.  But I think it could
> default to vsyscall=3Dnone in many more cases.
>=20

I=E2=80=99m wondering if we can still do it: add a note or other ELF indicat=
or that says =E2=80=9CI don=E2=80=99t need vsyscalls.=E2=80=9D  Then we can c=
hange the default mode to =E2=80=9Cno vsyscalls if the flag is there, else e=
xecute-only vsyscalls=E2=80=9D.

Would glibc go along with this?  Would enterprise distros consider backporti=
ng such a thing?

I=
