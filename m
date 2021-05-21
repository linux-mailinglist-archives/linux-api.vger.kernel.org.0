Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478D738CAFE
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhEUQbQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 12:31:16 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:40491 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhEUQbP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 12:31:15 -0400
Received: by mail-ed1-f53.google.com with SMTP id t3so23954274edc.7;
        Fri, 21 May 2021 09:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1baM0zqRLo4eZvgxJKx9Stnzz6oHz6lIg0FwM2ooeyw=;
        b=mMHzuGE0+np2peBsDZrfkVvODpWES2Br6wx4+md58GIguh8aw8/JoGY63rJD7qAqkP
         C3+MNbuq8nI7OJPaRNDIDzFYcyltQ34ycEVx7Zb7f2eV0aUts1QCYma7cDHzwYif2Qw+
         rpsCYL9d/dnCHiox+QJ1BIVGdSla4fA4Caz9H4BVjLkyDb/3lq419+w0otap6nbFg+Fm
         CtuSZW1+i9pfC53OjcL8mf2HqR78WrO7CHbKHOk1wmiLOSwkGMjgZlVSOqmCabJ9dYvl
         bxfMSuMpudZAparEqYmYVYkEHHQmB+DL9iC2WU16RZS7QA/JtQxcmBbO0RNzDTPneIlS
         mbzA==
X-Gm-Message-State: AOAM533likE2f+DYmkTIigPdjjU6nd5z2u2u+YFFZrgQhmw4CwHzzVDi
        iRZP0zvHssCjpHMIIRTZfc73f5/s4HIDK34hLM8=
X-Google-Smtp-Source: ABdhPJy8wWvFIw2z6q3UTOyxrRzzX9vAEy/ime+Byc9f7G5gzFpP2diXVvJIY6pSfmg4SEUhaNbbySjlMNE3D+JlOFE=
X-Received: by 2002:aa7:c818:: with SMTP id a24mr12147002edt.310.1621614590763;
 Fri, 21 May 2021 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <87pmxpk7jo.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87pmxpk7jo.fsf@oldenburg.str.redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 May 2021 12:29:39 -0400
Message-ID: <CAJvTdK=suyVdH5U4WAdAmsJcnZbRx4tOot-Eu_SV4LSwLwP+zw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 17, 2021 at 5:56 AM Florian Weimer <fweimer@redhat.com> wrote:

> How expensive is checking XCR0 via XGETBV instead, on the AMX path?

XGETBV takes about the same number of cycles as RDTSC (ie. it is
relatively fast)

Len Brown, Intel Open Source Technology Center
